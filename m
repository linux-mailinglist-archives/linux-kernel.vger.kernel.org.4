Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36BEC6B85D7
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 00:07:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbjCMXHI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 19:07:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCMXHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 19:07:05 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1DAE93E2B;
        Mon, 13 Mar 2023 16:06:37 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 80F91CE128C;
        Mon, 13 Mar 2023 23:06:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A6824C4339B;
        Mon, 13 Mar 2023 23:06:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678748791;
        bh=32LMZRRgY9Heh5Zy6mgD96NQ/9UxqafJlIGe3iNJPR0=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=p1Fhflo7e16PkWua2VrmfmNhClucrWIotAR0EQNI3avp3iSqwrm19UObZ0SoXMJ0D
         gZwYtyS3B7djgkM8MSTnZfDwQwAuIAHPooIYOaKsNK9GBrajAupyPJv1ITffYkwtgP
         GdCfag/1KRljaH8Hn8kUf/9o68AdVRIehQFbhBTNSGDzcqVtLSZqAKZQ03lWL0dEUq
         WEhZgw6x0zPKa3LtUQXSpqKljOfNhmcD3dKXhRsaQIjAGcnSoQQw+miQgr7mMpiEjk
         4iwDTlbEShCHOh9DSsXKTROOMRApcNhDcyEfOmtQAdc1jQoq9n+3cWWnefnHesyKJl
         jU9lBjsNWcu4w==
Received: by mail-lj1-f177.google.com with SMTP id a32so14263689ljq.1;
        Mon, 13 Mar 2023 16:06:31 -0700 (PDT)
X-Gm-Message-State: AO0yUKXu+Mp6HUKz/Z5hfKoylxZnhIO4cfXhqTPpVW3NKOSgWrzgRKYf
        joNTvDL1ebm40y9ISWw/ldobQoOPZh9AVsTGi2U=
X-Google-Smtp-Source: AK7set+3q0078CPE9b4taUG2K/RIOge027FCjRP30Js9cL88qNhljrFGUc2F1lvSpYqrE7I3qOUo2y0NrVFUC6XjyLU=
X-Received: by 2002:a05:651c:169a:b0:28e:d4ae:90ab with SMTP id
 bd26-20020a05651c169a00b0028ed4ae90abmr11003305ljb.2.1678748789638; Mon, 13
 Mar 2023 16:06:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230314094002.50555b2c@canb.auug.org.au>
In-Reply-To: <20230314094002.50555b2c@canb.auug.org.au>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Tue, 14 Mar 2023 00:06:18 +0100
X-Gmail-Original-Message-ID: <CAMj1kXHb8TK4WdA_Px5WOcNaBzj9E+gXcNnxJNPjnyGdLZBYKA@mail.gmail.com>
Message-ID: <CAMj1kXHb8TK4WdA_Px5WOcNaBzj9E+gXcNnxJNPjnyGdLZBYKA@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the efi-fixes tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 13 Mar 2023 at 23:40, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> After merging the efi-fixes tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
>
> arm-linux-gnueabi-ld: drivers/firmware/efi/efi-init.o: in function `efi_init':
> efi-init.c:(.init.text+0x474): undefined reference to `efi_earlycon_reprobe'
>
> Caused by commit
>
>   3923c4cf06af ("efi: earlycon: Reprobe after parsing config tables")
>
> $ grep CONFIG_EFI_EARLYCON .config
> $
>
> I have used the efi-fixes tree from next-20230310 for today.
>

Thanks for the report. It has already been fixed on the branch, so the
next time you pull it, things should build as expected.
