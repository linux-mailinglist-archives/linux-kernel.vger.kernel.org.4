Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D3CEC749E4C
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 15:56:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232718AbjGFN45 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 09:56:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbjGFN4z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 09:56:55 -0400
Received: from mail-qt1-x82c.google.com (mail-qt1-x82c.google.com [IPv6:2607:f8b0:4864:20::82c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 611D61BFB
        for <linux-kernel@vger.kernel.org>; Thu,  6 Jul 2023 06:56:51 -0700 (PDT)
Received: by mail-qt1-x82c.google.com with SMTP id d75a77b69052e-401d1d967beso317171cf.0
        for <linux-kernel@vger.kernel.org>; Thu, 06 Jul 2023 06:56:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688651810; x=1691243810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9o4NNAa0hEp40MVI+hiXpvFx+kGwffUnYwX0NvprFrM=;
        b=JnyflN6PUKyqI7ewT3XXEZWRKVLniQMvIuQLxFHC/dmxQ8lwB6HEcKrmIPpGMMDSuU
         jg7QLZ4mpNSokFlOr0Kgh1zJHmOxa8RpU1oiOHtLv23R7R+u+h18wBN+l8GxZfDMZFvC
         B56h3KzPm84Bf28/RdNWAxypmU0KMwM8Bw2kbSII1opUPHq1YC0LPhN7cKyAMDyhEb36
         ialNyHhaq6ZSRxGYMq/a+qGita4ERfSym1AeWkkUM7AIXZPg3etqC93IxawyLeNRKKct
         gjH5T+B7YWlLd7040vFwYE43AWsggser8E/WGSVcA/05/l4XEYT159HB6+5QCavjLe5o
         IzBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688651810; x=1691243810;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=9o4NNAa0hEp40MVI+hiXpvFx+kGwffUnYwX0NvprFrM=;
        b=TX4/Y72HuNGs6WrN3Y3JKs4hrYTl6f5BHXQLMNOBvPh3r/3vkBlxrT2UXxvoI+SldD
         T0cuHkI6yBFnZX8uQZpzALrGYkm9h0e2GSe8IJtlw3XKACJfbbYbjBLu31OgWBRQW+kF
         zjqlkEjJVUNWnDu2GiQ1fj3s9TLpADCR3S9bi5D0Bgz0Y5tfxJv+ciE7zU3J0hbxWbnY
         590xDKkIFz2u8xlhHbFKqI55Q71OtXcl2sAHuWg58BS6IekN82GezUux1/vHR8o02vNC
         UFNVnqUdWn1Zm027QGoiiRjm5tAOat3Q3ylqL68jWGMGryGRxKPuSJE1el954OH9s9UB
         elxw==
X-Gm-Message-State: ABy/qLankegunVy9e6Aw4X6vCKTnDTMWD2zEBj1j0ypzV+H0Y9oU57Ev
        cxHbJBD6ynNGTyemMNGEVNeOX7/pJtqRjxagVBCXfg==
X-Google-Smtp-Source: APBJJlEDtP/lmO1GgVOyh/3iYAbZvHjlNxw50iq/tp7xGY0Dwc7Y+VtoavfKVgkd36e3D4omB4TQ/Kh6tpmFL7Yl9qo=
X-Received: by 2002:ac8:5887:0:b0:3f9:6930:1308 with SMTP id
 t7-20020ac85887000000b003f969301308mr115350qta.13.1688651810098; Thu, 06 Jul
 2023 06:56:50 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com> <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
 <CAA85sZvn04k7=oiTQ=4_C8x7pNEXRWzeEStcaXvi3v63ah7OUQ@mail.gmail.com>
 <ffb554bfa4739381d928406ad24697a4dbbbe4a2.camel@redhat.com>
 <CAA85sZunA=tf0FgLH=MNVYq3Edewb1j58oBAoXE1Tyuy3GJObg@mail.gmail.com>
 <CAA85sZsH1tMwLtL=VDa5=GBdVNWgifvhK+eG-hQg69PeSxBWkg@mail.gmail.com>
 <CAA85sZu=CzJx9QD87-vehOStzO9qHUSWk6DXZg3TzJeqOV5-aw@mail.gmail.com>
 <0a040331995c072c56fce58794848f5e9853c44f.camel@redhat.com>
 <CAA85sZuuwxtAQcMe3LHpFVeF7y-bVoHtO1nukAa2+NyJw3zcyg@mail.gmail.com>
 <CAA85sZurk7-_0XGmoCEM93vu3vbqRgPTH4QVymPR5BeeFw6iFg@mail.gmail.com>
 <486ae2687cd2e2624c0db1ea1f3d6ca36db15411.camel@redhat.com>
 <CAA85sZsJEZK0g0fGfH+toiHm_o4pdN+Wo0Wq9fgsUjHXGxgxQA@mail.gmail.com>
 <CAA85sZs4KkfVojx=vxbDaWhWRpxiHc-RCc2OLD2c+VefRjpTfw@mail.gmail.com>
 <5688456234f5d15ea9ca0f000350c28610ed2639.camel@redhat.com>
 <CAA85sZvT-vAHQooy8+i0-bTxgv4JjkqMorLL1HjkXK6XDKX41w@mail.gmail.com>
 <CAA85sZs2biYueZsbDqdrMyYfaqH6hnSMpymgbsk=b3W1B7TNRA@mail.gmail.com>
 <CAA85sZs_H3Dc-mYnj8J5VBEwUJwbHUupP+U-4eG20nfAHBtv4w@mail.gmail.com>
 <92a4d42491a2c219192ae86fa04b579ea3676d8c.camel@redhat.com>
 <CAA85sZvtspqfep+6rH8re98-A6rHNNWECvwqVaM=r=0NSSsGzA@mail.gmail.com>
 <dfbbe91a9c0abe8aba2c00afd3b7f7d6af801d8e.camel@redhat.com>
 <CAA85sZuQh0FMoGDFVyOad6G1UB9keodd3OCZ4d4r+xgXDArcVA@mail.gmail.com>
 <062061fc4d4d3476e3b0255803b726956686eb19.camel@redhat.com>
 <CAA85sZv9KCmw8mAzK4T-ORXB48wuLF+YXTYSWxkBhv3k_-wzcA@mail.gmail.com>
 <CAA85sZt6ssXRaZyq4awM0yTLFk62Gxbgw-0+bTKWsHwQvVzZXQ@mail.gmail.com>
 <d9bf21296a4691ac5aca11ccd832765b262f7088.camel@redhat.com>
 <CAA85sZsidN4ig=RaQ34PYFjnZGU-=zqR=r-5za=G4oeAtxDA7g@mail.gmail.com>
 <14cd6a50bd5de13825017b75c98cb3115e84acc1.camel@redhat.com>
 <CAA85sZuZLg+L7Sr51PPaOkPKbbiywXbbKzhTyjaw12_S6CsZHQ@mail.gmail.com>
 <c6cf7b4c0a561700d2015c970d52fc9d92b114c7.camel@redhat.com>
 <CAA85sZvZ_X=TqCXaPui0PDLq2pp5dw_uhga+wcXgBqudrLP9bQ@mail.gmail.com> <67ff0f7901e66d1c0d418c48c9a071068b32a77d.camel@redhat.com>
In-Reply-To: <67ff0f7901e66d1c0d418c48c9a071068b32a77d.camel@redhat.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Thu, 6 Jul 2023 15:56:38 +0200
Message-ID: <CANn89i+F=R71refT8K_8hPaP+uWn15GeHz+FTMYU=VPTG24WFA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Paolo Abeni <pabeni@redhat.com>,
        Willem de Bruijn <willemb@google.com>
Cc:     Ian Kumlien <ian.kumlien@gmail.com>,
        Alexander Lobakin <aleksander.lobakin@intel.com>,
        intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 6, 2023 at 3:02=E2=80=AFPM Paolo Abeni <pabeni@redhat.com> wrot=
e:
>
> On Thu, 2023-07-06 at 13:27 +0200, Ian Kumlien wrote:
> > On Thu, Jul 6, 2023 at 10:42=E2=80=AFAM Paolo Abeni <pabeni@redhat.com>=
 wrote:
> > > On Wed, 2023-07-05 at 15:58 +0200, Ian Kumlien wrote:
> > > > On Wed, Jul 5, 2023 at 3:29=E2=80=AFPM Paolo Abeni <pabeni@redhat.c=
om> wrote:
> > > > >
> > > > > On Wed, 2023-07-05 at 13:32 +0200, Ian Kumlien wrote:
> > > > > > On Wed, Jul 5, 2023 at 12:28=E2=80=AFPM Paolo Abeni <pabeni@red=
hat.com> wrote:
> > > > > > >
> > > > > > > On Tue, 2023-07-04 at 16:27 +0200, Ian Kumlien wrote:
> > > > > > > > More stacktraces.. =3D)
> > > > > > > >
> > > > > > > > cat bug.txt | ./scripts/decode_stacktrace.sh vmlinux
> > > > > > > > [  411.413767] ------------[ cut here ]------------
> > > > > > > > [  411.413792] WARNING: CPU: 9 PID: 942 at include/net/ud  =
   p.h:509
> > > > > > > > udpv6_queue_rcv_skb (./include/net/udp.h:509 net/ipv6/udp.c=
:800
> > > > > > > > net/ipv6/udp.c:787)
> > > > > > >
> > > > > > > I'm really running out of ideas here...
> > > > > > >
> > > > > > > This is:
> > > > > > >
> > > > > > >         WARN_ON_ONCE(UDP_SKB_CB(skb)->partial_cov);
> > > > > > >
> > > > > > > sort of hint skb being shared (skb->users > 1) while enqueued=
 in
> > > > > > > multiple places (bridge local input and br forward/flood to t=
un
> > > > > > > device). I audited the bridge mc flooding code, and I could n=
ot find
> > > > > > > how a shared skb could land into the local input path.
> > > > > > >
> > > > > > > Anyway the other splats reported here and in later emails are
> > > > > > > compatible with shared skbs.
> > > > > > >
> > > > > > > The above leads to another bunch of questions:
> > > > > > > * can you reproduce the issue after disabling 'rx-gro-list' o=
n the
> > > > > > > ingress device? (while keeping 'rx-udp-gro-forwarding' on).
> > > > > >
> > > > > > With rx-gro-list off, as in never turned on, everything seems t=
o run fine
> > > > > >
> > > > > > > * do you have by chance qdiscs on top of the VM tun devices?
> > > > > >
> > > > > > default qdisc is fq
> > > > >
> > > > > IIRC libvirt could reset the qdisc to noqueue for the owned tun
> > > > > devices.
> > > > >
> > > > > Could you please report the output of:
> > > > >
> > > > > tc -d -s qdisc show dev <tun dev name>
> > > >
> > > > I don't have these set:
> > > > CONFIG_NET_SCH_INGRESS
> > > > CONFIG_NET_SCHED
> > > >
> > > > so tc just gives an error...
> > >
> > > The above is confusing. AS CONFIG_NET_SCH_DEFAULT depends on
> > > CONFIG_NET_SCHED, you should not have a default qdisc, too ;)
> >
> > Well it's still set in sysctl - dunno if it fails
> >
> > > Could you please share your kernel config?
> >
> > Sure...
> >
> > As a side note, it hasn't crashed - no traces since we did the last cha=
nge
>
> It sounds like an encouraging sing! (last famous words...). I'll wait 1
> more day, than I'll submit formally...
>
> > For reference, this is git diff on the running kernels source tree:
> > diff --git a/net/core/skbuff.c b/net/core/skbuff.c
> > index cea28d30abb5..1b2394ebaf33 100644
> > --- a/net/core/skbuff.c
> > +++ b/net/core/skbuff.c
> > @@ -4270,6 +4270,17 @@ struct sk_buff *skb_segment_list(struct sk_buff =
*skb,
> >
> >         skb_push(skb, -skb_network_offset(skb) + offset);
> >
> > +       if (WARN_ON_ONCE(skb_shared(skb))) {
> > +               skb =3D skb_share_check(skb, GFP_ATOMIC);
> > +               if (!skb)
> > +                       goto err_linearize;
> > +       }
> > +
> > +       /* later code will clear the gso area in the shared info */
> > +       err =3D skb_header_unclone(skb, GFP_ATOMIC);
> > +       if (err)
> > +               goto err_linearize;
> > +
> >         skb_shinfo(skb)->frag_list =3D NULL;
> >
> >         while (list_skb) {
>
> ...the above check only, as the other 2 should only catch-up side
> effects of lack of this one. In any case the above address a real
> issue, so we likely want it no-matter-what.
>

Interesting, I wonder if this could also fix some syzbot reports
Willem and I are investigating.

Any idea of when the bug was 'added' or 'revealed' ?
