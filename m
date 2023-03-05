Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BA896AB219
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 21:26:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbjCEU0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 15:26:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCEU0i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 15:26:38 -0500
Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2BD11145;
        Sun,  5 Mar 2023 12:26:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=lgYNTzW6gawadmebn/VRYl1mwn+DWb0hT5wqBDv9YxY=;
        t=1678047997;x=1678137997; 
        b=tJcF3e7ZpcIINsa7cFqVTzir0wAWZrX7zr/U9LrTrg9tImYlziN9WAx0Igbpr00KdrKSDRWV4mf6mI0+8lnDrgFyuNKq4SwY820DATqfCI/ziNLs9/xrvI14ZjVwRBS5EnyRyQDOT0hqlLYOooMu/0fpc1VJDifWeWLjnAaWvis=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pYuwF-00A5Rd-3d; Sun, 05 Mar 2023 23:26:35 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        abel.vesa@linaro.org, rishabhb@codeaurora.org,
        saiprakash.ranjan@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 2/2] soc: qcom: llcc: Add configuration data for SM7150
Date:   Sun,  5 Mar 2023 23:26:27 +0300
Message-Id: <20230305202627.402386-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305202627.402386-1-danila@jiaxyga.com>
References: <20230305202627.402386-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp63.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: B8F34718100C35BD
X-77F55803: 4F1203BC0FB41BD9BCEC41593EBD8357D61703A5C7370B1E319F7344C6651618182A05F5380850404B5ABABDD357052B0B94EE2454854F3A4D592347165C255E8EED69AB451245FD
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE77806F8AEFB2C8BE8EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063702DFA59B3C994360EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B6F1F7B995052D5CE685D4FB135444E96D6B4252C3A7C74D8CC7F00164DA146DAFE8445B8C89999728AA50765F79006373F278AD70EDB56F1389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC86317DB91DEFCD113F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C95C44B506FFBBDA5BA3038C0950A5D36C8A9BA7A39EFB766EC990983EF5C0329BA3038C0950A5D36D5E8D9A59859A8B6398D3D36CE1CA3E976E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249EC8D19AE6D49635B68655334FD4449CB9ECD01F8117BC8BEAAAE862A0553A39223F8577A6DFFEA7CE471091D5D40D95643847C11F186F3C59DAA53EE0834AAEE
X-C1DE0DAB: 0D63561A33F958A54FC77A9EB55AE1A7607F191F3D2191A007BE0AAEECDCB5804EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34A63B03BCD35E0C0ACF23F858F2FE0AF1E0AE34B6FE27B69163EBE5602F98C4DEFB300F896F003D121D7E09C32AA3244C50B2A354DFC621CDCB86A577079BF6BCD9ADFF0C0BDB8D1F111969D93F5DC462
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMXwBDQf4j7NLSjc6NusPGA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498118617784DBFF2E98EDCFBE0C60533772AFE57FE6586BF64D643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add LLCC configuration data for SM7150 SoC.

Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/soc/qcom/llcc-qcom.c | 17 +++++++++++++++++
 1 file changed, 17 insertions(+)

diff --git a/drivers/soc/qcom/llcc-qcom.c b/drivers/soc/qcom/llcc-qcom.c
index 23ce2f78c4ed..0ed8cd4f66da 100644
--- a/drivers/soc/qcom/llcc-qcom.c
+++ b/drivers/soc/qcom/llcc-qcom.c
@@ -227,6 +227,14 @@ static const struct llcc_slice_config sm6350_data[] =  {
 	{ LLCC_MODPE,    29,  64, 1, 1, 0xFFF, 0x0, 0, 0, 0, 0, 1, 0 },
 };
 
+static const struct llcc_slice_config sm7150_data[] =  {
+	{ LLCC_CPUSS,    1,  512, 1, 0, 0xF, 0x0, 0, 0, 0, 1, 1 },
+	{ LLCC_MDM,      8,  128, 2, 0, 0xF, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_GPUHTW,   11, 256, 1, 1, 0xF, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_GPU,      12, 256, 1, 1, 0xF, 0x0, 0, 0, 0, 1, 0 },
+	{ LLCC_NPU,      23, 512, 1, 0, 0xF, 0x0, 0, 0, 0, 1, 0 },
+};
+
 static const struct llcc_slice_config sm8150_data[] =  {
 	{  LLCC_CPUSS,    1, 3072, 1, 1, 0xFFF, 0x0,   0, 0, 0, 1, 1 },
 	{  LLCC_VIDSC0,   2, 512,  2, 1, 0xFFF, 0x0,   0, 0, 0, 1, 0 },
@@ -464,6 +472,14 @@ static const struct qcom_llcc_config sm6350_cfg = {
 	.edac_reg_offset = &llcc_v1_edac_reg_offset,
 };
 
+static const struct qcom_llcc_config sm7150_cfg = {
+	.sct_data       = sm7150_data,
+	.size           = ARRAY_SIZE(sm7150_data),
+	.need_llcc_cfg	= true,
+	.reg_offset	= llcc_v1_reg_offset,
+	.edac_reg_offset = &llcc_v1_edac_reg_offset,
+};
+
 static const struct qcom_llcc_config sm8150_cfg = {
 	.sct_data       = sm8150_data,
 	.size           = ARRAY_SIZE(sm8150_data),
@@ -1022,6 +1038,7 @@ static const struct of_device_id qcom_llcc_of_match[] = {
 	{ .compatible = "qcom,sc8280xp-llcc", .data = &sc8280xp_cfg },
 	{ .compatible = "qcom,sdm845-llcc", .data = &sdm845_cfg },
 	{ .compatible = "qcom,sm6350-llcc", .data = &sm6350_cfg },
+	{ .compatible = "qcom,sm7150-llcc", .data = &sm7150_cfg },
 	{ .compatible = "qcom,sm8150-llcc", .data = &sm8150_cfg },
 	{ .compatible = "qcom,sm8250-llcc", .data = &sm8250_cfg },
 	{ .compatible = "qcom,sm8350-llcc", .data = &sm8350_cfg },
-- 
2.39.2

