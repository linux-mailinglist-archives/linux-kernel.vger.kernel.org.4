Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65DF6DD8A2
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:01:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229966AbjDKLBn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:01:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDKLB0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:01:26 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 859E840E2
        for <linux-kernel@vger.kernel.org>; Tue, 11 Apr 2023 04:01:11 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 33BB0ZZx122831;
        Tue, 11 Apr 2023 06:00:35 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1681210835;
        bh=W3NzIE8sGMgn9PRlZqqS9sCXJDaliKur8CYiCbVbIfY=;
        h=From:To:CC:Subject:Date;
        b=XQoWb6iQj1G/HMjckgRUgGsMjGljEoNCpGBd+qEoD9+dWEU0zIBc280IhDXcqJR6Z
         g/EiNL5kRq6GNiaqL08Ufxbe7+gYhCXUoLTeKzYMDqYtDT9G/bwKT482x6A9jn/ARN
         oRm4cJclu/5uobeKbtTQmNcirtprTWOT5jIhfeoE=
Received: from DLEE104.ent.ti.com (dlee104.ent.ti.com [157.170.170.34])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 33BB0ZNg029151
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 11 Apr 2023 06:00:35 -0500
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 11
 Apr 2023 06:00:35 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 11 Apr 2023 06:00:35 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 33BB0Yeq031524;
        Tue, 11 Apr 2023 06:00:35 -0500
From:   Bhavya Kapoor <b-kapoor@ti.com>
To:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <b-kapoor@ti.com>, <catalin.marinas@arm.com>, <will@kernel.org>,
        <quic_bjorande@quicinc.com>, <arnd@arndb.de>,
        <krzysztof.kozlowski@linaro.org>, <geert+renesas@glider.be>,
        <nfraprado@collabora.com>, <broonie@kernel.org>, <rafal@milecki.pl>
Subject: [PATCH 0/2] arm64: defconfig: Enable TI TSCADC and ADC drivers
Date:   Tue, 11 Apr 2023 16:30:32 +0530
Message-ID: <20230411110034.351950-1-b-kapoor@ti.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enable TSCADC driver to be built as a module which will add support
for TI's TSC/ADC MFDevice. Enable ADC driver to be built as module
to add support for ADC in TI K3 specific SoCs.

Bhavya Kapoor (2):
  arm64: defconfig: Enable TI TSCADC driver
  arm64: defconfig: Enable TI ADC driver

 arch/arm64/configs/defconfig | 2 ++
 1 file changed, 2 insertions(+)

-- 
2.34.1

