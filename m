Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F8FD61F46A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 14:34:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231793AbiKGNeb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 08:34:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231361AbiKGNe3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 08:34:29 -0500
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E9B86242
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 05:34:28 -0800 (PST)
Received: by mail-lf1-x12b.google.com with SMTP id b3so16782012lfv.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 05:34:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vdz+1Q7zBiRW6MF3qhB7WV4Qg0sOEM6CF8MdyibKzIg=;
        b=ZqcfiCwwWO1bfGxaW+NajK7Ah+0AkL6zpxSFjpBZFKO/maY69WkC/T2O3p/Tn/WjMH
         cklt7vc97aY090LnP49+TE7qz/nTsbsOTi2OIf9mpPLcpwnIrhcjXDxShflGXDqYTORn
         a4hTVFOp6T58XWb4NtCn0BwCKci62yTUqpoC+sHKS/ofuk1AiJS78L4lV+YQIWX6kDKH
         K2QsA96zTowh5Jgon3MJf8mSIUBx4Q4IH7iVo6oojVVoI9DbH3lO3CVeWtrDsUDr4KW0
         NWVtS2BoI8/fYsE1zU9XV4UY6yRaCMCYHTydWLwkjrwVHryAUz2JAx7oKOECRRoIQast
         M7xw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vdz+1Q7zBiRW6MF3qhB7WV4Qg0sOEM6CF8MdyibKzIg=;
        b=UBlwMReQ29gCHSC58t+DTD2lwl6see6hnIwcia+NdfeLfTI5xwbnd+PCd4oBHokR/y
         V0Tf7JGamNXG4fROfTrNkYz/e0jSOz393MGSIV+eaKFr0DajQHR+v9r9JUu+DL2MvmpQ
         kvW8MJ3yFpFgFQyEXl3U4i/aZDyFdXbEbyHWn+4nRh7gLMHmUEEcNu4KCNPggQ1CmoFV
         LydY9k+f9dhJvnkBknQCi+Q7TjX5hy4HMeZbtmQTVQdtV+1HpE455/KCpYiy50sHRD9n
         s6xSjrfgWdQOnL50tA7VNSelQqzafGge0D0MydODZUC4WKi3VE3J52YfBxJFgSNStlqJ
         8cPQ==
X-Gm-Message-State: ANoB5plEr1RTDIpRXQJZRDcMcj2A79BE5GveYHBw6SHAOWdwTJCD9GIZ
        mjUcQ6TrkZcV13NCzC1Fk4sApQ==
X-Google-Smtp-Source: AA0mqf7Or3CcEibqyWEIh2bUM8AoblrV6X1Yf77y41Fbgy2z6wfFhhTpXR7/I0nZJPSrix0ZbST8wA==
X-Received: by 2002:ac2:4642:0:b0:4b3:e507:695e with SMTP id s2-20020ac24642000000b004b3e507695emr541281lfo.256.1667828066537;
        Mon, 07 Nov 2022 05:34:26 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id bi39-20020a0565120ea700b00492e3a8366esm1246878lfb.9.2022.11.07.05.34.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 05:34:25 -0800 (PST)
Message-ID: <8b547e46-04a4-6410-8394-70b9ea0c638b@linaro.org>
Date:   Mon, 7 Nov 2022 14:34:24 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 1/3] dt-bindings: arm: ti: Add binding for AM68 SK
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Nishanth Menon <nm@ti.com>, Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sinthu Raja <sinthu.raja@ti.com>
References: <20221107123852.8063-1-sinthu.raja@ti.com>
 <20221107123852.8063-2-sinthu.raja@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221107123852.8063-2-sinthu.raja@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/11/2022 13:38, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> AM68 Starter Kit is a low cost, small form factor board designed for
> TI's AM68 SoC which is optimized to provide best in class performance
> for industrial applications and add binding for the same.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

