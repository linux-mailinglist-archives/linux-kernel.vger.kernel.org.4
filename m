Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F49C5B6649
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 05:48:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229951AbiIMDsI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 23:48:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229569AbiIMDr7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 23:47:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EECF94A11F;
        Mon, 12 Sep 2022 20:47:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A4DACB80DEC;
        Tue, 13 Sep 2022 03:47:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 26096C433D6;
        Tue, 13 Sep 2022 03:47:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663040876;
        bh=DOqZmbK92BrZad5DB9KgLPgPMZouFoLcfUHuamLgC5w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=loQ+dvMYSIJCjX5QUcTAC67lXUpsyYHxM77d/ZV9H/P4UrrEmjSNuIV5vJ1Gr5f61
         km9hsry850L+Lw9y0BMYyJxJe5n8pb+POAIFwApknJrKUtSmbkkJuxzWkTLEBO9ig2
         OEmzf6X44BGNE1j71+CVc4oYgs3PApOLZ3xDfGx8a8Gg/N/CkpTThoxKVtu3WL3eWf
         Ibu4JMB41Fw+rPEAi1O8suag+ySZlAPop0d2t0eGdLaYyvKhC+Xujtk+BtqgMPCZ9b
         CDkTGPCGL/sVay0lKUB2nHLPt4eRRMxdpfJubBxj57fCaTXYsbw+U08uoWxupChb+X
         bqrkh8i2gWTVQ==
Date:   Mon, 12 Sep 2022 22:47:53 -0500
From:   Bjorn Andersson <andersson@kernel.org>
To:     Richard Acayan <mailingradian@gmail.com>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Taniya Das <tdas@codeaurora.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Caleb Connolly <caleb@connolly.tech>,
        Joel Selvaraj <jo@jsfamily.in>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v3 1/3] dt-bindings: clock: gcc-sdm845: add sdm670 global
 clocks
Message-ID: <20220913034753.gmdcnm54x5lw7bxc@builder.lan>
References: <20220908231224.209020-1-mailingradian@gmail.com>
 <20220908231224.209020-2-mailingradian@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220908231224.209020-2-mailingradian@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 08, 2022 at 07:12:22PM -0400, Richard Acayan wrote:
[..]
> +allOf:
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,gcc-sdm670
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Board XO source
> +            - description: Board active XO source
> +            - description: Sleep clock source
> +        clock-names:
> +          items:
> +            - const: bi_tcxo
> +            - const: bi_tcxo_ao
> +            - const: sleep_clk
> +
> +  - if:
> +      properties:
> +        compatible:
> +          contains:
> +            const: qcom,gcc-sdm845
> +    then:
> +      properties:
> +        clocks:
> +          items:
> +            - description: Board XO source
> +            - description: Board active XO source
> +            - description: Sleep clock source
> +            - description: PCIE 0 Pipe clock source
> +            - description: PCIE 1 Pipe clock source
> +        clock-names:
> +          items:
> +            - const: bi_tcxo
> +            - const: bi_tcxo_ao
> +            - const: sleep_clk
> +            - const: pcie_0_pipe_clk
> +            - const: pcie_1_pipe_clk
> +

Series looks good to me, but linux-next has 0f71ae945730 ("dt-bindings:
clk: qcom,gcc-*: use qcom,gcc.yaml") which conflicts with this addition.
Can you please rebase on top of linux-next, retest and submit a new
version?

Thanks,
Bjorn
