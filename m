Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A145612F8D
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 05:55:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiJaEzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 00:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbiJaEzQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 00:55:16 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606F6DC7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 21:55:15 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id q1so9721534pgl.11
        for <linux-kernel@vger.kernel.org>; Sun, 30 Oct 2022 21:55:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6k9edOmi4jQnhndJM0oPHUDhd1xsqVU4YBKn2qnh9js=;
        b=YJFdZOx751Fhpcy/3SpXXpJ9lMBzwaS3Y4XPbXFsxxKVC1htuaUPzC1iANIyKCJhKF
         +KUL25Kv3HO+liKpWix91hA5OPOUONiFOf5CG1rVW88rislxfGhyZ1Y5PpZpL9UIhHr5
         XYGzcgvbP1VtaHfpJ062p0YHy0zjg2payQtj+gIIuUUGAfNXoTtMCIVDGu0R6oVmGWOf
         CZMz8Obq+T6pUk8ywudqdUD7ypyaKXPkh+uOeehzOhEvis3Hmfd2me+3uWJtditI4NjM
         /AmqrNO+e8kfNSS+1OGg+27o3POPZToIwzp2QjYV04U7Vwo1pIyajIb0zP08WNyFKc4v
         thsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6k9edOmi4jQnhndJM0oPHUDhd1xsqVU4YBKn2qnh9js=;
        b=L26+qsl6QoWJhDr022utSvtEiGSUDzCcO+3jK2vUxwIiCqDL/4VnOPV+ok7RX9h1gs
         BqbgMzUyEZA0oUPZcvGufgx74/qqLMBbaxI8dWbSmScbPDH3HkgjONiG4UPi+EX4ehDf
         TZ+5cJzfwuIhlwYxnO3bQ5wvgsH2TFxPHCdG01TgaRsH2r13EYK6iL1OEksl31zB+Npj
         WPR2bAK1e46jbkkwZvtc7IUQp2EyIt08ZM24aSlzWRebND5v+3mgb+fPNNZxNgTUyMan
         j+2bf++Le5BPEzdHoZfrxmNFov9YHa3NBoPY/be6uEtxlAXWZ4IhJPDjnfTe2ilx1wv9
         iHpA==
X-Gm-Message-State: ACrzQf2B977SXfy9dKaF6gAC4dtyc1V1TEord728xIaEV3s+SiEvKALS
        B2LlNduJXxm8BCzVd6nq+8E=
X-Google-Smtp-Source: AMsMyM5NM8Ob+41DG0FBkvAYtjDNB2Y4hmQC4/wy+TDcNA3sURXm8nAhJ3/oEVv/Ukoc4UOV58FXkQ==
X-Received: by 2002:a63:2ad8:0:b0:46e:bb8e:b343 with SMTP id q207-20020a632ad8000000b0046ebb8eb343mr10999760pgq.408.1667192114710;
        Sun, 30 Oct 2022 21:55:14 -0700 (PDT)
Received: from smtpclient.apple (c-24-6-216-183.hsd1.ca.comcast.net. [24.6.216.183])
        by smtp.gmail.com with ESMTPSA id b3-20020a1709027e0300b00176b3c9693esm3409135plm.299.2022.10.30.21.55.12
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 30 Oct 2022 21:55:13 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3696.120.41.1.1\))
Subject: Re: [PATCH 01/13] mm: Update ptep_get_lockless()s comment
From:   Nadav Amit <nadav.amit@gmail.com>
In-Reply-To: <A48A5CEB-2C02-4101-B315-6792D042C605@gmail.com>
Date:   Sun, 30 Oct 2022 21:55:11 -0700
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Jann Horn <jannh@google.com>,
        John Hubbard <jhubbard@nvidia.com>, X86 ML <x86@kernel.org>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        jroedel@suse.de, ubizjak@gmail.com,
        Alistair Popple <apopple@nvidia.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <DDF26E69-1FFF-40D6-802B-2A5DC5C3D4CE@gmail.com>
References: <20221022111403.531902164@infradead.org>
 <20221022114424.515572025@infradead.org>
 <2c800ed1-d17a-def4-39e1-09281ee78d05@nvidia.com>
 <Y1ZGNwUEdm15W6Xz@hirez.programming.kicks-ass.net>
 <CAG48ez3fG=WnvbiE5mJaD66_gJj_hohnV8CqBG9eNdjd7pJW3A@mail.gmail.com>
 <Y1fsYwshJ93FT21r@hirez.programming.kicks-ass.net>
 <CAG48ez3VE+3dVdUMK+Pg_942gR+h_TCcSaFxGwCbNfh3W+mfOA@mail.gmail.com>
 <Y1f7YvKuwOl1XEwU@hirez.programming.kicks-ass.net>
 <CAG48ez05gBiB2w7bL_3O_OUoBWazmHnRwMiuni_wQyXBUcaxbQ@mail.gmail.com>
 <Y1oub9MvqwGBlHkq@hirez.programming.kicks-ass.net>
 <CAHk-=wihPdOtXgJ32pLB6Xd-UvnaZW9YvOOjM24JGYRjNHeykA@mail.gmail.com>
 <6C548A9A-3AF3-4EC1-B1E5-47A7FFBEB761@gmail.com>
 <CAHk-=wh8oi0qQtYDFTfm7d1s5C8mG7ig=NfzGWt4zbjXMzcdqQ@mail.gmail.com>
 <F9E42822-DA1D-4192-8410-3BAE42E9E4A9@gmail.com>
 <B88D3073-440A-41C7-95F4-895D3F657EF2@gmail.com>
 <CAHk-=wgzT1QsSCF-zN+eS06WGVTBg4sf=6oTMg95+AEq7QrSCQ@mail.gmail.com>
 <47678198-C502-47E1-B7C8-8A12352CDA95@gmail.com>
 <CAHk-=wjzngbbwHw4nAsqo_RpyOtUDk5G+Wus=O0w0A6goHvBWA@mail.gmail.com>
 <CAHk-=wijU_YHSZq5N7vYK+qHPX0aPkaePaGOyWk4aqMvvSXxJA@mail.gmail.com>
 <140B437E-B994-45B7-8DAC-E9B66885BEEF@gmail.com>
 <CAHk-=wjX_P78xoNcGDTjhkgffs-Bhzcwp-mdsE1maeF57Sh0MA@mail.gmail.com>
 <CAHk-=wio=UKK9fX4z+0CnyuZG7L+U9OB7t7Dcrg4FuFHpdSsfw@mail.gmail.com>
 <CAHk-=wgz0QQd6KaRYQ8viwkZBt4xDGuZTFiTB8ifg7E3F2FxHg@mail.gmail.com>
 <CAHk-=wiwt4LC-VmqvYrphraF0=yQV=CQimDCb0XhtXwk8oKCCA@mail.gmail.com>
 <A48A5CEB-2C02-4101-B315-6792D042C605@gmail.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
X-Mailer: Apple Mail (2.3696.120.41.1.1)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Oct 30, 2022, at 9:09 PM, Nadav Amit <nadav.amit@gmail.com> wrote:

> I understand from the code that you decided to drop the deferring of
> set_page_dirty(), which could - at least for the munmap case (where
> mmap_lock is taken for write) - prevent the need for =E2=80=9Cforce_flus=
h=E2=80=9D and
> potentially save TLB flushes.
>=20
> I was just wondering whether the reason for that is that you wanted
> to have small backportable and conservative patches, or whether you
> changed your mind about it.

Please ignore this silly question. I understand - the buffers might =
still be
dropped.=
