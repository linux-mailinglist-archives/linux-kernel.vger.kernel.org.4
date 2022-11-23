Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0B6E63521C
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Nov 2022 09:18:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236001AbiKWISX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Nov 2022 03:18:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236491AbiKWISS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Nov 2022 03:18:18 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B787931214
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:18:16 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id s24so20507495ljs.11
        for <linux-kernel@vger.kernel.org>; Wed, 23 Nov 2022 00:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=fL0RQ9V3lsCHjFuI9X5q3hTnnfNaNlsOWbPGogwO7Tk=;
        b=lgfpAulgNwQyAsUYf92b42NDgYv4N76VOGD/OP/HSSTSBJcxgrReakyMNG+pVkl61t
         9DGBRp5UkjtO4P0q1WDFvUtAe5WlNEYHeSBa6GhXVhoE1+Tr8lt1CGUmNdXv4fRKIMWH
         JbX3V42YRa44xrUiHrH4rZmABG5PpWrxUta/nniWfk/LrKvfAbYwToDFB7lPDlJtchc0
         gQqR3Sr8VfS+mRRfmcXEAlwH/U/MPC3NM0pFspbpOgXNuV+6RQ+FrmMLxuRBNqS+Zqbt
         SUn82DCoy2dD5pLdHTmHjlrCH2aPpgTAs9OgPSB2U5sBqShu4QbKnOFsQRiNY8FGf6gs
         +I5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=fL0RQ9V3lsCHjFuI9X5q3hTnnfNaNlsOWbPGogwO7Tk=;
        b=xaZ1+9PYLrtZnwkKmvq027QnsY7Ava55i+Oaa15JjSXXCZ5lZmVs4NaeryKp9aq1Am
         P/+HB8JEqABlZ8EXGSuearmGqZIoQZsvMGdp1Ub8cHYnPxr1T8wQnjFIoWMiKoon1Spp
         WwzqcG+cUSbS//oaNMOvyN5vHYyjtdxe9Ka0ZOFYgJhjAwI0ip/z+EFR9e7gmiS4mJVQ
         V03Clv9b9YzBD0LfyBSuNAZJlrsNlJhiQKa1Ldy+3OvWx/EjTRVG2CT6PIvLAyB29ui4
         K71V21geUWmP2PFoOVc0xsR3B7y46YHB854uHG60WEAadG2k1TAXhlqFUqApR4b+hHSw
         k2yQ==
X-Gm-Message-State: ANoB5pmTSbtUM1fPioHHFZcBepHNCK1rNE3VIoeXmAIomJO3nx6wUBE+
        bOM6pJybU9+HgqU1s3SaJBFOryHqDAkLKZdJ
X-Google-Smtp-Source: AA0mqf6qdnORHkVtPLBs2odty+zr62ZdV3b3E3AHmbLeJ/v/hIe3N/3e/3cwDklJV2X74Rt7spHKmw==
X-Received: by 2002:a05:651c:205d:b0:26f:b445:8c8a with SMTP id t29-20020a05651c205d00b0026fb4458c8amr2918141ljo.156.1669191494829;
        Wed, 23 Nov 2022 00:18:14 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id m6-20020a056512358600b0049468f9e697sm2766578lfr.236.2022.11.23.00.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Nov 2022 00:18:14 -0800 (PST)
Message-ID: <51389853-35db-5162-e488-f5b3cfc25f27@linaro.org>
Date:   Wed, 23 Nov 2022 09:18:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v2 3/7] dt-bindings: pinctrl: mediatek,mt65xx: Deprecate
 pins-are-numbered
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        khilman@baylibre.com
References: <20221122010753.3126828-1-bero@baylibre.com>
 <20221122010753.3126828-4-bero@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221122010753.3126828-4-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/11/2022 02:07, Bernhard Rosenkränzer wrote:
> Make pins-are-numbered optional and deprecate it
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,mt65xx-pinctrl.yaml | 5 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

