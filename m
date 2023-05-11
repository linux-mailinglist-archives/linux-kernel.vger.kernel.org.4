Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7ADF16FEAE2
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 06:46:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236856AbjEKEp7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 00:45:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjEKEp5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 00:45:57 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 10B452D5E;
        Wed, 10 May 2023 21:45:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QGzqD6d7fz4x4h;
        Thu, 11 May 2023 14:45:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1683780345;
        bh=gGQo2Hod1s0dUe8TaV/VGhddTEqXZ34G+98W5auwrHA=;
        h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
        b=SYn1FHGeyN2/KAqF8+2vnJXhmFrxun3VUz0Gm9tCde4qEbF3rEovKXDUS6pQCfiyw
         glrKlKcrrf9chWC+x/mErRxsdtXBHUqxEKAC6crYiVTLfcP/SprOVnkVTHA6ouhNQ/
         ETxHTeSacOeGfaPHeCdf5c+LKnmdBlSDnLZEOySHAZkk5TuanfORoUgQWu6TTmeK1x
         fFP2VQAp6atPbM6/tlL4TDo2TzY9xwKsD2SVLI3Va4Qaa/5FBcR5jDFYoIkEKSiUjb
         LKs1sKrmmNjOr77HT5e+V2hgGKTADo9yergTHjCiPGLJrbDHrlFDbxHHGwgXVy8vzx
         smd4t/8KrwPIA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        PowerPC <linuxppc-dev@lists.ozlabs.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warnings in powercp build
In-Reply-To: <20230511121635.0a6764a0@canb.auug.org.au>
References: <20230511121635.0a6764a0@canb.auug.org.au>
Date:   Thu, 11 May 2023 14:45:44 +1000
Message-ID: <871qjna32f.fsf@mail.lhotse>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Stephen Rothwell <sfr@canb.auug.org.au> writes:
> Hi all,
>
> Today's (and a few before) linux-next build (powerpc pseries_le_defconfig)
> produced these warnings:

Those aren't really warnings, it's just merge_config.sh telling you what
it's doing. The whole point of the generated configs is to override
those symbols.

Looks like there is a way to silence them, by using merge_into_defconfig_override.

cheers

> Building: powerpc pseries_le_defconfig
> Using /home/sfr/next/next/arch/powerpc/configs/ppc64_defconfig as base
> Merging /home/sfr/next/next/arch/powerpc/configs/le.config
> Merging /home/sfr/next/next/arch/powerpc/configs/guest.config
> Value of CONFIG_VIRTIO_BLK is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_BLK=m
> New value: CONFIG_VIRTIO_BLK=y
>
> Value of CONFIG_SCSI_VIRTIO is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_SCSI_VIRTIO=m
> New value: CONFIG_SCSI_VIRTIO=y
>
> Value of CONFIG_VIRTIO_NET is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_NET=m
> New value: CONFIG_VIRTIO_NET=y
>
> Value of CONFIG_VIRTIO_CONSOLE is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_CONSOLE=m
> New value: CONFIG_VIRTIO_CONSOLE=y
>
> Value of CONFIG_VIRTIO_PCI is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_PCI=m
> New value: CONFIG_VIRTIO_PCI=y
>
> Value of CONFIG_VIRTIO_BALLOON is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VIRTIO_BALLOON=m
> New value: CONFIG_VIRTIO_BALLOON=y
>
> Value of CONFIG_VHOST_NET is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_VHOST_NET=m
> New value: CONFIG_VHOST_NET=y
>
> Value of CONFIG_IBMVETH is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_IBMVETH=m
> New value: CONFIG_IBMVETH=y
>
> Value of CONFIG_IBMVNIC is redefined by fragment /home/sfr/next/next/arch/powerpc/configs/guest.config:
> Previous value: CONFIG_IBMVNIC=m
> New value: CONFIG_IBMVNIC=y
>
> I am not sure exactly which change(s) introduced these warnings.
>
> -- 
> Cheers,
> Stephen Rothwell
