Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BC9E5BAD2D
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 14:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231429AbiIPMNw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 08:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39618 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231477AbiIPMNI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 08:13:08 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02E8FB0B3D;
        Fri, 16 Sep 2022 05:13:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F20D762AFB;
        Fri, 16 Sep 2022 12:12:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DFF0C433D6;
        Fri, 16 Sep 2022 12:12:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663330379;
        bh=PRODYos1SOL0wigtxeHeW2kCFKz0wxV0NAFDelLx1z0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qCx5OobSda8deAXsVqhSpZCJ6WRCGMZ5FImMWSYKNfD4anNq3acqW6qMxJowoRSH2
         Y6jdMLJhoSWxB5D/urcvfrUTzDnjsCrWYCwVyC+KMigVPRWqbNVXvnN4kOI8ci6cis
         A6GvelssrFxHrH/K5M4+W+maoaXAg2voXyO3Stj9TC3jCwFBf57kG0r6NFn3D44beX
         UvFx3sGuixeGWdVf0EyvXsgYhfQbU1tbJPfbcq8W5lhv3+oZEAn/0L7lxCIsDYPESJ
         aM7YOikqcMF9y0E3DlOoDpDgKJxmLfUngarpTa6Se13Tgz6A0dojAEMixfO/zx3oMK
         BUTqpkktmWgFQ==
Date:   Fri, 16 Sep 2022 20:12:54 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Li Yang <leoyang.li@nxp.com>
Cc:     devicetree@vger.kernel.org, robh+dt@kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 00/11] accumulated dts updates for ls1043a
Message-ID: <20220916121254.GP1728671@dragon>
References: <20220914214703.29706-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220914214703.29706-1-leoyang.li@nxp.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 04:46:52PM -0500, Li Yang wrote:
> v2 updates:
> - Use MACROs for interrupts and gpio property
> 
> Hou Zhiqiang (2):
>   arm64: dts: ls1043a: Add SCFG phandle for PCIe nodes
>   arm64: dts: ls1043a: Add big-endian property for PCIe nodes
> 
> Laurentiu Tudor (2):
>   arm64: dts: ls1043a: add missing dma ranges property
>   arm64: dts: ls1043a: use a pseudo-bus to constrain usb and sata dma
>     size
> 
> Li Yang (7):
>   arm64: dts: ls1043a: fix the wrong size of dcfg space
>   arm64: dts: ls1043a: Enable usb3-lpm-capable for usb3 node
>   arm64: dts: ls1043a: use pcie aer/pme interrupts
>   arm64: dts: ls1043a: make dma-coherent global to the SoC
>   arm64: dts: ls1043a: add gpio based i2c recovery information
>   arm64: dts: ls1043a-qds: add mmio based mdio-mux support
>   arm64: dts: ls1043a-rdb: add pcf85263 rtc node

Applied all, thanks!
