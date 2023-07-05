Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32068748E2F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 21:45:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232908AbjGETpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 15:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233593AbjGETpW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 15:45:22 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0245B1BDB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 12:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B0DA616EB
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 19:45:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43801C433C7;
        Wed,  5 Jul 2023 19:45:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1688586302;
        bh=KhM+sxLQiJ8EQAqx2ZFTY7MHUfcaTKS1JUQRGcq0tM0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=poxkH5gdEZ2c9IhyvSpQR3hSjWvM5CPONJUqxcTdtjjRDpiZdojCi2OwTyF4r6F8V
         OBzYPUvibXCDXhTCPly5I+HFUXZaQyd6EwAhZhGUvf/gAzkYPwaQ/qpIPEXhC3yswZ
         tbOm7fBRKWrUlrX6ABIdZqwzX9tmkrYtsAfIuCDD+MmL+FYAA5tV1TQ43hCz/KQMRh
         pV5yT9JgURn+A0iR6SRJGPbM3ZmKZfEjzAqKOIckb6d8+ylyHdbx12koKgUvSkY6JR
         doedZ5VdftBGWRmjPD8JcggTKLRvAI0+l4dqh9jIxhx9K9QBZPPYdBQLUHUJYr1fbx
         5Rh6rOyMLUoYQ==
Date:   Thu, 6 Jul 2023 01:14:58 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>
Subject: Re: [GIT PULL]: Generic phy subsystem updates for v6.5-rc1
Message-ID: <ZKXIOnniqbMEcj4z@matsya>
References: <ZKUkQTLeDMNIyyK7@matsya>
 <CAHk-=whPwD-7x=g9zR2xZ0=4EopwoJxaY=qX=T71vwWEcmaGWg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=whPwD-7x=g9zR2xZ0=4EopwoJxaY=qX=T71vwWEcmaGWg@mail.gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05-07-23, 11:16, Linus Torvalds wrote:
> On Wed, 5 Jul 2023 at 01:05, Vinod Koul <vkoul@kernel.org> wrote:
> >
> > Hello Linus,
> >
> >  - New support:
> >    - TI J784S4  gmii phy and SGMII support
> >    - Rockchip RK3588 naneng combo phy
> >    - Mediatek mt8195 hdmi phy
> >    - Qualcomm UFS PHY for sa8775p, SM7150, PCI phy for SDX65
> >    - Drop Thunder Bay eMMC PHY support
> >
> >  - Updates
> >    - Further cleanup for Qualcomm phys and support for PCIe RC
> >    - Xilinx zynqmp SGMII support
> >    - Cadence Sierra PCIe + SGMII PHY multilink configuration
> >    - Phy subsystem platform remove callback
> 
> Pretty much none of the explanations seem to be true. The Thunder Bay
> changes happened the last merge window.  The alleged 8195 changes do
> not seem to exist. The RK3588 changers are nowhere to be found.
> 
> And the sparx5 changes - that seem to be a noticeable part of this -
> aren't mentioned.

Sorry somehow I seemed to have reused old data while generating the tag
and email, I messed up!

> 
> I pulled, then unpulled.

Rightly so, I will send updated request, based on correct summary!

Apologies

-- 
~Vinod
