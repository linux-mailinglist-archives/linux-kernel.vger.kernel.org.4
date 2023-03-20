Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB2C96C1A1F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:47:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231982AbjCTPrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:47:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231200AbjCTPqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:46:42 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C1B332534;
        Mon, 20 Mar 2023 08:37:32 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 32KFbOwB113786;
        Mon, 20 Mar 2023 10:37:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1679326644;
        bh=NnN5T3sm2b4vkPryIvp4/YKjJEAmclRvK3xcrqU5oq8=;
        h=Date:From:To:CC:Subject:References:In-Reply-To;
        b=SCu8gMj/c5Tk9bU7Tpq7AXHgf8521CddthzmZd/jt92o31SDD1efhqBEDkn/mlYW8
         JLIeeV7TRLIz/TmjLjy+eElSZ5z7ftzsB7r3JEcHz1FsfiIivw64mlOod36un7ivSM
         hm/sEMgIUWd27htAvLdya7fwhg2a4JGfLGeG0JaM=
Received: from DLEE112.ent.ti.com (dlee112.ent.ti.com [157.170.170.23])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 32KFbOlp053470
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Mon, 20 Mar 2023 10:37:24 -0500
Received: from DLEE115.ent.ti.com (157.170.170.26) by DLEE112.ent.ti.com
 (157.170.170.23) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16; Mon, 20
 Mar 2023 10:37:23 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE115.ent.ti.com
 (157.170.170.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.16 via
 Frontend Transport; Mon, 20 Mar 2023 10:37:23 -0500
Received: from localhost (ileaxei01-snat.itg.ti.com [10.180.69.5])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 32KFbNa8119049;
        Mon, 20 Mar 2023 10:37:23 -0500
Date:   Mon, 20 Mar 2023 10:37:23 -0500
From:   Bryan Brattlof <bb@ti.com>
To:     Nishanth Menon <nm@ti.com>
CC:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Tero Kristo <kristo@kernel.org>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Julien Panis <jpanis@baylibre.com>
Subject: Re: [PATCH 0/2] arm64: dts: ti: k3-am62: Add watchdog and rtc nodes
Message-ID: <20230320153723.dqt7uuhtwevuwrit@bryanbrattlof.com>
X-PGP-Fingerprint: D3D1 77E4 0A38 DF4D 1853 FEEF 41B9 0D5D 71D5 6CE0
References: <20230311105850.21811-1-nm@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Disposition: inline
In-Reply-To: <20230311105850.21811-1-nm@ti.com>
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On March 11, 2023 thus sayeth Nishanth Menon:
> Hi,
> 
> Couple of misc patches.
> 
> AM62x WDT was posted here[1] - So, this would be a resend, dropping the
> board level reservation.
> 
> Julien Panis (1):
>   arm64: dts: ti: k3-am62: Add watchdog nodes
> 
> Nishanth Menon (1):
>   arm64: dts: ti: k3-am62-wakeup: Introduce RTC node
> 
>  arch/arm64/boot/dts/ti/k3-am62-main.dtsi   | 45 ++++++++++++++++++++++
>  arch/arm64/boot/dts/ti/k3-am62-mcu.dtsi    |  9 +++++
>  arch/arm64/boot/dts/ti/k3-am62-wakeup.dtsi | 21 ++++++++++
>  3 files changed, 75 insertions(+)
> 
> [1] https://lore.kernel.org/all/20221109093026.103790-2-jpanis@baylibre.com/
>

The series looks good to me

Reviewed-by: Bryan Brattlof <bb@ti.com>

~Bryan
