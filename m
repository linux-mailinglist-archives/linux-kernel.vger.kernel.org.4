Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6B5717774
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234379AbjEaHB5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:01:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234445AbjEaHBu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:01:50 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E943E75
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:01:16 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f3a99b9177so6376519e87.1
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 00:01:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685516474; x=1688108474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Gugzw/ZDhVToGVEb0wC3/St7NtpJ5Cjx1IuUybeWuA0=;
        b=S2EAHmLNqWgUjK2TlPEND4ZmV7qdlytu2hedseQ/zs7R1VBaFyyVZwzUhFrI7FEO4H
         5B+upiEQK4QBOV1bIbBh2TwyuKdi+7XCgySJcqhZkM1ro/pdSR4a8JderVfk6Gv11fLt
         b1TL2u9QzVAuMFgYOIbfDtCKmTz9Ker2MSLfXplW1BTYX5BrF8hjBedAptBGcyAJmKkX
         xWdhdX/XY2+6Wt5J7RV+WOGan9FFgwIorbJO122p99QhCmnpVbk5hhbHUfv46yyJHpi0
         jSr54Y9sDQZSs69yeirP2wW9nfExjDw87wKplolbqMOBKDOOqbnDD7lMCvQ1XQq7nE6Y
         stvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685516474; x=1688108474;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Gugzw/ZDhVToGVEb0wC3/St7NtpJ5Cjx1IuUybeWuA0=;
        b=YGHd3lfQM8GjQRZeVfvqEtdilMog86iBmOU33cajDExBTqyW3Sp8uj/jSJ+ugjCabY
         zJ6Qk7LO0b29BSxdQV/iamD/czRygkX/o48dGnExGhC1fWrQ8R+sj9msATX4pKIj3diw
         /CJkjTfWbxRcnVkVqg3B79GvvULEr97yKg0CbBys5HiXslBfIqeOvsjNKRxjVZSZa20M
         hgJ7WNnXIjSza3CwMT1lbFTrDG8jD9uBrgneru54aSnZecqOc5ExHdyAXj4IioK1V9fS
         bcmMYxsJoVFh8Deb8+80+w97uV1F7+nNDSQ3YkcyVGamFS8Ergh5EJ3D7ZuSqEK0WVr8
         X9WA==
X-Gm-Message-State: AC+VfDxs7CMtywKaC03xBB7ph9fWBvCN6/DgU6InVSbQma2cxk5LVZxt
        TIRMdVEdu72AKPHCwA2X1ckn2g==
X-Google-Smtp-Source: ACHHUZ77G6Irh/j2MUHoe+ZtxAn87Qu5gUjnNAB/q3541+lFfODk7BxDYIm5+ELskaXbqrnyQNU3hw==
X-Received: by 2002:a19:750c:0:b0:4f4:b378:46a3 with SMTP id y12-20020a19750c000000b004f4b37846a3mr2282004lfe.36.1685516474665;
        Wed, 31 May 2023 00:01:14 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id r25-20020aa7da19000000b00510d8e43fe0sm5278648eds.7.2023.05.31.00.01.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:01:14 -0700 (PDT)
Message-ID: <518ce618-42c6-21f3-34ff-dd5a46fd5d3c@linaro.org>
Date:   Wed, 31 May 2023 09:01:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v6 1/2] dt-bindings: mtd: marvell-nand: Convert to YAML DT
 scheme
Content-Language: en-US
To:     Chris Packham <Chris.Packham@alliedtelesis.co.nz>
Cc:     "miquel.raynal@bootlin.com" <miquel.raynal@bootlin.com>,
        "sebastian.hesselbarth@gmail.com" <sebastian.hesselbarth@gmail.com>,
        "gregory.clement@bootlin.com" <gregory.clement@bootlin.com>,
        "vadym.kochan@plvision.eu" <vadym.kochan@plvision.eu>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "vigneshr@ti.com" <vigneshr@ti.com>,
        "conor+dt@kernel.org" <conor+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "andrew@lunn.ch" <andrew@lunn.ch>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "linux-mtd@lists.infradead.org" <linux-mtd@lists.infradead.org>,
        "enachman@marvell.com" <enachman@marvell.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "richard@nod.at" <richard@nod.at>
References: <20230530005337.3687938-1-chris.packham@alliedtelesis.co.nz>
 <20230530005337.3687938-2-chris.packham@alliedtelesis.co.nz>
 <20230530122625.7zu3ey5dnn6izeli@krzk-bin>
 <c030b2c5-2f44-72c7-f06f-9fa7b9247992@alliedtelesis.co.nz>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <c030b2c5-2f44-72c7-f06f-9fa7b9247992@alliedtelesis.co.nz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 22:59, Chris Packham wrote:
>> nand-controller@43100000: Unevaluated properties are not allowed ('dma-names' was unexpected)
>> 	arch/arm/boot/dts/pxa300-raumfeld-connector.dtb
>> 	arch/arm/boot/dts/pxa300-raumfeld-controller.dtb
>> 	arch/arm/boot/dts/pxa300-raumfeld-speaker-l.dtb
>> 	arch/arm/boot/dts/pxa300-raumfeld-speaker-m.dtb
>> 	arch/arm/boot/dts/pxa300-raumfeld-speaker-one.dtb
>> 	arch/arm/boot/dts/pxa300-raumfeld-speaker-s.dtb
> 
> I've been running `make ARCH=arm64 dtbs_check 
> DT_SCHEMA_FILES=marvell,nand-controller.yaml` (and similar for arm) but 
> didn't see these am I doing something wrong or did I just fail to look 
> properly.

It's fine. There were false positives in the report.

Best regards,
Krzysztof

