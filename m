Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AD4B622587
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:33:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230178AbiKIIdH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:33:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiKIIcs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:32:48 -0500
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 786F765ED;
        Wed,  9 Nov 2022 00:31:27 -0800 (PST)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id B74A180FB;
        Wed,  9 Nov 2022 08:21:39 +0000 (UTC)
Date:   Wed, 9 Nov 2022 10:31:25 +0200
From:   Tony Lindgren <tony@atomide.com>
To:     Andrew Davis <afd@ti.com>, Rob Herring <robh+dt@kernel.org>
Cc:     =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-omap@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] AM57x EVM Device Tree Overlays
Message-ID: <Y2tlXVA6CH/aSzeK@atomide.com>
References: <20221101221110.17885-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221101221110.17885-1-afd@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew & Rob,

* Andrew Davis <afd@ti.com> [221102 00:01]:
> Hello all,
> 
> These is an uncontroversial (hopefully) DT Overlay to support the
> TI AM57x EVM. More complex cases are staged and ready to follow but
> wanted to test the water with this one.
> 
> For some reason dtbs_check does not get run on overlays, this
> will need further investigation to fix in kbuild. For now I ran
> it through manually but am not 100% sure it actually checked it,
> so double checks here very welcome.
> 
> Series depends on https://www.spinics.net/lists/kernel/msg4548509.html

Looks like we now have commit 26c9134a370a ("Merge branch 'dt/dtbo-rename'
into dt/next") in Linux next.

Can these two patches now be applied if I merge in the commit above?

Regards,

Tony
