Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C607248CC
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 18:17:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238598AbjFFQRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 12:17:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237919AbjFFQRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 12:17:25 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69F0D1984;
        Tue,  6 Jun 2023 09:17:04 -0700 (PDT)
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 356GGhJ7123247;
        Tue, 6 Jun 2023 11:16:43 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686068203;
        bh=l/utGV2xHuvd6SjkKf3JwfSV+9hC4Z5HI/Wp+aX4gqE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=k+vIcpUUgw4S18ioAaDgvgaGR1lxuLXqAgBnZDLFaz1DV+deWtjL8Vk8vW0g6YmzR
         EjKv8YM8mGpy1UtMaPEVRglpW5G8le9jYtsNpIv1JJ68tn7SU5kM2NR/zlaad2c1F5
         8xuXRNSPKwmg4loMZ9Q3dYuhHo8mp+L7gUrYcoGk=
Received: from DFLE115.ent.ti.com (dfle115.ent.ti.com [10.64.6.36])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 356GGho7121447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 6 Jun 2023 11:16:43 -0500
Received: from DFLE114.ent.ti.com (10.64.6.35) by DFLE115.ent.ti.com
 (10.64.6.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Tue, 6
 Jun 2023 11:16:43 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Tue, 6 Jun 2023 11:16:43 -0500
Received: from localhost (ileaxei01-snat2.itg.ti.com [10.180.69.6])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 356GGhle023280;
        Tue, 6 Jun 2023 11:16:43 -0500
Date:   Tue, 6 Jun 2023 11:16:43 -0500
From:   Nishanth Menon <nm@ti.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>
CC:     <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>, <vaishnav.a@ti.com>,
        <afd@ti.com>, <u-kumar1@ti.com>
Subject: Re: [PATCH 0/3] arm64: dts: ti: k3-j7200: Fixes for various
 dtbs_checks warnings
Message-ID: <20230606161643.2fvbfysy5c622xkg@unwound>
References: <20230424173623.477577-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230424173623.477577-1-nm@ti.com>
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

On 12:36-20230424, Nishanth Menon wrote:
> Hi,
> 
> Few fixups for j7200 dtbs_check warnings.
> 
> Bootlog: https://gist.github.com/nmenon/6a37fca2f05633b7153e661d2516deab
> 
> NOTE: lets see the discussion summary of [1] to see where to take this
> series, but, I will put it out here in the list for discussion anyways.
> 
> [1] https://lore.kernel.org/all/76da0b98-3274-b047-db11-ecabc117ae11@ti.com/
> 
> Nishanth Menon (3):
>   arm64: dts: ti: k3-j7200-mcu-wakeup: Remove 0x unit address prefix
>     from nodename
>   arm64: dts: ti: k3-j7200-mcu-wakeup: Switch mcu_syscon to
>     ti,j721e-system-controller
>   arm64: dts: ti: k3-j7200-mcu-wakeup: Split fss node up
> 
>  .../boot/dts/ti/k3-j7200-mcu-wakeup.dtsi      | 29 ++++++++++++-------
>  1 file changed, 19 insertions(+), 10 deletions(-)
> 

After looking a bit closer at this, lets drop this series.
For the pinctrl fixup: Please pick up
https://lore.kernel.org/all/20230510091850.28881-1-tony@atomide.com/
instead

As discussed in
https://lore.kernel.org/all/20230605205220.rjmcsi5tjn4auqa7@arose/ we
can look at fss and syscon cleanup in the next kernel rev once the
dependencies are sorted out.

-- 
Regards,
Nishanth Menon
Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
