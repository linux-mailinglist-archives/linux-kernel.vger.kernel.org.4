Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D26E56BE282
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 09:04:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230254AbjCQIEa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Mar 2023 04:04:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230164AbjCQIEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Mar 2023 04:04:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B608B04BC;
        Fri, 17 Mar 2023 01:04:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B20CAB82466;
        Fri, 17 Mar 2023 08:04:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 53F2CC433D2;
        Fri, 17 Mar 2023 08:04:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679040254;
        bh=p0BUqJSg2SeYj38Fa5fWlisgpVk5eSZqipdHV2NgafE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXL+AVMtAeY3d9tTUmuu7OMV6IBQFULHQ7lDYNXdVTpIY+1AdyRgVzfBmHOx73hJV
         ZQiYhxhB/35aZ8HBM4zN6FZGxypbBR/Ibs49z9sGKQ3BY9Pg5izZWJCnf32LMBKxP5
         UZliE/iEMHglYRdDg60LQoaGaePJEsJiJ2QGFm7OS3EGWbpluxulgidcwnznnk/yUE
         LQDh6N2QeF0pDlZRGs1d1CoXOI1py7xobDxzeXhPiioeP/N7LCXa6QpTqTxicC31xq
         3FWtbhdn4ZROq9tRIM8XUYOE3YS0w3QDS33wcWRXSOf6K8XdMYTbrBt3Rp4Nhe2Ro7
         2tUAsVJRi35LA==
Date:   Fri, 17 Mar 2023 08:04:07 +0000
From:   Lee Jones <lee@kernel.org>
To:     ChiaEn Wu <chiaen_wu@richtek.com>
Cc:     corbet@lwn.net, pavel@ucw.cz, matthias.bgg@gmail.com,
        andriy.shevchenko@linux.intel.com, jacek.anaszewski@gmail.com,
        angelogioacchino.delregno@collabora.com, linux-doc@vger.kernel.org,
        peterwu.pub@gmail.com, cy_huang@richtek.com,
        linux-leds@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        szunichen@gmail.com
Subject: Re: [PATCH v18 3/3] docs: leds: Add MT6370 RGB LED pattern document
Message-ID: <20230317080407.GD9667@google.com>
References: <cover.1678430444.git.chiaen_wu@richtek.com>
 <38f1e863b0f099158a63fb6f95056a1cb30d80a0.1678430444.git.chiaen_wu@richtek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <38f1e863b0f099158a63fb6f95056a1cb30d80a0.1678430444.git.chiaen_wu@richtek.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Mar 2023, ChiaEn Wu wrote:

> From: ChiYuan Huang <cy_huang@richtek.com>
>
> Document the MT6370 RGB LED pattern trigger.
>
> This simply describe how the pattern works, each timing period, and the
> pattern diagram for MT6370 RGB LED.
>
> Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> ---
> v18:
> - Revise the text in document title and description.
> ---
>  Documentation/leds/leds-mt6370-rgb.rst | 64 ++++++++++++++++++++++++++++++++++
>  1 file changed, 64 insertions(+)
>  create mode 100644 Documentation/leds/leds-mt6370-rgb.rst

Applied, thanks

--
Lee Jones [李琼斯]
