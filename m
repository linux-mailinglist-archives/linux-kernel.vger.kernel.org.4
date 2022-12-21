Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267EB652E17
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 09:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiLUItz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 03:49:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234435AbiLUItv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 03:49:51 -0500
Received: from mail-ej1-x636.google.com (mail-ej1-x636.google.com [IPv6:2a00:1450:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 07B9E205F7
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:49:50 -0800 (PST)
Received: by mail-ej1-x636.google.com with SMTP id t17so35224163eju.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 00:49:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tkOSuHUzBTxFkwSXJ90hPWSIh5LICMT5pIVgCEzDQ50=;
        b=oqBs7mzdPwgyRidlzC5e+yBROeh8xMaYm6oCWIi1f8Wekk8p9U44UyhkslGvwceNaA
         5opmRYLKS9MKQ96t6qznlNGNP8+BYBNSrINKtFVAUkew4MTb0KQzQY2nLttG+Qq+YPlK
         xQHcW155w2lAyMTjFnw8EOPGbk37XvgzAoeHwpo6F5ZryU6emN7vWcNqUiQ5yohE2yFe
         Gj1dzGHr/NewHnrzOUHHbVJ7L5butdYwbhWrnqEeHN3rNbP+dDK3Sb6bdakxy91cGqJs
         TM5oGh0BY8HIcdf+2Rz/zgoUhIhcC6C2s8SyXH7ko+S9LUHLWv2brperAQijdvqqt/lx
         dSXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tkOSuHUzBTxFkwSXJ90hPWSIh5LICMT5pIVgCEzDQ50=;
        b=2Uf2OB3Hx9B506lxwosWA+IhDlQbs/D36tE0hX7yLPGTwKR/YTnU5fLSU6O99qu3ot
         tjvC0cnkAY6DLi6x2v/BumleQ37OmGeEmzUp+y4l8YxzQOpAhIvrFyWoYS5B3uqBAgrK
         IyR6C8sT+K4aAbLztZhXniEmQLWBqube/wDJMdUBVTg8AYbz5gslo/DOiR1a3PBF0bR0
         9dEfq6fSVzjyJE4dExuJAkuyYy6JlaowCRj38S9RO/NFjqh7uBbv++s2wX+lCCy0NWKt
         cGyIusNDzM+XG6bomHOGxGvRK+2m78E4k8vNO8WGIakxZm4/mku4bINiq70BqDBZJoSL
         rwwg==
X-Gm-Message-State: AFqh2ko3i4FVlqne5HOhiD79sMBWw2n8HN5xSvgotGKHM09cFBzocEOc
        85YMW2FxQYGremP5ZE3iqmGHDA==
X-Google-Smtp-Source: AMrXdXvfM0m5x2b9n+k7dskqxPIZYdggUAbEdzBLxPMaE9GUYYD8axtNUQl+Hw1cIZ7rgcUiiJJVMg==
X-Received: by 2002:a17:907:3f9f:b0:840:4901:901f with SMTP id hr31-20020a1709073f9f00b008404901901fmr144882ejc.3.1671612588568;
        Wed, 21 Dec 2022 00:49:48 -0800 (PST)
Received: from [192.168.0.173] ([82.77.81.131])
        by smtp.gmail.com with ESMTPSA id c13-20020a0564021f8d00b0046b471596e6sm6720705edc.57.2022.12.21.00.49.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 00:49:48 -0800 (PST)
Message-ID: <84378cf6-c0ca-0cf4-c3f2-c65b40bc837d@linaro.org>
Date:   Wed, 21 Dec 2022 10:49:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v3 1/2] mtd: spi-nor: issi: is25wp256: Init flash based on
 SFDP
Content-Language: en-US
From:   Tudor Ambarus <tudor.ambarus@linaro.org>
To:     Guenter Roeck <linux@roeck-us.net>,
        Sudip Mukherjee <sudip.mukherjee@sifive.com>
Cc:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        Pratyush Yadav <pratyush@kernel.org>,
        Michael Walle <michael@walle.cc>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>, greentime.hu@sifive.com,
        jude.onyenegecha@sifive.com, william.salmon@sifive.com,
        adnan.chowdhury@sifive.com, ben.dooks@sifive.com,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220920184808.44876-1-sudip.mukherjee@sifive.com>
 <20221221003009.GA280250@roeck-us.net>
 <96b4574d-8fe1-7662-5029-fc375f7b9ac9@linaro.org>
In-Reply-To: <96b4574d-8fe1-7662-5029-fc375f7b9ac9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21.12.2022 09:03, Tudor Ambarus wrote:
> Would you please revert the patch locally and do the
> tests from below? Thanks!

Disregard this, I thought you have a real flash. Michael is right about
qemu.

