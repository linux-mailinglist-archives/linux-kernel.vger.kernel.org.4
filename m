Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9D335BA0ED
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Sep 2022 20:46:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229625AbiIOSqc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 14:46:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbiIOSq3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 14:46:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6ED59A68A;
        Thu, 15 Sep 2022 11:46:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7DED8625F4;
        Thu, 15 Sep 2022 18:46:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BFB4C433C1;
        Thu, 15 Sep 2022 18:46:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663267587;
        bh=xChaNWZaTfA8GaSh2F5Mi+IsCxwrgzYZucCR5BSDzYQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VwyJ3h4MhfTBn0r/I7ErupFSe3+J9PRhh6DALGR2rH/4oD75lZ4BNSfl+PM5f1VpJ
         5oJtc2vHv1sqoCXJR4tiiPB2AE6zEZYCwMpIUqUazrJ356teiYttZggB2Hwk+GCFKd
         vBtonr/pcUrQzwq3PesGCxiaNmoK87rgQ4VUlDUwBV0j/X9mDZS9ml98E/m7dgNer+
         IWnZ/K1t+eoGNOT/GiKFALrsRniTmBBNoHF1qWlCs2vBpKmKAOvzvs37NRKbBtgR90
         oUJ2sKtQ+JlPcc7LyEryeAmOAbiEKY2d5R7qGlgV838MFxqAiplD7TPS9hoNnDFSZS
         7Hd9sbvfTCJiA==
From:   Bjorn Andersson <andersson@kernel.org>
To:     johan+linaro@kernel.org
Cc:     robh+dt@kernel.org, agross@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, konrad.dybcio@somainline.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] arm64: dts: qcom: ipq8074: fix PCIe PHY serdes size
Date:   Thu, 15 Sep 2022 13:46:25 -0500
Message-Id: <166326758062.847092.16539111299394629381.b4-ty@kernel.org>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220915143431.19842-1-johan+linaro@kernel.org>
References: <20220915143431.19842-1-johan+linaro@kernel.org>
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

On Thu, 15 Sep 2022 16:34:30 +0200, Johan Hovold wrote:
> The size of the PCIe PHY serdes register region is 0x1c4 and the
> corresponding 'reg' property should specifically not include the
> adjacent regions that are defined in the child node (e.g. tx and rx).
> 
> 

Applied, thanks!

[1/2] arm64: dts: qcom: ipq8074: fix PCIe PHY serdes size
      commit: ed22cc93abae68f9d3fc4957c20a1d902cf28882
[2/2] arm64: dts: qcom: sm8540: fix UFS PHY serdes size
      commit: 677920072e9d757ae158d66b8fdb695992bb3f1a

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
