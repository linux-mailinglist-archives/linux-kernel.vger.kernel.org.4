Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6A62733A20
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 21:45:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234497AbjFPTpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 15:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344729AbjFPTox (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 15:44:53 -0400
Received: from mail-yw1-x1129.google.com (mail-yw1-x1129.google.com [IPv6:2607:f8b0:4864:20::1129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C59D30EA;
        Fri, 16 Jun 2023 12:44:53 -0700 (PDT)
Received: by mail-yw1-x1129.google.com with SMTP id 00721157ae682-5701810884aso13302637b3.0;
        Fri, 16 Jun 2023 12:44:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686944692; x=1689536692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BW2NOHOwO+QgUHw/NgfDIAh7cmXwSaSnA8DVFSVtIx8=;
        b=GcdVkrMUO48g4N2P74BlwRfRLeUCnKQwPzVSMU0AaAFHdyokgy2q18ZXAEDiARuXmd
         QqV8svSbVu4YE0EiFj2Lt1Z2F7QJx48uk7bosKTca4tF6gUZcEU+AUpvP8BSAKsw6yhz
         EwBxUc4MPR32okshuIjcDmatdjYdCgalaeKP5PiVYiC1rVYyrwHUq2Gl5iA/Bd1pGJeX
         5+InI4e1fjVkkzCsrWiw6XYOvqNrykwZcH3NfveQAptBVsGOBlIEaafSe5k68Ur2flDc
         44MOBTYLctz0VZF26VpGL2dn+LFbSaz86wBFp4+jhjE1Mj//ildBtXa9Acv+xRVdcHjP
         oeYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686944692; x=1689536692;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=BW2NOHOwO+QgUHw/NgfDIAh7cmXwSaSnA8DVFSVtIx8=;
        b=ERs3gMLDp7r67ht+iclUzNpjrKIC8YKBCU79HAz/FN79aT5EAHi6r6l7AzftlWtkRK
         NCtmmrkZZ5A0kyH0xPmB+zlaz1Tk5Aj8NEr+/LF8//tnRRSJuDz2ssuuVayLI8x0xqZX
         LqzdN7gsBjQaPU8Mexc6B3jW2zVFS68fC1v3/T7ulM3K12JBvYInDMRCJHIrr6cMGP2r
         GWXP/FLbDa3ftJahoWCfqk9/f2dS/FJN4Uc8gdPm7YrHE96ZJxojMXCR8MkvopXAyaNK
         WlcqpBPAp3zD532/juxByWd5VNM1EXMRmNC6Ex9bRSy+ae3H+BvnBOwoWSMwHpXGQIMD
         uDzg==
X-Gm-Message-State: AC+VfDw2il54Mddu+ZVaqxx3Q42FaNDrjVrZDiFhObzU4sJVDHGmT3Tf
        Mg+ztD94da/Rna/tVdNJKmY6CMBt8kjWhAqxJyU=
X-Google-Smtp-Source: ACHHUZ6gdmSG7jw55MrKlUWBbdsh90msqYmjtTXITWleso4hQBLUtjcSsFQDIf1f68OyytK29J+gRYHSZxlgTWvDXy8=
X-Received: by 2002:a0d:d8d5:0:b0:570:2568:15e with SMTP id
 a204-20020a0dd8d5000000b005702568015emr3055887ywe.43.1686944692205; Fri, 16
 Jun 2023 12:44:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230616115856.3ce7682c@canb.auug.org.au>
In-Reply-To: <20230616115856.3ce7682c@canb.auug.org.au>
From:   Vishal Moola <vishal.moola@gmail.com>
Date:   Fri, 16 Jun 2023 12:44:41 -0700
Message-ID: <CAOzc2pxi1AH0Zmm_E=scqyO=Aemd3jeRje8tpsWhJ+5T3E7C5Q@mail.gmail.com>
Subject: Re: linux-next: manual merge of the block tree with the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Jens Axboe <axboe@kernel.dk>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 6:59=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org=
.au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the block tree got a conflict in:
>
>   mm/gup.c
>
> between commit:
>
>   0f3f569eca46 ("mm/gup.c: reorganize try_get_folio()")
>
> from the mm tree and commit:
>
>   c8070b787519 ("mm: Don't pin ZERO_PAGE in pin_user_pages()")
>
> from the block tree.
>
> I fixed it up (I think - see below) and can carry the fix as necessary.
> This is now fixed as far as linux-next is concerned, but any non trivial
> conflicts should be mentioned to your upstream maintainer when your tree
> is submitted for merging.  You may also want to consider cooperating
> with the maintainer of the conflicting tree to minimise any particularly
> complex conflicts.

Thanks for fixing these up. I'll keep an eye out for conflicts in
linux-next as well
in the future.
