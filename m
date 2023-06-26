Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD8973EC63
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 23:02:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230234AbjFZVBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 17:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230231AbjFZVBw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 17:01:52 -0400
Received: from mail-lj1-x234.google.com (mail-lj1-x234.google.com [IPv6:2a00:1450:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DEC0D9;
        Mon, 26 Jun 2023 14:01:51 -0700 (PDT)
Received: by mail-lj1-x234.google.com with SMTP id 38308e7fff4ca-2b69f958ef3so26601011fa.1;
        Mon, 26 Jun 2023 14:01:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687813309; x=1690405309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=jEzlsaUmZXPnWU2Adei6SoQasb2UVBNAtJg+OJameMI=;
        b=cTYOGQnpwPMCPf3IJICbOnspn9is3TyiDc38a9Hmvy5OCHC/oSXJXVz5Yppiv+bg6e
         R8uX0qvBmRpj/Tln1Td5thtDGArJZnrUFIHqEA+FWXbBjYIyOom9P0hIIx69MB1gsAQ5
         GgdNSK90BiYfX0JJf3NyxI9TInUzrzVT46b0f5fml2w5kTWyqBDL9uFCNIRAPxxOYBO6
         ARseH4ugXCbu4LKdhtPEOtE/+WyOQvPItfO1l2vnIRKGMN97boUnKRzmsnAmmkNtBrAl
         L/FvgouoyHFyhsWAvBXl5RYbqd31q84ZKNu1btwBYafj2bu5Eg0oNWZ9ideMdGxcq4O+
         IxkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687813309; x=1690405309;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jEzlsaUmZXPnWU2Adei6SoQasb2UVBNAtJg+OJameMI=;
        b=Uq89FFBtPjtPMff2nX2zyQ9M3EkQKTDOrjEj2lE5/r3bT/09zNHSGvPi92MVGLlYPk
         tI72EZINwbMXZvF5yESOnUSlNmuGfN8/Cl0tiAIAmChBzgsq7xI+0XgkWgZcZ3MN6Nqc
         jyY5hHpaTcb6+X91L3vqNVJwx+L05tzjLgc88tNouJaY97imw2jKJlwCf3PmFhBad2L1
         feh927MIipEJsAtp74GrORMj3PFNNlo3mrHFO6NDYpIKS+qPVxq6KPezuWMTXpC+XFU2
         c9tmhrxApJJQ9GklziwkDk0/ooFj79POM2wcttFpRAB1MhJ8m4lnmpoDTtDgUzmMWtlh
         r7Vw==
X-Gm-Message-State: AC+VfDytS/O+ey7QaqtbB5T3G7av7O4YvLlXUxBSehjWgq6LRX7K3bHZ
        OQedixoVPy3JwEcQEGms+BY3+6xIHpB987gqSUk=
X-Google-Smtp-Source: ACHHUZ7xKMNm6A1vIDbxhQP9GjPBJ+rANHnqBKz1mGtMsQWZx2HxYp/X48ttGDtA/xHvUTMceGFdUfUwG3KCuchNAeU=
X-Received: by 2002:a2e:83d0:0:b0:2b4:792d:a4b5 with SMTP id
 s16-20020a2e83d0000000b002b4792da4b5mr13512330ljh.33.1687813309269; Mon, 26
 Jun 2023 14:01:49 -0700 (PDT)
MIME-Version: 1.0
References: <3101881.1687801973@warthog.procyon.org.uk> <CAOi1vP_g70kV_YFjHNoS1hHPpCiMxW1hTfm92Ud35ehYrmv=1Q@mail.gmail.com>
 <3109248.1687812255@warthog.procyon.org.uk>
In-Reply-To: <3109248.1687812255@warthog.procyon.org.uk>
From:   Ilya Dryomov <idryomov@gmail.com>
Date:   Mon, 26 Jun 2023 23:01:37 +0200
Message-ID: <CAOi1vP8nbP93SyjhN4uJDaKEFKmsBcOKH6iGjpt3Qbj8n7CapQ@mail.gmail.com>
Subject: Re: [PATCH net-next] libceph: Partially revert changes to support MSG_SPLICE_PAGES
To:     David Howells <dhowells@redhat.com>
Cc:     netdev@vger.kernel.org, Xiubo Li <xiubli@redhat.com>,
        Jeff Layton <jlayton@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, Jens Axboe <axboe@kernel.dk>,
        Matthew Wilcox <willy@infradead.org>,
        ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Mon, Jun 26, 2023 at 10:44=E2=80=AFPM David Howells <dhowells@redhat.com=
> wrote:
>
> Ilya Dryomov <idryomov@gmail.com> wrote:
>
> >   if (sendpage_ok(bv.bv_page))
> >           msg.msg_flags |=3D MSG_SPLICE_PAGES;
> >   else
> >           msg.msg_flags &=3D ~MSG_SPLICE_PAGES;
>
> Hmmm...  I'm not sure there's any guarantee that msg, including msg_flags=
,
> won't get altered by ->sendmsg().

If this is indeed an issue, do_sendmsg() should be fixed too.  I would
like to avoid having do_try_sendpage() do one thing and do_sendmsg() do
something subtly different.

But then, even with the current patch, only msg_flags is reinitialized
on the next loop iteration, not the entire message.  Should the entire
message be reinitialized?

Thanks,

                Ilya
