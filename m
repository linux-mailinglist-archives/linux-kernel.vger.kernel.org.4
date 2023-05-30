Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCA10715B1D
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231409AbjE3KKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231136AbjE3KJn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:09:43 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F5593;
        Tue, 30 May 2023 03:09:37 -0700 (PDT)
Received: from stefanw-SCHENKER ([37.4.248.58]) by mrelayeu.kundenserver.de
 (mreue107 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1N1gac-1qEl5B15OC-0121IH; Tue, 30 May 2023 12:09:09 +0200
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
        Stefan Wahren <stefan.wahren@i2se.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: [PATCH V4 2/2] dt-bindings: imxgpt: add imx6ul compatible
Date:   Tue, 30 May 2023 12:08:43 +0200
Message-Id: <20230530100843.15072-3-stefan.wahren@i2se.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230530100843.15072-1-stefan.wahren@i2se.com>
References: <20230530100843.15072-1-stefan.wahren@i2se.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:q+6glmaBLTUjizXeKRScM+ThD4mzq5bQPImbRnYuNw8FauQ0lb+
 jXdEnpleoDdFRUXr73DrVn4cbennLfQOBxp8n8uljUgB0rn3s1QEU7qC6yfJD0y2uMinpaq
 EjAo/a+3MrrCGf13y7uwHIGdkuYzV8tyzbtCGLWJz48PQmgEhmXyxvn0pWlhMOQUHhVDsjS
 aQyASebSuJcP0uJnimhew==
UI-OutboundReport: notjunk:1;M01:P0:6JsSqUpKsQg=;LuYs2rRX5rdwDRMVXWTFSE4j3Vm
 Cg9nHmh1jE7c8FEvQJl7dbq5iAGCQSBk9ldl0JOiXykrpkOc1T8+HW+kDUjgGt888s5Xuaa+F
 q8F86TVVbf9Ac31OpdxBBNdyRhfoQmoSMgFd+xeQKvVGf6eDcrbE9FSY/cmLTIh43oeEF4yCg
 VD63RfaSYVNbN5vusaGJv6uMmS/JEc4hByCZMGMul//BksgYpq3gyAa5UMCq539lhDuCQLVP9
 ulGOsqt94023ctjxyny+AtvAco5df6kS4PmDQZL/hllp/AzFSD0qLNcfzyK+HG0fDWuuNts/v
 9QkszW96oGzF0Hqs2FTmWflKGeh5Y54XDTkciwt+9bC6zUoiBj9jy+r986o2GWC5GNMgt/wJd
 r3qQUCccUL9lr4w3aWOKaM++/O1X6KXi5RwO7j8+kArlTnJHcqzzt09KAN3OoZky8JOHewlT3
 Fi97Kc5BpwHu9S7MR+bGDLDDRmnkZGI/GDYt3LE6tlQQdv4/pniS0O4qS7KxTaV5zTu4uII1p
 mPWhMjJFC6gVrp2tju06Y4P4efRJBYpj9a2OGBGTjp4ty25RVLUHMN+jjuDi7v8s3InF9R6q/
 yLiVU9YWeCIZUhyzLCTztQOSq40FoRFEFQU6+nDqH6ue+aZv40D4hiCpPE+f58qjJpzQ8BstI
 NgPlOb8Y5uzXduHoQSNfHXLTdFNrJ5AAPU1L/jYvzA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the dtbs_check for imx6ul generates warnings like this:

['fsl,imx6ul-gpt', 'fsl,imx6sx-gpt'] is too long

According to the timer-imx-gpt driver all imx6 use the same imx6dl data,
but according to the existing DTS files the imx6ul GPT IP is derived from
imx6sx. So better follow the DTS files here and make the imx6ul GPT
compatible to the imx6sl one to fix the warning.

Signed-off-by: Stefan Wahren <stefan.wahren@i2se.com>
Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
index 716c6afcca1f..685137338ac9 100644
--- a/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
+++ b/Documentation/devicetree/bindings/timer/fsl,imxgpt.yaml
@@ -34,6 +34,9 @@ properties:
               - fsl,imxrt1050-gpt
               - fsl,imxrt1170-gpt
           - const: fsl,imx6dl-gpt
+      - items:
+          - const: fsl,imx6ul-gpt
+          - const: fsl,imx6sx-gpt
 
   reg:
     maxItems: 1
-- 
2.34.1

