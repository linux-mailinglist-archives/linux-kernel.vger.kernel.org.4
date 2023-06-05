Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E9F722F44
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234620AbjFETH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbjFETHz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:07:55 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5811094;
        Mon,  5 Jun 2023 12:07:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E94356235F;
        Mon,  5 Jun 2023 19:07:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC4FC433D2;
        Mon,  5 Jun 2023 19:07:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685992073;
        bh=yJ72jRLtFpzG+/fjIjwkL9G1ylCYwX1ZQXh9Lme/jVM=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=VBSCBGmYOxuW1IyHBeLtzOSmA7mcSQ9CxOhA5cMC/mBDyDlpAC1hFis8SH7IGy9N2
         J9/qe7STFPXABakLLH+60jA3DH8oLG8qSBAoQpoJrA+iooXuA1RtKvdP/Nn9j1NJLR
         fNt8kynYAJTI4FwMEsbOP7OQDZRTqqE9cG2/UGKTMqGMB6rH5h6VwzxRpAojGtDmCL
         C15Qv9gP4uhyW5/2S6wktmsvzW/qrQ+FyoIXtTdGxTT6ybTZYWwVdYx4MDhuKjFwTS
         f+fXINf0NqySTq8WiETFIBbRMA6LH8QUsJ9D+dXaPVNvrPUrNkztD//7Np6T3mOJ74
         Jy6XuOMoEg7Ig==
Message-ID: <e050f28406061440edcd96921effff7fe01532f0.camel@kernel.org>
Subject: Re: linux-next: bad rebase of the tpmdd tree
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Mon, 05 Jun 2023 22:07:50 +0300
In-Reply-To: <20230531092448.5fa4d718@canb.auug.org.au>
References: <20230531092448.5fa4d718@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.48.1-0ubuntu1 
MIME-Version: 1.0
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-05-31 at 09:24 +1000, Stephen Rothwell wrote:
> Hi all,
>=20
> The tpmdd tree has been rebased onto Linus' tree, but has included some
> of the patches from Linus' tree as new commits :-(

Hi, I'm sorry for late response.

I fixed the issue:

git log --oneline upstream/master..origin/next
57094c1699ab (HEAD -> next, origin/next) integrity: Remove EXPERIMENTAL fro=
m Kconfig
14d723483fb7 integrity: Enforce digitalSignature usage in the ima and evm k=
eyrings
538b04b8c136 KEYS: DigitalSignature link restriction
90bfba7a9e1d KEYS: Replace all non-returning strlcpy with strscpy
405def5af246 security: keys: perform capable check only on privileged opera=
tions
f28ac094fb2d tpm_tis_spi: Release chip select when flow control fails
9c7b610c7299 tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11
1f603c8055ab tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx creati=
on

BR, Jarkko

