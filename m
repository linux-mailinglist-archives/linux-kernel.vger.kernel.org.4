Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB928660068
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 13:41:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232967AbjAFMlc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 07:41:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233605AbjAFMlY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 07:41:24 -0500
Received: from mail-lj1-x230.google.com (mail-lj1-x230.google.com [IPv6:2a00:1450:4864:20::230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D16769B24;
        Fri,  6 Jan 2023 04:41:23 -0800 (PST)
Received: by mail-lj1-x230.google.com with SMTP id g14so1335776ljh.10;
        Fri, 06 Jan 2023 04:41:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2IEXWb90A2ORKetFHJM3fQKwX37z+1Oer7Os7LHk7HE=;
        b=TToPC1P90xgzIbNwuuuPO4EtE2wkqj9SO4p4W2r03VQ4DB+lCy1UxHBl4TlEQEF+Ii
         REkY0Tb0Xqoar17Mi6Dfluz05qJhRQCLjbLp/iW7FWhe3WeGnU9RjqCHtPHYG8agEMd4
         7mrPUGPArHaLyP4c2fhxyYabgnTD/rKJOuL2HapZB4e5yEAA1WqjcG2fLeU/fM45fo+M
         9Cbl4hKp/BqbXX9h9z33NOoFaHa7wdVZY5RKODyx6jkQKYD8gai863vT7tGHsZJFz5a6
         9oWax3naEbnKT9zbUYkVEBv/3VuaG7CFxN8sM95mR/4hIVuW7kT2tGOE1Zk/H20SUilf
         EFPw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2IEXWb90A2ORKetFHJM3fQKwX37z+1Oer7Os7LHk7HE=;
        b=oiNA+XLOeVHNw4xYB8tQrp5ygObP4CFTb7jimECNuunmqCvghzqTatPl9MkacHTj1N
         ix+LFhn/hDHLTZmctJymSdXiZhSPkcnTHLZAojkqwY15KlCzKqRif8SmfG9tSP20ip35
         7vHal5Kv84TWsFgDuux1GmrmnXYRVqrJs6VoHt5Kq1bAZqT/hC+iCi5KON0wz0C5GNJZ
         e9Qt0IvXf6LUZkdNgxl5Nf1NOPANU+4d0GDIFcH0K9SaMlByLuTZJ9wKdwO4XYT2AjGd
         XJTONEl1HlFoRwmUfX2u2sQasnQsz98ewS17hWrTaewlLNvddTub81ExD7GzyzQ4//E0
         IOlg==
X-Gm-Message-State: AFqh2kqu8mRt/yaGYBdzdOPY4noOHafWSnIrCfUFgESAUT+bt/w39uJP
        lzntefLZaXrBiLpdu1jI54Q=
X-Google-Smtp-Source: AMrXdXuuvyBfKUIHCcRdIkLZGHWR3DULmqKZZWFxcW+qVza2hQQ693JqcAig2NKuMvKRn6zqQzjK7A==
X-Received: by 2002:a2e:8256:0:b0:27f:ecef:bec7 with SMTP id j22-20020a2e8256000000b0027fecefbec7mr4992055ljh.20.1673008881754;
        Fri, 06 Jan 2023 04:41:21 -0800 (PST)
Received: from [192.168.0.108] (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.googlemail.com with ESMTPSA id be40-20020a05651c172800b0027ff5abbc96sm93018ljb.130.2023.01.06.04.41.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 04:41:21 -0800 (PST)
Message-ID: <2a6748b5-df3b-b3a7-f17a-664aab030b48@gmail.com>
Date:   Fri, 6 Jan 2023 14:41:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 1/3] dt-bindings: pinctrl: msm8226: Add General Purpose
 clocks
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230106114403.275865-1-matti.lehtimaki@gmail.com>
 <20230106114403.275865-2-matti.lehtimaki@gmail.com>
 <b866e6e1-da10-9152-8bda-966015998877@linaro.org>
Content-Language: en-US
From:   =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <b866e6e1-da10-9152-8bda-966015998877@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6.1.2023 14.32, Krzysztof Kozlowski wrote:
> On 06/01/2023 12:44, Matti Lehtimäki wrote:
>> +                blsp_uart3, blsp_uart4, blsp_uart5, cam_mclk0,
>> cam_mclk1, +                gp0_clk, gp1_clk, sdc3, wlan ]
> 
> Driver does not support them (and there is no driver change, unless
> you cc-ed people selectively...).

The driver changes are in patch number 2 of the series, I used
git send-mail with a cc script, which uses get_maintainer.pl to
get the needed addresses for each patch, to send the patches. It
probably didn't send every patch to everyone and would need some
improvement.

-Matti


