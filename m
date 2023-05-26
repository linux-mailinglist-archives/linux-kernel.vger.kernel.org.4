Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D60F5712DA7
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 21:35:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244054AbjEZTfS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 15:35:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230263AbjEZTe6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 15:34:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D10A0A3;
        Fri, 26 May 2023 12:34:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5079F652F5;
        Fri, 26 May 2023 19:34:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A508BC4339E;
        Fri, 26 May 2023 19:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685129696;
        bh=mWooyFPpmQls+pW8WTQXRMHig5ua5iKNguf32X9lQ6k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gw8J9Ew9VSVA5T3oGEAUdsU1KPy5wm4C2g/TXpOlA8H6u75ddm7ARuYTAJqci5FHC
         nW0aW0FJcysvikVxiwyNTtSAG179y5S5OIHkimltroRIIMNsT/rFX0+ww5t0TBGK+X
         rvxVx5ni+jwdB1IzKUO7s/0CHKhyVeGRNQpCRURM3yw1+9aAuramabrutK3k9OP3XK
         YD4zHBV1FWPBXi6kXeqFSrYK4FQFxEmJ9hbGBA+a9Mdv2lar7+Hc1U0m/J0k2EkqXR
         3GcoNiMLug76c68MhF8siUC/i9q3D2TO+a37xPmP8bNDBc1PIYhUuofTTCc76XoQcj
         Pbxr4OTWDEydg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     lgirdwood@gmail.com, agross@kernel.org, devicetree@vger.kernel.org,
        konrad.dybcio@linaro.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, broonie@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, linux-arm-msm@vger.kernel.org,
        Devi Priya <quic_devipriy@quicinc.com>
Cc:     quic_kathirav@quicinc.com, quic_gokulsri@quicinc.com,
        quic_anusha@quicinc.com, quic_sjaganat@quicinc.com,
        quic_srichara@quicinc.com, quic_arajkuma@quicinc.com
Subject: Re: (subset) [PATCH V4 0/5] Add regulator support for IPQ9574 SoC
Date:   Fri, 26 May 2023 12:38:35 -0700
Message-Id: <168512991476.248818.6075574733104138108.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230407155727.20615-1-quic_devipriy@quicinc.com>
References: <20230407155727.20615-1-quic_devipriy@quicinc.com>
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

On Fri, 7 Apr 2023 21:27:22 +0530, Devi Priya wrote:
> IPQ9574 SoC uses the PMIC MP5496 and SMPA1 regulator for APSS voltage scaling.
> This patch series adds support for the same and also enables the RPM
> communication over the RPMSG framework.
> 
> DTS patch depends on the below series
> https://lore.kernel.org/linux-arm-msm/20230406061314.10916-1-quic_devipriy@quicinc.com/
> 
> [...]

Applied, thanks!

[3/5] arm64: dts: qcom: ipq9574: Add RPM related nodes
      commit: 8cc864a4375dd62023a2880050bf618a225cb907
[4/5] arm64: dts: qcom: ipq9574: Add SMPA1 regulator node
      commit: 56ba2b3aeb4b76549a7759e79bd44330cd9b885a
[5/5] arm64: dts: qcom: ipq9574: Add cpufreq support
      commit: 8f0ae6bc0098f63a008820f80c08b01ea2167da3

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
