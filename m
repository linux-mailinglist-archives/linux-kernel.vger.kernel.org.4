Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05F66C336
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 16:03:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232877AbjAPPDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 10:03:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbjAPPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 10:01:18 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 257DA25E07;
        Mon, 16 Jan 2023 06:52:00 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 29C2A8108;
        Mon, 16 Jan 2023 14:51:59 +0000 (UTC)
Date:   Mon, 16 Jan 2023 16:51:57 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Adam Ford <aford173@gmail.com>
Cc:     Andreas Kemnade <andreas@kemnade.info>, bcousson@baylibre.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "H. Nikolaus Schaller" <hns@goldelico.com>
Subject: Re: [PATCH] ARM: dts: gta04: fix excess dma channel usage
Message-ID: <Y8VkjQ2yZQssx/wJ@atomide.com>
References: <20230113211151.2314874-1-andreas@kemnade.info>
 <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHCN7xJH+c41Yas+xnWA57KNi9arOOJDxJ=joEDEJr2k6jrRrw@mail.gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Adam Ford <aford173@gmail.com> [230116 14:16]:
> Would it make sense to make this default in the omap3.dtsi file and
> enable them in the individual boards that need it?

In general disabling the unused devices by default for omaps will break
the power management. The disabled devices are completely ignored by the
kernel, and the devices are left to whatever the bootloader state might
be.

For SoCs using firmware to manage devices it's a bit different story
however. The firmware can still idle disabled devices based on a
late_initcall for example, even if the kernel knows nothing about the
disabled devices.

Regards,

Tony
