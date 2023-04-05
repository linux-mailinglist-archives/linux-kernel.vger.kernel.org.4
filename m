Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D2756D7341
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 06:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236770AbjDEEOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 00:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237020AbjDEEON (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 00:14:13 -0400
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C7385276
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 21:11:00 -0700 (PDT)
Received: by mail-ed1-x531.google.com with SMTP id 4fb4d7f45d1cf-50263dfe37dso550441a12.0
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 21:11:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680667858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=h1GN6xo/n2b3TSYYAByQ/8rvL9wFLW9Alx0V1L3ih/0=;
        b=UNNzLEV0+If7e42INbC8amWNJk9poSZ6nqqQ0p8/FhZ3lZLvNsMW5QJ39b8TEtYz7B
         /jpp7E6STNg9kRLBV5dUhCHVFR+6YtFQk/KCgCWxu0Sg9SaURKQ9HiodY3tRjQEKPD2b
         UUKkQbcgUKI2BTpu2UqC/JYCYLa5Y4iXF+stlLIOhbuU5Wd1CanOhXLTHNb7mTpbcYt5
         ZLiXzJgs+4VZOmSSQhfCSA5IUTA81mML+Hjq+laypRk3ZlVOvY5V6lV1dXY7oNKmfeYJ
         t2KCpswMCSNFfXhrdYmKYgHLOdVMNWQcUCBeyPQcCtioKvUwZV/lBPOkzXrpxeCZPgjz
         LQHQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680667858;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=h1GN6xo/n2b3TSYYAByQ/8rvL9wFLW9Alx0V1L3ih/0=;
        b=JrfonqeBEhm9iE9YbZkro2v01OyTKNreDCoO7/MxMMSDunR2hzwVNs9Fdpa114MhHr
         HqLyx6jbY7hPsgXqlYPEqcJ6x6viTi1OmGGwVE3Cj/H4Sd3ZH17Myp0P8HH3q1nFZOeS
         KHvzWcbnXSM9DVEhhpqjD21r+CDWXLxrMEhDj8uQmoio5U4lc4bGAVyb+i9gk/Uqsduw
         Q97S1sTS/f8D2+0tngB4Vna0qFAeX5a0M/ieelCJ4apqJENd07ICq3IVfOOjEHjHBLGv
         EsGSgwyNq5+TIcXqLDXXPkmFJlDlE8UTg9+q4tqsug8r2T4R85gbFkmA4WHKUuoGAfSK
         SJPw==
X-Gm-Message-State: AAQBX9fEW+X/fnEh+25KbcUL3u5ryRHTHh7FImjL37qmfSnB++K9zd0f
        LzBJUY3Z3hyTNUfG5xdBzYU4Og1sDV4nRaKF3djJDQ==
X-Google-Smtp-Source: AKy350asW3E3EWA+ReuQbhUXfumD/QcB2U/qZ1hGbnnYkU0aF2zKJnJJ4roWNcUMK8z6BJZrhXZhbHO750pyeElRcAQ=
X-Received: by 2002:a50:a6d1:0:b0:4fa:71a2:982b with SMTP id
 f17-20020a50a6d1000000b004fa71a2982bmr293903edc.0.1680667857724; Tue, 04 Apr
 2023 21:10:57 -0700 (PDT)
MIME-Version: 1.0
References: <20230405140852.04a808e5@canb.auug.org.au>
In-Reply-To: <20230405140852.04a808e5@canb.auug.org.au>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Tue, 4 Apr 2023 21:10:21 -0700
Message-ID: <CAJD7tkYteBhds8iBi11ddYv_qyOELS136rfx3M3jtheYSFfPoA@mail.gmail.com>
Subject: Re: linux-next: manual merge of the slab tree with the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 4, 2023 at 9:08=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.org.=
au> wrote:
>
> Hi all,
>
> Today's linux-next merge of the slab tree got a conflict in:
>
>   mm/slob.c
>
> between commit:
>
>   3fb083757df1 ("mm: vmscan: refactor updating reclaimed pages in reclaim=
_state")
>
> from the mm tree and commit:
>
>   6630e950d532 ("mm/slob: remove slob.c")
>
> from the slab tree.
>
> I fixed it up (I just removed the file) and can carry the fix as
> necessary. This is now fixed as far as linux-next is concerned, but any

Sounds good to me, thanks! Let me know if anything else needs to be done he=
re.


> non trivial conflicts should be mentioned to your upstream maintainer
> when your tree is submitted for merging.  You may also want to consider
> cooperating with the maintainer of the conflicting tree to minimise any
> particularly complex conflicts.


>
> --
> Cheers,
> Stephen Rothwell
