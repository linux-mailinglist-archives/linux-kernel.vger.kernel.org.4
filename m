Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA61E727A1A
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235483AbjFHIhv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:37:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233645AbjFHIht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:37:49 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A4B226B2;
        Thu,  8 Jun 2023 01:37:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A69864AA9;
        Thu,  8 Jun 2023 08:37:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3A46C433A1;
        Thu,  8 Jun 2023 08:37:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686213467;
        bh=b8w2dww11+jeMQIGk8g14QqcvLwbopMkYC+R8CQKZcI=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=le1K4qUjRcurFJR4PvKWFr5yX1wr0bfbQMMQHpCiVNVL/GKFvdUoD3YXlQwh9z2aw
         a2k/KClut7Rba/NBifCDLFmoNHZoSWst8biJ4nex0gyZrtMuZBwNJ/TI59S6X9Q3SI
         PD52rYChAEgeGp/WmvngWXiwjouLglPxSMGOkbntnVfwdoRTNiMn8mcN4/PAGxHWnI
         KKcwuJzJpG2khAypic80LcdVcW7flajlgM1XjpDxzo5fguM5HNdniH7+61plfrq24n
         PqPJjdnb/NTO64Qyz6G4uavwQec+K3YYwagbM83ZkrAx2q9BgYjVnImFQ0YURyTh1m
         nzneBZ1G8KChg==
Received: by mail-lf1-f48.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so465853e87.3;
        Thu, 08 Jun 2023 01:37:46 -0700 (PDT)
X-Gm-Message-State: AC+VfDypERVI4+7y/0vomASr5qpZ8QsEXkJY8adAnn52FGKzyXhPLx6b
        I04oGT/lUYJFRpFEtRzK2lzk3Xjxq/2RqKHZDXw=
X-Google-Smtp-Source: ACHHUZ5YQ0EtwVOGgeqK+JNVOPM9pQ0uf1Q3nAcBP5h+ykVX8Gku7lWhb/0mJ5g2QMceulFBf3GJScF5rZVdvgUjp9g=
X-Received: by 2002:a05:651c:113:b0:2b1:eab1:e083 with SMTP id
 a19-20020a05651c011300b002b1eab1e083mr3391281ljb.16.1686213465018; Thu, 08
 Jun 2023 01:37:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230607053940.39078-10-bagasdotme@gmail.com> <20230607053940.39078-11-bagasdotme@gmail.com>
 <CAC1cPGxD6xOLksyMHCcreFyEv5Yoo50LY=xM9BmOEP=oECoNww@mail.gmail.com>
In-Reply-To: <CAC1cPGxD6xOLksyMHCcreFyEv5Yoo50LY=xM9BmOEP=oECoNww@mail.gmail.com>
From:   Ard Biesheuvel <ardb@kernel.org>
Date:   Thu, 8 Jun 2023 10:37:33 +0200
X-Gmail-Original-Message-ID: <CAMj1kXGnzphm5Wyz7RfZdWVxPnEihR0NGy5mFs4neQM+7EfEGQ@mail.gmail.com>
Message-ID: <CAMj1kXGnzphm5Wyz7RfZdWVxPnEihR0NGy5mFs4neQM+7EfEGQ@mail.gmail.com>
Subject: Re: [PATCH 1/8] crypto: Convert dual BSD 3-Clause/GPL 2.0 boilerplate
 to SPDX identifier
To:     Richard Fontana <rfontana@redhat.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Franziska Naepelt <franziska.naepelt@googlemail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux SPDX Licenses <linux-spdx@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Linux Crypto <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dan Carpenter <dan.carpenter@linaro.org>,
        Alexander Kjeldaas <astor@fast.no>,
        Herbert Valerio Riedel <hvr@hvrlab.org>,
        Kyle McMartin <kyle@debian.org>,
        "Adam J . Richter" <adam@yggdrasil.com>,
        Dr Brian Gladman <brg@gladman.me.uk>,
        Stephan Mueller <smueller@chronox.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 7 Jun 2023 at 16:38, Richard Fontana <rfontana@redhat.com> wrote:
>
> On Wed, Jun 7, 2023 at 1:42=E2=80=AFAM Bagas Sanjaya <bagasdotme@gmail.co=
m> wrote:
> >
> > Replace license boilerplate for dual BSD-3-Clause/GPL 2.0 (only or
> > later) with corresponding SPDX license identifier.
>
> This is at least the fourth or fifth time (I'm losing track) where you
> have incorrectly assumed a particular non-GPL license text matches a
> particular SPDX identifier without (apparently) checking.
>

What exactly does 'checking' entail here? There is no guidance in
Documentation/process/license-rules.rst on how to perform this
comparison.

Also, checkpatch now complains about missing SPDX identifiers, which
is what triggered this effort. Should it stop doing that?

> Bagas, I urge that you learn more about the nature of SPDX identifiers
> before submitting any further patches at least involving replacement
> of non-GPL notices with SPDX identifiers. For this unprecedented
> license notice replacement initiative to have any legitimacy it must
> attempt to apply SPDX identifiers correctly.
>

Since we're in language pedantic mode: it must do more than attempt,
it must apply them correctly, period.

Arguably, this is an 'attempt to apply SPDX identifiers correctly' on
Bagas's part, which apparently falls short (and I may be guilty of the
same for some arch crypto code)

So what is the ambition here: do we just leave the ambiguous ones as-is?
