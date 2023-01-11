Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB355665D75
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 15:14:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232343AbjAKOOg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 09:14:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232656AbjAKOOT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 09:14:19 -0500
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0E1E38B4;
        Wed, 11 Jan 2023 06:14:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1673446455;
        bh=5R+BDO8hhIMYzqA8po6d4hMbVhMtgHcE2MvtMKkOAk8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References;
        b=eCPcgJuewLowX0Q8qWQQIogHk2eVWeH/4MYGw9eQyR99cAakTS48jJ360p5Bk6zdb
         PWmAP13rVLOIPCYx8p8dXXF0dT9Q/UAqNmAgO1Fit1x6CZW6yJOCosxCMCNbkCAXuh
         F3pkEcQJTH0zrJU7XmqTwFAyAzwhOqv0UFyC5YHY=
Received: from localhost.localdomain ([111.60.247.106])
        by newxmesmtplogicsvrszc2-1.qq.com (NewEsmtp) with SMTP
        id 37731CEB; Wed, 11 Jan 2023 22:13:55 +0800
X-QQ-mid: xmsmtpt1673446452t0n5cqb9g
Message-ID: <tencent_CBBB183FDF1C6134607850ED023A2930AE06@qq.com>
X-QQ-XMAILINFO: NMGzQWUSIfvTx6o2bDgHiM/5FMAB/i49UepwPDEVPF/CPWymsc/q1PshUQyz7d
         /OebKUMqVQge5cgj7Mlk+f7RR66c1xLJ1hMj64ptKOv5J5E9BlHb4EC5phA3IQ6rns1MCH6IF5eC
         GsncWmNnahFkskHhcYk4RX3AbdBPXn7iuPkIgjCZk/1Fyq8eldJE9y+6ol264/0RDarZhYB/R0m2
         pxxBuPIFrj14PXj0WCuAATX2v7RT+77KBhzgY5a29eToz4Ik8Qq0sMk36v13en58bFFYOwgk41kD
         tv5BxDAx4Ug7uBZQ34Xb3AiotCB5bRTTtrE9FEgo8/Wn1WfYn8ngKrlR6iHiBsLcCTM4XPGAKNef
         fqOEys604beA6d8sXJopKeOyzfXLvUsEYabo3TdvOj97xSI6Sou9IBt887cbP4gaf26vdEXkPmLt
         FhgHVhXLj5XY+CQun416qnHMITbrLiL9pqFah0Usmx3IOT8D1RyVHMyRyKa2atKvXdV7J+ZnGF6x
         lBUziluceDzvJeOl+3STwfm9vulc7BTLvZVhT0y+BYqz/3+keVQvsAyn0iYszQ7CF3sVT8TqF7vU
         vmUQ5GIsvEN6KHp+QFPAtEXf/Sgl2L53SGa/tMtw/TX6AtiyF7ct4F0FWrPssDGG27Bt1t/Y19Ae
         EXhvK6Eob4ft3MgmNnYTspit0qcpeHQ+R6CjMlkhBB2OKCp2RtEi/LG/nAjbRvjxXqzKDzVpO35P
         FsxcA8Tu/ml6RekFqqXxkXuMf+H8O4bBrgUh1yFDnvHXnhyWFHnuo+0u75eDeCO7PeqBCk99/Ykm
         1cPOIS6UDNyshrgpGa9XTYuUDIgUR2kOC+Bv45bxBmRzdckCndFkNgheGhaQXRY88nV/W63dMXhe
         2xSgYSg9KQsVRzxCcuxqCCmqyj8q8OHb/MGR7Z5c7DcAFSuhfb4vLci1yKksYqVGaeCnsAWvsSq6
         Ou1AA9AX4ebyfnF+qIA+s4UMH5eJZ4mHzlJPc747hyCP7fCDAZOuXH/ZQVvTcxYM2OZXwINO1bw6
         WQq2vca0iXRxwQw36xuCgAQUkwZv8=
From:   Yang Xiwen <forbidden405@foxmail.com>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Jaime Breva <jbreva@nayarsystems.com>,
        Nikita Travkin <nikita@trvn.ru>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Yang Xiwen <forbidden405@foxmail.com>
Subject: [PATCH v2 2/3] dt-bindings: qcom: Document msm8916-thwc-uf896 and ufi001c
Date:   Wed, 11 Jan 2023 22:13:10 +0800
X-OQ-MSGID: <20230111141311.14682-3-forbidden405@foxmail.com>
X-Mailer: git-send-email 2.39.0
In-Reply-To: <20230111141311.14682-1-forbidden405@foxmail.com>
References: <20230111141311.14682-1-forbidden405@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Document the new thwc,uf896/ufi001c device tree bindings used in their device
trees.

Signed-off-by: Yang Xiwen <forbidden405@foxmail.com>
---
 Documentation/devicetree/bindings/arm/qcom.yaml | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/Documentation/devicetree/bindings/arm/qcom.yaml b/Documentation/devicetree/bindings/arm/qcom.yaml
index 65ef7e442da0d..18070574848ae 100644
--- a/Documentation/devicetree/bindings/arm/qcom.yaml
+++ b/Documentation/devicetree/bindings/arm/qcom.yaml
@@ -209,6 +209,8 @@ properties:
               - samsung,grandmax
               - samsung,j5
               - samsung,serranove
+              - thwc,uf896
+              - thwc,ufi001c
               - wingtech,wt88047
           - const: qcom,msm8916
 
-- 
2.39.0

