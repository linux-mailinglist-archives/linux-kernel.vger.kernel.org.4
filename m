Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4B9D677261
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 21:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229971AbjAVUbb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 15:31:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229973AbjAVUba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 15:31:30 -0500
X-Greylist: delayed 3702 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sun, 22 Jan 2023 12:31:28 PST
Received: from fallback25.mail.ru (fallback25.m.smailru.net [94.100.189.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E0EA193C1;
        Sun, 22 Jan 2023 12:31:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=DcSKLk0gVwmz8BpeZbtff0Bkzgj/pJdpCU0MZvQBdl4=;
        t=1674419488;x=1674509488; 
        b=oRmVdo/bOPllX79MMMBI+HvlmTdOLscHh1ZsSfrAOu5F4yvjoEW3HzQ5bfoCGEe8A5kN6tiFzYRQsOhi2kWtOvrlzd/rHi/bdQkK1LAkunDQMBZrOg+CczjEBeGArMOv6fySliLJ6UrTZIn+SMST+6s/c6gZk/lnSw6lnFM/LIg=;
Received: from [10.161.64.60] (port=51314 helo=smtp52.i.mail.ru)
        by fallback25.m.smailru.net with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1pJg2C-0006N8-CT; Sun, 22 Jan 2023 22:29:44 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=DcSKLk0gVwmz8BpeZbtff0Bkzgj/pJdpCU0MZvQBdl4=;
        t=1674415784;x=1674505784; 
        b=f7iaV3tKVj/tSTGICUAoVI2FBH0TlnlSI37WfE+nRHYpPYilyrVQaDqUiLr+F/Nt9s0aVsoGs9FIbaBqZSOZDg0RQlCZivfrlUOwoKU08NbBHWPa9EZzN2mqstZ0uljndP2lfZAw1iDnAAAvJXJbEUGLxAHk2+ecc1td3oGM5xk=;
Received: by smtp52.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pJg1v-00025a-OH; Sun, 22 Jan 2023 22:29:28 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH v2 0/2] clk: qcom: Add GCC support for SM7150
Date:   Sun, 22 Jan 2023 22:29:22 +0300
Message-Id: <20230122192924.119636-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 646B95376F6C166E
X-77F55803: 4F1203BC0FB41BD9A6D6F5724DD3A0B60E915A56FB921C50CC0C40CAEDEC64A7182A05F538085040AE260C501E6C41ABC05D42AFD4F8E0B841100C04E85CEABF43574F03DDDFDF4B
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE76D24A1449B9F25A2EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F790063726CA83C7ABDB938E8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8A043E42EC604D0F15CA2112500DF1CF0117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCF80095D1E17F4578A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520902A1BE408319B292CC0D3CB04F14752D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE7B96B19DC40933214782AAF36435267CD8FC6C240DEA7642DBF02ECDB25306B2B78CF848AE20165D0A6AB1C7CE11FEE37812A6222701F2156136E347CC761E07C4224003CC836476E2F48590F00D11D6E2021AF6380DFAD1A18204E546F3947C1D471462564A2E192E808ACE2090B5E1725E5C173C3A84C3C5EA940A35A165FF2DBA43225CD8A89F0A35B161A8BF67C15E1C53F199C2BB95B5C8C57E37DE458BEDA766A37F9254B7
X-C1DE0DAB: 0D63561A33F958A5EE318B4E067BA4A4B7DF90B92EEAFD569522EBF41C03BE0D4EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D348BE83DFD8AFB1CAC224345CA66BF9CB722EA0747038FF67A519469981EAFC237D40D5D519B98CFF81D7E09C32AA3244C4C1BFBBC5EAC02664D90DFD8CB244B233A92A9747B6CC886111969D93F5DC462
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojbL9S8ysBdXhi6CxFFqkWTUfe7eZU/ykR
X-Mailru-Sender: 9EB879F2C80682A09F26F806C73949815D389F18FFC5AFA2EA50F6B0B1BB825CDBA86B69F688CB0D643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B4FA133F958ACA88638D06B3AF3B1F633A526ED3C2A381FBF9049FFFDB7839CE9EAB1F03AB1C4AFD783499CBF4A5A43ED9935D66D762FB1E7E5B6EFA599FAD3AA3
X-7FA49CB5: 0D63561A33F958A573DF67D9FBD3C03A6613EFFFCA81E7CAD9CEEF188099397E8941B15DA834481FA18204E546F3947C68B9A68E260AC75CF6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637DFC0370CCA7FDEF5389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F790063732583F09E8EA83FCD81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7CAC39357BFF8B7FB443847C11F186F3C59DAA53EE0834AAEE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojrYIVAnYNYwCsWKXgCDo5qQ==
X-Mailru-MI: 800
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM28,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Global Clock Controller for SM7150.

Changes in v2:
- Dropped redundant "binding" in subject
- Fixed yamllint and dtschema errors
- Replaced additionalProperties with unevaluatedProperties
- Added Danila and David to maintainers
- Added Konrad Reviewed-by on patch 2
- Link to v1: https://lore.kernel.org/linux-clk/20230109193030.42764-1-danila@jiaxyga.com/

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Michael Turquette <mturquette@baylibre.com>
To: Stephen Boyd <sboyd@kernel.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-clk@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Danila Tikhonov <danila@jiaxyga.com>

Danila Tikhonov (2):
  dt-bindings: clock: Add SM7150 GCC clocks
  clk: qcom: Add Global Clock Controller (GCC) driver for SM7150

 .../bindings/clock/qcom,sm7150-gcc.yaml       |   69 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-sm7150.c                 | 3159 +++++++++++++++++
 include/dt-bindings/clock/qcom,sm7150-gcc.h   |  193 +
 5 files changed, 3430 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm7150.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-gcc.h

--
2.39.1

