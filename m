Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E46EB6AB20F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 21:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229696AbjCEUP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 15:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCEUP4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 15:15:56 -0500
Received: from fallback3.i.mail.ru (fallback3.i.mail.ru [79.137.243.69])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18F25FF3D;
        Sun,  5 Mar 2023 12:15:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=dFL43gZgiS1xZ22vSSA+UXTKBe7s1pQ98YWaT12VAQw=;
        t=1678047354;x=1678137354; 
        b=ZR7n5yJyCKg35XxRhFzD2zbkx27TYnBGytwkd/Jve0JmTC9kgdQc67X545NT2gAQ2sfjX43srT1uJxH8+kwZ4wvrE7Q5qMGXqRIIPU1Cn05sjVC84E86O8cxWk5bneIAaCVDphmStmZTkMUCwoOC1vwNvYK/ofkE+ruYvS3eCfk=;
Received: from [10.12.4.11] (port=56270 helo=smtp36.i.mail.ru)
        by fallback3.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1pYts8-00EBG6-Mi; Sun, 05 Mar 2023 22:18:16 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=dFL43gZgiS1xZ22vSSA+UXTKBe7s1pQ98YWaT12VAQw=;
        t=1678043896;x=1678133896; 
        b=LMcO5khUGPexfx8ElKYxpoX+5Iiw3d37kgQXI5CY0IBpHE1tDJ9TQZYroHUFo8Q/Z04IQHk6uDOfbTEE2Hr6S49Xkwcoa+g/Vwnm1/VlRp44Ywvo6DY/GTP9OLVzKDMp6wuX5j9AP3vHOfg928BeYX+F804MQ3Pq/GqvadBCaHY=;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pYts1-00BIaX-7O; Sun, 05 Mar 2023 22:18:09 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, David Wronek <davidwronek@gmail.com>,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 2/2] soc: qcom: socinfo: Add Soc ID for SM7150
Date:   Sun,  5 Mar 2023 22:17:45 +0300
Message-Id: <20230305191745.386862-3-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305191745.386862-1-danila@jiaxyga.com>
References: <20230305191745.386862-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD9BCEC41593EBD8357E11587E679F50E6B5E08481E444D2B44182A05F538085040D5DC73D33A83A7261AEAC18F12A2BA5F429F60C24E239F2BD1D4045A2B921A16
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE732F68F8AF5E5BA59EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063775FF68B4B43662428638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D80A308C93275ED7E564FC11E95604B28E117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCCDDA9AEF61929F65A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520902A1BE408319B292CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE599709FD55CB46A69935A1E27F592749D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE34D3DDB508812D900040F9FF01DFDA4A8C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F79006374C9948CBF2E1C8CBEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A58257D58B575381881CA33C1A2CC8196B0896A7F7E695C3774EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34F1ADD4D8CD3C81CE2E0E327645BD62CCE690A666F11F3B3AE72A753332D7BDE0026E39CC5E6B640A1D7E09C32AA3244CADC6DB03D54E9C85A7ADBDD1D195093B64EE5813BBCA3A9DED98077840A144B9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMXwBDQf4j7NCi5zPlcjmrA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981E39502E655FA936A64A3B169FFF539A2EA73CA019633F4A1643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4BD2EB812D5A6E5F7D3C1BE093F4DBF3E2C2E764F14C8543A049FFFDB7839CE9E62BCD1450C26EE0F0392B49203573CCAA6A1E60E0FA32A8E91F54EC22B3865E1
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdAc2jUOxWGfy7rjyaVGmG6g==
X-Mailru-MI: 800
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

Add Soc ID table entries for Qualcomm SM7150.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 drivers/soc/qcom/socinfo.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/soc/qcom/socinfo.c b/drivers/soc/qcom/socinfo.c
index e9012ca1a87b..c3542252dbbc 100644
--- a/drivers/soc/qcom/socinfo.c
+++ b/drivers/soc/qcom/socinfo.c
@@ -405,6 +405,7 @@ static const struct soc_id soc_id[] = {
 	{ qcom_board_id(SA8155) },
 	{ qcom_board_id(SDA439) },
 	{ qcom_board_id(SDA429) },
+	{ qcom_board_id(SM7150) },
 	{ qcom_board_id(IPQ8070) },
 	{ qcom_board_id(IPQ8071) },
 	{ qcom_board_id(QM215) },
-- 
2.39.2

