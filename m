Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1060066312D
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 21:15:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235365AbjAIUPY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 15:15:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbjAIUO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 15:14:59 -0500
X-Greylist: delayed 286 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 09 Jan 2023 12:14:56 PST
Received: from fallback22.mail.ru (fallback22.m.smailru.net [94.100.176.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 395C3271B0;
        Mon,  9 Jan 2023 12:14:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=34xT9OK2MFa6LoDN4xJc2CtfG8oZzw4ktjT9EW7ddoE=;
        t=1673295296;x=1673385296; 
        b=BB46XmE/2tPAu2ALA9cY6VtRmxbsYukrjFuMPfKIZV40AmjuuVBIUdN3IZtwe8dj0w1EMOtpkYx8DSFXBH1/lAOBFMClPUQVhtIK3B9q7uc80QQQyxfUjhRtT7x7PIL3JljvsW8E6Ev9D5oF4zj/8FZyNFo84pyWl52d1C8Jq1A=;
Received: from [10.161.64.59] (port=47008 helo=smtp51.i.mail.ru)
        by fallback22.m.smailru.net with esmtp (envelope-from <danila@jiaxyga.com>)
        id 1pExrI-0002Gi-M6; Mon, 09 Jan 2023 22:31:01 +0300
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=jiaxyga.com; s=mailru;
        h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:Cc:To:From:From:Subject:Content-Type:Content-Transfer-Encoding:To:Cc; bh=34xT9OK2MFa6LoDN4xJc2CtfG8oZzw4ktjT9EW7ddoE=;
        t=1673292660;x=1673382660; 
        b=bqG3SLtZzOlUMrAlZZoSWUFIy7PemaDf7v12AAjW9jCIa5DxY/7FiQTb3lDN/blj7xMoMz5/wKGhsNJtTmeto+b8vRQVIuEdjU6IPuU1hUSJMQrsyc3KBNokaQTssmUIukej2vCj8k90c7iz1/oEgTGY0z9kr3Lsbr2FdFdhyOQ=;
Received: by smtp51.i.mail.ru with esmtpa (envelope-from <danila@jiaxyga.com>)
        id 1pExr1-0001ej-FE; Mon, 09 Jan 2023 22:30:44 +0300
From:   Danila Tikhonov <danila@jiaxyga.com>
To:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Danila Tikhonov <danila@jiaxyga.com>
Subject: [PATCH 0/2] clk: qcom: Add GCC support for SM7150
Date:   Mon,  9 Jan 2023 22:30:28 +0300
Message-Id: <20230109193030.42764-1-danila@jiaxyga.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailru-Src: smtp
X-7564579A: 78E4E2B564C1792B
X-77F55803: 4F1203BC0FB41BD90D1502B3BE350FE4736FC4076420874E19255304332EEB6200894C459B0CD1B9B73717BA739F188B9E5DAA0C5407038C54974B6CF8F786DE4044E5D25B716309
X-7FA49CB5: FF5795518A3D127A4AD6D5ED66289B5278DA827A17800CE7B9EA053ECF1425EFEA1F7E6F0F101C67BD4B6F7A4D31EC0BCC500DACC3FED6E28638F802B75D45FF8AA50765F7900637560334CFC131571A8638F802B75D45FF36EB9D2243A4F8B5A6FCA7DBDB1FC311F39EFFDF887939037866D6147AF826D870C256E551D2966D3C720265434B0385117882F4460429724CE54428C33FAD305F5C1EE8F4F765FCE96A3A8AAADC8934A471835C12D1D9774AD6D5ED66289B52BA9C0B312567BB23117882F4460429728776938767073520599709FD55CB46A6F04B652EEC242312D2E47CDBA5A96583BA9C0B312567BB2376E601842F6C81A19E625A9149C048EE38D4DC57D478E688AD7EC71F1DB884274AD6D5ED66289B52698AB9A7B718F8C46E0066C2D8992A16725E5C173C3A84C3378368E892C6C3AABA3038C0950A5D36B5C8C57E37DE458B330BD67F2E7D9AF16D1867E19FE14079C09775C1D3CA48CF17B107DEF921CE791DD303D21008E298D5E8D9A59859A8B6B372FE9A2E580EFC725E5C173C3A84C3CD42BCEBB57B85E635872C767BF85DA2F004C90652538430E4A6367B16DE6309
X-C1DE0DAB: 0D63561A33F958A526810B2649DEFB7FFB4F5DD83CD21BBF98AA64CE66AD7F044EAF44D9B582CE87C8A4C02DF684249CC203C45FEA855C8F
X-C8649E89: 4E36BF7865823D7055A7F0CF078B5EC49A30900B95165D3430FC2BC1B917F018FFB7531AB398E56F0573F5C6364459201A0E7063B422845D59F1EF98F93912A31D7E09C32AA3244C1474CB7EEDCB4DEB293AB17C442285B9F522A1CF68F4BE05111969D93F5DC462
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojqOyU7017cIuJqF33OH+iSw==
X-Mailru-Sender: 9EB879F2C80682A09F26F806C7394981E397D480C3580E4E63ADECB528D28A1D9F315BB77F09BCAE643683D8C0F3ED1CA3C71A376745D86BBE86167304C7680C3980CE5AAA35C7CD60F22E8815EDE5EAEAB4BC95F72C04283CDA0F3B3F5B9367
X-Mras: Ok
X-7564579A: 646B95376F6C166E
X-77F55803: 6242723A09DB00B41CF11DA7185A12D60956B8559AC36011BEC7098C9D373FFD68F3CF0E9FE49B69FEFBE5D651DB9B98106EEA8ABA2B67EF6377D470B09FF54E7743418DB97B0D59
X-7FA49CB5: 0D63561A33F958A51212E5DFA8B47D9C0F37CC369A3FE979206BA5383A7D80BB8941B15DA834481FA18204E546F3947CC11B1E8D35EB7500F6B57BC7E64490618DEB871D839B7333395957E7521B51C2DFABB839C843B9C08941B15DA834481F8AA50765F7900637A38BAC9F596BD8CD389733CBF5DBD5E9B5C8C57E37DE458BD9DD9810294C998ED8FC6C240DEA76428AA50765F7900637EFF5ECB7E57EE405D81D268191BDAD3DBD4B6F7A4D31EC0BEA7A3FFF5B025636AAAE862A0553A39223F8577A6DFFEA7C3FD97E4CBBB7207543847C11F186F3C59DAA53EE0834AAEE
X-D57D3AED: 3ZO7eAau8CL7WIMRKs4sN3D3tLDjz0dLbV79QFUyzQ2Ujvy7cMT6pYYqY16iZVKkSc3dCLJ7zSJH7+u4VD18S7Vl4ZUrpaVfd2+vE6kuoey4m4VkSEu530nj6fImhcD4MUrOEAnl0W826KZ9Q+tr5ycPtXkTV4k65bRjmOUUP8cvGozZ33TWg5HZplvhhXbhDGzqmQDTd6OAevLeAnq3Ra9uf7zvY2zzsIhlcp/Y7m53TZgf2aB4JOg4gkr2biojqOyU7017cIv7E4RpKbqZuA==
X-Mras: PROBABLE_SPAM
X-SRW:  226918D22793EE576E46E5F72D0E341D326D40C5A663423D8E49331F722C2768
X-Spam-Status: No, score=-0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FROM_FMBLA_NEWDOM,
        RCVD_IN_BL_SPAMCOP_NET,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the Global Clock Controller for SM7150.

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
  dt-bindings: clock: Add SM7150 GCC clock binding
  clk: qcom: Add Global Clock Controller (GCC) driver for SM7150

 .../bindings/clock/qcom,sm7150-gcc.yaml       |   50 +
 drivers/clk/qcom/Kconfig                      |    8 +
 drivers/clk/qcom/Makefile                     |    1 +
 drivers/clk/qcom/gcc-sm7150.c                 | 3159 +++++++++++++++++
 include/dt-bindings/clock/qcom,sm7150-gcc.h   |  193 +
 5 files changed, 3411 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm7150-gcc.yaml
 create mode 100644 drivers/clk/qcom/gcc-sm7150.c
 create mode 100644 include/dt-bindings/clock/qcom,sm7150-gcc.h

-- 
2.39.0

