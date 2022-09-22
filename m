Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D15F5E6872
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 18:30:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232135AbiIVQan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 12:30:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232113AbiIVQaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 12:30:24 -0400
Received: from mout.perfora.net (mout.perfora.net [74.208.4.196])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D6E953D30
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 09:30:15 -0700 (PDT)
Received: from toolbox.toradex.int ([31.10.206.125]) by mrelay.perfora.net
 (mreueus004 [74.208.5.2]) with ESMTPSA (Nemesis) id 1MILw8-1oVx322vp6-00EOji;
 Thu, 22 Sep 2022 18:29:57 +0200
From:   Marcel Ziswiler <marcel@ziswiler.com>
To:     linux-arm-kernel@lists.infradead.org
Cc:     Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Biju Das <biju.das.jz@bp.renesas.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Vinod Koul <vkoul@kernel.org>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH v1 7/8] arm64: defconfig: enable snvs lpgpr support
Date:   Thu, 22 Sep 2022 18:29:24 +0200
Message-Id: <20220922162925.2368577-8-marcel@ziswiler.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220922162925.2368577-1-marcel@ziswiler.com>
References: <20220922162925.2368577-1-marcel@ziswiler.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:kWVqR6dvKLRcjt9BslzxChkMYItmMq9gdG4ip4DAibBqyNEGyvh
 OUnHHDZeTk+tsoIgoDsFLo6syWho+2XgfZw4SfWSmkyhKUKo2S5J5sQYtX82hJbkOs8uRFf
 NdcJdJT4en9i72sgOapF0x4EFJcVpgHdx26n+CGL3vDqC7NBhAVxj1jwD1UFgBzDWV8qetu
 3PZCADsugaxRwk3h3BpQg==
X-UI-Out-Filterresults: notjunk:1;V03:K0:aqntJi6Oe3s=:0/tzn7EjcaCyaLzUE2diQh
 29NrbKccIksg0N5ynDOOAKgUIcwC7okL39+VDgyYkvMHYpjUZmGeR16ewXXsusMUiXSzgWKpa
 YizQVpKnp+0LgThO7D54j3jG7gXj2F073l09oBtUDwm3hPeNITuswdgwSlLIovDDMedmfnvRp
 r48jo265P00HLZVFFaXzjhhuy4cvjylDL9n9GibnjRQryjLrxIOGBpRNhxaVuFOkyK9B40YtL
 TSULlLIs/TJQvNNeu39CVy42/WVVGMT4/EJoamN1QRJhN7fK3IDjCz5DeW5K8C6HR9vCwmHMZ
 H1+dGw1im6WKFVmXyNwUkOLfXAfg+Sgh+CVotxgnyr7KXCoXf8wpehR3NNwwGoCzurf5Fuok/
 bjm+QU2TzkeE5GUPdXSQALXYZ+7XJzKkK6HkWIPXhKOLs6huGKYd63D+N1GDfJdu96j8ogUAs
 eLyf9NjBhCJwmOyx1vtBRlztrHuHQbpp7iBdzcWK7l7+i1ThIB8h2TULXXlw6HKLW6ZtWA6vP
 JIJ8r8DkArn835/6Fw+yKzSkmoU2ybHmjw6xwUYAZZh46k4dFdlrDBpMd3zWzKf8+iNVvhOuH
 0jGWw8iPlW7a8gyJWs8fA0oO9I9BaFDXLi5C3E5XFKiIE21AOej2Q9EbHPURR/0R6CqRdHxFj
 PHCDr2+qfVlJZwASLwPUWwCdkiHAa8s+JrNY7ERnbGe1IStu+z4yD2Eu86UVwF8poVhohg+gf
 hgabdUXdq9c9Nyv9Ka1R3djZWv9ZKvf9VAwtRyp430n3iFqWaBJtZSVUYeCQA3jxMKcz000/t
 ot5ELE7UmIFhDR+a3kf8GvIYI+UdA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marcel Ziswiler <marcel.ziswiler@toradex.com>

Enable SNVS LPGPR support. This may e.g. be used on the i.MX 8M Mini and
Plus to store a form of boot counter.

Signed-off-by: Marcel Ziswiler <marcel.ziswiler@toradex.com>
---

 arch/arm64/configs/defconfig | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index d5b2d2dd4904..521c784463bb 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -1239,6 +1239,7 @@ CONFIG_NVMEM_IMX_OCOTP_SCU=y
 CONFIG_MTK_EFUSE=y
 CONFIG_QCOM_QFPROM=y
 CONFIG_ROCKCHIP_EFUSE=y
+CONFIG_NVMEM_SNVS_LPGPR=y
 CONFIG_NVMEM_SUNXI_SID=y
 CONFIG_UNIPHIER_EFUSE=y
 CONFIG_MESON_EFUSE=m
-- 
2.36.1

