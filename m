Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3E506F6E99
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 17:06:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231139AbjEDPGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 11:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230495AbjEDPG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 11:06:28 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F39DC3
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 08:06:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3A4CD6301C
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 15:06:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3E19BC433EF;
        Thu,  4 May 2023 15:06:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683212786;
        bh=e6TydR08eXObbWSXZBvKj7cOlcyvP0Fh60ymlnpBqgc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=K/Vpd9pZAy58FmzsTrVPg7RSwqo8089WjAItbdp13rLow5t9bcUzlJ4htHc4Mr3FQ
         sQXsqiQJ57f2sEWjfnljFUw8gS8TfYGc/xsgHOpksA3N1WVh2qroPFRL/EQMpXVtSo
         KntQGMiE5tUy1opVNzPCaLAPpXB4qMHqTebkk7hJPWKm/NBFDI3pkxPAjw7dBp8o4W
         uWgRg+XLACf91TLagSJStYTE8+pl9jOen7F/78+UNcxfjL5DpGlqdGOX9ziqlLmYKy
         Kj1OWvhGIjccXtWurEAHmJQLAfDmsv/RZAKXAOSQqRQ+q9PqO1BODpLIAxnd7+FfK6
         zgdAdQ/dEVdsw==
Date:   Thu, 4 May 2023 08:06:24 -0700
From:   Nathan Chancellor <nathan@kernel.org>
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Phy <linux-phy@lists.infradead.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        llvm@lists.linux.dev
Subject: Re: [GIT PULL]: Generic phy updates for v6.4
Message-ID: <20230504150624.GA1000378@dev-arch.thelio-3990X>
References: <ZFI74eeUzVPKhi4f@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZFI74eeUzVPKhi4f@matsya>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vinod,

On Wed, May 03, 2023 at 04:18:01PM +0530, Vinod Koul wrote:
> Hello Linus,
> 
> Please consider pull to receive generic phy updates for v6.4-rc1. We
> have a bunch of new controller support in qcom, mediatek and rk socs.
> Intel Thunder Bay eMMC PHY driver is dropped as no users and bunch of
> driver updates for the subsystem
> 
> The following changes since commit fe15c26ee26efa11741a7b632e9f23b01aca4cc6:
> 
>   Linux 6.3-rc1 (2023-03-05 14:52:03 -0800)
> 
> are available in the Git repository at:
> 
>   git://git.kernel.org/pub/scm/linux/kernel/git/phy/linux-phy.git tags/phy-for-6.4
> 
> for you to fetch changes up to a0106132372120dd0abf5ad7636614e5aeb5da08:
> 
>   phy: cadence: cdns-dphy-rx: Add common module reset support (2023-04-12 22:16:16 +0530)
> 
> ----------------------------------------------------------------
> phy-for-6.4
> 
>   - New support:
>         - UFS PHY for Qualcomm SA8775p, SM7150
>         - PCIe 2 lane phy support for sc8180x and PCIe PHY for SDX65
>         - Mediatke hdmi phy support for mt8195
>         - rockchip naneng combo phy support for RK358
> 
>   - Updates:
>         - Drop Thunder Bay eMMC PHY driver
>         - RC support for PCIe phy for Qualcomm SDX55
>         - SGMII support in WIZ driver for J721E
>         - PCIe and multilink SGMII PHY support in cadence driver
>         - Big pile of platform remove callback returning void conversions
> 
> ----------------------------------------------------------------
...
> Guillaume Ranquet (3):
>       dt-bindings: phy: mediatek: hdmi-phy: Add mt8195 compatible
>       phy: phy-mtk-hdmi: Add generic phy configure callback
>       phy: mediatek: add support for phy-mtk-hdmi-mt8195

This patch went in without one of the three simple/obvious fixes sent to
you, so now clang builds with -Werror are broken, as they have been in
-next for almost three weeks :/

https://lore.kernel.org/20230413-fixes-for-mt8195-hdmi-phy-v2-1-bbad62e64321@baylibre.com/
https://lore.kernel.org/20230414075842.4006164-1-arnd@kernel.org/
https://lore.kernel.org/20230414122253.3171524-1-trix@redhat.com/

  drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: error: variable 'ret' is uninitialized when used here [-Werror,-Wuninitialized]
          if (ret)
              ^~~
  drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:216:12: note: initialize the variable 'ret' to silence this warning
          int i, ret;
                    ^
                     = 0
  1 error generated.

Could one of these please be picked up by either you or Linus directly,
since this is the third ping on the matter:

https://lore.kernel.org/20230421221330.GA3657732@dev-arch.thelio-3990X/
https://lore.kernel.org/CAKwvOd=5szkx5yA0bxcyktx85opAwLrB3_4n13SMV7p3m9x7LQ@mail.gmail.com/

Cheers,
Nathan
