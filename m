Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6BC096B60FD
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 22:21:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229737AbjCKVV2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 16:21:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjCKVVX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 16:21:23 -0500
Received: from smtp17.i.mail.ru (smtp17.i.mail.ru [95.163.41.70])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B347D7430B;
        Sat, 11 Mar 2023 13:21:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=RH2ZrndtpAYlZt0XycEmkXYRfNT/qKRc9JqVYCSJTUQ=;
        t=1678569681;x=1678659681; 
        b=MkFp4iGUUSHk+pMT2w47Ik5qNzo5pfkw8ERHOJXnu1ucjZtSbwfzMH7Tgqzp1vNztsh/1Y/40TIdAMAxFq7gnJJJe2aFkBusrX0Zs1JZb062xpiEwbtaoVbhsp3hMFYkoQoi/aShEeIEMEJeIXrhmLhp6iQoetfkUyj/2gHr+i4=;
Received: by smtp17.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pb6eT-001tiu-AL; Sun, 12 Mar 2023 00:21:17 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        linus.walleij@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        danila@jiaxyga.com
Subject: [PATCH 0/2] pinctrl: qcom: Add support for SM7150
Date:   Sun, 12 Mar 2023 00:21:12 +0300
Message-Id: <20230311212114.108870-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Authentication-Results: smtp17.i.mail.ru; auth=pass smtp.auth=danila@jiaxyga.com smtp.mailfrom=danila@jiaxyga.com
X-Mailru-Src: smtp
X-7564579A: EEAE043A70213CC8
X-77F55803: 4F1203BC0FB41BD9CCC71FA9F690445032EB9CAF2580409F12317AC7DC600120182A05F5380850404C228DA9ACA6FE27BC11337B7CFB0E93850810F903E8D49F580641BA815A1E00DF4C30378CE86032
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7466896EF24E80F12EA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F79006371E8C7BD479B346ED8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D8B9D9450D9BD1B3FCD644E96FA14E544B117882F4460429724CE54428C33FAD305F5C1EE8F4F765FC3EAA04613575FAEBA471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520C65AC60A1F0286FEC26CFBAC0749D213D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE7B96B19DC40933219735652A29929C6C4AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3887A4342A344B6ED76E601842F6C81A1F004C906525384303E02D724532EE2C3F43C7A68FF6260569E8FC8737B5C2249D082881546D93491E827F84554CEF50127C277FBC8AE2E8BA83251EDC214901ED5E8D9A59859A8B6DEFAA5D9F874865875ECD9A6C639B01B4E70A05D1297E1BBCB5012B2E24CD356
X-C1DE0DAB: 0D63561A33F958A536676E4ADB2DEC315B2740467A99574386A7892DA55F802A4EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D34EA882B598A209811FA4C9C23909F5F7FDB385C2DCEB02F60EB897EAD937FC36747A44B40590DECAA1D7E09C32AA3244CFBE7331D465B2B90EECC38A1E5201E3F24AF4FAF06DA24FDC2E5D8217768D59A
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojEg2t1XEOuWENpWA3g2QmiQ==
X-DA7885C5: 2A16630153B13E2C60EF68CCB0BD4FE8EE63864363672CCC0B08A3B4C955722CD8288D6B1992AB67EF2421ABFA55128D02E9C42E3A59EA20
X-Mailru-Sender: 9EB879F2C80682A09F26F806C739498116D2F3E63D051AB54E80588AE51AC0CA8E1A1FDBE0F94EC1643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds pinctrl support for Qualcomm SM7150 SoC.

To: Andy Gross <agross@kernel.org>
To: Bjorn Andersson <andersson@kernel.org>
To: Konrad Dybcio <konrad.dybcio@linaro.org>
To: Linus Walleij <linus.walleij@linaro.org>
To: Rob Herring <robh+dt@kernel.org>
To: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc: linux-arm-msm@vger.kernel.org
Cc: linux-gpio@vger.kernel.org
Cc: devicetree@vger.kernel.org
Cc: linux-kernel@vger.kernel.org

Danila Tikhonov (2):
  dt-bindings: pinctrl: qcom: Add SM7150 pinctrl binding
  pinctrl: qcom: Add SM7150 pinctrl driver

 .../bindings/pinctrl/qcom,sm7150-tlmm.yaml    |  162 +++
 drivers/pinctrl/qcom/Kconfig                  |   10 +
 drivers/pinctrl/qcom/Makefile                 |    1 +
 drivers/pinctrl/qcom/pinctrl-sm7150.c         | 1280 +++++++++++++++++
 4 files changed, 1453 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,sm7150-tlmm.yaml
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm7150.c

-- 
2.39.2

