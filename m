Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8CCA6E6069
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 13:50:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231464AbjDRLuu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 07:50:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231143AbjDRLus (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 07:50:48 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3E983C2B;
        Tue, 18 Apr 2023 04:50:26 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id o29-20020a05600c511d00b003f1739de43cso2944078wms.4;
        Tue, 18 Apr 2023 04:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681818568; x=1684410568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hSo0y9CU6JHSsniPLuWjZnH8Pywoh9MjPxBwO/oPayE=;
        b=iYzCdFVpoMYIAY6TP9UzJhtj8UgzcAGZErudc9XqV/BMHdaAksha9j60H8OBXL6Xmj
         GA/sZHJitcsxf4vg37R1pKtl4ntCxyzve/dwfADMZDANIoIQUUqGCo7lBtjHiKTm87p8
         aMac/vux03EsWvEGqeX2pI44ydhjz6un1qy0qgO6jM9y1mSalZdrdN6YUnwiQtnc0ICp
         W4Spp+a3BMpOZZ8JBFOGcMbmDNRxKewd8C1UUT9JCfCjGQePuOW2cZWw6fUjR5PXB7rW
         R6yT75ej7rKjgR+Hs994NKnfjmVKqQvyzwK2Gh3xY9IBfRXzFxGg2mlJaWyMjpfyazXh
         8J3w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681818568; x=1684410568;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hSo0y9CU6JHSsniPLuWjZnH8Pywoh9MjPxBwO/oPayE=;
        b=XsT1aReR+0ZuNx3XarVVWSVR6SLgZvQRXo7C990mZl3O//kvKI3gbr9VzZRyXD36yb
         79PNNJi5XJNbTIn6uBNU4cozENtJf/UgsYdBTyvZxBf57sNryyvT0q7OTDO5yBwEuJbS
         KXZ9g7KJwzXjfp0Bk9nsbIqPqH2TN5bZV6fokm8C3tN8qmf4Lc3xwfVrCdKeUulhaqij
         0U+Su/y3sYyF4EOBTYJ96Cqa6pdsrfHKtXLMAFiPoLWWeL0UtmXpTzopwc4bpum9kcvC
         7OV3E7DkeJ/FzovEt3/8DAiwpC110Mjljg89mNHI2z0buQ3rY3mMzl/0JyO1dN9gzY1e
         RUxQ==
X-Gm-Message-State: AAQBX9dgsmCNKp2Bnxk2H/S2MKB3DmKte/wCAdODliLK/Fk7WoUqLJT4
        MZUriu5nfOcSGSwyjj4c5A8=
X-Google-Smtp-Source: AKy350Yw0P9E+LEmNEiXhXkFoVPpmOWwCwTlmkd1a6rpkMkfR5iRtWzbGGhV7W7Y15b6BUq8S6gO4g==
X-Received: by 2002:a05:600c:45ce:b0:3f1:7619:f0f6 with SMTP id s14-20020a05600c45ce00b003f17619f0f6mr3636747wmo.9.1681818567943;
        Tue, 18 Apr 2023 04:49:27 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id s9-20020a05600c45c900b003f09d51a4edsm18674280wmo.48.2023.04.18.04.49.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Apr 2023 04:49:26 -0700 (PDT)
Message-ID: <34acf346-a3d8-6f75-8d4f-0c68cda19506@gmail.com>
Date:   Tue, 18 Apr 2023 13:49:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] media: platform: mtk-mdp3: work around unused-variable
 warning
Content-Language: en-US
To:     Arnd Bergmann <arnd@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Moudy Ho <moudy.ho@mediatek.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Sun Ke <sunke32@huawei.com>,
        Ping-Hsun Wu <ping-hsun.wu@mediatek.com>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230418091555.2605961-1-arnd@kernel.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230418091555.2605961-1-arnd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/04/2023 11:15, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
> 
> When CONFIG_OF is disabled, the 'data' variable is not used at all
> because of_match_node() turns into a dummy macro:
> 
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c: In function 'mdp_comp_sub_create':
> drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c:1038:36: error: unused variable 'data' [-Werror=unused-variable]
>   1038 |  const struct mtk_mdp_driver_data *data = mdp->mdp_data;
>        |                                    ^~~~
> 
> Remove the variable again by moving the pointer dereference into the
> of_match_node call.
> 
> Fixes: b385b991ef2f ("media: platform: mtk-mdp3: chip config split about subcomponents")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>

> ---
>   drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c | 3 +--
>   1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> index 75c92e282fa2..19a4a085f73a 100644
> --- a/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> +++ b/drivers/media/platform/mediatek/mdp3/mtk-mdp3-comp.c
> @@ -1035,7 +1035,6 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
>   {
>   	struct device *dev = &mdp->pdev->dev;
>   	struct device_node *node, *parent;
> -	const struct mtk_mdp_driver_data *data = mdp->mdp_data;
>   
>   	parent = dev->of_node->parent;
>   
> @@ -1045,7 +1044,7 @@ static int mdp_comp_sub_create(struct mdp_dev *mdp)
>   		int id, alias_id;
>   		struct mdp_comp *comp;
>   
> -		of_id = of_match_node(data->mdp_sub_comp_dt_ids, node);
> +		of_id = of_match_node(mdp->mdp_data->mdp_sub_comp_dt_ids, node);
>   		if (!of_id)
>   			continue;
>   		if (!of_device_is_available(node)) {
