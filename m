Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F3CE632229
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 13:33:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbiKUMdU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 07:33:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231128AbiKUMcz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 07:32:55 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE37BC0537
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:31:32 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id a15so14317162ljb.7
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 04:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T7QmgsUXbk5ulUZ1hF0nbMp3XdRFQhnR410qxXP28rY=;
        b=KmnUc0D1CjTUMDO40A7MQkDJlIe5cwPCU3aHqrRmO4U0jXyi1P1xglanxf4YVHj0l4
         rKthJadqCRIIrQ0w4CVc9M8U+0mbWZk+mHX39m4deNY2/8Ce//i469Qh39FWPG43zCoL
         Q8RQKhVstKSPYynkF1OswMzSy9ZsBh18o754Bkk9xk26rUvPalVvVYEnBzhLg+/aUn3r
         bVSrEEEE/016AoVvIdokpapMz/ORZasJ+OpLsEg87QZwfYcPg5g8LEq6OWNr9uniFZAI
         e2+m0hltvBzD020NNve67V6erXHA9i/0Iw9Dinqtal7pGEf5jF6hfWjgWlmcjIDGlfEz
         9tcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T7QmgsUXbk5ulUZ1hF0nbMp3XdRFQhnR410qxXP28rY=;
        b=NUB+HYsZyU00Xouk0sAkuuJoMSSKmZI7U4GTAJdPEgJ5fX7kn0shY+YU3s/xfOU+Xu
         pbnTvanMxb6VzEZkPPybXyjKNGi4jixkUTrSmGEk9iJAURAwo1mIoAvupF92GJvjTux7
         oJptkn4t7Y61jQ9W1TXncR+HsYKDJrdiUalI5K3MnPgvWcnEE5hL26PDsc8/aczZjlKm
         8S/Nm6DT3m7a2riZ5XAlZA93lSa7lnKe/Z0yaoe/exjSwgg/vLpYmnA6EeSydc2pj6ZA
         n0WiCel9cAgK2shZFgQfB+5NANLjybdYnno+jriT+cFcZtYx3wgSK3zI2BtqBli/CI68
         UhEw==
X-Gm-Message-State: ANoB5pkp7CB1XMs6xjN5ZJKXT1OL2NtUBuin0dLiMP1pcbGM9aSslNCz
        E6G/YpYl90Kty5OukzB6uruAH4p/5AxJ3Z0+
X-Google-Smtp-Source: AA0mqf4bjSXPY0u/1byf7bRmllNXjWyAVYxWC7TCztAPelgseKtZJI1xTRh9q7ZbH/ccq7gTj7C0NQ==
X-Received: by 2002:a2e:b80e:0:b0:277:5279:1b8 with SMTP id u14-20020a2eb80e000000b00277527901b8mr5542577ljo.58.1669033890732;
        Mon, 21 Nov 2022 04:31:30 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id y4-20020a05651c106400b0027754bdd667sm1387581ljm.109.2022.11.21.04.31.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 04:31:30 -0800 (PST)
Message-ID: <d507f9ff-d170-dc3a-cb73-f00b8b04c6a5@linaro.org>
Date:   Mon, 21 Nov 2022 13:31:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] arm64: dts: Add SYSREG nodes for FSD SoC
Content-Language: en-US
To:     Sriranjani P <sriranjani.p@samsung.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        devicetree@vger.kernel.org, alim.akhtar@samsung.com,
        pankaj.dubey@samsung.com, ravi.patel@samsung.com
Cc:     linux-kernel@vger.kernel.org
References: <CGME20221121090555epcas5p29c8c7de6dba38449aaf3357beb43432d@epcas5p2.samsung.com>
 <20221121091118.48628-1-sriranjani.p@samsung.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121091118.48628-1-sriranjani.p@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/11/2022 10:11, Sriranjani P wrote:
> FSD SoC has three sysreg nodes one in PERIC block and other two are in
> FSYS0 and FSYS1 block. This patch series add required DT binding and
> DT file modifications.
> 
> Sriranjani P (2):
>   dt-bindings: mfd: syscon: Add tesla compatibles found on FSD SoC
>   arm64: dts: fsd: add sysreg device node
> 
>  Documentation/devicetree/bindings/mfd/syscon.yaml |  1 +
>  arch/arm64/boot/dts/tesla/fsd.dtsi                | 15 +++++++++++++++

This does not CC necessary lists and folks, but that's MAINTAINERS or
get_maintainers.pl fault. I sent a patch for it.

Best regards,
Krzysztof

