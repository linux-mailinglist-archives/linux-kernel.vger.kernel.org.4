Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 120135ED348
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 05:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232530AbiI1DHH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 23:07:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229630AbiI1DGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 23:06:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 483521CE914;
        Tue, 27 Sep 2022 20:06:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CF5CC61CFD;
        Wed, 28 Sep 2022 03:06:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 121D0C433C1;
        Wed, 28 Sep 2022 03:06:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664334410;
        bh=3j7lUQIdsrYc+2eX2IWCd5WxozwgI6aTea19eKPxzvU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=bTp2dMKIU62NKZzR4WBN0UtxZTi3QxOAmhfp1eXtYrc/oU2apkEel6XqbVATUlQPA
         NwZPV7pumHl62El5uKmip3TIRWkPFAi4ShYBTQLHxdG2HznRSyOzUGX+2WlURYYNeg
         EgksWQJDDUnxNQHhcw9/lXhMW8Md66aG4kOwDaqHZUdJdAqW2hHKwUADzl+0NuPcKK
         YEOmdXJZlqspPIY31cQwYXEvG6pD2i4sDRmEnlguXopKS47PLDb5VAxxCQgvz4Qdy3
         Vb6b3rERIAEUyjKOxNQ5yvDZVtMrCe87/Q7oeYkgO6DL2MaBmTkuCL+bA7tYB0vgCG
         TyoW5D4hglu5g==
From:   Bjorn Andersson <andersson@kernel.org>
To:     konrad.dybcio@somainline.org, ~postmarketos/upstreaming@lists.sr.ht
Cc:     jamipkettunen@somainline.org, devicetree@vger.kernel.org,
        robh+dt@kernel.org, marijn.suijten@somainline.org,
        sboyd@kernel.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        mturquette@baylibre.com, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: clock: qcom,rpmcc: Add compatible for SM6375
Date:   Tue, 27 Sep 2022 22:06:44 -0500
Message-Id: <166433439996.1849007.15361302726140615662.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921004458.151842-1-konrad.dybcio@somainline.org>
References: <20220921004458.151842-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 02:44:56 +0200, Konrad Dybcio wrote:
> Add a compatible for RPMCC on SM6375.
> 
> 

Applied, thanks!

[1/3] dt-bindings: clock: qcom,rpmcc: Add compatible for SM6375
      commit: de55ec3b3af0db790948906b0e41f468fcfa9f98
[2/3] dt-bindings: clock: qcom: rpmcc: Add BIMC_FREQ_LOG
      commit: 65cfaf4eface0a347f62187b52eeb84f635b6be0
[3/3] clk: qcom: smd: Add SM6375 clocks
      commit: 644c4229559257cadc4267fc36c2dc22ee9c040f

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
