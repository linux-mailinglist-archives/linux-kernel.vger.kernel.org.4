Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3A8C63C397
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 16:22:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235282AbiK2PWa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 10:22:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235277AbiK2PWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 10:22:07 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3487860361;
        Tue, 29 Nov 2022 07:21:35 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id n21so34581233ejb.9;
        Tue, 29 Nov 2022 07:21:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=T7wvGwt+dN4+DiJ9hB5IVdY0Pgs4QchSkXpHI/89Yd0=;
        b=IVjz/V1qBfSOBqjJcu415bL9eRKElmmO5iFTelSWJGfBZQN5TD4eW05JZs8taoEzqU
         OFztI0xC6mBgdvjsCe4Cozop50o2Y5p2FoaxzUuXgPqM26b702PMWdKAMtY7CtGQdvfH
         SsZx4i8NmCCyJTPG6LqSzPkiENzLhQtNSJ/y4qKTWWppt+M52pJ8pNCAjEZRBnUynVqB
         Kec68C2xYOxbD4jcJXI4lasm1RCJ172nKHCmkg0AAfS6ayQoeUt2ajMm6Fc4CSR/wBF4
         p8+JeKym+Eg9aE57SRVtlh1NfWPEy18xuMxQnOfFUeYJEhdd4gVSNOgx3W1qBOVP0D0e
         24uw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=T7wvGwt+dN4+DiJ9hB5IVdY0Pgs4QchSkXpHI/89Yd0=;
        b=l8DwAHKORTvx3uqh5qQ4GnCuAeQWA4PTWUurz9gFvXJ8lI2hazJnZvaxGai7pfRf7k
         ckGmDZKxZv34j5gzcqD3Ko+tYEGSplAF8aATfqqwFFlJxbfH+hc4UU6rmXE+tM5Lw8P3
         NzddWmMmO8ljiI8zWycPnT1LSjIyLN7qoKP0P5fcqHh3iutdKK9sgLjH/5wsq02S2Wyk
         KBOm85Sp/HTfyBiOUrqAXjKyTQH32o3eX0edo0gJA51p3eLYBxDq8T/d63tLDfe7sozM
         drWupfa+hexrExAwhUCKgTYYTnFRxu91PvKM5d+vbW03e6/CYUyBV8pAQ82lgY9746bA
         Cwcg==
X-Gm-Message-State: ANoB5pkBsxk3aO5+OZbSVN/qT50Ri9UXT4fl85Y97VcjbQe89UHG81+H
        Fz/ZqF1zwTNgr14x7qo0Y03yLPYdHU/xIHSDVes=
X-Google-Smtp-Source: AA0mqf7GNqjuM8Q259t5BZy7S13FS1YCYF5vMIbD7X8+VHEKT2xacF/PK/Rm/pnig9ikulU/2SVS6voPseL2dcFeAbs=
X-Received: by 2002:a17:906:2345:b0:7ad:adfe:1ceb with SMTP id
 m5-20020a170906234500b007adadfe1cebmr40371839eja.89.1669735293478; Tue, 29
 Nov 2022 07:21:33 -0800 (PST)
MIME-Version: 1.0
References: <20221129103949.19737-1-lhenriques@suse.de> <4914a195-edc0-747b-6598-9ac9868593a1@redhat.com>
 <CAOi1vP8raoFP2dsc6RY1fONCsHh5FYv2xifFY7pHXZWX=-vePw@mail.gmail.com> <20e0674a-4e51-a352-9ce2-d939cd4f3725@redhat.com>
In-Reply-To: <20e0674a-4e51-a352-9ce2-d939cd4f3725@redhat.com>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Tue, 29 Nov 2022 16:21:21 +0100
Message-ID: <CAOi1vP_H8jE4ZU4a4srhQev3odECgZD1LyxA8dv+Fk-bVDvoyQ@mail.gmail.com>
Subject: Re: [PATCH v4] ceph: mark directory as non-complete complete after
 loading key
To:     Xiubo Li <xiubli@redhat.com>
Cc:     Venky Shankar <vshankar@redhat.com>,
        Gregory Farnum <gfarnum@redhat.com>,
        =?UTF-8?Q?Lu=C3=ADs_Henriques?= <lhenriques@suse.de>,
        Jeff Layton <jlayton@kernel.org>, ceph-devel@vger.kernel.org,
        linux-kernel@vger.kernel.org
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

On Tue, Nov 29, 2022 at 3:50 PM Xiubo Li <xiubli@redhat.com> wrote:
>
>
> On 29/11/2022 22:32, Ilya Dryomov wrote:
> > On Tue, Nov 29, 2022 at 3:15 PM Xiubo Li <xiubli@redhat.com> wrote:
> >>
> >> On 29/11/2022 18:39, Lu=C3=ADs Henriques wrote:
> >>> When setting a directory's crypt context, ceph_dir_clear_complete() n=
eeds to
> >>> be called otherwise if it was complete before, any existing (old) den=
try will
> >>> still be valid.
> >>>
> >>> This patch adds a wrapper around __fscrypt_prepare_readdir() which wi=
ll
> >>> ensure a directory is marked as non-complete if key status changes.
> >>>
> >>> Signed-off-by: Lu=C3=ADs Henriques <lhenriques@suse.de>
> >>> ---
> >>> Hi Xiubo,
> >>>
> >>> Here's a rebase of this patch.  I did some testing but since this bra=
nch
> >>> doesn't really have full fscrypt support, I couldn't even reproduce t=
he
> >>> bug.  So, my testing was limited.
> >> I'm planing not to update the wip-fscrypt branch any more, except the =
IO
> >> path related fixes, which may introduce potential bugs each time as be=
fore.
> >>
> >> Since the qa tests PR has finished and the tests have passed, so we ar=
e
> >> planing to merge the first none IO part, around 27 patches. And then
> >> pull the reset patches from wip-fscrypt branch.
> > I'm not sure if merging metadata and I/O path patches separately
> > makes sense.  What would a user do with just filename encryption?
>
> Hi Ilya,
>
> I think the IO ones should be followed soon.
>
> Currently the filename ones have been well testes. And the contents will
> be by passed for now.
>
> Since this is just for Dev Preview feature IMO it should be okay (?)

I don't think there is such a thing as a Dev Preview feature when it
comes to the mainline kernel, particularly in the area of filesystems
and storage.  It should be ready for users at least to some extent.  So
my question stands: what would a user do with just filename encryption?

Thanks,

                Ilya
