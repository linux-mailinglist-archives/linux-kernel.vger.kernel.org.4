Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8A863364D
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 08:51:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232592AbiKVHvR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 02:51:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232373AbiKVHvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 02:51:14 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 124B332B8C;
        Mon, 21 Nov 2022 23:51:14 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AEEB78061;
        Tue, 22 Nov 2022 07:40:59 +0000 (UTC)
Date:   Tue, 22 Nov 2022 09:51:12 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Nishanth Menon <nm@ti.com>, Apurva Nandan <a-nandan@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Hari Nagalla <hnagalla@ti.com>
Subject: Re: [PATCH v3 4/4] arm64: dts: ti: Add support for J784S4 EVM board
Message-ID: <Y3x/cGYWLLB+J2zU@atomide.com>
References: <20221116130428.161329-1-a-nandan@ti.com>
 <20221116130428.161329-5-a-nandan@ti.com>
 <b57433e7-b309-bd1c-f794-3da74021f03c@ti.com>
 <20221118174754.y37pq77drvla2uxj@tinderbox>
 <8c123fa2-caab-d2dd-5eb4-688f1c6abb33@ti.com>
 <20221118180808.wnel7d6gswsnooww@junkman>
 <93242211-95e7-09a0-fced-5ef2deb9fc08@ti.com>
 <20221118192744.wish2vrxgy7dg7c2@unnerving>
 <3d5e41f6-16a8-4298-ccd3-6db60f94eb47@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3d5e41f6-16a8-4298-ccd3-6db60f94eb47@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Davis <afd@ti.com> [221118 21:05]:
> Why do we need SERIAL_8250_NR_UARTS at all, might be a better question.
> These should be dynamically allocated if the number goes over the
> default count imposed by the TTY framework. Maybe folks are still a
> bit too afraid to touch the TTY subsystem core, I don't blame them..

The 8250 core preallocates a number of ports for use, see
serial8250_isa_init_ports() and serial8250_register_8250_port(). As the
serial port driver probes, the preallocated ports get re-assigned to
the port driver.

Maybe we could keep the static serial8250_ports[] and add those ports
to a list where also the dynamically allocated ports would go..

Regards,

Tony
