Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E39DB74FEC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:37:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230474AbjGLFhs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:37:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjGLFhp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:37:45 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABC9E1712
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:37:44 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id 2adb3069b0e04-4fb9ae4cef6so10601652e87.3
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 22:37:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1689140263; x=1691732263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+pDAwsES6/UJGMRnoH6Hw6ybZSO8OTJt1TeRcdDP7sc=;
        b=aJtz6FNUeRcV1954EDvaz2DjKt0ooaO6XkF2f3HAIeuTpNylBKocZGx7tyt82eKCax
         7j7TZayLViSKP/vwaG3NeGCXPvnFPyrIDLAKW21qpfmNLkLKWWxeeKFrrMN0R6hPEjMw
         wsduODQAySQvq2EIzb8Wm7C6A39Dx4oGk+QHjfl0pgeuXAswYseoLyzux4tUtWep1tJX
         BcbIXcuSCT3VsvHyFourgbu1CeukdgF6/42swclh+kWobVB3xigJAhvgk9tux9iMsvuX
         i/W/weC7ErGg/PlyhkROoAAxXYSFYA6O6F+p2X/QS8QcROfF22lnWdCc/AExjAk1ySUY
         reXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689140263; x=1691732263;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+pDAwsES6/UJGMRnoH6Hw6ybZSO8OTJt1TeRcdDP7sc=;
        b=GxtSPIVUDYPFwObjO5qFsJjvIw//BREV4plvhksQJI//ZIjVWlwOYNj+x3GB2RHXoO
         fTEfNBwMGiU/UABDgxmcTi71dFU/n7k7kXUpoOov6LIs1u6mbnPy39rgqWZdzMhYxzZr
         iwoHKtzfn2NcQWFEqzuOLOyfPUsce9lbZIjjxAbJbyTuv5oc83shDsOx7YJDQ3aFj8k1
         cfXu7kRH2AS6GXnDVvrC3I1+VxE8rbjxm844K6sBA9KUWp0yxpCUNPkZd/nVNRHG07WD
         JkifrJvOSq+hsLspfmahRqjIOyesQM6UORof4BxaNIyJdAK97AEPsNDQ1yV4D66Gw409
         jZ5Q==
X-Gm-Message-State: ABy/qLbh+WIYQa98HxHubgrXAqJI/1fMkUNNr+mV7LeblLN9VtRFJfv4
        Bv9AlXgJL1pvcJ15Tx7fD9fcJQ==
X-Google-Smtp-Source: APBJJlEwqhkXOyt65V84KWLF0TrTw7ci9mw3/uJcSEo60JbAasj5LSNrmdrbPO3QWDCuzxL6PufJWg==
X-Received: by 2002:ac2:51bb:0:b0:4fb:90c6:c31a with SMTP id f27-20020ac251bb000000b004fb90c6c31amr12514057lfk.14.1689140262956;
        Tue, 11 Jul 2023 22:37:42 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id d18-20020aa7ce12000000b0051ddfb4385asm2199187edv.45.2023.07.11.22.37.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Jul 2023 22:37:42 -0700 (PDT)
Message-ID: <b3723443-2a27-0a51-babd-b36eef095913@linaro.org>
Date:   Wed, 12 Jul 2023 07:37:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v8 1/4] iio: adc: Kconfig change description for Allwinner
 GPADC
Content-Language: en-US
To:     =?UTF-8?Q?Jernej_=c5=a0krabec?= <jernej.skrabec@gmail.com>,
        linux-iio@vger.kernel.org, Maksim Kiselev <bigunclemax@gmail.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Cristian Ciocaltea <cristian.ciocaltea@collabora.com>,
        Andre Przywara <andre.przywara@arm.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        Arnd Bergmann <arnd@arndb.de>,
        =?UTF-8?Q?Leonard_G=c3=b6hrs?= <l.goehrs@pengutronix.de>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Haibo Chen <haibo.chen@nxp.com>,
        Mike Looijmans <mike.looijmans@topic.nl>,
        Quentin Schulz <quentin.schulz@free-electrons.com>,
        Maxime Ripard <mripard@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20230619154252.3951913-1-bigunclemax@gmail.com>
 <20230619154252.3951913-2-bigunclemax@gmail.com>
 <2148594.irdbgypaU6@jernej-laptop>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <2148594.irdbgypaU6@jernej-laptop>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 20:14, Jernej Škrabec wrote:
> Dne ponedeljek, 19. junij 2023 ob 17:42:24 CEST je Maksim Kiselev napisal(a):
>> This patch adds SoCs names to Allwinner GPADC description to
>> make it more informative.
> 
> Please reword to remove "This patch".
> 
>>
>> Fixes: d1caa9905538 ("iio: adc: add support for Allwinner SoCs ADC")
> 
> I'm fine with the patch in general, but does this really warrant fixes tag?
> 

No, it's some fake fix. There is no bug here.

Best regards,
Krzysztof

