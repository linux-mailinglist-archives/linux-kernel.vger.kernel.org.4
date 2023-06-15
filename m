Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A13127319F6
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 15:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245579AbjFON3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 09:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244403AbjFON3D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 09:29:03 -0400
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D0612944;
        Thu, 15 Jun 2023 06:29:02 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 35FDSuDv013982;
        Thu, 15 Jun 2023 08:28:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1686835736;
        bh=8uqd5e0vpRcZntkbZEhFTb+I4lBVzSNewxS1zEhY2SM=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=aqW60r0CWdU1tLZ0OG0kSAzH5epDWc35iEAatPxpi5KQTrQMDtlaMCN38j7ZnbyWQ
         GK8qqxLoMZKhOrstWjU9m+eSOlWyBtG/lY4jrsFVxbSCmQVG6UyeedJl+24CyOWLoB
         qeGtJfya5uaNA06IAkIEqLJ/mwJd91TWkcYFRAxI=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 35FDSuLp117815
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 15 Jun 2023 08:28:56 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23; Thu, 15
 Jun 2023 08:28:56 -0500
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.23 via
 Frontend Transport; Thu, 15 Jun 2023 08:28:56 -0500
Received: from uda0132425.dhcp.ti.com (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 35FDSqkp067924;
        Thu, 15 Jun 2023 08:28:53 -0500
From:   Vignesh Raghavendra <vigneshr@ti.com>
To:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        Thejasvi Konduru <t-konduru@ti.com>
CC:     Vignesh Raghavendra <vigneshr@ti.com>, Nishanth Menon <nm@ti.com>,
        Andrew Davis <afd@ti.com>, Apurva Nandan <a-nandan@ti.com>,
        Udit Kumar <u-kumar1@ti.com>
Subject: Re: [PATCH] arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets
Date:   Thu, 15 Jun 2023 18:58:51 +0530
Message-ID: <168682622740.2286657.4598600901991294366.b4-ty@ti.com>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230503083143.32369-1-t-konduru@ti.com>
References: <20230503083143.32369-1-t-konduru@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Thejasvi Konduru,

On Wed, 03 May 2023 14:01:43 +0530, Thejasvi Konduru wrote:
> The wkup_pmx register region in j784s4 has multiple non-addressable
> regions, hence the existing wkup_pmx region is split as follows to
> avoid the non-addressable regions. The pinctrl node offsets are
> also corrected as per the newly split wkup_pmx* nodes.
> 
> wkup_pmx0 -> 13 pins (WKUP_PADCONFIG 0 - 12)
> wkup_pmx1 -> 11 pins (WKUP_PADCONFIG 14 - 24)
> wkup_pmx2 -> 72 pins (WKUP_PADCONFIG 26 - 97)
> wkup_pmx3 -> 1 pin (WKUP_PADCONFIG 100)
> 
> [...]

I have applied the following to branch ti-k3-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-j784s4: Fix wakeup pinmux range and pinctrl node offsets
      commit: 14462bd0b247d05070d48d0f02eb7ca2680ab7bd

All being well this means that it will be integrated into the linux-next
tree (usually sometime in the next 24 hours) and sent up the chain during
the next merge window (or sooner if it is a relevant bug fix), however if
problems are discovered then the patch may be dropped or reverted.

You may get further e-mails resulting from automated or manual testing
and review of the tree, please engage with people reporting problems and
send followup patches addressing any issues that are reported if needed.

If any updates are required or you are submitting further changes they
should be sent as incremental updates against current git, existing
patches will not be replaced.

Please add any relevant lists and maintainers to the CCs when replying
to this mail.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
--
Vignesh

