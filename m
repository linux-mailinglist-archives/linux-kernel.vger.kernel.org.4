Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 544146CF5B5
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 23:55:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjC2VzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 17:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50102 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjC2VzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 17:55:18 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA3797;
        Wed, 29 Mar 2023 14:55:16 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32TLt6au039103;
        Wed, 29 Mar 2023 16:55:06 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1680126906;
        bh=2OoQhKzka37UYBcMeeKflQjgVO0yFL0GNd1Bh9ptI4E=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=IyyHzuoxNlC6chbTeDgpmuxkCLpW3F+whW+NxwBkYo0KMr4Myh84LpcoXg8wO+UIM
         K7FLmxSl2vg2QQA06eLjGD6mLVhTKOEphTwT8EWhDnQs0A+u8hLV0P7zi3y3eODk7u
         NKpEA6vyi+Cc2ybepqohfUkztDgmanc26LceR7/k=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32TLt6gk062820
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 29 Mar 2023 16:55:06 -0500
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Wed, 29
 Mar 2023 16:55:06 -0500
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Wed, 29 Mar 2023 16:55:05 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32TLt5Xk103802;
        Wed, 29 Mar 2023 16:55:05 -0500
Date:   Wed, 29 Mar 2023 16:55:05 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Hari Nagalla <hnagalla@ti.com>
CC:     <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] arm64: dts: ti: k3-j784s4-main: Add MAIN domain R5F
 cluster nodes
Message-ID: <20230329215505.gxeute6pxblbw2hn@habitual>
References: <20230329093627.30719-1-hnagalla@ti.com>
 <20230329093627.30719-2-hnagalla@ti.com>
 <20230329125247.w45k5fjzmcgjdyso@delicate>
 <48c03b5a-6557-9eee-8b85-24d72cfbfcd1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <48c03b5a-6557-9eee-8b85-24d72cfbfcd1@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15:19-20230329, Hari Nagalla wrote:
[...]
> >> +			status = "disabled";
> > Why are these disabled by default?
> Well, the idea is to let the board specific device tree enable needed remote
> core nodes in *-evm/sk.dts and disable by default in SoC device tree files
> by default.

NAK. SoC dtsi nodes are enabled by default, the actual "disable" in a
node only makes sense if that node has some dependency on board specific
physical dts property - such as pinmux etc that characterizes. This is
the discussion we have had and why selective muxes are enabled. CPU
cores make no sense to disable by default - you could have a case where
they may be efused out on a sub device variant, in which case, you are
perfectly valid to disable that node in the board dts OR if the sub
device variant is used on multiple boards, introduce a sub board variant
and disable it in the dtsi.


-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
