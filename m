Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297886F802F
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231794AbjEEJjr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:39:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231800AbjEEJjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:39:40 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5C1681A109;
        Fri,  5 May 2023 02:39:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5848F80FC;
        Fri,  5 May 2023 09:39:31 +0000 (UTC)
Date:   Fri, 5 May 2023 12:39:30 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Nishanth Menon <nm@ti.com>
Cc:     Wadim Egorov <w.egorov@phytec.de>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, upstream@lists.phytec.de,
        vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add basic support for
 phyBOARD-Lyra-AM625
Message-ID: <20230505093930.GS14287@atomide.com>
References: <20230504140143.1425951-1-w.egorov@phytec.de>
 <20230504140143.1425951-2-w.egorov@phytec.de>
 <20230504142643.pkzsftrsrqph4vql@banked>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504142643.pkzsftrsrqph4vql@banked>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Nishanth Menon <nm@ti.com> [230504 14:33]:
> Just wondering: if the carrier board can easily work with different
> SoMs.. in which case, we could do overlay to create the som + carrier
> overlay to create rdk dtb - this might allow the scheme to scale to
> additional SoMs and carrier combinations.. and the SoM dtb could be
> sufficient for something like a bootloader.

It might be best to limit the overlay usage to devices that might see
dual use on the carrier board.. Not sure if setting up the entire
carrier board makes sense as an overlay :) Not sure if folks want to
debug boot issues on a remote server for example if an overlay is
needed to boot with Ethernet :)

Regards,

Tony
