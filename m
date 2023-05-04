Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E886F7196
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229813AbjEDRxP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:53:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbjEDRxM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:53:12 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A96C1BFA;
        Thu,  4 May 2023 10:53:12 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-1aaec6f189cso5471925ad.3;
        Thu, 04 May 2023 10:53:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683222791; x=1685814791;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QhzG9QLeT/AdwEJ8Xk3sMDacDxvGCe+E8Bp6ZVi59ME=;
        b=LHml+uR/ZhwNW9M2o200+o91wZ/+L31CZDo3b0g2MswycgXeh9wLm49qcqqyUqZ+YB
         zdEKsoEECmlPVTgPZ4IgWsYMCjuwlm2AglcyuD1jAxX7iFN5yHbUOJZnYfq8QfNfdZmV
         XjCINQawt6ZpSgQXGeLQIIqg3O7kgm3M46kzDPELWrDTYLoe/HghXu49ahQUfwnEfMwu
         CcOfrQgINAMbnYR4wJGS3sR1sVNG71W4PH1NjfLAeJk9caABanmvwdEBT5iHMlR7zr1a
         OyHoU0XahPWsMqGDiCZWx85ZFd6nGWgXNwVmd16zL+bXb5jaElxfLEYfN6RKkQ4bV5rN
         PSYA==
X-Gm-Message-State: AC+VfDynSE3e+9Nj9bcjpqAK+KQVKm//5K85ctBzujxI4s5ow5pXMVw3
        LGdlbP8jzC8hR7aykiJdIzzMMMzLyS8=
X-Google-Smtp-Source: ACHHUZ4C7y9zvavNMATZM/yIXk7L6sPqM0mTK5ArKCWEGmDnByeHoWYcbAjZkDsrbRvUKy40xiR8hA==
X-Received: by 2002:a17:902:c40b:b0:1ab:28ec:bf10 with SMTP id k11-20020a170902c40b00b001ab28ecbf10mr5757457plk.51.1683222791313;
        Thu, 04 May 2023 10:53:11 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:2c3b:81e:ce21:2437? ([2620:15c:211:201:2c3b:81e:ce21:2437])
        by smtp.gmail.com with ESMTPSA id n4-20020a170902d2c400b001a5260a6e6csm9985629plc.206.2023.05.04.10.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 04 May 2023 10:53:10 -0700 (PDT)
Message-ID: <14b9ca4a-26f8-e033-3bda-50c339635c56@acm.org>
Date:   Thu, 4 May 2023 10:53:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2 2/5] ufs: mcq: Add support for clean up mcq resources
Content-Language: en-US
To:     "Bao D. Nguyen" <quic_nguyenb@quicinc.com>,
        quic_asutoshd@quicinc.com, quic_cang@quicinc.com, mani@kernel.org,
        Powen.Kao@mediatek.com, stanley.chu@mediatek.com,
        adrian.hunter@intel.com, beanhuo@micron.com, avri.altman@wdc.com,
        martin.petersen@oracle.com
Cc:     linux-scsi@vger.kernel.org, Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1681764704.git.quic_nguyenb@quicinc.com>
 <5e662692bc0ad5108ce91ae3d1ec2b575c34d4ae.1681764704.git.quic_nguyenb@quicinc.com>
 <12308ca3-f824-596e-078f-bc00fa674aef@acm.org>
 <b1af6459-43b7-d193-c6e7-37f24d7349e6@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <b1af6459-43b7-d193-c6e7-37f24d7349e6@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/3/23 21:01, Bao D. Nguyen wrote:
> On 4/25/2023 5:08 PM, Bart Van Assche wrote:
>> On 4/17/23 14:05, Bao D. Nguyen wrote:
>>> @@ -3110,7 +3128,7 @@ static int ufshcd_wait_for_dev_cmd(struct ufs_hba *hba,
>>>           err = -ETIMEDOUT;
>>>           dev_dbg(hba->dev, "%s: dev_cmd request timedout, tag %d\n",
>>>               __func__, lrbp->task_tag);
>>> -        if (ufshcd_clear_cmds(hba, 1U << lrbp->task_tag) == 0) {
>>> +        if (ufshcd_clear_cmds(hba, 1UL << lrbp->task_tag) == 0) {
>>>               /* successfully cleared the command, retry if needed */
>>>               err = -EAGAIN;
>>>               /*
>>
>> Is this change necessary?
> My intention was to support tag greater than 31 and less than 64.
> The 1U << only works up to 32 bits.

The UFSHCI 4.0 standard and also the Linux kernel UFS driver support more than
64 outstanding commands so the above change is not sufficient.

>> Please do not use lrbp->cmd to check whether or not a command has completed. See also my patch "scsi: ufs: Fix handling of lrbp->cmd".
> I have been thinking how to replace lrbp->cmd, but could not find a good solution. Throughout this patch series, I am using lrbp->cmd as a way to find the pending command that is being aborted and clean up the resources associated with it. Any suggestions to achieve it? 

Using lrbp->cmd is fine but checking whether or not it is NULL is not OK. How
about using blk_mq_request_started() to check whether or not a request is still
pending?

Thanks,

Bart.
