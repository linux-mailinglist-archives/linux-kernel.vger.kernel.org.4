Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED24C61E92A
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:13:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230513AbiKGDNo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:13:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbiKGDNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:13:11 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7B40DF8A;
        Sun,  6 Nov 2022 19:12:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4551360E99;
        Mon,  7 Nov 2022 03:12:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E8D7C43147;
        Mon,  7 Nov 2022 03:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667790775;
        bh=/86VvwuUAAMCvKdf9DScaNKbTmY6CzgkZWN9ufZkwB8=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=T8pPcbAamsWmHRM6326lVlFPCeAZLeRkjjXNJRI97D9FrIXS+ucfzqybIn8LwEu7A
         LQu+oPc7f/lehJs678eYMxo00GoBte8pnTzcTO/8TNDd26P4ezwWAF1Ha22fmaupzs
         trXGXlnToKXOM5FP4wBTQ2fTHeKygFTzZurXKZuNpoRcl1kDDhY1FXHP9QdB6laEb1
         wvttD+5YD3F0RP3g7cECPgtiWR8YYQjmL5yf1MUpMFUN2kgH1rvjcYJ2M0LE7knn1+
         ceHelwHZESXH7vo8clfSYhq+YiHAmgz4f0SKWW26Lxtnj6TiHn+uRVEVP+gYQWVyR5
         R+17+/vTtrjMA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski+dt@linaro.org, devicetree@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, konrad.dybcio@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, Andy Gross <agross@kernel.org>
Subject: Re: (subset) [PATCH 1/2] dt-bindings: sram: qcom,imem: document SDX65
Date:   Sun,  6 Nov 2022 21:12:13 -0600
Message-Id: <166779074268.500303.497872794815573539.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221104190840.134733-1-krzysztof.kozlowski@linaro.org>
References: <20221104190840.134733-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 15:08:39 -0400, Krzysztof Kozlowski wrote:
> Add compatible for SDX65 IMEM.
> 
> 

Applied, thanks!

[1/2] dt-bindings: sram: qcom,imem: document SDX65
      commit: bdc51f42d25af15c91ec1b1a20c595ec33b3ea8e
[2/2] ARM: dts: qcom: sdx65: add dedicated IMEM and syscon compatibles
      commit: 9b4dc87d352d0109c36efeea60cb75d14ac50ef1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
