Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8F8660323A
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 20:21:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230187AbiJRSVA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 14:21:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229832AbiJRSU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 14:20:57 -0400
Received: from mail-pj1-f53.google.com (mail-pj1-f53.google.com [209.85.216.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBE506D549;
        Tue, 18 Oct 2022 11:20:56 -0700 (PDT)
Received: by mail-pj1-f53.google.com with SMTP id x31-20020a17090a38a200b0020d2afec803so14776327pjb.2;
        Tue, 18 Oct 2022 11:20:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z73w0O3hRJhEUdd4v+7DeZIcTv7VLoI96swI4hEwvBM=;
        b=PYdxr5JKtYDmdQRElD/avEFghaICe0oRpfWjGlmNXMY2NzrxEn3rrEHWmWxtbRVF3A
         hbOt3dI0H+D02ByjnCBvVUIELAOzxexOU5MR6UAUQdh0cDmYbn39IHQqDNIn/rWM7pu4
         CHfFjBOYDuwrqRgDkLB/HB72vfMRTfw1KeEy1C/02P2puoU0SD2p2oltdy9pNPjwFpO7
         MK1M+IwCHpynnEjfpa2VL/xAs+ocTrq6vG3y4cJsTvmKVUb9umIavLSHCMAOi3XAdiMW
         EEGuxnKhK7/PabndoR+JqQa5WGD8nVprntXoofWKWqAgTwn/mpjQbrkoOWoQDexYcZR9
         1o3w==
X-Gm-Message-State: ACrzQf31bPhMZvneEA4Yk0Mlc6oXJOfZj74EyP8rsCYfTAgREJhSyHRK
        PUfdzHUr1Hv2qE5rerMb+d4=
X-Google-Smtp-Source: AMsMyM4fm/pKAoP4EZ9XJh1ddJXnwvh0gkJgzjGNbEn3/SYXO6CRkZhLN8eTx0G01IsjY12SitghUQ==
X-Received: by 2002:a17:902:a612:b0:17e:539:c415 with SMTP id u18-20020a170902a61200b0017e0539c415mr4316988plq.173.1666117255260;
        Tue, 18 Oct 2022 11:20:55 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:522b:67a3:58b:5d29? ([2620:15c:211:201:522b:67a3:58b:5d29])
        by smtp.gmail.com with ESMTPSA id ij11-20020a170902ab4b00b0017824e7065fsm8880402plb.180.2022.10.18.11.20.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 11:20:54 -0700 (PDT)
Message-ID: <8fbe22f1-d216-3841-62c3-675dcb8b6e8d@acm.org>
Date:   Tue, 18 Oct 2022 11:20:52 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH v3 1/3] scsi: ufs: core: Remove unnecessary if statement
Content-Language: en-US
To:     Bean Huo <beanhuo@iokpp.de>, alim.akhtar@samsung.com,
        avri.altman@wdc.com, asutoshd@codeaurora.org, jejb@linux.ibm.com,
        martin.petersen@oracle.com, stanley.chu@mediatek.com,
        beanhuo@micron.com, tomas.winkler@intel.com, cang@codeaurora.org,
        daejun7.park@samsung.com, huobean@gmail.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221018181627.326657-1-beanhuo@iokpp.de>
 <20221018181627.326657-2-beanhuo@iokpp.de>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221018181627.326657-2-beanhuo@iokpp.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/18/22 11:16, Bean Huo wrote:
> From: Bean Huo <beanhuo@micron.com>
> 
> LUs with WB potential support are properly checked in ufshcd_wb_probe()
> before calling ufshcd_read_unit_desc_param(), so remove this unnecessary
> if-checkup in ufs_is_valid_unit_desc_lun() to match its function definition.

Hi Bean,

Does this patch differ from a revert of Jaegeuk's patch? If not, please 
change the patch title into "Revert scsi: ufs: WB is only available on 
LUN #0 to #7" and add "Cc: Jaegeuk Kim <jaegeuk@kernel.org>" just above 
the Signed-off-by line.

Thanks,

Bart.

