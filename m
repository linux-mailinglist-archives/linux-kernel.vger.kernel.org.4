Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F7DD659AB9
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:55:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235191AbiL3Qza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:55:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235124AbiL3Qz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:55:27 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47DA312742;
        Fri, 30 Dec 2022 08:55:26 -0800 (PST)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2BUGtCup043522;
        Fri, 30 Dec 2022 10:55:12 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1672419312;
        bh=d30Wym9qx6BNk0JFWtaJxSIVPqMT14wAaa/TcS4I8wY=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=kCg6CxOp+8JjMg31ZywwYJEYoOuyaZ1qCMqqcvwbGP3lmg71EuQ9/X+FiI5PXnRVV
         Ik5Aj46uAsLp0x+RB9p5dzjGwLwcVA7CuGihDglqAioXX8aD0UZy3pqFltfSHAjqpZ
         k499sXijJoEEvlYC7IYElg3zuQpzJrUTuCECUi5I=
Received: from DLEE101.ent.ti.com (dlee101.ent.ti.com [157.170.170.31])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2BUGtCpG084689
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 30 Dec 2022 10:55:12 -0600
Received: from DLEE114.ent.ti.com (157.170.170.25) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Fri, 30
 Dec 2022 10:55:11 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE114.ent.ti.com
 (157.170.170.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Fri, 30 Dec 2022 10:55:11 -0600
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2BUGtBbQ004873;
        Fri, 30 Dec 2022 10:55:11 -0600
Date:   Fri, 30 Dec 2022 10:55:11 -0600
From:   Bryan Brattlof <bb@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, <nm@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Fix clocks for McSPI
Message-ID: <20221230165511.7spk6cedrtm6nkv2@bryanbrattlof.com>
References: <20221227051208.158894-1-d-gole@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20221227051208.158894-1-d-gole@ti.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
User-Agent: NeoMutt/20171215
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On December 27, 2022 thus sayeth Dhruva Gole:
> Fixes the clock Device ID's in the DT according to the tisci docs clock
> identifiers for AM62x
> 
> Signed-off-by: Dhruva Gole <d-gole@ti.com>
> ---

Good catch!

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
