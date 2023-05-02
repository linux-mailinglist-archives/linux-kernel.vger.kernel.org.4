Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E66DA6F4B11
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 22:13:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjEBUNX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 16:13:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjEBUNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 16:13:21 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E0FA19A7
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 13:12:59 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id 4fb4d7f45d1cf-50bc4b88998so5500876a12.3
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 13:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683058378; x=1685650378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=P/xq/tzHtej/fzK6I1AmmjIHpO+eMLtvnYIVKZW+7ZU=;
        b=DazVRNWHg3hg8ml1vKRlpWVmXWmZxVY/GsbgFCWvkyqvPN4PR5paGnNNNKO9CTznhH
         JssG8hxbhzhOMHSHsLXawl9yWBh4eWWGQCHTD8biSjaywnpiNEm0cUAIkhGymrhqomqB
         34sJqpHbDZ34SYMbb4eIiI4LxURoFt2RAxCZA+QD19xXORRacMdr6WtZFNrz+bX8LlFw
         RVgpFEhinNYFT9cZMFVkpKhNuombPaGtVEh5JVOEcQ5rErL27sNbPEI6f2yg2RQdGP/8
         h6QUDCpjWr1ItVJ4j1pHyxMZCVAEg4uaCW6n4wzNkaqkPjcy888pbcrvryGst5UtaTit
         mesQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683058378; x=1685650378;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=P/xq/tzHtej/fzK6I1AmmjIHpO+eMLtvnYIVKZW+7ZU=;
        b=RDa9CpIaHbgDfff92x+m87Gf4ICIT1ZkMovTqJ7fB8zWfY0If3mEkz7qnqwpowQKkh
         4BgMqwtUDBL1OqpVyCkflhX/NecIXGlmQq2AlDFna0sjVLhYFbgm0m/DCoTYQdM1UG72
         KORZ8sCFWdf4WU3Vcjc7wQ1gOrL9sfOp+M0VtVuWkttACRE1i/d3Eg3bQ/OKopoydx27
         YdqfowW92n+PmzOUhyAwe4j+cx6692grTZreHsZ22WV7hJPnRmd3ZAU73YfyUHI45Npq
         jl4VurSAtHRP3ArDm08kmkZa1BnBTaXf8paFzI8aM5WWozl6fyaA1FEc1chNnz6A7HyE
         AJkw==
X-Gm-Message-State: AC+VfDwmQaN/lxs36A+nupRdyyY1pcYSqNnW9oHxbGoZ+VbXBaUxshem
        roH2SRPdRPLaU0Of526hCvOl5w==
X-Google-Smtp-Source: ACHHUZ6hcb+/wiMhyfbpB59/j6QyIW4RQ3+kUtH2G6Lsf9FdAhsCzVoLpKYvti1Cummm+uTzwurNPA==
X-Received: by 2002:a05:6402:1a48:b0:50b:c56a:feec with SMTP id bf8-20020a0564021a4800b0050bc56afeecmr6393797edb.17.1683058378156;
        Tue, 02 May 2023 13:12:58 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:37be:eda5:e303:19e0? ([2a02:810d:15c0:828:37be:eda5:e303:19e0])
        by smtp.gmail.com with ESMTPSA id b11-20020a056402138b00b004bd6e3ed196sm13386727edv.86.2023.05.02.13.12.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 May 2023 13:12:57 -0700 (PDT)
Message-ID: <041b6dbf-c55a-02da-350c-a6a968485482@linaro.org>
Date:   Tue, 2 May 2023 22:12:56 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] Revert "arm64: dts: zynqmp: Add address-cells property to
 interrupt controllers"
Content-Language: en-US
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Harini Katakam <harini.katakam@amd.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Michael Grzeschik <m.grzeschik@pengutronix.de>,
        Radhey Shyam Pandey <radhey.shyam.pandey@amd.com>,
        Rob Herring <robh+dt@kernel.org>,
        Robert Hancock <robert.hancock@calian.com>,
        Sai Krishna Potthuri <lakshmi.sai.krishna.potthuri@xilinx.com>,
        Tanmay Shah <tanmay.shah@amd.com>,
        Vishal Sagar <vishal.sagar@amd.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <e3312910db0922bb8c24a8e681de41709ca11bdf.1683035456.git.michal.simek@amd.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <e3312910db0922bb8c24a8e681de41709ca11bdf.1683035456.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/05/2023 15:51, Michal Simek wrote:
> This reverts commit c6badbd2d321c19d4f55ee56b0ef12bb3352feac.
> 
> Long time ago this was discussed with Rob at link below that there is no
> need to add address-cells to gpio and interrupt nodes that's why reverting
> this patch for ZynqMP.
> Also there is no visible DTC warning which was seen in past.
> 
> Link: https://lore.kernel.org/r/91e3405245c89f134676449cf3822285798d2ed2.1612189652.git.michal.simek@xilinx.com
> Signed-off-by: Michal Simek <michal.simek@amd.com>

That seems right:
https://devicetree-specification.readthedocs.io/en/latest/chapter2-devicetree-basics.html#interrupt-map


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

