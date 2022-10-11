Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33F215FABFB
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 07:46:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229538AbiJKFp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 01:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229486AbiJKFp4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 01:45:56 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id EC4AD4D15C;
        Mon, 10 Oct 2022 22:45:55 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 24D8F80FE;
        Tue, 11 Oct 2022 05:37:08 +0000 (UTC)
Date:   Tue, 11 Oct 2022 08:45:54 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] ARM: dts: omap3-n900: fix LCD reset line polarity
Message-ID: <Y0UDEtQlN5Y9h7BU@atomide.com>
References: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221004213503.848262-1-dmitry.torokhov@gmail.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Dmitry Torokhov <dmitry.torokhov@gmail.com> [221004 21:26]:
> The LCD driver (panel-sony-acx565akm), when probing, starts with line
> driven low, and then toggles it to high and keeps it there. Also, the
> line is driven low when powering off the device, and ls released when
> powering it back on. This means that the reset line should be described
> as "active low" in DTS. This will be important when the driver is
> converted to gpiod API which respects the polarity declared in DTS.

We should ensure these patches get merged together with the driver
change to avoid breaking LCD for booting. Probably no need to have
the driver quirk handling for inverted polartity in this case.

It's probably easiest to have an immutable branch for the driver
changes I can base the dts changes on. Or I can ack the dts changes
if they get merged with the driver.

Regards,

Tony
