Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F716C9D39
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 10:10:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232965AbjC0IKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 04:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232957AbjC0IKI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 04:10:08 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4747749DD;
        Mon, 27 Mar 2023 01:10:07 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id AFF918108;
        Mon, 27 Mar 2023 08:10:06 +0000 (UTC)
Date:   Mon, 27 Mar 2023 11:10:05 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        =?utf-8?Q?Beno=C3=AEt?= Cousson <bcousson@baylibre.com>,
        Colin Foster <colin.foster@in-advantage.com>,
        Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v4 0/3] AM57x EVM Device Tree Overlays
Message-ID: <20230327081005.GD7501@atomide.com>
References: <20230307161715.15209-1-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307161715.15209-1-afd@ti.com>
X-Spam-Status: No, score=0.0 required=5.0 tests=SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Andrew Davis <afd@ti.com> [230307 18:17]:
> Hello all,
> 
> These are a set of uncontroversial (hopefully) DT Overlays to support the
> TI AM57x EVM and displays for AM57x IDKs. More complex cases are staged
> and ready to follow, but wanted to test the water with these first.

Applying these into omap-for-v6.4/dt-overlays thanks.

> For some reason dtbs_check does not get run on overlays, this
> will need further investigation to fix in kbuild. For now I ran
> it through manually but am not 100% sure it actually checked it,
> so double checks here very welcome.

Seems like that's a separate patch from this series.

Regards,

Tony
