Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8CE672A2F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 22:16:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230421AbjARVQA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 16:16:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230415AbjARVPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 16:15:38 -0500
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C4EC63E1F;
        Wed, 18 Jan 2023 13:15:21 -0800 (PST)
Received: by mail-pl1-f170.google.com with SMTP id k13so409482plg.0;
        Wed, 18 Jan 2023 13:15:21 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VfYeoPZtVQr6RUjpHn+YzmJhfEx/kDkA6rxpThlAcYE=;
        b=zZWCNTblv+5Sm37kImrZ7N+TqiAXDLoqiI/vqVGkmU+ugcZP8IW7YUPK/XCo7Qu6zy
         orPr2Qv1+57x+PNqN9ebGA8uoYY3hPiTJBEcel0hDb/snOlKLzrcUMkONCbREACtqmUB
         Hq4hmLEvSpP26VgCd3qQjcDs7oru5dSDg6P6ACg21JQexFnhzywhnvpOpGyUNJWMFYHr
         tFctx4VubDwBO7HRLr8hoqVvXn7Z5zcxhuQwd+XxYZGHYS5V3FGWrqVO7ksYAHb6F4M6
         tQ/AjsDLAQ99Ha3B9B6xwCo7ZEUfx/AVJOHPpxqP2aXBaqY7qpoAHC8anHc8X9k74QP0
         y3Ng==
X-Gm-Message-State: AFqh2kr5caOyYS+Tx2H13NT2olTdqFaT4iv8WWI5oEbKLEPJXWd1oi0N
        pf9JOir0zqw69xO8xPHo0LY=
X-Google-Smtp-Source: AMrXdXutlXFWfVgcDAhZIIV7axYmi0fKCKZsAkx3faC454CblA1coJQ2Xu64WKn1Dbt/NkUSasU2bA==
X-Received: by 2002:a17:903:cd:b0:194:721e:611d with SMTP id x13-20020a17090300cd00b00194721e611dmr7215057plc.14.1674076520987;
        Wed, 18 Jan 2023 13:15:20 -0800 (PST)
Received: from ?IPV6:2620:15c:211:201:22ae:3ae3:fde6:2308? ([2620:15c:211:201:22ae:3ae3:fde6:2308])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b0019327f40bfasm20784319plw.119.2023.01.18.13.15.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 18 Jan 2023 13:15:20 -0800 (PST)
Message-ID: <52f6c811-bda9-7ae6-645b-daffe1ba7be3@acm.org>
Date:   Wed, 18 Jan 2023 13:15:18 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH] scsi: MAINTAINERS: Add entry for Exynos UFS driver
Content-Language: en-US
To:     Alim Akhtar <alim.akhtar@samsung.com>,
        linux-kernel@vger.kernel.org, linux-scsi@vger.kernel.org
Cc:     avri.altman@wdc.com, martin.petersen@oracle.com
References: <CGME20230114023022epcas5p37521ca1f5a34c36e33e0d73bd0066aa8@epcas5p3.samsung.com>
 <20230114080247.601312-1-alim.akhtar@samsung.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230114080247.601312-1-alim.akhtar@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/14/23 00:02, Alim Akhtar wrote:
> Add maintainer entry for Exynos UFS driver.
> 
> Signed-off-by: Alim Akhtar <alim.akhtar@samsung.com>
> ---
>   MAINTAINERS | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 9033d9ec7196..a960327de27f 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -21444,6 +21444,12 @@ L:	linux-scsi@vger.kernel.org
>   S:	Supported
>   F:	drivers/ufs/host/*dwc*
>   
> +UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER EXYNOS HOOKS
> +M:	Alim Akhtar <alim.akhtar@samsung.com>
> +L:	linux-scsi@vger.kernel.org
> +S:	Maintained
> +F:	drivers/ufs/host/ufs-exynos*
> +
>   UNIVERSAL FLASH STORAGE HOST CONTROLLER DRIVER MEDIATEK HOOKS
>   M:	Stanley Chu <stanley.chu@mediatek.com>
>   L:	linux-scsi@vger.kernel.org

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
