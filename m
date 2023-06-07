Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 09AB7726928
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:48:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232969AbjFGSsx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:48:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230424AbjFGSst (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:48:49 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A6291712
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 11:48:48 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-9786fc23505so348423266b.2
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 11:48:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686163727; x=1688755727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=29OJvOdVP3cfctCNFEvqMHAvC+WSgkcfDomRRbTwfRI=;
        b=BYhKD8aiGexe+ybFIpMSTc4CnPKXfHx/fLqdreaTMszLmfINxfPq7uLgVjn9dAvoW9
         q2MpDREdmsFeEsjcFm/xPOQsQs0HC0zAputzOh7tLtzpFuRomomKCzaWAxYmsl8ZRuTD
         wzROqHF2/kQ2meahTSycbvcstDeMJWWs6b43h4TP7wcge98EpLGLsItbQCSI84peA07d
         URwyMNJ+V8DQjj8ADMthL0Kx7JrFq8v1DJfxB5VRPUVZ44oK9AegHUKUeX1LGhjPvTB7
         dTupgKfU45H0MSBjf+CpiAbiDVnOuf5E2PIqaslWYFwKlrhFQBxxjb12QfM9fVt2VdD3
         aaXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686163727; x=1688755727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=29OJvOdVP3cfctCNFEvqMHAvC+WSgkcfDomRRbTwfRI=;
        b=CYhpepGEAlJ5nkQpQT6yH/bAgY5VPjqSS/H9KAj1LiE2QUmv5Vdlhvmsjr9ghg7XVo
         Z9/g46iao5wckoxanVO7FbEtWJdPXjQpnsTLwfNTuCPshz0yQZ4u/F4ZeGeM2Uzsfepk
         vWx9QXwihQ8lWjBvq1q9ZD8iGgDlViMPegi8K+fABy34BkHrrRu5UlNa5tNrRO/2lEy2
         /C6G1kNtkLHpRPrR+VuE5eqNl5sGfc3EDb/qaEoS5as7HKuK+NVwo+T/EFZQ+Li/BxQ1
         6mHr26mUT4ov/c7aeKkUdVPSZGIDTWl23ghialj+gQMqnfhUKEmqQaXDv5fQlIzGoLRn
         ChVg==
X-Gm-Message-State: AC+VfDz67TYmcb0XSJiUifgkAfGhJPgM4jYwi3Y/+gdWncOs5DZ+SZX0
        bC5qvueb+24snDN2QALBfYE/dQ==
X-Google-Smtp-Source: ACHHUZ5G2lDFndSHPtYEc/klD3MXZikJ6vTsoEEYPxFBS8uE9R981LfGT7qPfxA27Utx0Uo1dMwYeg==
X-Received: by 2002:a17:907:8a05:b0:96f:9608:da7c with SMTP id sc5-20020a1709078a0500b0096f9608da7cmr7722896ejc.36.1686163726685;
        Wed, 07 Jun 2023 11:48:46 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id m15-20020aa7c2cf000000b00514a97b6b80sm6507254edp.78.2023.06.07.11.48.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 11:48:46 -0700 (PDT)
Message-ID: <bd2d1770-9856-d022-5e91-6a2cdc302b73@linaro.org>
Date:   Wed, 7 Jun 2023 20:48:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 0/2] Meson NAND: waiting w/o wired ready/busy pin
Content-Language: en-US
To:     Arseniy Krasnov <avkrasnov@sberdevices.ru>,
        Liang Yang <liang.yang@amlogic.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     oxffffaa@gmail.com, kernel@sberdevices.ru,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230607145026.2899547-1-AVKrasnov@sberdevices.ru>
 <a1e048aa-ec64-bd0b-aa17-e3e9bdf18090@sberdevices.ru>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a1e048aa-ec64-bd0b-aa17-e3e9bdf18090@sberdevices.ru>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2023 17:18, Arseniy Krasnov wrote:
> 
> 
> On 07.06.2023 17:50, Arseniy Krasnov wrote:
>> Main thing that this patchset adds is support for waiting for command
>> completion when there is no wired ready/busy pin. This is implemented
>> by using Meson specific command which operates without wired pin, but
>> supports interrupt driven waiting (default way for waiting without
>> hardware pin is 'nand_soft_waitrdy()' which uses software loop instead
>> of interrupt). To select which mode to use during driver initialization,
>> common NAND controller property is used - 'nand-rb'. It is described in
>> 'nand-controller.yaml'. But for Meson, its description was missed in
>> 'amlogic,meson-nand.yaml', so this patchset also adds support for it.
>>
>> Patch for bindings was tested with dt_binding_check and dtbs_check.
>>
>> Arseniy Krasnov (2):
>>   dt-bindings: nand: meson: Fix 'nand-rb' property
>>   mtd: rawnand: meson: waiting w/o wired ready/busy pin
>>
>>  .../bindings/mtd/amlogic,meson-nand.yaml      |  7 ++
>>  drivers/mtd/nand/raw/meson_nand.c             | 82 ++++++++++++++++++-
>>  2 files changed, 85 insertions(+), 4 deletions(-)
>>
> 
> Changelog:
> * Two separate patches:
>   For bindings: https://lore.kernel.org/linux-mtd/20230606193507.35024-1-AVKrasnov@sberdevices.ru/
>   For driver: https://lore.kernel.org/linux-mtd/20230607073015.1280085-1-AVKrasnov@sberdevices.ru/
>   Now fixed/updated and combined to this patchset with v1 version.
> 
> * In binding patch:
>   * Invalid type of 'nand-rb' is fixed, it was 'bool', now it is 'uint32 array' as required. Also
>     new declaration of 'nand-rb' contains several restrictions like number of elements and min/max
>     value of elements.
>   * Location of 'nand-rb' is moved from the controller object to the chip object as required.

Version your patchsets. This is v2, not v1.

Best regards,
Krzysztof

