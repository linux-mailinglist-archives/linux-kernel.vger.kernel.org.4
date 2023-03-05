Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B3C16AB212
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 21:26:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjCEU0i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 15:26:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229561AbjCEU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 15:26:35 -0500
Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C242A11145;
        Sun,  5 Mar 2023 12:26:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=/MA8OQmKoCy4J8qMwUp4GJThWc/HvmAvc5EiS0d6gbg=;
        t=1678047994;x=1678137994; 
        b=wx8G8Rwe7xA9CpLpa0R/q/1HXCME3ED/nttwX6I90Ugl2gOVeHu8KSubJZR93AniLVR1WvvMDXj7ul0OQqW8MdMp1YFL63PCUvCAWa5+a+BZ+MdoM6w4kyZocwsWyTfgNp7aOw0R/3tMC3MLjbQZoHgzIqSEZ7nkVuy3Q4/aCSI=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pYuwC-00A5Rd-Cj; Sun, 05 Mar 2023 23:26:32 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        abel.vesa@linaro.org, rishabhb@codeaurora.org,
        saiprakash.ranjan@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: arm: msm: Add LLCC for SM7150
Date:   Sun,  5 Mar 2023 23:26:26 +0300
Message-Id: <20230305202627.402386-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305202627.402386-1-danila@jiaxyga.com>
References: <20230305202627.402386-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp63.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9BCEC41593EBD8357B8315801F980F14B9D42377418D05A81182A05F538085040CF477FC4BBE41C19DAEE704DCD96093E259C7428247B832DF4DE7991F6D4DA09
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE751DD1FEBB966604DEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637129C704593A46970EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B6F1F7B995052D5CE71B38564A1331FBACB3EE4E66C8BAA0ECC7F00164DA146DAFE8445B8C89999728AA50765F7900637498978385686B898389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC8DBD6BAFA574C8444F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947CCBD0204554ED7BDEAD7EC71F1DB884274AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3015E3C4E802C7FF8BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C329E02162369759EE35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A525464011090F2F7C607F191F3D2191A07068044832FB3C314EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D349C39CCCDAABCB54BB6571E503B2EF7D2EEEA91D946A8021A2E9124696FEF3E01B4741452C3BA8A581D7E09C32AA3244CC3F1BFCCC5AAF19E0302A292AA503B051E098CBE561D6343111969D93F5DC462
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMXwBDQf4j7MNco0Lbo3XZw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498118617784DBFF2E98D1980B6C11B2B2FA39D8A1B107B343D2643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC compatible for SM7150 SoC.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml | 1 +
 1 file changed, 1 insertion(+)

diff --git a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
index 38efcad56dbd..0f838b899127 100644
--- a/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
+++ b/Documentation/devicetree/bindings/arm/msm/qcom,llcc.yaml
@@ -27,6 +27,7 @@ properties:
       - qcom,sc8280xp-llcc
       - qcom,sdm845-llcc
       - qcom,sm6350-llcc
+      - qcom,sm7150-llcc
       - qcom,sm8150-llcc
       - qcom,sm8250-llcc
       - qcom,sm8350-llcc
-- 
2.39.2

