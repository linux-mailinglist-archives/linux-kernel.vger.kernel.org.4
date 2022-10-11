Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA3505FB521
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 16:51:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbiJKOve (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 10:51:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbiJKOuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 10:50:46 -0400
Received: from mail-qt1-x836.google.com (mail-qt1-x836.google.com [IPv6:2607:f8b0:4864:20::836])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DBCB66A4E
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:50:37 -0700 (PDT)
Received: by mail-qt1-x836.google.com with SMTP id g11so3729659qts.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Oct 2022 07:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ARkoPd8M29kPGeM8qAWkfi6M8hZhp8t8SkTlUe/Jc3A=;
        b=IWg6YoA+R7v4mauRKQrSCQgXgONUNjMUZKf3hMdGFKBs19oQlccYIH3Dt2H4nqXjd5
         lyjnDsbUVM+rt9nzkHZ72mOwr1YCjZegGE+b6ne+0pVvaId/nRqZXlTMpELUPvnMq6CJ
         shbVvHkkms9M6CjpMI7Mzpy9Z7x9Z7rGGKWZw1Q24qIToaAxY4eJjd3X1G5RLusItVuK
         SjYbH4pqcO0jddEDpyHPmrUO43xhn/xWrRlbkGsQjzpdwNxx+FIjYJ/GthD0DXo96RhW
         mseHa48tNZGf4FlCcr8Zhm6IPzmXeZWgCtNHBMMAmdUrEmZSecNEIUvPiBUmTuPh9yB2
         DK2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ARkoPd8M29kPGeM8qAWkfi6M8hZhp8t8SkTlUe/Jc3A=;
        b=j9Dg7q59xigI/Qb5FYCulhmqwAC/gInj7hIvocbVSfOk41+Xoc0MtJdFDKrnpZNFCf
         inW755PP6hWLFvJvupYKWZqqqDhvLNInznlUlhxs9bfMEkeo1ZnAS8s6DzxHgLnw0WSI
         6A+wKJB6g087lE7HFxjGAIsRNLOMn9ofqRqlDIVFbdy5AeQfa8V0zG3MW5wUoXtw/FVQ
         23UWLTC05+choAZGCtqj6mCnObIxlgOc1p4LZhD1EQK0vPGp3G2GfQZn7QfpN6rRVv9t
         x45iqtQWSVONO273E93IZTp7aW27V08Uw10EKz9XdbTWvp59DAgqKspBggIdXhgd4llh
         B3Zw==
X-Gm-Message-State: ACrzQf3yM8wtL/XS7N8lODX8JP7zqJD7og2iAkKaAptAI92QzxYv/HmF
        CNceGvcPnR/iC1H3jLCB6jurbw==
X-Google-Smtp-Source: AMsMyM4+tXXvWkoKLCPUTn8kj2gzDJcsSI7tHkYr4xYjw4DcJe9MBSvtRF/eE+iCFLqTtili11742g==
X-Received: by 2002:a05:622a:138e:b0:399:2b42:5ff1 with SMTP id o14-20020a05622a138e00b003992b425ff1mr10561720qtk.361.1665499835495;
        Tue, 11 Oct 2022 07:50:35 -0700 (PDT)
Received: from [192.168.1.57] (cpe-72-225-192-120.nyc.res.rr.com. [72.225.192.120])
        by smtp.gmail.com with ESMTPSA id a18-20020a05622a02d200b0039543f89109sm11383713qtx.96.2022.10.11.07.50.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Oct 2022 07:50:34 -0700 (PDT)
Message-ID: <72b9809e-d6d7-862a-26b8-221d14ea4322@linaro.org>
Date:   Tue, 11 Oct 2022 10:48:22 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH v6 6/6] arm64: defconfig: Add tps65219 as modules
Content-Language: en-US
To:     Jerome Neanne <jneanne@baylibre.com>, lgirdwood@gmail.com,
        broonie@kernel.org, robh+dt@kernel.org, nm@ti.com,
        kristo@kernel.org, dmitry.torokhov@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, catalin.marinas@arm.com,
        will@kernel.org, lee@kernel.org, tony@atomide.com, vigneshr@ti.com,
        bjorn.andersson@linaro.org, shawnguo@kernel.org,
        geert+renesas@glider.be, dmitry.baryshkov@linaro.org,
        marcel.ziswiler@toradex.com, vkoul@kernel.org,
        biju.das.jz@bp.renesas.com, arnd@arndb.de, jeff@labundy.com
Cc:     afd@ti.com, khilman@baylibre.com, narmstrong@baylibre.com,
        msp@baylibre.com, j-keerthy@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-input@vger.kernel.org, linux-omap@vger.kernel.org
References: <20221011140549.16761-1-jneanne@baylibre.com>
 <20221011140549.16761-7-jneanne@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221011140549.16761-7-jneanne@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/10/2022 10:05, Jerome Neanne wrote:
> This adds defconfig option to support TPS65219 PMIC, MFD, Regulators

Do not use "This commit/patch".
https://elixir.bootlin.com/linux/v5.17.1/source/Documentation/process/submitting-patches.rst#L95

> and power-button.

You explained what you did, which is easily visible. You did not explain
why you are doing it.

Best regards,
Krzysztof

