Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51B146A32C7
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Feb 2023 17:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229752AbjBZQXH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Feb 2023 11:23:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjBZQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Feb 2023 11:23:06 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 128A3CC10;
        Sun, 26 Feb 2023 08:23:05 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t25-20020a1c7719000000b003eb052cc5ccso5124638wmi.4;
        Sun, 26 Feb 2023 08:23:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=w2PLHhwdaQbS2cYnTTtwyaA7Q4BGApIwwoUz5TUfv2I=;
        b=kp2I+Ep8bT/N1ioJjCGtSrL/YKVRLtf4sTHYL4Gg2e8QTtXo3zu3EbR0zqipC5VoKV
         fSOeeYFlaAAyGYn4nsXjopQ4K61zr4BV5+CC/ucON7swIA1ZJbAb87rBt5vFg7SPBTKe
         V3m4mh6vLQW6VEjAMM6iowjk72+bV1hCNznaej7byur+UXpiouL8iobzvzc6h3vbTHCl
         5grb2L/ZNIKjn7YpNJVxd7fA11fy/B2yM3rUMVpZ5h3x1Xr7gAJC8wyNOx/XkuVesBn2
         pIwZ573N8a14qQeCJLypL/ADg9S5gBZ1d8qQhFQu5mAptQSgVTZm0soCum6eYrfdf87k
         mVlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=w2PLHhwdaQbS2cYnTTtwyaA7Q4BGApIwwoUz5TUfv2I=;
        b=Rb2hP7EwczHbrp8WgbyZ1aDiv/xELOz0ews+/pRQHYvDpRxdHmKw5mGDSCRc4F7RWa
         RrxCwfjDvCEPXYfEGRdoyEaHVafILuKNQywDlAOuQFonJzsfncTtL8dWiHk38InJOW9M
         VlUiSaMc5K0QeSNuM2UrvMXcgse2kF5hSAUOc+W0iabE74pSFwj9w6WwVGTJNtlg+iEZ
         xkxDsQWvnMbpEE2HZuZOmND8DqkEIelBO0VB7mn3+8JrVhmthSUuAZm0H+cKQzy1tlPD
         Xg4y7Xz96HssdXuLo1SdJHstkbsIiOL7rxQYYVEbP1LhakY81Hc8SPRZYM54p6QQM6mF
         EOeQ==
X-Gm-Message-State: AO0yUKU9aojKs+XdJpwe4ZurZqfq6ZDv9zRgkYvkqda/V4l5jlMiPyfV
        OaxDOj/bw4G2+BGdNSeCHzw=
X-Google-Smtp-Source: AK7set+XH2HKW8gykxK8QLLfvaADjEB2az3jjR9ernI2o1HPKmxYMjHjNFATDIJv0x+BvhfHrefErQ==
X-Received: by 2002:a05:600c:810:b0:3db:2e06:4091 with SMTP id k16-20020a05600c081000b003db2e064091mr17369419wmp.37.1677428583449;
        Sun, 26 Feb 2023 08:23:03 -0800 (PST)
Received: from ?IPV6:2003:c5:8708:4321:dcf1:ac0e:cc8d:62ca? (p200300c587084321dcf1ac0ecc8d62ca.dip0.t-ipconnect.de. [2003:c5:8708:4321:dcf1:ac0e:cc8d:62ca])
        by smtp.gmail.com with ESMTPSA id a5-20020a5d4565000000b002c3f81c51b6sm4710874wrc.90.2023.02.26.08.23.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 26 Feb 2023 08:23:02 -0800 (PST)
Message-ID: <eda65f0b-bbd1-5e3d-5d85-a5686a06ba5a@gmail.com>
Date:   Sun, 26 Feb 2023 17:23:01 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v3 4/6] scsi: ufs: core: Remove redundant check
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
References: <20230223152757.13606-1-powen.kao@mediatek.com>
 <20230223152757.13606-5-powen.kao@mediatek.com>
From:   Bean Huo <huobean@gmail.com>
In-Reply-To: <20230223152757.13606-5-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23.02.23 4:27 PM, Po-Wen Kao wrote:
> is_mcq_supported() already check on use_mcq_mode.
>
> Signed-off-by: Po-Wen Kao <powen.kao@mediatek.com>
> Reviewed-by: Stanley Chu <stanley.chu@mediatek.com>
> Reviewed-by: Ziqi Chen <quic_ziqichen@quicinc.com>
> ---
>   drivers/ufs/core/ufshcd.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index 81c9f07ebfc8..3357cfa23616 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8544,7 +8544,7 @@ static int ufshcd_device_init(struct ufs_hba *hba, bool init_dev_params)
>   			hba->scsi_host_added = true;
>   		}
>   		/* MCQ may be disabled if ufshcd_alloc_mcq() fails */
> -		if (is_mcq_supported(hba) && use_mcq_mode)

This has been removed/optimized  by commit:

https://patches.linaro.org/project/linux-scsi/patch/8840cea4a57b46dabce18acc39afc50ab826330f.1676567593.git.quic_asutoshd@quicinc.com/

so this patch is not necessary anymore???


> +		if (is_mcq_supported(hba))
>   			ufshcd_config_mcq(hba);
>   	}
>   
