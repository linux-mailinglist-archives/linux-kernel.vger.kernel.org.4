Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAB5B623ADC
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 05:09:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiKJEJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 23:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59340 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232566AbiKJEJT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 23:09:19 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97D9221E19;
        Wed,  9 Nov 2022 20:09:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 401F0B820C2;
        Thu, 10 Nov 2022 04:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19722C43141;
        Thu, 10 Nov 2022 04:09:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668053355;
        bh=CkVFGNcqaWU99yYES9gwP8NvhGm9sjmnaQkH4cQwnEE=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=chKhMiCTuWL9GPCsD3c7eAquVevJJZ151GeBAFa80mC10/PvC1F8Oigl+BgJR4o/K
         aeOgiwkBVXeZGtPMq3H/An2V6XqD5fHXCddFnsWCxu71uLSKkhG3JMhejtFQ2eBJ03
         1THlOJB9ZKlvHqGnzGF21ih3xHooSH1vSXBhhG41VCMkgTX5plWpI2hvhYgOrCy7j8
         wydVL0xmwxKvJCceK8t+6ER0F0BtYGvrmQzUEF86RQg1fqE2xh5qX45euxDwVkwZeI
         Gjr7j8Egau2qsYh6fAk3H8WFvT/9xeYX7AmbqSm3Z30HNUhEQzroPzXcvbP0zphtc7
         UdInY1SB7WqlA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     agross@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski@linaro.org,
        devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linus.walleij@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] dt-bindings: pinctrl: qcom,ipq8074: convert to dtschema
Date:   Wed,  9 Nov 2022 22:09:08 -0600
Message-Id: <166805334843.800572.7948604609838863000.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221108142357.67202-1-krzysztof.kozlowski@linaro.org>
References: <20221108142357.67202-1-krzysztof.kozlowski@linaro.org>
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

On Tue, 8 Nov 2022 15:23:56 +0100, Krzysztof Kozlowski wrote:
> Convert Qualcomm IPQ8074 pin controller bindings to DT schema.  Keep the
> parsing of pin configuration subnodes consistent with other Qualcomm
> schemas (children named with '-state' suffix, their children with
> '-pins').
> 
> 

Applied, thanks!

[2/2] arm64: dts: qcom: ipq8074: align TLMM pin configuration with DT schema
      commit: 1c3c31a6e7f6b467c160a4c58e385b2991e49139

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
