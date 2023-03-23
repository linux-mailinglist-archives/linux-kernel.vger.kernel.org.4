Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 749F66C618F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 09:24:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjCWIYG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 04:24:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50918 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231381AbjCWIXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 04:23:51 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36CB3303CC
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:23:47 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id eg48so82945015edb.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 01:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679559825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AIE/U68x3uSInXEW6KNHZvs1hznr1wFNENd55MjTdLk=;
        b=rLgf6L+07k4Eifu/vhgCPXbEUN5wzYR2AvYsJr3AQObjKl3S8LZRRiwtPtn7ajC8vL
         CJKD6qW1vuq70Nf9XIrKzDx2M4LTKsXJ+B1ne36RIPXhqAfL67FP+u4vLn2pOUBAPaXf
         W2l0WgC7xocf7hG5scQBtIGyp41h2NvGkDO0gkdFlRT/qoBz66ElIFX1PvYeHnuOIPip
         E6milHMZ6WbiN+bU/yNUYjkMfc5pwdPF9Z4Sx97vXdd00iQbRKA3ht8/IPc7OIuFKIjF
         7h12wjBFbD7VjphfKOaXfGEAgp7FejrMTes58GYzg66Z9O43921B84tUDhMoM12k4EDR
         aTvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679559825;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AIE/U68x3uSInXEW6KNHZvs1hznr1wFNENd55MjTdLk=;
        b=CJx1dxf3BNnwVd1dFz9SWsfgnUlSDgsKVIQwKGqaVUS+NO2lPB83vtxVM9X5wtRG0c
         nqYJODxtToKqy4eHp3XYfmZR47zUkN7kfTxhWG+84poIyrqfAxCKUoSOfohhNQzvLgq/
         YIcJkS0fAkNFu3j7NbS2OV/ezHh6hQznRdEtgsJ71Rh91gZY/ywmJ2bU+wtwsLlia8ii
         vYM5KjUZLqupVscn1MKzfcAOLgnBsDneyRGsoArA1XLMFZbdaQ9vjLTmTBvWniXO/thg
         E9YHIODCqRKsicSNY2CjmNRJ47WlraxPmDLHaUxfLItcjdPnm9i4Y3XgDTfphWEUeJRy
         Fa7A==
X-Gm-Message-State: AO0yUKXj5Nh/55FHcsoS7PbbqkJN73inixbhsMOKjlsY1qcyCUwDQMEf
        Rz1XR+oO/myKNl6G3lm+gXKvqQ==
X-Google-Smtp-Source: AK7set9Ft9Tio7464rwlMIwtDD2Ui7cQ1MoFhecyq9TTVIsrTGpdtRWhPZJZmljemRrMLTX6HApETA==
X-Received: by 2002:a17:906:22d4:b0:931:a0cb:1ef1 with SMTP id q20-20020a17090622d400b00931a0cb1ef1mr9364177eja.7.1679559825688;
        Thu, 23 Mar 2023 01:23:45 -0700 (PDT)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id e7-20020a170906248700b0093408d33875sm5524228ejb.49.2023.03.23.01.23.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 01:23:45 -0700 (PDT)
Message-ID: <7e9ee8e2-988e-1f51-e7ed-19f9e3181d9e@linaro.org>
Date:   Thu, 23 Mar 2023 08:23:40 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH V2 0/3] nvmem: support post read for U-Boot's "ethaddr"
Content-Language: en-US
To:     =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <zajec5@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Michael Walle <michael@walle.cc>, gregkh@linuxfoundation.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, u-boot@lists.denx.de,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>
References: <20230318171356.29515-1-zajec5@gmail.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230318171356.29515-1-zajec5@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 18/03/2023 17:13, Rafał Miłecki wrote:
> From: Rafał Miłecki <rafal@milecki.pl>
> 
> This change is required for NVMEM consumers to get expected MAC address
> from U-Boot env data variable "ethaddr".
> 
> To address some previous concerns:
> 1. Yes, U-Boot env binding & driver should be converted to NVMEM layout
> 2. My priority is to get working MAC rather than fancy DT syntax
> 3. I AM going to convert U-Boot env into layout later
> 4. This work DOESN'T conflict with layout migration
> 5. This code WILL stay during / after layout migration
> 
> My brain limitations don't allow me to handle everything at once, please
> let's review what I already have here.


Thanks for your patience.

Applied now,

--srini

> 
> Rafał Miłecki (3):
>    dt-bindings: nvmem: u-boot,env: add MAC's #nvmem-cell-cells
>    nvmem: core: support specifying both: cell raw data & post read
>      lengths
>    nvmem: u-boot-env: post-process "ethaddr" env variable
> 
>   .../devicetree/bindings/nvmem/u-boot,env.yaml |  7 ++++-
>   drivers/nvmem/Kconfig                         |  1 +
>   drivers/nvmem/core.c                          | 11 +++++---
>   drivers/nvmem/u-boot-env.c                    | 26 +++++++++++++++++++
>   include/linux/nvmem-provider.h                |  2 ++
>   5 files changed, 42 insertions(+), 5 deletions(-)
> 
