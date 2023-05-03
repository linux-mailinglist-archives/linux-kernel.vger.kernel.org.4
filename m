Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9506D6F5940
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 15:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230220AbjECNqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 09:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229793AbjECNqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 09:46:30 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37DD249F9
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 06:46:28 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id 4fb4d7f45d1cf-50bd37ca954so6961547a12.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 06:46:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683121586; x=1685713586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=axb4hsXlmFr83tA4xeoHXLKOgCRNm9SMQj6gN9PpDXw=;
        b=QAzuGmeNB88tZp09MZP0yiysHnaBQL2cCSdPygobX+guQiWepOealJNlfOK+r3g/AS
         rAoFzy4Mm0EOQnZyGC2l86+uKx+sIRltqfAquaHCYPdxCnrJh4xUD4te+D7NG2U9U4o6
         NL45bLJnD6ld8KkSOplfnBwJpOJV9xdTOCpVVKZbumYVHymGGAHiG0Pz60dkvcPpU1Bx
         eVrQtKswaAc3V36t2+egEsImcQtKJ4dDVQMi+sIsVFK1IaaUNNQon1Ywuj9TMh0oTSjQ
         GHlXN+qcqQZi0tLVB3K4f7mCgafvFsFhy/26JnIUNYVfNuMvBY0bf/rQvZOlX6EZNny2
         r8Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683121586; x=1685713586;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=axb4hsXlmFr83tA4xeoHXLKOgCRNm9SMQj6gN9PpDXw=;
        b=JSUy0yT+xV2yC3hOdxv0AZYljGJRG0Bd2ij8OMcIpMBR43tftCelHzPzp1dKOMAuog
         zsL8WeUIqaFPVDqmBqGmPusGXai5j8tTvcgfvuT7/Tc3fFFlEumlsX9DTsbnQnPRsZ+s
         5iTQlLt69N8NkBhJMT7za0saO8g48KbWV5qZeCgSEaBs4F0eBmuhLj7Q3UfvvBxPglBi
         Hlem/mJlatzYZNDKcVVOZvFubgSkrUjtjjyYEEXL90V6hWJxOWAqDQxr4J+cDwqhiK7q
         z6ndkoMVzIH//9jCCl0GX5qK4egwl8OlltcjgqYTHpR8SU4vDaHZjUxW5O16R2Iaygh6
         bsDA==
X-Gm-Message-State: AC+VfDyKNiGOUccoRSJviwyVTcqWPkMX+nlNDeB2Q2S5cKU/5jD0yEA0
        TKEB2L27KIbqEZA71evgCgB9iA==
X-Google-Smtp-Source: ACHHUZ4NuFlJ/Wa7YCqOr30cagS7gjoxX7SmR72GunTu/7lDsfbshb9zK3nhCGjzdoiZaNi7Bm/2WA==
X-Received: by 2002:a17:907:7e83:b0:94e:83d3:1b51 with SMTP id qb3-20020a1709077e8300b0094e83d31b51mr1842852ejc.23.1683121586596;
        Wed, 03 May 2023 06:46:26 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:db42:e3d0:c55a:8cf1? ([2a02:810d:15c0:828:db42:e3d0:c55a:8cf1])
        by smtp.gmail.com with ESMTPSA id s12-20020a170906bc4c00b00947ed087a2csm17309530ejv.154.2023.05.03.06.46.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 06:46:25 -0700 (PDT)
Message-ID: <64ce9447-7ae5-efbf-870f-74e45075a748@linaro.org>
Date:   Wed, 3 May 2023 15:46:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [PATCH] dt-bindings: xilinx: Remove Naga from memory and mtd
 bindings
To:     Michal Simek <michal.simek@amd.com>, linux-kernel@vger.kernel.org,
        monstr@monstr.eu, michal.simek@xilinx.com, git@xilinx.com
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Naga Sureshkumar Relli <nagasure@xilinx.com>,
        Richard Weinberger <richard@nod.at>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mtd@lists.infradead.org
References: <6b4cdc7158599b4a38409a03eda56e38975b6233.1683103250.git.michal.simek@amd.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <6b4cdc7158599b4a38409a03eda56e38975b6233.1683103250.git.michal.simek@amd.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/05/2023 10:40, Michal Simek wrote:
> Naga is no longer works for AMD/Xilinx and there is no activity from him to
> continue to maintain Xilinx related drivers. Two drivers have Miquel as
> maintainer and for the last one add myself instead to be kept in a loop if
> there is any change required.
> 
> Signed-off-by: Michal Simek <michal.simek@amd.com>
> ---
> 
>  .../devicetree/bindings/memory-controllers/arm,pl35x-smc.yaml   | 1 -
>  .../devicetree/bindings/mtd/arasan,nand-controller.yaml         | 2 +-
>  Documentation/devicetree/bindings/mtd/arm,pl353-nand-r2p1.yaml  | 1 -
>  3 files changed, 1 insertion(+), 3 deletions(-)


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

