Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A271722472
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 13:20:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232221AbjFELTu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 07:19:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232157AbjFELTq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 07:19:46 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4760EA
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 04:19:44 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so47631545e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 04:19:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=monstr-eu.20221208.gappssmtp.com; s=20221208; t=1685963983; x=1688555983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/2GeFZgT1WnJNC/NfN0WVTSVRdYPWxbrrbu9DBaBK6U=;
        b=kjW0C+MgFAKdQgVjJ2kuxLTkFdjuMI93nt+89oMUVU4sEkzaImU4Ao1UB2XYA++Li2
         owjEqGJthIzUrTfr5f0Tf3Rm/iQJxly/E5p+zI/sKwfQ8Z1zpWa8pcUJzoti8akxAKpr
         P/c+ooVhOeVXTmQ/fD1h3WaB6bL7E3AAgk1V9gNBdYNJO2Kj9sqpRc6qE2hudvi+FYCn
         RmVD6i0xiInGI2GZyPudWSuRZ5Sv+RUGwEbH7Ob5/Dxfw/UgLZ1USa91nKKppX8lGYOx
         wLwW61JrWzEuv1DF6oQn1O7WgLsKsYTyhlM6iHX6os2mrChpHddLKx5xe1tErP2qWYwE
         ZrDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685963983; x=1688555983;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/2GeFZgT1WnJNC/NfN0WVTSVRdYPWxbrrbu9DBaBK6U=;
        b=ea0n0qE6LyImQ4fkPTT0rXtlpk9JacuZClCfRaTeEi92ABRlnATR6KsMYeZS0qLEfz
         fbO0RRNj7IMACvKYgV8tDSQe2vnPlbPQxctGsV9K6jBMzin2GaSCwp0u5ZmVM2xIjapV
         HZg2ozNImqOrVgWMwqPMF5T6TCScplqfyBhf+lJmgKKz0JTAIVwko5R4oa4vher6PdRb
         TBHaYTwmXJZX1CH3LBukUc7j2Z9n+Rdce02J04JanQdDOENkh0yIrpH+E2wJXSUCu57n
         6Px0UH+oCB9sUV/Xv7HwuihY9Qd6bn7vS5rcgd/yXoSP2RhUL1kK0kaU+8lZYbbgWp6z
         w8DA==
X-Gm-Message-State: AC+VfDwjQNNusDNnP9Rz/hsvP+6NdG/8iCiDDxIHQQ/ylFBxmvILruZ0
        Cq4jd4fH+6Man4Ai/I2RowEI+A==
X-Google-Smtp-Source: ACHHUZ6mGNEpvRyPdwOomBqN4k3CM+jb0DWupcVuQVVUi4/vhJIrU2g7E8GK/nmWc2Q2KOGB8Trk/w==
X-Received: by 2002:a05:600c:b43:b0:3f5:ffe2:91c0 with SMTP id k3-20020a05600c0b4300b003f5ffe291c0mr8173985wmr.0.1685963983279;
        Mon, 05 Jun 2023 04:19:43 -0700 (PDT)
Received: from [192.168.0.105] (nat-35.starnet.cz. [178.255.168.35])
        by smtp.gmail.com with ESMTPSA id y24-20020a7bcd98000000b003f42314832fsm10406288wmj.18.2023.06.05.04.19.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 04:19:42 -0700 (PDT)
Message-ID: <18921e62-e7f9-f6ff-7657-e755335a81ba@monstr.eu>
Date:   Mon, 5 Jun 2023 13:19:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH] dt-bindings: usb: xilinx: Replace Manish by Piyush
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, monstr@monstr.eu,
        michal.simek@xilinx.com, git@xilinx.com, piyush.mehta@amd.com
Cc:     Conor Dooley <conor+dt@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org
References: <504444f5c2f4e725ac39cba1d72032d5a00c7cda.1684828805.git.michal.simek@amd.com>
 <34a95a76-97f9-517f-e09b-a74a06d8da34@linaro.org>
From:   Michal Simek <monstr@monstr.eu>
In-Reply-To: <34a95a76-97f9-517f-e09b-a74a06d8da34@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/2/23 15:16, Krzysztof Kozlowski wrote:
> Resending as my previous email probably got lost. If you got it twice,
> apologies.

I got also the first one.

> 
> On 23/05/2023 10:00, Michal Simek wrote:
>> Manish no longer works for AMD/Xilinx and there is also no activity from
>> him. That's why proposing Piyush as the best candidate instead.
>>
>> Signed-off-by: Michal Simek <michal.simek@amd.com>
>> ---
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Anyway I will take it via my tree and soc tree.

Applied.
M

-- 
Michal Simek, Ing. (M.Eng), OpenPGP -> KeyID: FE3D1F91
w: www.monstr.eu p: +42-0-721842854
Maintainer of Linux kernel - Xilinx Microblaze
Maintainer of Linux kernel - Xilinx Zynq ARM and ZynqMP/Versal ARM64 SoCs
U-Boot custodian - Xilinx Microblaze/Zynq/ZynqMP/Versal/Versal NET SoCs
TF-A maintainer - Xilinx ZynqMP/Versal/Versal NET SoCs
