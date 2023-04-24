Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A4876D5493
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 00:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233718AbjDCWOe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 18:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233471AbjDCWOc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 18:14:32 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A40B26A1
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 15:14:30 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id ew6so123051096edb.7
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 15:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=isovalent.com; s=google; t=1680560069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=I2gU0xPDdb0K1FdwRxRILyU2Pj+Ds548w8HpDbFE5RI=;
        b=Z3NoYUpuN+51H4YiZ+UYdsc87GFYIQAyh0NSDMG3zS8LomdR8E6aRi5E3S2QdnrBb/
         kjJIHm4IDH/Dj6cbTU7p9/qUFM4kYQSdN5SVTjL+KqSXSUlNP7qimcsU97bKdXIY9Rs4
         vToz6xxm5tqyKeXovpsrjRyG1yGl5SHXsHE5QKphWSICeqHV56OBzlRXGs7E1S0heM+f
         xjGQ8RewuNiyTV2gBrN3/HoBEcGcYzZYUaIHUrynX5B6VqlRyO6ek4HhVE7BYnr53FbU
         4fG9hlG1x8/596/5W6OtaOCOH2VT3OrODJo0B4feYHD5cLkjOy+ZpxQXP5U0CEhveQBu
         XRNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680560069;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=I2gU0xPDdb0K1FdwRxRILyU2Pj+Ds548w8HpDbFE5RI=;
        b=jLK0OboWyo9PXS9/RsEBHDqO1o299Kkp6GlKo9MGty6CCuuFVoPeR9XWhTHgE8bRdI
         v6ZeIivMWE0bRWoitZP8uJVEqKN17z6ilRS1GsfkbeHUbWgotXDsrlJl+MamR4NVdBvw
         r6AjfzLA7WSas6QH23WAVCDbddUjtVMsKLxAqePnmYyICCzIZqXvXYDrKwV+JLHnhuCh
         RoAAPDUOqKpYKQNX8w4wYxMMNcEjBZnmxs+6RSklB0xGeH7B0juthEnz7ufLAeZfQ/NV
         R2ou/ZTKxMpzkjmpV4cfH8kCZNwHLy0nFDYPzcIc5yHAO68e4Y233BVA9nn7bYe4vXNy
         0mbQ==
X-Gm-Message-State: AAQBX9dskAbi53KAeWzv9MMVlhBfjtJPUwwMJlABZgjxrnQ5dlQqtAT+
        LFYDxpP7nITEOoKXc22uezGuIo07oiQnocyY4rUyQQ==
X-Google-Smtp-Source: AKy350YZ1CZ0S5BzS52EaZnwqGrMGvgVImHG39BdJiwjlssHdwEMxh/stb+LlVhPZyYrsD8ZkSJhQYiO+WNXK1nF+ZI=
X-Received: by 2002:a17:906:b55:b0:93f:82cb:fe44 with SMTP id
 v21-20020a1709060b5500b0093f82cbfe44mr114553ejg.11.1680560068875; Mon, 03 Apr
 2023 15:14:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230401200651.1022113-2-joe@isovalent.com> <202304022107.IwHc05cs-lkp@intel.com>
 <ZCpK5wOI0ZEedhrr@debian.me> <ZCqTMq3sHMrx2boI@mail.gmail.com>
In-Reply-To: <ZCqTMq3sHMrx2boI@mail.gmail.com>
From:   Joe Stringer <joe@isovalent.com>
Date:   Mon, 3 Apr 2023 15:14:17 -0700
Message-ID: <CADa=Ryw2BNupx9GH8cMTKLbgTZD6sLLAHdsmwr0AiEwa9DOsZA@mail.gmail.com>
Subject: Re: [PATCH bpf-next v4 2/2] docs/bpf: Add LRU internals description
 and graph
To:     Maxim Mikityanskiy <maxtram95@gmail.com>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        kernel test robot <lkp@intel.com>, bpf@vger.kernel.org,
        oe-kbuild-all@lists.linux.dev, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, ast@kernel.org, corbet@lwn.net,
        martin.lau@linux.dev, john.fastabend@gmail.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I can reproduce this issue, will fix it up.

$ dot -V
dot - graphviz version 2.43.0 (0

On Mon, Apr 3, 2023 at 1:49=E2=80=AFAM Maxim Mikityanskiy <maxtram95@gmail.=
com> wrote:
>
> On Mon, 03 Apr 2023 at 10:41:27 +0700, Bagas Sanjaya wrote:
> > On Sun, Apr 02, 2023 at 09:47:49PM +0800, kernel test robot wrote:
> > > All warnings (new ones prefixed by >>):
> > >
> > > >> Warning: Orthogonal edges do not currently handle edge labels. Try=
 using xlabels.
> > >
> >
> > Hi,
> >
> > I can't reproduce the warning above. My system has graphviz 2.42.2
> > installed (via Debian package). What graphviz version do kernel test
> > robot have?
>
> I have the same warning on Arch Linux.
>
> $ dot --version
> dot - graphviz version 7.1.0 (0)
