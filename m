Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C54750AAC
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 16:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232252AbjGLOSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 10:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231773AbjGLOSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 10:18:41 -0400
Received: from lelv0143.ext.ti.com (lelv0143.ext.ti.com [198.47.23.248])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5104810C2;
        Wed, 12 Jul 2023 07:18:39 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 36CEISXg027458;
        Wed, 12 Jul 2023 09:18:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1689171508;
        bh=Q2qC031RY1YwzS5Cvq9Q8bcfDhZxdfNO7PiWoI1D2AU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=YrKAFrXEOpfRBZrc7MLa0IbE9BYhs/x8CconZK6ucp8anrkt8sSp1uo8TElOomCKP
         AtdER/fCA46dQvKXcj9KTzAFheffGsCtpBStHrz4t3E4y3I1RbVj+mr+v2a9sWZZ4y
         /HFoNp0/vif6ai/VOC1MwIVUuYP1udXprAKAu/lE=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 36CEIS2w020366
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 12 Jul 2023 09:18:28 -0500
Received: from DLEE110.ent.ti.com (157.170.170.21) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 12
 Jul 2023 09:18:28 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 12 Jul 2023 09:18:28 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 36CEISLa079341;
        Wed, 12 Jul 2023 09:18:28 -0500
Date:   Wed, 12 Jul 2023 09:18:28 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Jayesh Choudhary <j-choudhary@ti.com>
CC:     <vigneshr@ti.com>, <krzysztof.kozlowski+dt@linaro.org>,
        <afd@ti.com>, <s-vadapalli@ti.com>, <kristo@kernel.org>,
        <robh+dt@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v5 3/5] arm64: dts: ti: k3-j784s4: Add WIZ and SERDES PHY
 nodes
Message-ID: <20230712141828.lnpo4mhd5dv34rlz@census>
References: <20230710101705.154119-1-j-choudhary@ti.com>
 <20230710101705.154119-4-j-choudhary@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230710101705.154119-4-j-choudhary@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:47-20230710, Jayesh Choudhary wrote:
> From: Siddharth Vadapalli <s-vadapalli@ti.com>
> 
> J784S4 SoC has 4 Serdes instances along with their respective WIZ
> instances. Add device-tree nodes for them and disable them by default.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> [j-choudhary@ti.com: fix serdes_wiz clock order]
> Signed-off-by: Jayesh Choudhary <j-choudhary@ti.com>
> ---
NAK. This patch introduces the following dtbs_check warning.
arch/arm64/boot/dts/ti/k3-am69-sk.dtb: serdes-refclk: 'clock-frequency' is a required property

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
