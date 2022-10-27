Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AFBC66103FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 23:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236853AbiJ0VGb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 17:06:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237287AbiJ0VGL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 17:06:11 -0400
Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287DA5DF3E;
        Thu, 27 Oct 2022 14:02:52 -0700 (PDT)
Received: by mail-pj1-f48.google.com with SMTP id u8-20020a17090a5e4800b002106dcdd4a0so7837303pji.1;
        Thu, 27 Oct 2022 14:02:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UmE1DG7kSl1xwJVJ4g+VjJX4wwHIYDfR/132aX/ZXDQ=;
        b=jKdkOcRvmp/s3JXiX1MTBRVA0KzDakC0B+e6++o5i23gU+nfoisFfVipGCMTWq8ZUY
         tD4WHec3LjipCre4Hty85+9f1OxaGTmMNGYZm+VqtiDqJ+tfASZPcE4+eclwq8hA/zHt
         hEjLwVrVT+pFT/kzmdQVjXH2itM7Ml4RzAx1DU/bpiXnnp3qFqpSvguQ7xVQ8d/wxIrT
         mLhXWCQFb3SxN9ok8M/eOcrv+ijmVowcGfYoNUzCi2pGzlKSM4rgTMPjCIP15DSepUfo
         7feoFqFU/QqMBDt3t8a1IUOvr9Y0I3KTEgcBo1yXIx1Dh4kbw6etldYQqmKlq35Mn0xC
         aCZQ==
X-Gm-Message-State: ACrzQf2L93b3xEWSYmIxRCvSSoxSRBljpcP5ZYUSJ4xQwpwf9kBAdsVt
        pq0GptocdY/y2gPJLn3ekGY=
X-Google-Smtp-Source: AMsMyM4waBikI2WZ1brhVMMOQyb//PPS2Vno4JXG8gLyAZEPyadBpLLjvNBP4/85jCGUHmDpbrJMXA==
X-Received: by 2002:a17:90b:4d84:b0:212:c78f:8d6e with SMTP id oj4-20020a17090b4d8400b00212c78f8d6emr12100332pjb.201.1666904571619;
        Thu, 27 Oct 2022 14:02:51 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:bc2b:ff19:1b02:257b? ([2620:15c:211:201:bc2b:ff19:1b02:257b])
        by smtp.gmail.com with ESMTPSA id ne23-20020a17090b375700b0020aacde1964sm3035694pjb.32.2022.10.27.14.02.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 14:02:51 -0700 (PDT)
Message-ID: <e370c9df-ce6e-99b6-25d4-a0cc691675ce@acm.org>
Date:   Thu, 27 Oct 2022 14:02:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [PATCH v3 01/17] ufs: core: Probe for ext_iid support
Content-Language: en-US
To:     Asutosh Das <quic_asutoshd@quicinc.com>, quic_cang@quicinc.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org
Cc:     quic_nguyenb@quicinc.com, quic_xiaosenh@quicinc.com,
        stanley.chu@mediatek.com, eddie.huang@mediatek.com,
        daejun7.park@samsung.com, avri.altman@wdc.com, mani@kernel.org,
        beanhuo@micron.com, quic_richardp@quicinc.com,
        linux-arm-msm@vger.kernel.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        Jinyoung Choi <j-young.choi@samsung.com>,
        Kiwoong Kim <kwmad.kim@samsung.com>,
        open list <linux-kernel@vger.kernel.org>
References: <cover.1666288432.git.quic_asutoshd@quicinc.com>
 <1de72ea43ca5958cf839f4f21e42be744e122960.1666288432.git.quic_asutoshd@quicinc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1de72ea43ca5958cf839f4f21e42be744e122960.1666288432.git.quic_asutoshd@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/20/22 11:03, Asutosh Das wrote:
> +static unsigned int ufs_get_ext_ufs_feature(struct ufs_hba *hba,
> +					    const u8 *desc_buf)
> +{
> +	if (hba->desc_size[QUERY_DESC_IDN_DEVICE] <
> +	    DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP + 4)
> +		return 0;
> +
> +	return get_unaligned_be32(desc_buf +
> +				  DEVICE_DESC_PARAM_EXT_UFS_FEATURE_SUP);
> +}

Please avoid code duplication and make ufshcd_wb_probe() and
ufshcd_temp_notif_probe() call the above function. Please also introduce
the above function and perform the requested refactoring as a separate
patch.

Otherwise this patch looks good to me.

Thanks,

Bart.
