Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A2B65A769
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 23:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232307AbiLaWYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 17:24:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232169AbiLaWYo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 17:24:44 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A222A63A8
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 14:24:42 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4NkxWY07Vcz1S5Dx
        for <linux-kernel@vger.kernel.org>; Sat, 31 Dec 2022 17:24:40 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:mime-version:references:in-reply-to
        :x-mailer:message-id:date:subject:to:from; s=dkim; t=1672525480;
         x=1673389481; bh=We5xjhGqrFdJQxR93Npt09VH/7a6fXPhQTRN9HYr93I=; b=
        VnSuBj/p0ZTLvZrkBy8xEMBAOgT+Iwslxo6bCFLuHuhlP0G0ZWuYwET5t/dDxqH6
        5i8i52BguP2AwqXQexDEom11x5DSmNd0ATPjZvsR+I0L+o9Q4pCdDPfR8CQNHudw
        Aygxd2UV52XuSxMfoq7s5dbvb3vszDSqyo+6yhRWETy4DbwUlHt3oPMkvLmEseMb
        b/y74llbXuoBZz3CSi52lz2yhcrHr1ejf4Eh2BGyI+cuZcRKM6ILpNjlS47lbM8l
        D333JO9OHZoxOz3VppqnwlbuZ3nv1hb8eN0CmB5/PUmII2cs8HayjWNjCgjKUfP9
        AhJi62wSJ2UyAXWaOLYMZA==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id wW6HOZOeFChE for <linux-kernel@vger.kernel.org>;
        Sat, 31 Dec 2022 17:24:40 -0500 (EST)
Received: from dorothy.. (unknown [190.196.92.66])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4NkxWQ3LWTz1S56h;
        Sat, 31 Dec 2022 17:24:34 -0500 (EST)
From:   Lux Aliaga <they@mint.lgbt>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        marijn.suijten@somainline.org, Lux Aliaga <they@mint.lgbt>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 1/6] dt-bindings: ufs: qcom: Add SM6125 compatible string
Date:   Sat, 31 Dec 2022 19:24:15 -0300
Message-Id: <20221231222420.75233-2-they@mint.lgbt>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221231222420.75233-1-they@mint.lgbt>
References: <20221231222420.75233-1-they@mint.lgbt>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the compatible for UFS found on the SM6125.

Signed-off-by: Lux Aliaga <they@mint.lgbt>
---
 Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml b/Docume=
ntation/devicetree/bindings/ufs/qcom,ufs.yaml
index b517d76215e3..42422f3471b3 100644
--- a/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
+++ b/Documentation/devicetree/bindings/ufs/qcom,ufs.yaml
@@ -29,6 +29,7 @@ properties:
           - qcom,sc8280xp-ufshc
           - qcom,sdm845-ufshc
           - qcom,sm6115-ufshc
+          - qcom,sm6125-ufshc
           - qcom,sm6350-ufshc
           - qcom,sm8150-ufshc
           - qcom,sm8250-ufshc
@@ -185,6 +186,7 @@ allOf:
           contains:
             enum:
               - qcom,sm6115-ufshc
+              - qcom,sm6125-ufshc
     then:
       properties:
         clocks:
--=20
2.38.1

