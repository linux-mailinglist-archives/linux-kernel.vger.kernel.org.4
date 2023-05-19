Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E580709CE4
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 18:51:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbjESQv2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 12:51:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230522AbjESQv0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 12:51:26 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A32A210C3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 09:51:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 37C3C6596F
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:51:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 94FACC433D2;
        Fri, 19 May 2023 16:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684515067;
        bh=730V0uvPApFBAJbWmMGCylUVOVuACQcDvVpOizAcH74=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tphNb9r4MGp6VbK+8d86jKx64lohOeTAguUZnBIuMtfKmU/fdr0chH9Br+W7r0KxA
         oyk3C0zyvQ39YHz2n3M3Ubge1bxzEdByXQaqwAaklRg1D8wk3vzPESgIn0RSTVgaHg
         U+zWiXeQAHFTvGHiuLzwjBqtXd2P6RDvlD7dnNEcqGNUX/JFz2qI/+YgZBV7A61s9N
         90h77T2mmGwGbjbiTDZotBLGRTG834MKak01T25Bf7oJUn19Y6b0AYms0SSYncpEZr
         5udOGFTiamtJqejYA8IMHfxhwfhc9oMyEsHXxyvpcsy2mC5cOyEGjN8xOkxNcUU8LF
         SDl9js+TQR54w==
Date:   Fri, 19 May 2023 18:51:04 +0200
From:   Simon Horman <horms@kernel.org>
To:     Nishanth Menon <nm@ti.com>
Cc:     Santosh Shilimkar <ssantosh@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] soc: ti: pruss: Allow compile-testing
Message-ID: <ZGeo+Nauwemwtc5v@kernel.org>
References: <20230511-ti-pruss-compile-testing-v1-1-56291309a60c@kernel.org>
 <168434612546.1538453.14483208071718769411.b4-ty@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168434612546.1538453.14483208071718769411.b4-ty@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 12:56:08PM -0500, Nishanth Menon wrote:
> Hi Simon Horman,
> 
> On Thu, 11 May 2023 16:54:36 +0200, Simon Horman wrote:
> > Allow compile testing of TI PRU-ICSS Subsystem Platform drivers.
> > This allows for improved build-test coverage.
> > 
> > No functional change intended.
> > 
> > 
> 
> I have applied the following to branch ti-drivers-soc-next on [1].
> NOTE: I did'nt see any immediate issue with this patch, but hopefully we dont
> break COMPILE_TEST going ahead. Lets see.
> Thank you!

Thanks. I'll look out for any notices regarding breakage.

> [1/1] soc: ti: pruss: Allow compile-testing
>       commit: e752f9b924a1fd1afcf36e51b03dfa9c3096a3bd
> 
> All being well this means that it will be integrated into the linux-next
> tree (usually sometime in the next 24 hours) and sent up the chain during
> the next merge window (or sooner if it is a relevant bug fix), however if
> problems are discovered then the patch may be dropped or reverted.
> 
> You may get further e-mails resulting from automated or manual testing
> and review of the tree, please engage with people reporting problems and
> send followup patches addressing any issues that are reported if needed.
> 
> If any updates are required or you are submitting further changes they
> should be sent as incremental updates against current git, existing
> patches will not be replaced.
> 
> Please add any relevant lists and maintainers to the CCs when replying
> to this mail.
> 
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/ti/linux.git
> -- 
> Regards,
> Nishanth Menon
> Key (0xDDB5849D1736249D) / Fingerprint: F8A2 8693 54EB 8232 17A3  1A34 DDB5 849D 1736 249D
> 
