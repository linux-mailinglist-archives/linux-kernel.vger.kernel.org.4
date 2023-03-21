Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51F716C3221
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 13:59:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229911AbjCUM7k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 08:59:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjCUM7i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 08:59:38 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C026646B9;
        Tue, 21 Mar 2023 05:59:36 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32LCxPu7124173;
        Tue, 21 Mar 2023 07:59:25 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679403565;
        bh=HmNO1EvDbS3Z0FvWRgk/ZP+c0DvWRB/BSf5vOIxflVc=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=DT99aL3Am1a/Bx7aO8mdurXCdyUf9Qr4NHPT9Dznz7l8SnK8O2NdFd203GeUWZ4/Z
         Cv75kFUGHZzVsyv3gtGQl/tikGd6cwhmbn/rctmvgzON2Tukzzut3TDrGTYXIPsNJo
         mio7bkEVG7AnPIblXvVQ2IShrxbd0Nu5Sg02rCso=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32LCxPg3012435
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 21 Mar 2023 07:59:25 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Tue, 21
 Mar 2023 07:59:24 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Tue, 21 Mar 2023 07:59:24 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32LCxO5P050755;
        Tue, 21 Mar 2023 07:59:24 -0500
Date:   Tue, 21 Mar 2023 07:59:24 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Dhruva Gole <d-gole@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>, <bb@ti.com>
Subject: Re: [PATCH V3 1/2] arm64: dts: ti: k3-am62-wakeup: Introduce RTC node
Message-ID: <20230321125924.23ythtji67y66hsi@satisfied>
References: <20230320165123.80561-1-nm@ti.com>
 <20230320165123.80561-2-nm@ti.com>
 <4a1f33bb-882a-ed49-9e0e-b463203e0ea9@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <4a1f33bb-882a-ed49-9e0e-b463203e0ea9@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:07-20230321, Dhruva Gole wrote:
[...]

> 
> I was just wondering why some of the rtctests show failures on this platform:
> 
> https://gist.github.com/DhruvaG2000/5c6d8bb99b087308b916985d70f0c440
> 
> pass:5 fail:2
> 
> the test is compiled from tools/testing/selftests/rtc/rtctest.c for arm64 target
> 
> Is this expected?

I used the standard defconfig and [1] on beagleplay and
cross verified on 6.3-rc3 as well. It works fine. See logs below.

NOTE: BeaglePlay has a external 32k crystal that drives RTC and other
32k clock sources internal to the SoC. This helps maintain accurate
time. If your platform does'nt have an external 32k crystal OR AM62
does'nt enable 32k using MCU_CTRL_LFXOSC_CTRL[2], then default 32k RC
osc inside the SoC triggers. This internal clock is very variable.
There are a ton of stuff inside the SoC that depends on 32k, so this
wont be just a RTC specific behavior.

ti-next: (6.3-rc1)
ti-next + 6.3-rc3: (dirty is because of a rtctest Makefile mod to build
static)
https://gist.github.com/nmenon/e1b300652ac452ad55fa4cf936fc3e63


[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git/log/
[2] https://git.beagleboard.org/beagleplay/u-boot/-/blob/lc-ti-u-boot-2021.01/board/ti/am62x/evm.c#L243
-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
