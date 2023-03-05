Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6704C6AB1DF
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 20:30:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229738AbjCETag (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 14:30:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbjCETae (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 14:30:34 -0500
Received: from fallback17.i.mail.ru (fallback17.i.mail.ru [79.137.243.72])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E72A12F26;
        Sun,  5 Mar 2023 11:30:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=JXUKNNLmBsq54GfddFYndLp3E16igNJM7pRxeUX5NKM=;
        t=1678044633;x=1678134633; 
        b=bYIxFNe6iKJie4QjXYVOsksvD/NTOhA54y0CBXVDoakzMQd1e62bd8EKbjRcq51nOYvkIo8z4DnmRYenMIILnckja/h1dJkInplB6Twng08NcgilmRb/X1OnUdXJLKrW7Ttw8c8j3IY2OVUxBfkdEYi/a2Qtyml3Xz8j/keHQ7s=;
Received: from [10.12.4.11] (port=60920 helo=smtp36.i.mail.ru)
        by fallback17.i.mail.ru with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1pYts7-0055Lk-01; Sun, 05 Mar 2023 22:18:15 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=JXUKNNLmBsq54GfddFYndLp3E16igNJM7pRxeUX5NKM=;
        t=1678043895;x=1678133895; 
        b=x/7HwlzwHz2Yja+hAdGAUqSHa9JNmbekW2XJwNHeuMTOHgoW8QDABE4dVwEaNwthRZ5ozQVAG/RkuPedIS10m3FjIljx3uKuzCehUHOEhM6M4yOG4ZyCXRuo+jLT+GDqBDUdImcV/fCeQi5nxj+V1U/FS4ypL1GeNgv4LErQiA8=;
Received: by smtp36.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pYtrr-00BIaX-NE; Sun, 05 Mar 2023 22:18:00 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] soc: qcom: socinfo: Add SM7150 ID
Date:   Sun,  5 Mar 2023 22:17:43 +0300
Message-Id: <20230305191745.386862-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD94A31EA4B0797EF2E72E18A16E4E3515776BF7CE6DCB565EC182A05F5380850404C228DA9ACA6FE27DA130036C345C63E96B9F48CC4A91B16D07926F003880CDC43B34C97440BA967
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7F9D3BE5B596754B8C2099A533E45F2D0395957E7521B51C2CFCAF695D4D8E9FCEA1F7E6F0F101C6778DA827A17800CE776377A057133B646EA1F7E6F0F101C6723150C8DA25C47586E58E00D9D99D84E1BDDB23E98D2D38B6F1F7B995052D5CE6E673C34233548CCC9490C833C9133B8CC7F00164DA146DAFE8445B8C89999728AA50765F790063713EF0ED8E3D6D567389733CBF5DBD5E9C8A9BA7A39EFB766F5D81C698A659EA7CC7F00164DA146DA9985D098DBDEAEC825D43C09D2508269F6B57BC7E6449061A352F6E88A58FB86F5D81C698A659EA73AA81AA40904B5D9A18204E546F3947C5149A672E96B27E16E0066C2D8992A164AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C385B422238E2AB019BA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C33FF75B2DE3BAA3BF35872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A54D161220BB9CD0981CA33C1A2CC8196B5137E474609137474EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34EB7BD66E9101C10022E33F17542963FA652E09EF773A66F1E587AB8A052465A7226E5AE63ADD61401D7E09C32AA3244CD4F02D2F04A6697BB847B95071B6A598F522A1CF68F4BE0527AC49D2B05FCCD8
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXig/qfUV51Dw1Mz47jZbx9t
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981B5751B9D9276E50CD91A99C3FD8EB8C729A3A547BC1C8C5A643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 78E4E2B564C1792B
X-77F55803: 6242723A09DB00B4BD2EB812D5A6E5F7D3C1BE093F4DBF3EB2D947066E19A99D049FFFDB7839CE9E62BCD1450C26EE0FAAC33FAE8A5118D40BD7C34919AE3715F698AC2DB47DF1CC
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5xhPKz0ZEsZ5k6NOOPWz5QAiZSCXKGQRq3/7KxbCLSB2ESzQkaOXqCBFZPLWFrEGlV1shfWe2EVcxl5toh0c/aCGOghz/frdRhzMe95NxDFdAc2jUOxWGfx0eZi3wsM+OA==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds ID for Qualcomm SM7150 SoC.

David Wronek (2):
  dt-bindings: arm: qcom,ids: Add Soc ID for SM7150
  soc: qcom: socinfo: Add Soc ID for SM7150

 drivers/soc/qcom/socinfo.c         | 1 +
 include/dt-bindings/arm/qcom,ids.h | 1 +
 2 files changed, 2 insertions(+)

-- 
2.39.2

