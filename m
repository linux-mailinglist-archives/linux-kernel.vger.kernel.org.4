Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69B06DB752
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 01:37:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjDGXhe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 19:37:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230241AbjDGXhZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 19:37:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 728FEE1A9;
        Fri,  7 Apr 2023 16:37:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFE8C65574;
        Fri,  7 Apr 2023 23:37:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DB9C4339E;
        Fri,  7 Apr 2023 23:37:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680910643;
        bh=m0sgo1ihIkMtssR/3JYZB4rC8EfpghJJKUdt43W98JE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=oiWipeIHgt7ebPpvx8qguxs/EVAKdy0aD1DCJy7j8SjkNClsv6pw9kmmeXqueyTsx
         u3nTuZGI4F1qVxjrRpUO6mcuvZF3Su7vYuU1iMVhF4HQ4DSQ0+g/VsogZLVT0LEhCd
         HnSXd89pZ5SqmHsS/9cWvgs8HTJwe/+NYDxebGyRDH7POQ2cPX4usEXUI8DrWfPggA
         gaC95QzM+hZwhjp4RnobS690ch5tTGNj4ufxoVJg4JEKRmQorE7t/iK7zx2W7J5oQs
         kx+Y7bWHQSroxIbNrrEF+NHGQFmX3jPewt9xZMfgprz6Yk4ekW9ZMUCkhspq+QXEeE
         qo/YoCG8AfcBA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, robh+dt@kernel.org,
        konrad.dybcio@linaro.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: (subset) [PATCH 1/2] ARM: dts: qcom: sdx55: Move reset and wake gpios to board dts
Date:   Fri,  7 Apr 2023 16:40:08 -0700
Message-Id: <168091080212.2759405.12019249242155124711.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230331145915.11653-1-manivannan.sadhasivam@linaro.org>
References: <20230331145915.11653-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 31 Mar 2023 20:29:14 +0530, Manivannan Sadhasivam wrote:
> The reset and wake properties in the PCIe EP node belong to the board dts
> as they can be customized per board design. So let's move them from SoC
> dtsi.
> 
> 

Applied, thanks!

[1/2] ARM: dts: qcom: sdx55: Move reset and wake gpios to board dts
      commit: a6d1d862638b51f2a874948f75fd7284d066f900
[2/2] ARM: dts: qcom: sdx55-fn980: Move "status" property to the end of node
      commit: 23fbf5339d4b18858bcd38811c0eb96df00e8289

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
