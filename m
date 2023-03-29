Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5766CD077
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 05:07:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230073AbjC2DHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 23:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229517AbjC2DHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 23:07:31 -0400
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com [209.85.214.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E09192D75;
        Tue, 28 Mar 2023 20:07:30 -0700 (PDT)
Received: by mail-pl1-f178.google.com with SMTP id kq3so13595350plb.13;
        Tue, 28 Mar 2023 20:07:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680059250;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=adLZ+hFzOFHt2ehEVGdWFwYoZL3029zv1IubnPhrNWk=;
        b=0tJWcIEjEgNp59KLzWRwzugsKBzKPdhxLndXUTo9hUFnvmQEJvf+xFkQ4E3xsrpTnD
         cD8ZFe4EnETVmyzLlu32U4oHFFYAmLEMrG5GkLVzZUxthMx2Cb4HNkcfXkGqU35/FVC8
         1W0WRBErd+YbuZ+A/JO6TlsruOKM0LehlXtSVqDZmENlMB40mFcls+J69vMu6iK/hwDI
         V2+XIJPfLKiZV7fBreP6LtBZxI5/Mr+ip9bUvyu4tPKsg+sjDFt400nTEf1jOAYkHxaZ
         yDkglV7M9BurhXGWMRP5oBTWrjSFF8Y1PxYQ9RsFsZ9jbULR2+cawA7nmkY4WC/Oq7As
         zRMg==
X-Gm-Message-State: AO0yUKWpAKs2Nm7KtvxhUeNADfZNSEPDYLz8CFF9CzUy43dwRpcrcC2t
        /s/7lKrlD5/6843oweUeUHY=
X-Google-Smtp-Source: AK7set/xqxAZrj+4KgMElymUiMjNGOVkKCU5KvXbtM7U3NOrVD9z4Gj2ye80yVWac/x0Mb2Saw98LA==
X-Received: by 2002:a05:6a20:c50f:b0:dd:bf6a:4609 with SMTP id gm15-20020a056a20c50f00b000ddbf6a4609mr15757410pzb.49.1680059249872;
        Tue, 28 Mar 2023 20:07:29 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id v7-20020a62a507000000b005e5b11335b3sm21750075pfm.57.2023.03.28.20.07.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Mar 2023 20:07:29 -0700 (PDT)
Message-ID: <b66e0433-040d-34b8-05f1-a6741861c684@acm.org>
Date:   Tue, 28 Mar 2023 20:07:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] scsi: ufs: core: Add host quirk
 UFSHCD_QUIRK_MCQ_BROKEN_INTR
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        stanley.chu@mediatek.com, alice.chao@mediatek.com,
        naomi.chu@mediatek.com, chun-hung.wu@mediatek.com,
        cc.chou@mediatek.com, eddie.huang@mediatek.com,
        mason.zhang@mediatek.com, chaotian.jing@mediatek.com,
        jiajie.hao@mediatek.com
References: <20230328103801.11198-1-powen.kao@mediatek.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230328103801.11198-1-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.5 required=5.0 tests=FREEMAIL_FORGED_FROMDOMAIN,
        FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 03:37, Po-Wen Kao wrote:
> diff --git a/drivers/ufs/core/ufshcd.c b/drivers/ufs/core/ufshcd.c
> index acae4e194ec4..1e1271aca1f2 100644
> --- a/drivers/ufs/core/ufshcd.c
> +++ b/drivers/ufs/core/ufshcd.c
> @@ -8493,11 +8493,15 @@ static int ufshcd_alloc_mcq(struct ufs_hba *hba)
>   static void ufshcd_config_mcq(struct ufs_hba *hba)
>   {
>   	int ret;
> -
> +	u32 intrs;
>   	ret = ufshcd_mcq_vops_config_esi(hba);
> +
>   	dev_info(hba->dev, "ESI %sconfigured\n", ret ? "is not " : "");

The use of blank lines in the above code is weird. Please make sure 
there is no blank line inside the declaration block and also that there 
is a blank line between declarations and statements as required by the 
kernel coding style.

> -	ufshcd_enable_intr(hba, UFSHCD_ENABLE_MCQ_INTRS);
> +	intrs = (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_INTR) ?
> +		(UFSHCD_ENABLE_MCQ_INTRS & ~MCQ_CQ_EVENT_STATUS) : UFSHCD_ENABLE_MCQ_INTRS;

All parentheses in the above expression are superfluous. Please leave 
these out. Or even better, rewrite the above code as follows:

	intrs = UFSHCD_ENABLE_MCQ_INTRS;
	if (hba->quirks & UFSHCD_QUIRK_MCQ_BROKEN_INTR)
		intrs &= ~MCQ_CQ_EVENT_STATUS;

> +
> +	/*
> +	 * Some platform raises interrupt (per queue) in addition to
> +	 * CQES (traditional) when ESI is disabled.
> +	 * Enable this quirk will disable CQES and use per queue interrupt.
> +	 */
> +	UFSHCD_QUIRK_MCQ_BROKEN_INTR			= 1 << 20,

Isn't this an UFS controller behavior instead of a platform behavior? 
Please consider changing "platform raises" into "controllers raise".

Thanks,

Bart.

