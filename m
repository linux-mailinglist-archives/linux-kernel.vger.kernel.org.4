Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7162471049A
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 06:55:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239341AbjEYEzE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 00:55:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239390AbjEYEx0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 00:53:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5AFB1712;
        Wed, 24 May 2023 21:51:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A28E1642A2;
        Thu, 25 May 2023 04:51:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F6C1C433A0;
        Thu, 25 May 2023 04:51:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684990283;
        bh=2TYZ2oSWqDISNu6YzPBuZ5UO1qw5XrXdj/Nr0a9/sxY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=A6Chbe+xcphRSueiKtEKj2opGRZYb5VGZ0ODybEm0QgsXDvgEWYLtZ2w6sqDBW30K
         5awZRQHoa3Lxq9Psgl5Vms1Cix43Gj0769ghtzk/x26VsaOWAR3QAuIO+r13T5WFBS
         rLDaP3Ro+MdbVImLukRkymIW5Oi0BPbbZ5bvvoCTvSSandDUFceHW2B13c7DTbC5tc
         YbPh+06GXYpNMj1xcLXprQhWg5VH8+McDONE6nyvZ7Aexs04HcYTyxt1PpQGl44YBV
         5XNSCp7tIBUlgDarBlTcXQsfYtRB4imAKKwh91Ln+Mcpml7ymNeHTQ45V/7TCRcS+J
         CwGQN8TPw2GQg==
From:   Bjorn Andersson <andersson@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Manivannan Sadhasivam <mani@kernel.org>
Subject: Re: [PATCH v6 0/2] Introduce RPM Master stats
Date:   Wed, 24 May 2023 21:54:03 -0700
Message-Id: <168499048181.3998961.3897734522173912001.b4-ty@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230405-topic-master_stats-v6-0-2277b4433748@linaro.org>
References: <20230405-topic-master_stats-v6-0-2277b4433748@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023 19:36:16 +0200, Konrad Dybcio wrote:
> v5 -> v6:
> - pick up tags
> - fix 'decisons' -> 'decisions' typo
> 
> v5: https://lore.kernel.org/r/20230405-topic-master_stats-v5-0-2e1c98a8b63e@linaro.org
> 
> v4 -> v5:
> - pick up tags
> - uintXY_t -> uXY
> - driver.name = "rpm_master_stats" -> "qcom_rpm_master_stats"
> - use dev_err_probe for debugfs file creation fail
> - use PTR_ERR(dent) intead of -EINVAL for debugfs file creation fail
> 
> [...]

Applied, thanks!

[1/2] dt-bindings: soc: qcom: Add RPM Master stats
      commit: 0be4392435a6a0e16b3eb56a8815ebdbcd44e1a7
[2/2] soc: qcom: Introduce RPM master stats driver
      commit: a77b2a0b12801a232226d227636236ed89b77043

Best regards,
-- 
Bjorn Andersson <andersson@kernel.org>
