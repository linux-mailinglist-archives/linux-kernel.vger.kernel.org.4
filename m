Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464E8734899
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Jun 2023 23:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229543AbjFRVeD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Jun 2023 17:34:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjFRVeB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Jun 2023 17:34:01 -0400
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B594E1;
        Sun, 18 Jun 2023 14:34:00 -0700 (PDT)
Received: by mail-lj1-x231.google.com with SMTP id 38308e7fff4ca-2b466744368so20640031fa.0;
        Sun, 18 Jun 2023 14:34:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687124038; x=1689716038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IOkfA4GaYDZQ1KN9R5z9rbZZiuOU0JFMDz+JkNVoMfs=;
        b=aAQvxhthEnemgwN0nPek8VPAe3c11NrE5vCc+DphFxmfMZqaWyrmMIZOwGm4aBNMQU
         NbjAdD3fhtV776hvXI2DVLsbuTuttHb+Pqdylq2JYMd05eBq/M+dacpuYlyuT87VXS4f
         LvISPpp4xWuHE0xCKecnyNtk52xGXkC6kOYVi73vbT5XKwyyERjRdP8ypjjID5mlLxj6
         ZIFFaFYn4VE1gYK8CQ2fvE/U5BPsfr+rPqWG+BYCsL6aGj2KBdhzWCYx9vdofRRdvb0x
         WdqXu8l6XssSq4MDHy7V3A1g5kgP+C4cwtfLTTLLCatE7xUaT0PMdyKN5tCwalAJyEfT
         S53Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687124038; x=1689716038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IOkfA4GaYDZQ1KN9R5z9rbZZiuOU0JFMDz+JkNVoMfs=;
        b=Dh7G5/rO8Zs59+SL/8nchStUkJXiRk2BysEigQgiWz/qddAkQRI4Iy1U05dp4VK7oN
         UsYx94kmBMXvzGItJzP6WmXOeBzWoZQsCWF+ZaD+tw+SLRHxRlPO00qz3nP75Xi9ZsTV
         L+55dkSOIzisFGlmb3KuWkz1+QXngamRbrB3PiYPQNQcipBeepqCSXJpaJbMHOgHxZyu
         PhvPnrgm3NObwcV7WbxKFNCFRdZcBrneJoSiIdlDu9krcYTqxWqoOv9m1+q6UgS5hZUL
         YDi94qxQjyyfYfYHHBlChr5KngXxajWuVFSZLWM9bD1j+MbWCOBbecRWcn34ydURU9bD
         IxfQ==
X-Gm-Message-State: AC+VfDzQSVf5camHpzkq1KoWxfmyzJKjCtx89FY4X2uVxcjARZkvL7WJ
        +vsoG1O4sQcBMLoNd4ZwwjI=
X-Google-Smtp-Source: ACHHUZ6pDuW5qdUrIsfxfB9WTCqbDn7YAwLcOcCOYbQq5TcMIHTtccwbnokjfhHkYJy2zt8464CiyA==
X-Received: by 2002:a2e:90c9:0:b0:2b4:7380:235 with SMTP id o9-20020a2e90c9000000b002b473800235mr1036205ljg.32.1687124038186;
        Sun, 18 Jun 2023 14:33:58 -0700 (PDT)
Received: from [192.168.2.145] (109-252-149-7.dynamic.spd-mgts.ru. [109.252.149.7])
        by smtp.googlemail.com with ESMTPSA id s25-20020a2e9c19000000b002b469fd0baasm965650lji.111.2023.06.18.14.33.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Jun 2023 14:33:57 -0700 (PDT)
Message-ID: <e41ff013-8224-1b96-5cd3-f0632d27191d@gmail.com>
Date:   Mon, 19 Jun 2023 00:33:56 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] misc: sram: Generate unique names for subpools
Content-Language: en-US
To:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Rob Herring <robh@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230417-ux500-sram-v2-0-6e62ad551faa@linaro.org>
 <20230417-ux500-sram-v2-2-6e62ad551faa@linaro.org>
From:   Dmitry Osipenko <digetx@gmail.com>
In-Reply-To: <20230417-ux500-sram-v2-2-6e62ad551faa@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

21.04.2023 00:17, Linus Walleij пишет:
> The current code will, if we do not specify unique labels
> for the SRAM subnodes, fail to register several nodes named
> the same.
> 
> Example:
> 
> sram@40020000 {
>   (...)
>   sram@0 {
>     (...)
>   };
>   sram@1000 {
>     (...)
>   };
> };
> 
> Since the child->name in both cases will be "sram" the
> gen_pool_create() will fail because the name is not unique.
> 
> Use dev_name() for the device as this will have bus ID
> set to the fully translated address for the node, and that
> will always be unique.
> 
> Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
> ---
> ChangeLog v1->v2:
> - Stop complicating things and just use dev_name()
> ---
>  drivers/misc/sram.c | 9 +++++----
>  1 file changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/misc/sram.c b/drivers/misc/sram.c
> index f0e7f02605eb..f80c3adddf0b 100644
> --- a/drivers/misc/sram.c
> +++ b/drivers/misc/sram.c
> @@ -240,10 +240,11 @@ static int sram_reserve_regions(struct sram_dev *sram, struct resource *res)
>  				goto err_chunks;
>  			}
>  			if (!label)
> -				label = child->name;
> -
> -			block->label = devm_kstrdup(sram->dev,
> -						    label, GFP_KERNEL);
> +				block->label = devm_kasprintf(sram->dev, GFP_KERNEL,
> +							      "%s", dev_name(sram->dev));

This broke device-trees that have no label property. The SRAM DT binding
says:

"
label:
description:
	The name for the reserved partition, if omitted, the label is taken
	from the node name excluding the unit address.
"

Not sure whether breakage was on purpose, otherwise doc needs to be
updated or there should be explicit check for the duplicated node names.

Secondly, AFAICS, the dev_name(sram->dev) is the name of the parent SRAM
device and not of the children sub-nodes, hence it's now always the same
dev_name(sram->dev) for all sub-nodes.

