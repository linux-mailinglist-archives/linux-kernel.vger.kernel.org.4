Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9830C73157A
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:35:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245065AbjFOKfd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:35:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343805AbjFOKfC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:35:02 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B1A2D57;
        Thu, 15 Jun 2023 03:34:51 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FAYjeo126737;
        Thu, 15 Jun 2023 05:34:45 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686825285;
        bh=wh0QqwRSPw29Uvn4QmDhToM9IHpmqbwMJmSZ/t9TW8Y=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=kcQoxDgi8XgMhoUgTcr9kZK2ME/i3TJm/k4GbuHkTqTmfwaOGuj6uVzJVWlD6aEdo
         t9hX8Kf5wvY8w8mxOlO2FtXyyXQ9H0NLCtmqOHTpHDan7XvKYjxs7hfIPA1qmsi06g
         La/+EOHYMtI62yrGCGexQPIR2N9GMD04wU15vvTE=
Received: from DLEE100.ent.ti.com (dlee100.ent.ti.com [157.170.170.30])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FAYjOQ085547
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 05:34:45 -0500
Received: from DLEE102.ent.ti.com (157.170.170.32) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 05:34:45 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE102.ent.ti.com
 (157.170.170.32) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 05:34:45 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FAYgBP117046;
        Thu, 15 Jun 2023 05:34:43 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Bhavya Kapoor <b-kapoor@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <robh+dt@kernel.org>,
        <kristo@kernel.org>, <nm@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4-main: Enable support for high speed modes
Date:   Thu, 15 Jun 2023 16:04:40 +0530
Message-ID: <168681785699.2096385.9821957808447105813.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230502090814.144791-1-b-kapoor@ti.com>
References: <20230502090814.144791-1-b-kapoor@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 02 May 2023 14:38:14 +0530, Bhavya Kapoor wrote:
> eMMC tuning was incomplete earlier, so support for high speed modes was
> kept disabled. Remove no-1-8-v property to enable support for high
> speed modes for eMMC in J784S4 SoC.
> 
> 

Applied, thanks!

[1/1] arm64: dts: ti: k3-j784s4-main: Enable support for high speed modes
      commit: 0bc425484e9c5fffc2b94e4a9a474401f2210d5f

Best regards,
-- 
Vignesh

