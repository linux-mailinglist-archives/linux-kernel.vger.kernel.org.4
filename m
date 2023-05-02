Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 542746F408F
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 12:00:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233712AbjEBKAU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 06:00:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjEBKAR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 06:00:17 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BB4830F6;
        Tue,  2 May 2023 03:00:16 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id ffacd0b85a97d-3062db220a3so1258772f8f.0;
        Tue, 02 May 2023 03:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683021614; x=1685613614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DMr9gvF8Pl9mIUWgrETUJDIt0vnyiOv1BE24SgG6Lto=;
        b=WmA9DGCkjPvr6YFIxM5TUvWVN9FipEkQlHdb5kpX4aVH4FkFW7QTYZ39MqtjtBmfG2
         +2dM7q8RVXvK7XC+TDSTqEBr+Ud9C5b7EakwQrExotdSZC93eWfv4Y/78ui5QG63BCbP
         vNCt8OjkdNfvDrwsDM3R8HPiZWh+gWAw5DBR1eJO0BxiW69xF4bwbFqkWyWRExLeBfEG
         GgCAYrm09/Wq8gus+GTJVU63oeXsiuX1KXF6acCdxWw/wFZHhkloAfg45A70JHE954Ua
         Erb38k+WOrmrQvpt+8tdaZtHCeOsoEeGmc51OWO9nXiiW+Iokuq+8oV06/XNtWb8OHsi
         ATbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683021614; x=1685613614;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DMr9gvF8Pl9mIUWgrETUJDIt0vnyiOv1BE24SgG6Lto=;
        b=giX6l6dOcdpyKAPRJitvy1v3NpBqashxsfnM4pFEnlHGKR/sm9opwoYi+hoLgSBFmm
         QBWqo+GR9iDnLRcGKxMNELCLDCp/oguY3NLvB9wU/lQ60JkFPKC5KBp960NM/ACMrwuc
         oPUJGrMFEQdRvgmOlkcPqh4QgXXDenNI7QpDOzuQpOxjolf6S6gdOhGd52ylh7qyCDHK
         LUqFo6HCL8tzP7xtlORKF/oFtP4pHC/qqZyfxeNl7E4zr+hUXzWJ5ZbMBiaF9Z670NTs
         pbcEEFqK99czf7QKMBHrPBERwH9epcG60IEPSgtnos0/Gx+rHrfWQEIlC4OQ3yasmveB
         IIww==
X-Gm-Message-State: AC+VfDx53nFddMuH11rbuYBDmolmx5wmNNKn9OmT4njRFkT2n8YjlSVJ
        ObZrrUhY5eRWxwGF+iPOPi8=
X-Google-Smtp-Source: ACHHUZ5nXwHh+CHAxSN7hBDo8xJZZF/pzllxqaFgnSIb6mXPfrPJBzKX0RwxiNFr6M626CDjvd3NDw==
X-Received: by 2002:a5d:4fcc:0:b0:306:32c4:7e7b with SMTP id h12-20020a5d4fcc000000b0030632c47e7bmr2951475wrw.41.1683021614402;
        Tue, 02 May 2023 03:00:14 -0700 (PDT)
Received: from [192.168.0.91] ([84.76.164.7])
        by smtp.gmail.com with ESMTPSA id t15-20020adfe10f000000b00304832cd960sm20629439wrz.10.2023.05.02.03.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 03:00:12 -0700 (PDT)
Message-ID: <c1986b45-b8cd-6c1c-7758-086dc943c7e0@gmail.com>
Date:   Tue, 2 May 2023 12:00:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] thermal/drivers/mediatek/lvts_thermal: Handle IRQ on
 all controllers
Content-Language: en-US, ca-ES, es-ES
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     Alexandre Bailon <abailon@baylibre.com>, kernel@collabora.com,
        Chen-Yu Tsai <wenst@chromium.org>,
        Balsam CHIHI <bchihi@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Alexandre Mergnat <amergnat@baylibre.com>,
        Amit Kucheria <amitk@kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-pm@vger.kernel.org
References: <20230428195347.3832687-1-nfraprado@collabora.com>
 <20230428195347.3832687-2-nfraprado@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230428195347.3832687-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 28/04/2023 21:53, Nícolas F. R. A. Prado wrote:
> There is a single IRQ handler for each LVTS thermal domain, and it is
> supposed to check each of its underlying controllers for the origin of
> the interrupt and clear its status. However due to a typo, only the
> first controller was ever being handled, which resulted in the interrupt
> never being cleared when it happened on the other controllers. Add the
> missing index so interrupts are handled for all controllers.
> 
> Fixes: f5f633b18234 ("thermal/drivers/mediatek: Add the Low Voltage Thermal Sensor driver")
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
> 
>   drivers/thermal/mediatek/lvts_thermal.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/thermal/mediatek/lvts_thermal.c b/drivers/thermal/mediatek/lvts_thermal.c
> index d0a3f95b7884..56b24c5b645f 100644
> --- a/drivers/thermal/mediatek/lvts_thermal.c
> +++ b/drivers/thermal/mediatek/lvts_thermal.c
> @@ -449,7 +449,7 @@ static irqreturn_t lvts_irq_handler(int irq, void *data)
>   
>   	for (i = 0; i < lvts_td->num_lvts_ctrl; i++) {
>   
> -		aux = lvts_ctrl_irq_handler(lvts_td->lvts_ctrl);
> +		aux = lvts_ctrl_irq_handler(&lvts_td->lvts_ctrl[i]);
>   		if (aux != IRQ_HANDLED)
>   			continue;
>   
