Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A6BC737AA3
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 07:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbjFUFhF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 01:37:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229638AbjFUFhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 01:37:03 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EDC9C0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 22:37:02 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35L5aSqB117307;
        Wed, 21 Jun 2023 00:36:28 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1687325788;
        bh=7H3Q52djUMasdHpplPrEgIGfckmscmK3xJbDB9XEeqA=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=E7JEFBQl2k9c9IbUnhAh0iTJse1ZLeBPJh2YnQn9WwAVVPSL5Dh3Dk2r8mSBzZiAB
         vDa2RVlt4N2Jzws1xs4DC7pG7sX6hS4ZTT6/hVU43pqjbcNSz4nypw3q6bLx88Vna0
         TQr8Gm299w744AX+z0nHCIrtPWU2i/i+wM+Vfxbk=
Received: from DLEE108.ent.ti.com (dlee108.ent.ti.com [157.170.170.38])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35L5aSRr022630
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 21 Jun 2023 00:36:28 -0500
Received: from DLEE109.ent.ti.com (157.170.170.41) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Wed, 21
 Jun 2023 00:36:28 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE109.ent.ti.com
 (157.170.170.41) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Wed, 21 Jun 2023 00:36:28 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35L5aSxl122025;
        Wed, 21 Jun 2023 00:36:28 -0500
Date:   Wed, 21 Jun 2023 00:36:28 -0500
From:   Nishanth Menon <nm@ti.com>
To:     "Kumar, Udit" <u-kumar1@ti.com>
CC:     <catalin.marinas@arm.com>, <will@kernel.org>, <vigneshr@ti.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <quic_bjorande@quicinc.com>,
        <arnd@arndb.de>, <krzysztof.kozlowski@linaro.org>,
        <konrad.dybcio@linaro.org>, <geert+renesas@glider.be>,
        <neil.armstrong@linaro.org>, <nfraprado@collabora.com>,
        <broonie@kernel.org>, <rafal@milecki.pl>
Subject: Re: [PATCH] arm64: defconfig: Enable K3 RTI Watchdog
Message-ID: <20230621053628.ql74hawl6ibv67pf@haunt>
References: <20230621051358.3905149-1-u-kumar1@ti.com>
 <20230621051544.mvxz5hjxhi37eakw@precinct>
 <498ccb75-03f0-9a8b-3626-11da47908ee0@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <498ccb75-03f0-9a8b-3626-11da47908ee0@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10:59-20230621, Kumar, Udit wrote:
[..]
> For ease of use, i used as part of kernel.
> 
> No issues having as module

Please keep it as a module as a rule, we don't want to blow up the kernel
Image size unless we have a very very strong need to have it in kernel
(example: for boot)

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
