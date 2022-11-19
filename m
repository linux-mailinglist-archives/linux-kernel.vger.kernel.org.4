Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85660630C78
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Nov 2022 07:32:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiKSGcg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Nov 2022 01:32:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiKSGce (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Nov 2022 01:32:34 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D67C8DA78;
        Fri, 18 Nov 2022 22:32:33 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C91EA60A38;
        Sat, 19 Nov 2022 06:32:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5178C433D6;
        Sat, 19 Nov 2022 06:32:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668839552;
        bh=bx1H5oyEj5Baf7Z8Q+gCPruinh9/I2zhfK2dAQ8AiUQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Tq/QSKIoUwptHIxIP79+FsAktHsZgNl1+4JG8N/tnO9jeeZf3iOoO4xmX0yoijKwc
         8ojx03oApjRSWbWH+zSuYkRrtoETJUfj5JokBgw9Bb2/jVXaOu8O+/mpSKb/4zhirC
         aZ4AdmXjXONTtyUZn4f7u2Z5fgPPnW5YqR7RYp4q2g8sDQQBCYi3dUHmhIKk2xhYgB
         z/AQpLeiRScXsoCnuP/UrGdbXzlFsbHiRUxem6e5j2O8jhGIv4aoRBolTOJEWKcrhm
         WNMnQzx6JviLY3MoT7LP8ZMaOoczLrUuSv0MuXKPWL/bmATuHoHVB+dplvZLqRuuun
         QsUz5b/wIyYtQ==
Date:   Sat, 19 Nov 2022 14:32:24 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Frank Rowand <frowand.list@gmail.com>,
        devicetree@vger.kernel.org, linux-kbuild@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 4/7] arm64: dts: freescale: Rename DTB overlay source
 files from .dts to .dtso
Message-ID: <20221119063223.GO16229@T480>
References: <20221024173434.32518-1-afd@ti.com>
 <20221024173434.32518-5-afd@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221024173434.32518-5-afd@ti.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022 at 12:34:31PM -0500, Andrew Davis wrote:
> DTB Overlays (.dtbo) can now be built from source files with the
> extension (.dtso). This makes it clear what is the content of the files
> and differentiates them from base DTB source files.
> 
> Convert the DTB overlay source files in the arm64/freescale directory.
> 
> Signed-off-by: Andrew Davis <afd@ti.com>
> Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied with Rob's dt/dtbo-rename branch pulled as dependency, thanks!

Shawn
