Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7D0F6B35BB
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 05:50:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCJEuP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 23:50:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCJEuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 23:50:12 -0500
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 576B410556C;
        Thu,  9 Mar 2023 20:50:10 -0800 (PST)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32A4ntFS033877;
        Thu, 9 Mar 2023 22:49:55 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1678423795;
        bh=GOVmsz54fCWASHTucGhNsomu+seIgh7aKu1gqDguiKg=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=SSzYOKa6jR3hKWqT3nU6XJet3btLYaexmkS0ClXHRjV8GIbuAqw0NRlP9YFz8YZjP
         YogR5Ci/m+GsHHzddCqQDNrsGHgi8I5OpsURSqiF67nW7k/QnjLyg8fx5reemQv2Ru
         T+pN3iRoUjoka9AO+z2jEIqMp+FXR/Czel5MtTQE=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32A4nts2130447
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 9 Mar 2023 22:49:55 -0600
Received: from DLEE100.ent.ti.com (157.170.170.30) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Thu, 9
 Mar 2023 22:49:55 -0600
Received: from fllv0040.itg.ti.com (10.64.41.20) by DLEE100.ent.ti.com
 (157.170.170.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Thu, 9 Mar 2023 22:49:55 -0600
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0040.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32A4ntMu049174;
        Thu, 9 Mar 2023 22:49:55 -0600
From:   Nishanth Menon <nm@ti.com>
To:     <krzysztof.kozlowski+dt@linaro.org>, <n-yadav@ti.com>,
        <vigneshr@ti.com>, <kristo@kernel.org>, <robh+dt@kernel.org>
CC:     Nishanth Menon <nm@ti.com>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH] arm64: dts: ti: k3-am62-main: Fix GPIO numbers in DT
Date:   Thu, 9 Mar 2023 22:49:45 -0600
Message-ID: <167842374569.9333.16089645209561935651.b4-ty@ti.com>
X-Mailer: git-send-email 2.37.2
In-Reply-To: <20230202085917.3044567-1-n-yadav@ti.com>
References: <20230202085917.3044567-1-n-yadav@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
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

Hi Nitin Yadav,

On Thu, 2 Feb 2023 14:29:17 +0530, Nitin Yadav wrote:
> Fix number of gpio pins in main_gpio0 & main_gpio1
> DT nodes according to AM62x SK datasheet. The Link
> of datasheet is in the following line:
> https://www.ti.com/lit/ds/symlink/am625.pdf?ts=1673852494660
> 
> Section: 6.3.10 GPIO (Page No. 63-67)
> 
> [...]

I have applied the following to branch ti-dts-next on [1].
Thank you!

[1/1] arm64: dts: ti: k3-am62-main: Fix GPIO numbers in DT
      commit: 21609ca1f13fc1feca7b4b4aa63d21d95b2e69e2

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

[1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
-- 
Nishanth Menon <nm@ti.com>
