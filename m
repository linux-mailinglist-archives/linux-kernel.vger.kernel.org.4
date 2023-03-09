Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF5136B2D26
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 19:51:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbjCISvG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 13:51:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229786AbjCISu7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 13:50:59 -0500
Received: from smtp61.i.mail.ru (smtp61.i.mail.ru [95.163.41.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D9E1FA0BB;
        Thu,  9 Mar 2023 10:50:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=GKTMVCNBdd5IAB3eOey0p1z8QiO1cQ4NlwUIAuNGZuA=;
        t=1678387856;x=1678477856; 
        b=ESAy5bQ4Bs0oUhaAAa/Ag3lUZM3ya7pg+he54rmC0ynzQSZZi2wLkkmYBABpTlZMTaKH5DYeTDTwhDxHGf+DSGdFYkMNQtHKCIG0Ha9vI3pmDF/75N2UIzYm07L6/DBdqyAenpMNlB+4zVp6EVdj9YikB/ArzTT9lws1MxveT8o=;
Received: by smtp61.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1paLLo-002rxt-GN; Thu, 09 Mar 2023 21:50:53 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        vkoul@kernel.org, kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        davidwronek@gmail.com, Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] phy: qcom-qmp-ufs: Add support for SM7150 
Date:   Thu,  9 Mar 2023 21:50:47 +0300
Message-Id: <20230309185049.170878-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp61.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9BCEC41593EBD83572AB17126CD52FE0BB53BB47C1B744DA8182A05F53808504035FABC9C2A2626CB284211DF2D02DB7BC1117CA9BB7C9E492ABAB0560DC1A2F2
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7A352E4F59960F77CEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006375E7A1B5661595F038638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D88E48F7AFCB5EE0F00D35250F579E40E6117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC93A51A5089774A2DA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F44604297287769387670735209647ADFADE5905B1C26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EEC24E1E72F37C03A07C6FCE95544A9834D8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE31DAA61796BF5227B6E0066C2D8992A16C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947CB11811A4A51E3B096D1867E19FE1407959CC434672EE6371089D37D7C0E48F6C8AA50765F790063762EFFBA1C158ADAAEFF80C71ABB335746BA297DBC24807EABDAD6C7F3747799A
X-C1DE0DAB: 0D63561A33F958A56C46B9145716F36637044E56BF2E133ECE22BA5B70441A324EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34AAC3D1FDB34D048868A218EC13F860D5BAADFDCC7D05DF0A85028E200F6734C95E007A2D6CCC48EB1D7E09C32AA3244C4B513982D2F1450D506A4D87034495EB69B6CAE0477E908D98DBA7662A2C9987
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojrI5GYPq6VsdMih5EX9dWLw==
X-DA7885C5: 9575E6C952D9754352948C0EBEBEC2F37194B06575433BB35B94381910900C97D8288D6B1992AB67EF2421ABFA55128D02E9C42E3A59EA20
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949812E89BE89565EF847A8D7812CB63BA61E6E88B0DBEEC58FB0643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds UFS QMP support for Qualcomm SM7150 SoC.

David Wronek (2):
  dt-bindings: phy: Add QMP UFS PHY comptible for SM7150
  phy: qcom-qmp-ufs: Add SM7150 support

 .../phy/qcom,msm8996-qmp-ufs-phy.yaml         |  3 +
 drivers/phy/qualcomm/phy-qcom-qmp-ufs.c       | 57 +++++++++++++++++++
 2 files changed, 60 insertions(+)

-- 
2.39.2

