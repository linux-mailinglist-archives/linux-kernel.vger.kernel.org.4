Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 22280722F51
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:09:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235001AbjFETJP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:09:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234979AbjFETI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:08:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6ADB394;
        Mon,  5 Jun 2023 12:08:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 07E2A6238B;
        Mon,  5 Jun 2023 19:08:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05AC3C4339C;
        Mon,  5 Jun 2023 19:08:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685992129;
        bh=Qw+to85OoCLshupPqJ27MnZgzCn+2/X1107uEHTDG9Y=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=SR8ebpABbJXP23RODVcuLIJCH7UhvcUrraG62O3x/XahHPrlGS1RDLsSoy5uBwfta
         yUYV1lQaXx5hI1JZSaSEMjrtrpy7OlpPG+ZkrndhwxRllSsbiRmc+uokg0Wwr1w2Dt
         InTViu++XdhrRtzmAJFtMQTAaHZ3J9/ro8y9BYgsMPqyiyvcD6nUjG15wsf7dXHltD
         KkrzdnWkNd9TEXy45UlBIPXroSx/ucFhESX3e5qCg/6bIzkSHbhaKGHe/AaIwi/0OQ
         KSJTdvowDAgXpfRPYm24DKber7k6PgBAYPbGS2DC9k82tqdf+E3qPhe8szlef1Nw01
         z4Qoe+EfxbHDQ==
Message-ID: <31f976e94ab3df02daf53fa99ca6faa33a62706a.camel@kernel.org>
Subject: Re: linux-next: bad rebase of the tpmdd tree
From:   Jarkko Sakkinen <jarkko@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Date:   Mon, 05 Jun 2023 22:08:46 +0300
In-Reply-To: <e050f28406061440edcd96921effff7fe01532f0.camel@kernel.org>
References: <20230531092448.5fa4d718@canb.auug.org.au>
         <e050f28406061440edcd96921effff7fe01532f0.camel@kernel.org>
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

On Mon, 2023-06-05 at 22:07 +0300, Jarkko Sakkinen wrote:
> On Wed, 2023-05-31 at 09:24 +1000, Stephen Rothwell wrote:
> > Hi all,
> >=20
> > The tpmdd tree has been rebased onto Linus' tree, but has included some
> > of the patches from Linus' tree as new commits :-(
>=20
> Hi, I'm sorry for late response.
>=20
> I fixed the issue:
>=20
> git log --oneline upstream/master..origin/next
> 57094c1699ab (HEAD -> next, origin/next) integrity: Remove EXPERIMENTAL f=
rom Kconfig
> 14d723483fb7 integrity: Enforce digitalSignature usage in the ima and evm=
 keyrings
> 538b04b8c136 KEYS: DigitalSignature link restriction
> 90bfba7a9e1d KEYS: Replace all non-returning strlcpy with strscpy
> 405def5af246 security: keys: perform capable check only on privileged ope=
rations
> f28ac094fb2d tpm_tis_spi: Release chip select when flow control fails
> 9c7b610c7299 tpm: tpm_tis: Disable interrupts *only* for AEON UPX-i11
> 1f603c8055ab tpm: tpm_vtpm_proxy: fix a race condition in /dev/vtpmx crea=
tion

[except 1f603c8055ab dropped from above]

BR, Jarkko
