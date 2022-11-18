Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DDDC62FC16
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242141AbiKRR4j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:56:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241622AbiKRR4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:56:34 -0500
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAC3C67F7D;
        Fri, 18 Nov 2022 09:56:33 -0800 (PST)
Received: by mail-yb1-xb2a.google.com with SMTP id f201so6480935yba.12;
        Fri, 18 Nov 2022 09:56:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9yPrPKQ5LGcHRBs57UvaycARK1BGynKMDI42dJyNdOM=;
        b=Q9Qx4OMcZDV3NHQUqOlhaK3/VXidSS9fT1IoEAaE766Rg5oKLrlb3gHSNjJyYCiWgh
         D1xjEMUb6S/Q+JcoJy08KBrb8HToKFAUxtfgtrxxf4GEc4WlMJzQ/KLwEdY9Al0eA8kB
         mcznAtJmTYVUaaQXTqe0R6FsmzIT/CQiGEVpi3wZwDLDZNTgqQnC1WQbHz2BK2OuNC1x
         JJ9kaI72LxPjaIMyOqr4U5W2q5GL254Hu0E/y6QUS5UhY1tEF/I2tA9wCXbOd/eBYNXg
         jZ2WXST3e3ESXgfjafeU3U5nRfDm0qiqZaJwFCHDseUUt8TN8Vt4sB66pPAFdaN2aEgI
         Sfiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9yPrPKQ5LGcHRBs57UvaycARK1BGynKMDI42dJyNdOM=;
        b=LfwQ23aw6unBk1Y9Xwi89xz/2Y396oGCwYM6AO+qHxVylIlCnZ7ZfRA5w84fiyxjL4
         6i93tYISMfS5IXEyY1+HEAJz77rxX/DhkrDN+YuiEUZXJWJ4QNimEc4DFngpOl2wtKGv
         ACfqnLS1nut9ltIWSro7vX4olXlNLApiCn63JGB0XKdlMnOsjgCYptLDWZ3B9Sh2TCtj
         BDaEm3ErtuGd9EHVI6U5H4pJNqfB0hPuy95Nz9ci1FxRQ7sotnlKmZhvoiDO3dGArZSI
         SoK/rxaTptyDYtBoMr4LfYNfjKPyP93TWVLqumkj4zheoHJdL7U6MopQC0hcf0psDbBT
         XFHg==
X-Gm-Message-State: ANoB5pn/WYzAHl09DcE72UpGQwhHRfhD969+zT3zoIDezEk2dudjro7u
        LBHYcAkZ+iMa2/iZWXn0Ne6LZixd0Vz2mBagyaU=
X-Google-Smtp-Source: AA0mqf5UllASHRM9YwksDVI1KOsZmMt5cJvRGnw+Xd3tBlpldd3UfEQ37Dv0XmoSxafk8Nfpyl2qTmSaeeUUnnv+HqA=
X-Received: by 2002:a25:7655:0:b0:6d3:7617:b8ea with SMTP id
 r82-20020a257655000000b006d37617b8eamr7621071ybc.75.1668794192380; Fri, 18
 Nov 2022 09:56:32 -0800 (PST)
MIME-Version: 1.0
References: <20221118170942.2588412-1-carlos.bilbao@amd.com>
In-Reply-To: <20221118170942.2588412-1-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 18 Nov 2022 18:56:21 +0100
Message-ID: <CANiq72=ANWtA+64O_sZu2r6XzNKnR7Sm_pXEW7XBtSUFYXPNVw@mail.gmail.com>
Subject: Re: [PATCH 0/2] kernel-docs: New maintainer and Spanish translation
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, Dhaval.Giani@amd.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 6:09 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote=
:
>
> This is a cover letter for just two patches, but I should provide context=
.
> I was going to translate kernel-docs.rst when I read:
>
> =E2=80=9CInitial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
> email address is defunct now.)=E2=80=9C
>
> I figured Juan-Mariano (CCed) may keep a Spanish version of the document,
> so I searched for his new email. He replied back proposing me to take car=
e
> of the document from now on. I will carry the torch with pleasure! This
> should also make Lukas happy [1].

Maybe some of this context could go into one commit message so that it
is recorded in Git.

> This cover letter is also a call for anyone interested in adding new, mor=
e
> up to date references to kernel-docs.rst. The document has been abandoned
> for a while but its original goal is still important.

Indeed, updates would be appreciated!

Cheers,
Miguel
