Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2C406C141F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:56:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231556AbjCTN4n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:56:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231675AbjCTN4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:56:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E8D3AD0C;
        Mon, 20 Mar 2023 06:55:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0F25461519;
        Mon, 20 Mar 2023 13:55:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 664BBC433D2;
        Mon, 20 Mar 2023 13:55:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679320556;
        bh=IDEsPDZL0eVwZgvBZYPKhbIzQ+HsdvJH6DLdaGRl3Ac=;
        h=From:To:Cc:Subject:Date:From;
        b=tQGGrQ5AMiheYj07qk45aCmweD1tdADnr1eWNnnKsZsBym9j7m6Rkb4tdRd+hctU7
         zrdy/kGvDs45M34yPyS3owtcpTf6taDAntYDHO6TwedOLNpYoxDpQH1vFIuImEKCt3
         +9RZo6bYAjrB1LjAbgovPePcuPMfph9eMLOzjBEkEzr4FNFlFW7VDsuwuVAMEdjfZs
         ifJW7Ws1EUvPYT9Vg/d0sVAdc3uwxLePFSFiwtk1+1WbLEERD/uCrOjM+wzPORUhtt
         bwhRZWg4XjlAkOg25g8wyhh8nuRZRNXZ21KPHinUZzM/qbnA3p1yogpdUuX1q/n0VG
         agDpaR9s7gE+g==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan+linaro@kernel.org>)
        id 1peG0j-0000WP-Kq; Mon, 20 Mar 2023 14:57:17 +0100
From:   Johan Hovold <johan+linaro@kernel.org>
To:     Bjorn Andersson <andersson@kernel.org>, Lee Jones <lee@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Johan Hovold <johan+linaro@kernel.org>
Subject: [PATCH 0/3] arm64: dts: qcom: sc8280xp-pmics: fix sdam 'reg' property
Date:   Mon, 20 Mar 2023 14:57:07 +0100
Message-Id: <20230320135710.1989-1-johan+linaro@kernel.org>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series addresses the dt-schema validation warnings that were
introduced when enabling the PMIC SDAM block (and RTC) on sc8280xp.

I guess this should go through the nvmem, qcom, and mfd trees,
respectively.

Johan


Johan Hovold (3):
  dt-bindings: nvmem: qcom,spmi-sdam: fix example 'reg' property
  arm64: dts: qcom: sc8280xp-pmics: fix sdam 'reg' property
  dt-bindings: mfd: qcom,spmi-pmic: add nvram function

 .../bindings/mfd/qcom,spmi-pmic.yaml          |  4 +++
 .../bindings/nvmem/qcom,spmi-sdam.yaml        | 31 +++++++++++--------
 arch/arm64/boot/dts/qcom/sc8280xp-pmics.dtsi  |  2 +-
 3 files changed, 23 insertions(+), 14 deletions(-)

-- 
2.39.2

