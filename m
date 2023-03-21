Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3BE16C3916
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 19:23:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230403AbjCUSXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 14:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230393AbjCUSX2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 14:23:28 -0400
Received: from smtp36.i.mail.ru (smtp36.i.mail.ru [95.163.41.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67F6230D3;
        Tue, 21 Mar 2023 11:23:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=xs4uVFznL219tuyNHCYHp5XAjWFTcAzTNnZpaFv2jQs=;
        t=1679423006;x=1679513006; 
        b=jBSLkAu+zxXndosmBRBQzq7UOtNMxs+chBiVkjwCMHYfuNGpxcdgq1hKJELyhFuj2SRmrfQdMVpxD1/Ii3yLru7bo5TamLuNcQoos3bvTjx1dtByxECtYCOv5HaRfvPSa4P0eALp/rX7MDaAwZccx8RF6hE1ckZw4JwMJ9pEIE0=;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pegdm-00Glud-Ve; Tue, 21 Mar 2023 21:23:23 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH] arm64: dts: qcom: pm8150l: add spmi-flash-led node
Date:   Tue, 21 Mar 2023 21:23:19 +0300
Message-Id: <20230321182319.24958-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp36.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD992B47CBA3690DD1E730BF522A0F2D395FFC21FDAFD9DE6B100894C459B0CD1B9F999F90D02607CDAC5E967044ABC5E847A462112700F1F46471E6F0AD5863D70
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE75EB26DC3398F980CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006372338AE33E473C9B88638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8762A69D38D3ADF52617B2ACF1C05D33B117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCC0EC8C44E4C1BEE2A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735200AC5B80A05675ACD2CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE599709FD55CB46A69100238FE36DC7A2D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE31DAA61796BF5227BC0837EA9F3D19764C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F7900637C17C018527E75DCFEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A5791C3B3D973970FABAED44A26150250F522FF0690FA73574F87CCE6106E1FC07E67D4AC08A07B9B01F9513A7CA91E5559C5DF10A05D560A950611B66E3DA6D700B0A020F03D25A09EDCF5861DED71B2FF32E08699F8F45A1CDFF42231550506261332C5CB50AE517BDAD6C7F3747799A
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34B9F55CA4D2956E3039AA125374783AFBE7AC28D960128EAEB5F56B1F83090FE0BCE2591BB1B8A7CD1D7E09C32AA3244C6216DAD2275768759DC9622E5D9CEF78A995755A1445935E27AC49D2B05FCCD8
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXgzVV34exisKqFl6dER70/N
X-DA7885C5: F372DD1B80E89470D92A718BBF65D2EC48836285C89F130DDE4C75F5F09B0B58D8288D6B1992AB67EF2421ABFA55128D02E9C42E3A59EA20
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981B35C08DFF3606A0C4592769330D757D0976AF1CB91E6EA81643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
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

Add a node describing the flash block found on pm8150l.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 arch/arm64/boot/dts/qcom/pm8150l.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm64/boot/dts/qcom/pm8150l.dtsi b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
index 135bfb8d629b..cca45fad75ac 100644
--- a/arch/arm64/boot/dts/qcom/pm8150l.dtsi
+++ b/arch/arm64/boot/dts/qcom/pm8150l.dtsi
@@ -116,6 +116,12 @@ pmic@5 {
 		#address-cells = <1>;
 		#size-cells = <0>;
 
+		pm8150l_flash: led-controller@d300 {
+			compatible = "qcom,pm8150l-flash-led", "qcom,spmi-flash-led";
+			reg = <0xd300>;
+			status = "disabled";
+		};
+
 		pm8150l_lpg: pwm {
 			compatible = "qcom,pm8150l-lpg";
 
-- 
2.39.2

