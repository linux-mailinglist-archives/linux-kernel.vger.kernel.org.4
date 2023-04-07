Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701A46DB1D1
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 19:38:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230197AbjDGRiy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 13:38:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230032AbjDGRif (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 13:38:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5265DBBBA;
        Fri,  7 Apr 2023 10:38:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E1B186533A;
        Fri,  7 Apr 2023 17:38:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB08EC433A8;
        Fri,  7 Apr 2023 17:38:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680889114;
        bh=3EA95KQTiLzBv9JnUhNUP5BifQaD1kXMxqdTlkzeNVo=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=hyhM15wHmA1NWu9AzL11g3ysGzfrLVJdUVmoFo+eMAtm3Lw32p1eFrOihIKPHa2tO
         n+jhXMEqKrOPKPjFNgEXk9im+A+aeSPTZOj4uuVcrhpsX+iCv6ay6cJER/eTYlBThf
         PiBng7uPcNDmAEh+anojBTZQjpws6eLN2Uhlyd31wvJxjnlLrNf+MI0VaLClJ54jWS
         Gwqv34wdD8eGUY5AKEjl5c6ELMGlxl4bDzeXs3HPPg+RUWCNrIm6r0FBNZI8qSVd/6
         IdoJuQYMuFL50P/ZAXlMzW75XwjvJ/FJq3A0lw8PQiNcH8KleNXI4q9uTYUSMcTBB6
         5b3bgIxkAZycA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Subject: Re: (subset) [PATCH 1/5] arm64: dts: qcom: sc8280xp: label the Soundwire nodes
Date:   Fri,  7 Apr 2023 10:41:11 -0700
Message-Id: <168088927577.2561591.8075821327118266569.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405060906.143058-1-krzysztof.kozlowski@linaro.org>
References: <20230405060906.143058-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 5 Apr 2023 08:09:02 +0200, Krzysztof Kozlowski wrote:
> Use labels, instead of comments, for Soundwire controllers.  Naming them
> is useful, because they are specialized and have also naming in
> datasheet/programming guide.
> 
> 

Applied, thanks!

[1/5] arm64: dts: qcom: sc8280xp: label the Soundwire nodes
      commit: f77256439ccb794ec02eb07dfc6f1f96972a8cff
[2/5] arm64: dts: qcom: sm8450: label the Soundwire nodes
      commit: add214009d0632bf3f28158f81e4d202d8c9aa0e
[3/5] arm64: dts: qcom: sc8280xp: simplify interrupts-extended
      commit: 465b99f3b4ca55f25124adff6d6ccac4371f1930
[4/5] arm64: dts: qcom: sm8250: simplify interrupts-extended
      commit: 563065020d9ae67999f3f3f3a6ec3508e17a4d88
[5/5] arm64: dts: qcom: sm8450: simplify interrupts-extended
      commit: d6573b4c202e75edd8b7ffbef6496613a1ef89df

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
