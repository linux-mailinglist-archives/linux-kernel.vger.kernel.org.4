Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8AD5672470
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 18:06:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230373AbjARRGt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 12:06:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230286AbjARRGq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 12:06:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D752F1716E;
        Wed, 18 Jan 2023 09:06:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81CA6B81D69;
        Wed, 18 Jan 2023 17:06:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86FAC433D2;
        Wed, 18 Jan 2023 17:06:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674061601;
        bh=QgSkoWdK4nXk9XDs52wWeDNBMAdFXFvIHRS961FB6pw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=KTfcX4dACin+ZcQp/sSFMJfHklTt4H7eDficwDRvB+DeZZMj3lJnVM/s7uOqSjZId
         Hr1F2fLZeR3lbU7voiR49QMpRho3EzOWQCqVeC2aXi1H5CMFuCFti8mW4oYiygvPsw
         LnJZTlBHTJiAcp2334p3S8n39a6Eu1pq7kU/NtQ4E4+EwNMTj3sPRsWbhP4nhILlf/
         nviRIAB6JV/D6gUEH42elFGvXdF3+9MPvNOfWJaL8k0I0i3SWNf8a07Dnn87G+1XE6
         V9VIlUO0yuDl7ImOJGWP9RD8/sMSD795Zre5Epu8DcV/YYtpzMMALIs9yWc/h2aP8h
         tubFw94FLcOdw==
Date:   Wed, 18 Jan 2023 11:06:38 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Alexey V. Vissarionov" <gremlin@altlinux.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the pci tree
Message-ID: <20230118170638.GA225976@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230116032354.GA8107@altlinux.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 16, 2023 at 06:23:55AM +0300, Alexey V. Vissarionov wrote:
> On 2023-01-16 08:14:25 +1100, Stephen Rothwell wrote:
>  > In commit
>  > 58d4c63d0a27 ("PCI/IOV: Enlarge virtfn sysfs name buffer")
>  > Fixes tag
>  > Fixes: dd7cc44d0 ("PCI: add SR-IOV API for Physical Function driver")
>  > has these problem(s):
>  > - SHA1 should be at least 12 digits long
> 
> Full SHA1 is dd7cc44d0bcec5e9c42fe52e88dc254ae62eac8d
> First 12 digits would obviously be dd7cc44d0bce

I fixed it locally for you, so no need to repost for this.

Bjorn
