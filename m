Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73FC70226A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 05:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238696AbjEODcZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 23:32:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238811AbjEODbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 23:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5CD1FD5;
        Sun, 14 May 2023 20:29:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F218961E41;
        Mon, 15 May 2023 03:29:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07F4C433EF;
        Mon, 15 May 2023 03:29:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684121368;
        bh=htnO5qmkxPpaAyW1KrLyYCFRc26DsdPe9S1odeINOvg=;
        h=From:To:Subject:Date:In-Reply-To:References:From;
        b=kN3rNeaqWRFmoUlbUgwleEZCKW2lcmK/Hvcn+lBe5Tl4r8rw0BfMAvC9V1eft/0pJ
         GI9Ejh+dG6O9TA2rZ0uJHepdd+SrQ6F8r8YRrr7uLw1FktHV2hZFn++S2Qqdd0Gcdr
         AwCVP8vwCb19WJdvLCdgEvGOpNKwBWjBQapxrSseo5E5rQExsheoFZftCkKM7HoVtb
         0m10XtpTZyWuMtIUYnGnrAl2WYTYvn5BGM4/G1NlHIJxByds6Oo+etkDlqLwv3GQMk
         JSnnofzoSz8N0QAhLK7/+mJjJeTiliDF/HlyD/O+bvda9dRXDAstNYVCKkGHCpEn8o
         T2iGAuAfNj2AQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: (subset) [PATCH v2 1/4] arm64: dts: qcom: sm8150: drop incorrect serial properties
Date:   Sun, 14 May 2023 20:33:07 -0700
Message-Id: <168412158456.1260758.2723323536611790207.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230417080818.28398-1-krzysztof.kozlowski@linaro.org>
References: <20230417080818.28398-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 17 Apr 2023 10:08:15 +0200, Krzysztof Kozlowski wrote:
> Drop incorrect and unused serial properties - address/size-cells and
> reg-names:
> 
>   sa8155p-adp.dtb: geniqup@ac0000: serial@a84000: Unevaluated properties are not allowed ('#address-cells', '#size-cells', 'reg-names' were unexpected)
> 
> 

Applied, thanks!

[1/4] arm64: dts: qcom: sm8150: drop incorrect serial properties
      commit: e10094bf590696a7f845790485cc3f753b2fd94a
[2/4] arm64: dts: qcom: sm8150: add missing qcom,smmu-500 fallback
      commit: 83254172fa7f4d4a400f2ff441f111e424dd5ee0
[3/4] arm64: dts: qcom: sm8150: drop snps,dw-pcie fallback compatible
      commit: 7df522338d63c42946eb82f8af7dba8c363bd725
[4/4] arm64: dts: qcom: sc8280xp: correct GIC child node name
      commit: 9230758996c3ff0b5cf8e8506731c956bfb351bf

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
