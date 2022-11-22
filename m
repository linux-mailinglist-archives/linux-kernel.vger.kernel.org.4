Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 460D7633694
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:05:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232659AbiKVIFH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:05:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232671AbiKVIE6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:04:58 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 84FA43E0A1;
        Tue, 22 Nov 2022 00:04:53 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 2762F8061;
        Tue, 22 Nov 2022 07:54:39 +0000 (UTC)
Date:   Tue, 22 Nov 2022 10:04:51 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] ARM: dts: am335x: Fix TDA998x ports addressing
Message-ID: <Y3yCoyWp6a9K7e/5@atomide.com>
References: <e9ac64d29bc18b3b394fd9a2abbfeafacc624f98.1669047037.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e9ac64d29bc18b3b394fd9a2abbfeafacc624f98.1669047037.git.geert+renesas@glider.be>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Geert Uytterhoeven <geert+renesas@glider.be> [221121 16:01]:
> Fix addressing in the NXP TDA998x HDMI transmitters' subnodes:
>   - Add missing #{address,size}-cells properties to ports capsule,
>   - Add missing reg properties to port child nodes,
>   - Drop bogus unit addresses from endpoint grandchildren nodes.

Thanks applying into omap-for-v6.2/dt.

Regards,

Tony
