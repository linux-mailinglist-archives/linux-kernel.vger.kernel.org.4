Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2599691B0B
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 10:14:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231876AbjBJJN6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 04:13:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231765AbjBJJNr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 04:13:47 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40196CC47
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:13:35 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id o36so3323884wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Feb 2023 01:13:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HlncjyUCwyJrK1zxs8hOgkWlTAUHyGxnew5NJR5HoOk=;
        b=ioeihDRpWkLc0NiYcHmP2VjAXuXfJgTno0+GGHtc2ApSbnwf8ZttX4ToE2X1LGl9e3
         rn0sey7JRnTQvxRc9a3hCc/7r45zXLqRIBZVMQhygpAOE4Kh4evGQl/j2/5F58fj7KSV
         mkiLmdMz6lwrqwc3wgONkzWFfGxTEUllHMuDNYzHvkFyWPr5YSoA0usILw4IbULG6f7I
         oXf5tkS+Il5qR0PLlz/SUDOY1KL66rp4mRNBPhrD6skoJVFrascRyehbrjc6xoYBILoc
         MguYi5u3ynlBMdb34LDZjITpHuQ8jG00Y1tLH4kmK9EWK5Mr4E+koLbcI0+gzvwtr1br
         Yj0w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HlncjyUCwyJrK1zxs8hOgkWlTAUHyGxnew5NJR5HoOk=;
        b=tEVzCLITWV6O/GSvn5k4yQgwnMPrwNd45jJCSiA+9ouCyf2ZSc+RqDDVUp4BFWBuRg
         Q1uKRDq6dawmhRhwCzVkoLSi5Yowox91H8o6uCOxt6b+JlvIioWjQKWvCtPdE3atK/xa
         l5Bv9uSCho11xYuFvM6Z9npIq4SblfnVe81/EpA4tCDULiPgs6fg93FXmItVrSn/3ozB
         NKN9ZG7iO+8BUT25j8ZBr8Zxpgir0JM4M2Cox043pQ+JVDxr8AUNEyVfXHte9R0xSWQA
         y209HNcm6cM6Frqx0JV9Dh4ns4l8rFUpcKDbmjWbcvo+iQDNoSz9npHve3lNv9nVJc4z
         XbaQ==
X-Gm-Message-State: AO0yUKXXHIr0+3bfDc07EgyVESDX/huVNFkiT4946eIaMe4tZEZz63MM
        v/Cfj29L44sRPYZKB25lY4v05g==
X-Google-Smtp-Source: AK7set9hTzR19H75OZ+KCGwk0xY4ukdRB5fD+F5y3OEC4AKzPLXqs450JrI5RSl1Ypsyl9gIdXzqNA==
X-Received: by 2002:a05:600c:990:b0:3da:fc07:5e80 with SMTP id w16-20020a05600c099000b003dafc075e80mr1549310wmp.12.1676020414014;
        Fri, 10 Feb 2023 01:13:34 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id l19-20020a05600c2cd300b003dfefe115b9sm4965219wmc.0.2023.02.10.01.13.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Feb 2023 01:13:33 -0800 (PST)
Message-ID: <c1e096fa-5941-cdd8-2cdc-ecf04661a389@linaro.org>
Date:   Fri, 10 Feb 2023 10:13:31 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/4] soc: aspeed: Add UART DMA support
Content-Language: en-US
To:     Chia-Wei Wang <chiawei_wang@aspeedtech.com>,
        gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, joel@jms.id.au, andrew@aj.id.au,
        jirislaby@kernel.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org
References: <20230210072643.2772-1-chiawei_wang@aspeedtech.com>
 <20230210072643.2772-3-chiawei_wang@aspeedtech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230210072643.2772-3-chiawei_wang@aspeedtech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/02/2023 08:26, Chia-Wei Wang wrote:
> This driver provides DMA support for AST26xx UART and VUART
> devices. It is useful to offload CPU overhead while using
> UART/VUART for binary file transfer.
> 
> Signed-off-by: Chia-Wei Wang <chiawei_wang@aspeedtech.com>
> ---
>  drivers/soc/aspeed/Kconfig             |   9 +
>  drivers/soc/aspeed/Makefile            |   1 +
>  drivers/soc/aspeed/aspeed-udma.c       | 447 +++++++++++++++++++++++++
>  include/linux/soc/aspeed/aspeed-udma.h |  34 ++

NAK.

DMA drivers do not go to soc, but to dma subsystem.

>  4 files changed, 491 insertions(+)
>  create mode 100644 drivers/soc/aspeed/aspeed-udma.c
>  create mode 100644 include/linux/soc/aspeed/aspeed-udma.h
> 

(...)

> +
> +	return 0;
> +}
> +
> +static const struct of_device_id aspeed_udma_match[] = {
> +	{ .compatible = "aspeed,ast2600-udma" },

Undocumented compatible.

Please run scripts/checkpatch.pl and fix reported warnings.



Best regards,
Krzysztof

