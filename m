Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249626B2D25
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:51:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230494AbjCISvD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:51:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229925AbjCISu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:50:59 -0500
Received: from smtp61.i.mail.ru (smtp61.i.mail.ru [95.163.41.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088BCFAAF2;
        Thu,  9 Mar 2023 10:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=boycZjMnkdiPRXi0duwk189S6tnvS8Q4lJwNOGtbdoM=;
        t=1678387857;x=1678477857; 
        b=aM3X65AvwGeycKpnw4R25Nz+LgvyMaG8bWIsLUol/gaYLzjOl32WZy3p1nmf1+S6R+4UKGE5NCj/WGW9+AzFOT+m26hH50y75xK5H7y5kof2MUs3wdlE0JT3FogY/mBZHuo4V3wUKojIC6gA+f8ubCRFLE5rNgK84b4QuaTBbHQ=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1paLLq-002rxt-Ma; Thu, 09 Mar 2023 21:50:55 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidwronek@gmail.com, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: phy: Add QMP UFS PHY comptible for SM7150
Date:   Thu,  9 Mar 2023 21:50:48 +0300
Message-Id: <20230309185049.170878-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230309185049.170878-1-danila@jiaxyga.com>
References: <20230309185049.170878-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp61.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9450F94ADE3469222FC2D5B536EB64E3CE38E7626B6D44DBF1313CFAB8367EF908E2BE116634AD74D7AFE34B0D956BE00FFF89472C9F2C3EB6C7E1B3D995C836563C3B99123503CBA
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7E50EC9128971FD6EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006370E5D717DF121F99E8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8888CB4928319BC4340073DC6314E88EE117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC791E6C230873D55CA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520B1593CA6EC85F86D28451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEC24E1E72F37C03A028765F5520A300B2D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE35E3BF8C76DC23F7403F1AB874ED89028C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F790063789CC3F4C0027555EEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5E75C0640B69ABEBA37044E56BF2E133EB77B9BD8B52F30724EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D342B8615F5CFAD9D027CF743F0DF0DEC47370E02ED6CCE13103A981BFE944437DE0D08003001BB4F9B1D7E09C32AA3244CBC696285065C8D03E3AD7D576DB05A28E3D93501275E802F98DBA7662A2C9987
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojrI5GYPq6Vsd6BuclMab8cA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949812E89BE89565EF847568F3DBD5B5070B2EFE24C4A92C69CBE643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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
 .../devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml      | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
index 80a5348dbfde..da223abaa3a2 100644
--- a/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
+++ b/Documentation/devicetree/bindings/phy/qcom,msm8996-qmp-ufs-phy.yaml
@@ -25,6 +25,7 @@ properties:
       - qcom,sdm845-qmp-ufs-phy
       - qcom,sm6115-qmp-ufs-phy
       - qcom,sm6350-qmp-ufs-phy
+      - qcom,sm7150-qmp-ufs-phy
       - qcom,sm8150-qmp-ufs-phy
       - qcom,sm8250-qmp-ufs-phy
       - qcom,sm8350-qmp-ufs-phy
@@ -127,6 +128,7 @@ allOf:
               - qcom,sdm845-qmp-ufs-phy
               - qcom,sm6115-qmp-ufs-phy
               - qcom,sm6350-qmp-ufs-phy
+              - qcom,sm7150-qmp-ufs-phy
               - qcom,sm8150-qmp-ufs-phy
               - qcom,sm8250-qmp-ufs-phy
     then:
@@ -162,6 +164,7 @@ allOf:
               - qcom,msm8998-qmp-ufs-phy
               - qcom,sdm845-qmp-ufs-phy
               - qcom,sm6350-qmp-ufs-phy
+              - qcom,sm7150-qmp-ufs-phy
               - qcom,sm8150-qmp-ufs-phy
               - qcom,sm8250-qmp-ufs-phy
               - qcom,sm8350-qmp-ufs-phy
-- 
2.39.2

