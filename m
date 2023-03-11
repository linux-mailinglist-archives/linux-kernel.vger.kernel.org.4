Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBF5F6B6202
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Mar 2023 00:17:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjCKXRp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 18:17:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbjCKXRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 18:17:41 -0500
Received: from smtp46.i.mail.ru (smtp46.i.mail.ru [95.163.41.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E13462D8D;
        Sat, 11 Mar 2023 15:17:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=zZT7SzQItSXGsV/KQyC5x/5aIAx9EI9rLbBKcRq43u4=;
        t=1678576659;x=1678666659; 
        b=RC5Sg2cy2EIFmFMTZDEqdviAQaCOAYfFouUcw8LGTzQhuG2lydgj1g6DrjxXnn+aTBTpqwBqoPEkOukreB1so4UNU9damS1R+6he74hyI2dnjz46atY+u5z8dDy+a2KSnEVD7i7FEU36sp78tW4g+l/ZDTj7ZaxMWXKNxxLgp1o=;
Received: by smtp46.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pb8T2-00B9aE-QV; Sun, 12 Mar 2023 02:17:37 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     dmitry.baryshkov@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, davidwronek@gmail.com,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for SM7150
Date:   Sun, 12 Mar 2023 02:17:32 +0300
Message-Id: <20230311231733.141806-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230311231733.141806-1-danila@jiaxyga.com>
References: <20230311231733.141806-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp46.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9BCEC41593EBD83573328AE13154FE908333A02E638E8A8D8182A05F5380850404C463074FC77DC138E2B1AC6EE66EAB056DE8276EE1B4C0B37749537E00BFDDB
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE79D9C320A40CA82D4EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006378437B1752DAB1FC78638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D82D64FD58ACC9660044F6CD9B640F7099117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF87214F1A954108EA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B28585415E75ADA9618001F51B5FD3F9D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE7532CA1512B81981C0837EA9F3D197644AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3FF30E5DF5FCA5605BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF3D321E7403792E342EB15956EA79C166A417C69337E82CC275ECD9A6C639B01B78DA827A17800CE7D283DE70228D6EEC731C566533BA786AA5CC5B56E945C8DA
X-C1DE0DAB: 0D63561A33F958A53461CD82E4D7BF09B11436FC6533849E8763C17BAD019EE74EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34806D3522FB05EB398661A9A2C639ED650B7A1628F01AB333E78EB3C228D7F04ABCB358D55C3987C91D7E09C32AA3244C416EAA5C6103FFEF0CC09B718F715AB2F2F5F14F68F1805B0D282625F6E20647
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEg2t1XEOuWGEAT+5cEw80A==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949814893C669902AB604585B4DD48715B08C5C8D7F440B56D7D3643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_VALIDITY_RPBL,SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Wronek <davidwronek@gmail.com>

Document the QMP UFS PHY compatible for SM7150.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 .../devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml       | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
index 64ed331880f6..cd0fbbd3593d 100644
--- a/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,sc8280xp-qmp-ufs-phy.yaml
@@ -18,6 +18,7 @@ properties:
     enum:
       - qcom,sc8280xp-qmp-ufs-phy
       - qcom,sm6125-qmp-ufs-phy
+      - qcom,sm7150-qmp-ufs-phy
       - qcom,sm8550-qmp-ufs-phy
 
   reg:
-- 
2.39.2

