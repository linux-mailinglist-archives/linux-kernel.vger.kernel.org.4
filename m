Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1B94715B39
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:15:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230193AbjE3KPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:15:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjE3KPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:15:04 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [217.72.192.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9EF93;
        Tue, 30 May 2023 03:15:02 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MTzOe-1pe3Py0phi-00R2ux; Tue, 30 May 2023 12:09:08 +0200
From:   Stefan Wahren <stefan.wahren@i2se.com>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     Marek Vasut <marex@denx.de>, linux-kernel@vger.kernel.org,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Stefan Wahren <stefan.wahren@i2se.com>
Subject: [PATCH V4 0/2] dt-bindings: imx: Fix dtbs_check warnings
Date:   Tue, 30 May 2023 12:08:41 +0200
Message-Id: <20230530100843.15072-1-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:cmG0J6+3RtVmaV1J0wWj307gxunjjnimgjFaE9b6lVjMHRQjufg
 bczJG8hWuj3cBP0mZBDkoj0Rx0boCBSHEqMopw1W/fl3a1EBEJayHTZOi4yy71Rdp0QPX4p
 SoC2FaxRJQfVTSVVZo/iU34Wa1jcSC+Plmp+kz+DzQZK5viI8M0AaMBXH7HH5Y4meA+X1wY
 3zBD4aY/eCzRVei9EVb9w==
UI-OutboundReport: notjunk:1;M01:P0:MFVebADgs8M=;xnkBNB/IZ2UWaMjlN/W/WmW97Al
 8Ur6JxLVRiRyU3Y91c+1lvMElxZ/mS4v2hrJH5/7lXDMmnre9AE4aXY+nNeNtM4Nirc/LZ2WH
 WEiOm6FoHBV4/bNAGNmLMgpKgfYCsg5uHtTfaCXBcpWGNwgqfwajCTrN7biTMtskOCAM7C8H3
 UNCI5trU59lHwLrOCA3sqTYd5RlZ5IiOi2Z14nWp0he+mAjEEyDa14Vh8Usp3kYTPCr4YRLJa
 YwRrQ1YcchfzBvqCkXAp+m519anBb11NIU7eOO98HUNFeusmAb/6ue0sGCp98KAln5P99Rm+3
 LYAcw/KsmkgXu1R3ZvCw/2aWAWgCBmywX02CMTyvym5cJE3apezJU1pYjeHWGeITaChKI6afw
 L4REzpuoCa+7KxFfQRkzUhkoC5sKsLk4NDvT9AZRlVIfd9Nko2JkPnTUcOY7CJz2GnNCVqcXM
 Ft3d0TX1zRsC7vclohVP5qI93fnKvhNcdoodOS2Lfcn8+lA4/UalTOLfMuabpR9XZMT+r+4Bn
 t0gHywGxYm05hUNVLwRlmg15WFgd54dK0vauXotvsahfAVjeRFodH9KUzoxUNyMnKpJSDzgDR
 TCjZxbJBqxk0ZbGBnsDdNAjlUtngNTjJA8+Xa4v60DFgUyw9yMMhpJFivmGbXTZnHNSYNWg8Y
 Q9zRzXrsSh2dWNBuIW6ZdUgSsuDcqeZ0w/XoyYtSRA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series tries to address some dtbs_check warnings on i.MX6ULL.

Changes in V4:
- drop patch 1 from V3 which has already been addressed by Marek Vasut
- drop already applied patches from V3 (#3, #5, #6) 

Changes in V3:
- add Krzysztof's Reviewed-Bys
- fix indentation in Patch 6 found by Krzysztof Kozlowski

Changes in V2:
- new patch to fix fsl-imx-uart warnings 
- fixed GPC typo found by Fabio Estevam
- keep enum in bindings as suggested by Krzysztof Kozlowski
- make imx6ul GPT compatible to imx6sx


Stefan Wahren (2):
  dt-bindings: crypto: fsl-dcp: add imx6sl and imx6ull compatible
  dt-bindings: imxgpt: add imx6ul compatible

 .../devicetree/bindings/crypto/fsl-dcp.yaml          | 12 +++++++++---
 .../devicetree/bindings/timer/fsl,imxgpt.yaml        |  3 +++
 2 files changed, 12 insertions(+), 3 deletions(-)

-- 
2.34.1

