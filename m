Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B1576021D2
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 05:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230108AbiJRDHs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 23:07:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230338AbiJRDGn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 23:06:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD5498374;
        Mon, 17 Oct 2022 20:06:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 41D99CE1B19;
        Tue, 18 Oct 2022 03:06:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDF95C43140;
        Tue, 18 Oct 2022 03:06:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666062398;
        bh=DMaD1Y1npwIhNi9ShGiY/GcvA7TKdmL2Z27XOYl0MTo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FhWxR6isslXFdf6cLMsAOt0u6zautsTHeJaRkZkyuOwVbpwaxh254tISqFP2FEuab
         AEWuJ4QHKrJasr/zGb8Fvq7wQgInh8rAdolHrfupSc+tpJCqECXMM/Ttz2c6mBezv4
         Fq1iSzbqVR1IIyTm28n0XDe5+gRDslU3RdOa3lxTjrSVm+6h4CTuXf2tZRjGZsKCvk
         FHwNePLXKdQbvLr+GSdxzlM5vX4GpaCyEN1URhTK9yVRsjK5jOfEEeQ2cw2Lip+2/d
         6lXTbgI+PWfr48EoUqIdzmSweytQdSeMAXIBuyBDLxggitQbcn/GSm3W7ba9JLCAjM
         m3OvraZlRjn0A==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        agross@kernel.org, bmasney@redhat.com, robh+dt@kernel.org,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>
Subject: Re: [PATCH] arm64: dts: qcom: sc8280xp: fix ufs_card_phy ref clock
Date:   Mon, 17 Oct 2022 22:05:20 -0500
Message-Id: <166606235845.3553294.1270628441313635491.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20221005143305.388-1-johan+linaro@kernel.org>
References: <20221005143305.388-1-johan+linaro@kernel.org>
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

On Wed, 5 Oct 2022 16:33:05 +0200, Johan Hovold wrote:
> The GCC_UFS_REF_CLKREF_CLK must be enabled or the second UFS controller
> fails to enumerate on sa8295p-adp.
> 
> Note that the vendor kernel enables both GCC_UFS_REF_CLKREF_CLK and
> GCC_UFS_1_CARD_CLKREF_CLK and it is possible that the former should be
> modelled as a parent of the latter. The clock driver also has a
> GCC_UFS_CARD_CLKREF_CLK clock which the firmware appears to enable on
> the ADP.
> 
> [...]

Applied, thanks!

[1/1] arm64: dts: qcom: sc8280xp: fix ufs_card_phy ref clock
      commit: 8d6b458ce6e93286a607e54f787f7a86067f58bd

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
