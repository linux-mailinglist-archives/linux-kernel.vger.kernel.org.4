Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49A76722319
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 12:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230386AbjFEKNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 06:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjFEKNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 06:13:10 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BACCEC
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 03:13:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id a640c23a62f3a-977e83d536fso62714666b.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 03:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685959988; x=1688551988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EXo5Rv6lxYxO/Ac834u9DO3pHx7uLB62jagw1wFnYEA=;
        b=EQcAEoLOLVzga2GNKs65ncJFfLPyTrKY1MONFcKM+LvWQO9OAn7cgqrBE3JcWjxNkv
         vuahHS1hTxo39NBQIFlTdnFXWcloUBAPS/sbAutBDU74sMjry1UoeQujc177bIyHjUlE
         kDD6icuGeA3uaGuP/mnu6vzJGrKvi/En4EwX3NHgwViEMxTmQD8I5cUQKJ4Ox2srl2u5
         wSteN7hPcqu9espor8mvn2cQhxp8Gm5HGv1QWzkNHMZVqC5is15T+L/KQODrhwaQtSfR
         V/f5f5FeV7BnRNMi08k/4PYUQvm0h9WpTNwNsJjto1O0OKrGzQac2NCefQKJzepwhhfd
         K62g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685959988; x=1688551988;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EXo5Rv6lxYxO/Ac834u9DO3pHx7uLB62jagw1wFnYEA=;
        b=PckH+92lPbSc/8G5KLdTbOFaUD9PRJUB8ew9pHNU8tJSZTdaBOf7hTLxLaF5qIz1gr
         Z+zmds1njm/EPHKkDoip+edaOTBAFmRn83ycCa1OMkwdhfpHWP6LXT31GxvmNO9w+r1j
         uquqjaifQiuuV8ozrGDV/E8RqBYOA8zMUOLSDjTN6eZ2CAqk+C0TAwDgctWmTfEXcHdh
         kEwkWeEa4vD3rMdXjczOdhQDXgXjrRaySdgL7AY7DM5AieQaUPkCuHalVKV0vfnGtqUE
         7yslzHXBYOmGzvdPApWYQ8HoGFe+g8T0hh7fHj8mN/pZLfV9vDrjSrmThgWFE2ZaYSKz
         2Rhw==
X-Gm-Message-State: AC+VfDzsDL2SoELix8Ew2UeuFAIrq1ihRNKPn0Q68QLQgzZzwHX2AEq5
        dsjXEMkDr4gJ4qopndOWrY+46Q==
X-Google-Smtp-Source: ACHHUZ5YwqOJUS9L3wHNWuLMAHEd6L3fMzmNE1N/Ma9Ih52OBUDYSWBP/DeDR03+lq5lzq/2PXQQNw==
X-Received: by 2002:a17:907:2d2c:b0:966:eb8:2f12 with SMTP id gs44-20020a1709072d2c00b009660eb82f12mr5576990ejc.11.1685959987832;
        Mon, 05 Jun 2023 03:13:07 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id d10-20020a1709067f0a00b0096f5781205fsm4054001ejr.165.2023.06.05.03.13.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 03:13:07 -0700 (PDT)
Message-ID: <578088ff-9feb-3d03-f12e-577f105144f5@linaro.org>
Date:   Mon, 5 Jun 2023 12:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/2] dt-bindings: clock: Add nvmem-clock
To:     Mike Looijmans <mike.looijmans@topic.nl>,
        devicetree@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>, linux-kernel@vger.kernel.org
References: <1b153bce-a66a-45ee-a5c6-963ea6fb1c82.949ef384-8293-46b8-903f-40a477c056ae.2167d5ad-7e99-4eb9-a313-030fc7a7d546@emailsignatures365.codetwo.com>
 <20230526143807.10164-1-mike.looijmans@topic.nl>
 <c6d886d9-8f74-7af3-5478-030f5d6e4b1c@linaro.org>
 <ae4e2041-9fd7-30e7-8c0a-22a423c5871e@topic.nl>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <ae4e2041-9fd7-30e7-8c0a-22a423c5871e@topic.nl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/06/2023 12:01, Mike Looijmans wrote:
> On 31-05-2023 21:27, Krzysztof Kozlowski wrote:
>> On 26/05/2023 16:38, Mike Looijmans wrote:
>>> Add bindings for a fixed-rate clock that retrieves its rate from an
>>> NVMEM provider. This allows to store clock settings in EEPROM or EFUSE
>>> or similar device.
>>>
>>> Component shortages lead to boards being shipped with different clock
>>> crystals, based on what was available at the time. The clock frequency
>>> was written to EEPROM at production time. Systems can adapt to a wide
>>> range of input frequencies using the clock framework, but this required
>>> us to patch the devicetree at runtime or use some custom driver. This
>>> provides a more generic solution.
>> This does not look like real hardware. I mean, the clock does not fetch
>> its rate from nvmem, right? It's the Linux which does it, so basically
>> you described here driver, not hardware.
> Right, this just reads a setting from an NVMEM provider.
>> Extend existing fixed-clock bindings to allow reading frequency via
>> nvmem cells.
> 
> I just tried and implemented this, but it does not work. The reason is 
> that the fixed-clock implementation returns "void" in its 
> of_fixed_clk_setup() init function. The nvmem provider returns 
> EPROBE_DEFER because it isn't ready at this early stage, and this error 
> will not be propagated up because of the "void" signature. Thus, it's 
> never retried and the clock just disappears.

Linux driver problems are not a reason to add bindings for virtual
hardware...

Best regards,
Krzysztof

