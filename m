Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347BF6BE268
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:00:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjCQIAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231259AbjCQIA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:00:29 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1B163BDB9;
        Fri, 17 Mar 2023 01:00:24 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7E962B824B1;
        Fri, 17 Mar 2023 08:00:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A2BBC433A4;
        Fri, 17 Mar 2023 08:00:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679040022;
        bh=vZrkEtnyCQAIhjWoclfnnOJbdRek3fDnbCw6p5vpShQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Nue7L0v71HBMF+rpuwB6VEnqHymGv/UsSG4JT5y0dZJFWa/xSkJVrnBEEbk5Woc+q
         B5gx+dLHFDkchL1DE/7HvcdtyWgEmiNjW1UUYHMHu4UnrzsEAgFoN4PRdeD8Cs1CT+
         aaac+dfKhf6TRTa2V4VFsKkkHDlyymNLpSfDWNWia4UcT139ZMJb/JvQFhdxuVyEYy
         j3m/05asQk5dFYFW20/B4b9TTDx04yiUJWLCXfXkpWVrERVWkTjKAVwA0v2ihWFprE
         LErL16i7MCPslpgxdWwObtERJknfKOdR5xyLQRxdfmoy7y0jU2nSGOyv37Y/BUjYxH
         b6q+MERRwjWWA==
Date:   Fri, 17 Mar 2023 08:00:16 +0000
From:   Lee Jones <lee@kernel.org>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     corbet@lwn.net, pavel@ucw.cz, matthias.bgg@gmail.com,
        andriy.shevchenko@linux.intel.com, jacek.anaszewski@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-doc@vger.kernel.org,
        peterwu.pub@gmail.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com, Alice Chen <alice_chen@richtek.com>
Subject: Re: [PATCH v18 2/3] leds: flash: mt6370: Add MediaTek MT6370
 flashlight support
Message-ID: <20230317080016.GB9667@google.com>
References: <cover.1678430444.git.chiaen_wu@richtek.com>
 <52480420a160e5a4c71715fbbf105e684a16e7c2.1678430444.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <52480420a160e5a4c71715fbbf105e684a16e7c2.1678430444.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023, ChiaEn Wu wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
>
> The MediaTek MT6370 is a highly-integrated smart power management IC,
> which includes a single cell Li-Ion/Li-Polymer switching battery
> charger, a USB Type-C & Power Delivery (PD) controller, dual Flash
> LED current sources, a RGB LED driver, a backlight WLED driver,
> a display bias driver and a general LDO for portable devices.
>
> Add support for the MT6370 Flash LED driver. Flash LED in MT6370
> has 2 channels and support torch/strobe mode.
>
> Acked-by: Jacek Anaszewski <jacek.anaszewski@gmail.com>
> Co-developed-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: Alice Chen <alice_chen@richtek.com>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> v18:
> - Unwrap each line by 100 chars limit.
> - For joint flash, add more comments above the source code.
> - Remove 'sentinel' comment in of_device_id table declaration.
> ---
>  drivers/leds/flash/Kconfig             |  13 +
>  drivers/leds/flash/Makefile            |   1 +
>  drivers/leds/flash/leds-mt6370-flash.c | 573 +++++++++++++++++++++++++++++++++
>  3 files changed, 587 insertions(+)
>  create mode 100644 drivers/leds/flash/leds-mt6370-flash.c

Applied, thanks

--
Lee Jones [李琼斯]
