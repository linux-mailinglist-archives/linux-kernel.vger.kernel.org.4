Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0654C6AB215
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 21:26:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCEU0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 15:26:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbjCEU0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 15:26:35 -0500
X-Greylist: delayed 4109 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 05 Mar 2023 12:26:33 PST
Received: from smtp63.i.mail.ru (smtp63.i.mail.ru [95.163.41.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D96810AA8;
        Sun,  5 Mar 2023 12:26:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=Q2Dz7klb9fUun5EuXXTQz+k2rdK4tcPV0DNNqNcNIyM=;
        t=1678047993;x=1678137993; 
        b=fYRwM8BD88J+kml5vJJi5Hrp17fGFywSXNtUbc944zWQhrpJKhUUCKYbCnDbGAZiKNbwueqklVJKYzpthTS0PK4wUTP68LxQVCJla3vDSLea76usS3jVi2R9FTSUjADcFSmNlIGIA3YGP/mankGCsPq1IHE3ICNWBtklEuqZpPU=;
Received: by smtp63.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pYuw9-00A5Rd-SJ; Sun, 05 Mar 2023 23:26:30 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        abel.vesa@linaro.org, rishabhb@codeaurora.org,
        saiprakash.ranjan@codeaurora.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] soc: qcom: llcc: Add support for SM7150
Date:   Sun,  5 Mar 2023 23:26:25 +0300
Message-Id: <20230305202627.402386-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp63.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9BCEC41593EBD83572AB17126CD52FE0BB53BB47C1B744DA8182A05F538085040A193DC1D783C78F0C20D9E06EC9FFA623E7D45A2AC67888C381CD2B743DF3F11
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE70D278D70F8433719EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063727C65896DA7AF7D78638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8D36A4EFD6C8BEEF5A1058D8BB0E0CE66117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC20302DFC78685446A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520437C869540D2AB0FF04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEFAD5A440E159F97D0CB8D3112395442FD8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE36D3A1509E11137116E0066C2D8992A16C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C2FFDA4F57982C5F42E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89FAE2BFB9A60527F4F42539A7722CA490CB5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A55AE790616CACB79C607F191F3D2191A00481BBBF8FB2F9A14EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34F1ADD4D8CD3C81CE674013458A7D635E8E19CA6522A027EB53130BF92E8D4C128B85F1869D2973A81D7E09C32AA3244CBFCC5841CE99163D9976FFE49A0F121AB4DF56057A86259F111969D93F5DC462
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojMXwBDQf4j7PCoVM9JeMT+w==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498118617784DBFF2E98692A37846008A533A475549227A3A2E2643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds LLCC support for Qualcomm SM7150 SoC.

Danila Tikhonov (2):
  dt-bindings: arm: msm: Add LLCC for SM7150
  soc: qcom: llcc: Add configuration data for SM7150

 .../devicetree/bindings/arm/msm/qcom,llcc.yaml  |  1 +
 drivers/soc/qcom/llcc-qcom.c                    | 17 +++++++++++++++++
 2 files changed, 18 insertions(+)

-- 
2.39.2

