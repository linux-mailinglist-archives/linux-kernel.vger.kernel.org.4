Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8B2474D3CD
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 12:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233482AbjGJKl4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 06:41:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231531AbjGJKln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 06:41:43 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 228FC123;
        Mon, 10 Jul 2023 03:41:40 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bc379e4c1cbso5508563276.2;
        Mon, 10 Jul 2023 03:41:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688985700; x=1691577700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bmQLilPsv1+o9dpVfU0n6GqcdjgC09j/u6QpTRFz0XI=;
        b=eI+SBvrLFuHf0wip9WUKMldMlxbIbs+8sW6XDIrDv0sY1ImWgCaMCm8KgR2EYyn/J8
         uAOtq72v8B9TAE+cAcZ+3T9uARSm85IydeVZXfJqxsYaWXAOyWjPMKMUDixkAhST5IW4
         1aJABnzIgbhpB/x+fcRYCGzoYVSsObCUSBGpCUfJT+S1NSxBgJN12REwe7086pxNt5WG
         eN6J0YpQtgi0VVjQvx6AdmljzBjj6ANcJhaz99vz9CNTwtaTSaMe0CJUviwR5TbxFylT
         wcmL7DHYnuGT9bzNT2gU1aDJhQoszCaIPL/alEFp9lvzw5Cwaq8p7Adj0QKl/kTkDi7a
         9Xeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688985700; x=1691577700;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bmQLilPsv1+o9dpVfU0n6GqcdjgC09j/u6QpTRFz0XI=;
        b=QnEVTVkLXLZYFsPFf2O1YryW7w53dY1mPCL2CKYYGjuk3CvU8OlY+4yRKJi+ZsxEN6
         atzLuDYFQwtU3nHnHR59DRT0GnLfdjjbJzljJ9aHO2lNljS5qEaL+lUNJypCNNdNYwEZ
         fvlLKgRAeHKHgohJ24XMSSqVW81fnOEbkubU+NKN332wiUHqeeM4wK9+ZIzsOEy+8YKe
         kspB8haI1bxeop0jUUsDxQ9i94myMB/halsUEPhK0QzcsK8j+yiS5yTqTeHdYsnotEdd
         mq0LvEfawIr01kFeAmvuntLbSXuEjZU+jEiF1w0lTBDaeZQKfBWQCp0qefzJwGg3cA5C
         LG8Q==
X-Gm-Message-State: ABy/qLZ+ALLtz33suGWEheOlyvYuJwg9dWhQ2z4onO1IkNzcR+KKboSR
        L1JvVVGGmJWNANW1wlnYTbvOfQNTx3oDDaHk8Wa6t2EAKco=
X-Google-Smtp-Source: APBJJlGNVqWENF241nOZK+8gNRzOgayLH8nUDuN8QOMR7IHHOlCkSJYX0vv5Ou9qYsGOwoG4N5nb3y4P0BrTJfSSLSo=
X-Received: by 2002:a25:4c85:0:b0:c24:4536:1723 with SMTP id
 z127-20020a254c85000000b00c2445361723mr12260167yba.26.1688985699969; Mon, 10
 Jul 2023 03:41:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230710172602.05d32c03@canb.auug.org.au> <CANiq72npQiWMebvYTu8Z+XuJAyUH6-iygGtbF9V6y+R2aD1-vw@mail.gmail.com>
 <20230710182229.36bcf79d@canb.auug.org.au>
In-Reply-To: <20230710182229.36bcf79d@canb.auug.org.au>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 10 Jul 2023 12:41:29 +0200
Message-ID: <CANiq72mb5Rryeh-q9J+jZX1doHjUK+13yim3=Rrm-2j87dzQVg@mail.gmail.com>
Subject: Re: linux-next: branches to be removed
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        David Howells <dhowells@redhat.com>,
        Gabriel Krisman Bertazi <krisman@collabora.com>,
        Leo Li <leoyang.li@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Miguel Ojeda <ojeda@kernel.org>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vineet Gupta <vgupta@kernel.org>,
        NetFilter <netfilter-devel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 10, 2023 at 12:16=E2=80=AFPM Stephen Rothwell <sfr@canb.auug.or=
g.au> wrote:
>
> I have resurrected it.  You might consider just resetting the branch to
> something recent in Linus' tree.

Done, thanks!

Cheers,
Miguel
