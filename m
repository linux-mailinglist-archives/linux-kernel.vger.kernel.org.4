Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB4E36AB1DC
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbjCET3g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 14:29:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbjCET3e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:29:34 -0500
X-Greylist: delayed 675 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Mar 2023 11:29:32 PST
Received: from fallback13.i.mail.ru (fallback13.i.mail.ru [79.137.243.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45168125BA;
        Sun,  5 Mar 2023 11:29:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=IWnxOrk1O9V1el9edFQ7Izamb+ktwjKai6J3ZV9lWn0=;
        t=1678044572;x=1678134572; 
        b=bbXMpvziy8jMoGCfkn/EMm9Y0OybO7PDgxaO+T9ZmMDf4vtdoCOSZfoX+LAo9RvU6ilfwTeKyL5frhdXOjZ6fPW7RHzIsN8EZDfZ40y4idGlUHd6V71b6sfK/hTsUG+GtGSvx2CRupFRtEgR/HeQTCwJYHNHCLIif79vRzowmDU=;
Received: from [10.12.4.11] (port=37260 helo=smtp36.i.mail.ru)
        by fallback13.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1pYtsA-00Fc7m-QI; Sun, 05 Mar 2023 22:18:18 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=IWnxOrk1O9V1el9edFQ7Izamb+ktwjKai6J3ZV9lWn0=;
        t=1678043898;x=1678133898; 
        b=TnpWM1FrOFdHvA+mGunRXKKjSPC8wFhpCLIZAixX/XNeScPy2kTYivaNbd30xmdklHDY2t3q/1BxeZX6mgxqcwlRek1x0RxlqlprUR4TolxTC7cYdwAupfEU8418p1shJnD6HCRysk4u68keNYr6Re8m/bdV3qR0Z9Djxh9bL84=;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pYtrx-00BIaX-KE; Sun, 05 Mar 2023 22:18:06 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, David Wronek <davidwronek@gmail.com>,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 1/2] dt-bindings: arm: qcom,ids: Add Soc ID for SM7150
Date:   Sun,  5 Mar 2023 22:17:44 +0300
Message-Id: <20230305191745.386862-2-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230305191745.386862-1-danila@jiaxyga.com>
References: <20230305191745.386862-1-danila@jiaxyga.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9BCEC41593EBD8357D6AE1D10A68AF31DF4EC02C34BD736D3182A05F53808504054769FBBF153F2FF7903850DBE65299FD07926F003880CDC84D5383E39AAD531
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE792C68BF9CD4C0E9EEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637A005C90FB6EB35FF8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D83A2605CF60073FC5DDC0F6FA3A850E6D117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC4AFB60FD1831C04CA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735204B6963042765DA4B28451B159A507268D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEC65AC60A1F0286FE3DBBCB839D0549ACD8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE34D3DDB508812D9002D242C3BD2E3F4C6C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C2FFDA4F57982C5F42E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FB65E609F6EF545B96D8C47C27EEC5E9FB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5763627A4A91898C51CA33C1A2CC8196B69E0073C48B39ECB4EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D348BF433665406F3905E270B111805438BAB488409B68D557A284949C65C8EEDE8BDAEB93BCBFC37481D7E09C32AA3244C679017F0D7B5321F828C6BE6ADC513B5F522A1CF68F4BE05ED98077840A144B9
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMXwBDQf4j7OxWLge6GzQTA==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981B5751B9D9276E50CBF76269390DCD72E933621144CA8F47A643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4BD2EB812D5A6E5F7D3C1BE093F4DBF3E3AB7BEC7152D166B049FFFDB7839CE9E62BCD1450C26EE0F0365C8B259CFCE83848CC8CD1E9F76277771A298C2357A37
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdAc2jUOxWGfwqdI8efiaklg==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_VALIDITY_RPBL,
        SPF_HELO_PASS,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: David Wronek <davidwronek@gmail.com>

Add the ID for the Qualcomm SM7150 SoC.

Signed-off-by: David Wronek <davidwronek@gmail.com>
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>
---
 include/dt-bindings/arm/qcom,ids.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
index aa95439708dc..524e3a976191 100644
--- a/include/dt-bindings/arm/qcom,ids.h
+++ b/include/dt-bindings/arm/qcom,ids.h
@@ -192,6 +192,7 @@
 #define QCOM_ID_SA8155			362
 #define QCOM_ID_SDA439			363
 #define QCOM_ID_SDA429			364
+#define QCOM_ID_SM7150			365
 #define QCOM_ID_IPQ8070			375
 #define QCOM_ID_IPQ8071			376
 #define QCOM_ID_QM215			386
-- 
2.39.2

