Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EF0F6021E5
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:08:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230184AbiJRDIt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230239AbiJRDHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:07:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 906AD9A9E6;
        Mon, 17 Oct 2022 20:06:53 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8EA7A6136D;
        Tue, 18 Oct 2022 03:06:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 15279C4347C;
        Tue, 18 Oct 2022 03:06:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062412;
        bh=QCbK5f2VE/C+fbJAKSCNxZKYKqhRcv1lQGXmtIlS/fo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Bq5yf3dAsHItMWdFGyhMm2IwBsbO7498B6hJQIlfLPPM5DMaO4LE0ynsovtL47Iv4
         rKYdcd0hngq7n00B8zFDlnzAPKltkg7Nww8PyRha6/FyLaLMycNTGMfQM9hsgPPkX1
         mBVCgdkvbYIngV3f6BeqYWhBj5bMcHeqc0+cGGmvCGs+qeHGqPAezrZupeSD0Y3zEq
         hNSCkDLjamLOw5l1J7AVgKGg0MgKscSVGrNhk2RpAY/qSRBWoiOd9txWs/5FEUkmX2
         aawKrP1xBZgEAwut8N5z5e77WhOWGFtvGqZBCDTa/4g/cx4ML0vGErQhvfVcx9XUal
         1rsiH6KY5kHgQ==
From:   Bjorn Andersson <andersson@kernel.org>
To:     ~postmarketos/upstreaming@lists.sr.ht,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Cc:     angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        martin.botka@somainline.org, agross@kernel.org, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: (subset) [PATCH v2 1/2] dt-bindings: soc: qcom: qcom,smd-rpm: Add a compatible for SM6375
Date:   Mon, 17 Oct 2022 22:05:26 -0500
Message-Id: <166606235838.3553294.9806879624817237422.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220921004534.151990-1-konrad.dybcio@somainline.org>
References: <20220921004534.151990-1-konrad.dybcio@somainline.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 21 Sep 2022 02:45:32 +0200, Konrad Dybcio wrote:
> Document the compatible for SM6375.
> 
> 

Applied, thanks!

[1/2] dt-bindings: soc: qcom: qcom,smd-rpm: Add a compatible for SM6375
      commit: c7617580b44bb5ad04461ddd085fd4b2dd6eba19
[2/2] soc: qcom: smd-rpm: Add SM6375 compatible
      commit: a30c3c6a351c42c8a843f7631f0364dfddf337c7

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
