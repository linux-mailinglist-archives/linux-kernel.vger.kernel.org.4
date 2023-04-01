Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4725F6D336E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 21:22:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229379AbjDATWV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 15:22:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbjDATWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 15:22:18 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7947265B6
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 12:22:12 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id ek18so102555112edb.6
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 12:22:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680376931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=H52CLwgFmzODWEV7ZyX88hXt21VjGMM7q2XWcXPYXZo=;
        b=G6+uM3HrsaIiZkEnGmnZSOZYDd/ctZc+WrWXMyfGRlwv+fiTkp0o5kwkLv5R037j6Z
         PVi6leKQjpijc7k7Dvd0D/YRD8w2GZzFnx+cbrzQIQkkQGg+3G5Wx+BT2KjoH7+lboVj
         mC8Sa5DxcEmjGwz1ji4dPX8741wsErTiLq/QqMTUoVT2Ay67YskSpESPchEpfQoH6Q/n
         QsH0qAtnG4R+oyrB093HI6yBG+xu7ABhG0PCMsmjKGPLbmhxw8wJkDudrEfcyUZ6sVCi
         ju39JUvm0J/KqKbnpL2mz2NJmV7htKOGyXYB77k7Vr/VSUxkJarNG3ulWBhebe4IqpC1
         hGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680376931;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=H52CLwgFmzODWEV7ZyX88hXt21VjGMM7q2XWcXPYXZo=;
        b=j5X06qdiNBkX4MxGQIpSqlqaKANsT5QYcWh53hZxrVwUWN46YcUVRUqLaCUJFK2GOe
         su/AElRW9zw2aRzrDffDUoK9olq63A9aQLHTogvvy24e859H+stnEyDmf2IqqILxuYim
         iUAXDRUGw9f79lLF0fimIG8N3+Jml+Ix++habfocE4EbN3awDbX/w45Eqtzq/si//gQW
         SUQA+yrhTVeFdQS8jLxRvr9dIlI0zjE9HRNZJFTORqCKn0qcqiQslKncQW5jRYfe1YVC
         EV/G7PYBEf+ncDZUC0fwtxXtyMCGdkApQA/p1qX1nqG1iQw7iRuTziANb7/RD9SBhpHp
         W8cw==
X-Gm-Message-State: AAQBX9cJ6xLjbnr0dC99hAtCVZ4xJ1d1oMXdIGD+yAUZsylYJvdwwrhl
        x9jGAN1f1wvQIWonHvMOAkdgmA==
X-Google-Smtp-Source: AKy350ZJm5tp5I2jb1NNBIGacDicX0JZU7mDL4ocTF+L63vX3OGy+zNeHCj3rg5mni+NVvpDu2lC6g==
X-Received: by 2002:a17:907:c248:b0:931:ce20:db8e with SMTP id tj8-20020a170907c24800b00931ce20db8emr32764689ejc.51.1680376931197;
        Sat, 01 Apr 2023 12:22:11 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ec00:3acd:519:c7c2? ([2a02:810d:15c0:828:ec00:3acd:519:c7c2])
        by smtp.gmail.com with ESMTPSA id cw16-20020a170906c79000b0093dce4e6257sm2364490ejb.201.2023.04.01.12.22.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 12:22:10 -0700 (PDT)
Message-ID: <900aa336-43a6-d357-0f33-7dee4f8c3a70@linaro.org>
Date:   Sat, 1 Apr 2023 21:22:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v10 1/3] dt-bindings: mfd: x-powers,axp152: Document the
 AXP313a variant
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>,
        Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>, Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Martin Botka <martin.botka@somainline.org>,
        martin.botka1@gmail.com, Shengyu Qu <wiagn233@outlook.com>,
        Samuel Holland <samuel@sholland.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-sunxi@lists.linux.dev, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230401001850.4988-1-andre.przywara@arm.com>
 <20230401001850.4988-2-andre.przywara@arm.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230401001850.4988-2-andre.przywara@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/04/2023 02:18, Andre Przywara wrote:
> From: Martin Botka <martin.botka@somainline.org>
> 
> The X-Powers AXP313a is a PMIC used on some devices with the Allwinner
> H616 or H313 SoC.
> According to the datasheet, the DC/DC converter PWM frequency is fixed
> (to 3 MHz), so disallow the property that lets us set this frequency
> for the other PMICs.
> 
> Signed-off-by: Martin Botka <martin.botka@somainline.org>

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

