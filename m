Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91DFC672D21
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 00:56:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbjARX4G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 18:56:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230034AbjARXzz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 18:55:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA3D37540;
        Wed, 18 Jan 2023 15:55:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC8CBB81E12;
        Wed, 18 Jan 2023 23:55:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 847BCC43392;
        Wed, 18 Jan 2023 23:55:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674086151;
        bh=WAoXEdeh2Mmc67g3tKvBye5OCIEtuY/rTgZyEuIPps4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=K/UocZGeoOBXxMtWOm+7hH2fK1In1sQBfRK87a2rgPAtoPoW2Oy5Q8HIC7cx0/9sc
         3JJt/ZoevFomIbYp6hum6sxyTqXp9epbXv+A6KyIyzoA8F+M1OVKwNCQQ1oeKRNkI7
         aQjbIdWB7j0/OM6w65/YS7gPtolpjlHYSj3bi+CEetAwPhBVMZiezb1JLUwKwVRT6X
         7pMW5s35RdRdfn5M/FxSAM1nWQJLtsb5Fc+eokwE75mVeX7grImBzgRkWHJI3kewgZ
         NdSwpE/blEMZ0WBMt2EXOfe/jto2ACeC+gH46kUKUeylDEQbqtadLGtTNG58KOUyBQ
         ex8XGPbljg+dQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     krzysztof.kozlowski@linaro.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>, agross@kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     quic_sibis@quicinc.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
        djakov@kernel.org, linux-kernel@vger.kernel.org,
        marijn.suijten@somainline.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH v2 1/3] dt-bindings: interconnect: OSM L3: Add SM6350 OSM L3 compatible
Date:   Wed, 18 Jan 2023 17:55:35 -0600
Message-Id: <167408614062.2989059.3788980288889367002.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20230104171643.1004054-1-konrad.dybcio@linaro.org>
References: <20230104171643.1004054-1-konrad.dybcio@linaro.org>
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

On Wed, 4 Jan 2023 18:16:40 +0100, Konrad Dybcio wrote:
> SM6350, similarly to SDM845, uses OSM hardware for L3 scaling.
> Document it.
> 
> 

Applied, thanks!

[2/3] arm64: dts: qcom: sm6350: Add OSM L3 node
      commit: e17a806571bb01bb951faeec645944850241eae3
[3/3] arm64: dts: qcom: sm6350: Set up DDR & L3 scaling
      commit: bba952275b81971d329189a879a5611bc8eb0dd1

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
