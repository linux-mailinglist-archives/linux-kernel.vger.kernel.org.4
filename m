Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B70AD73D0A4
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Jun 2023 13:48:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231626AbjFYLrp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Jun 2023 07:47:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjFYLro (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Jun 2023 07:47:44 -0400
Received: from mail-qk1-x733.google.com (mail-qk1-x733.google.com [IPv6:2607:f8b0:4864:20::733])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E019D10F;
        Sun, 25 Jun 2023 04:47:41 -0700 (PDT)
Received: by mail-qk1-x733.google.com with SMTP id af79cd13be357-7653bd3ff2fso282572485a.3;
        Sun, 25 Jun 2023 04:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687693661; x=1690285661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c/zIdMgibt6Rs/eVUkJc6EtzUxpltNjY8BEXzWVE6r4=;
        b=Pq/yaM/NHHf3k+B+mLMoL/LQC1Ch+2DExIKcJBYd8G1nHb4CW1mznz1zswjTc+j+HW
         G8NdO0odECgFPE8iMUBL1b337E2x/2a3LPtfI7YK8USEHK7CsOhBmIysZKYPpQYt1LRe
         VDvc3BFG8SjnmdJlj54+UaKHl6WSOnD9t1GotYFCPjDcrnoTtqnZCqjkIHYV9vEphUS7
         +0ntv2afgzibegTaas4BH6hIE9dqVEm4s+ZfN/q1i/X2tarhRzbQqnhAFH/K5b303o8G
         kmxrY2lKLEfnS0uYfl58QIMWuK3QZzoQ0NucnveeVaiiE5w3xXCqgexzzrrkX4zfUanS
         FQDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687693661; x=1690285661;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=c/zIdMgibt6Rs/eVUkJc6EtzUxpltNjY8BEXzWVE6r4=;
        b=jdPohGGvjhFs9JGcfIOCPV09ryVhSOuU4kVbMp426eoDmCq/6ZBab4Uan2W5onvGvj
         EAME45+ty1l820e55rlw4OAUK3+I7Gg2waeOg8RmqY0D72+LxDldlR1OYHonNVk8lvEn
         q9LCyo7WDCLcDqLbShcBbnYinR6MKHA2A9qkf86yNdpGkY6Z4xwGdP/Swv5OwVOgZZkh
         Poih+ZoRX/WzwLz8Fgv2KZ0YQ/i47dAi7yjVf2HJUicT/bV9wbarIsdAsypc2WCphsbB
         G56GSz8WPD2CzmiCUYEqYQYtjQr6v7f2pX8uhKmAOwLREpOR7E6JscjX7WJCUSPHqCUq
         tEcA==
X-Gm-Message-State: AC+VfDy/xz0Dhq9rzjUlbxrG8EWjGdwP3TBED6At6BY6i4rsQU/5frWW
        CM4tUnkXVypE94UZDwn4bhFpC3LPW/huK5wq8WBIRfEs5+ksmg==
X-Google-Smtp-Source: ACHHUZ63XVM76rbQHOhItSLn94Sc5AW2syMsyYALHyPzgwEwhHZBAk/FRHb4liV6UqwcnLc6rmCVj4dOYevFAiRIsNw=
X-Received: by 2002:a05:620a:880f:b0:75b:23a1:363d with SMTP id
 qj15-20020a05620a880f00b0075b23a1363dmr17571873qkn.78.1687693660920; Sun, 25
 Jun 2023 04:47:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
 <20230621191302.1405623-2-paweldembicki@gmail.com> <27e0f7c9-71a8-4882-ab65-6c42d969ea4f@lunn.ch>
 <CACRpkdZ514z3Y0LP0iqN0zyc5Tgo7n8O3XHTNVWC0BrnPPjM2w@mail.gmail.com> <20230625112128.3vyvcuvypbkxuz3q@skbuf>
In-Reply-To: <20230625112128.3vyvcuvypbkxuz3q@skbuf>
From:   =?UTF-8?Q?Pawe=C5=82_Dembicki?= <paweldembicki@gmail.com>
Date:   Sun, 25 Jun 2023 13:47:31 +0200
Message-ID: <CAJN1KkxahD-Rh+77NRJnkUwvZY547f06ZoThmoqSp8SBs3mnnA@mail.gmail.com>
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set function
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Andrew Lunn <andrew@lunn.ch>, netdev@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
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

niedz., 25 cze 2023 o 13:21 Vladimir Oltean <olteanv@gmail.com> napisa=C5=
=82(a):
>
> On Wed, Jun 21, 2023 at 11:27:14PM +0200, Linus Walleij wrote:
> > On Wed, Jun 21, 2023 at 9:33=E2=80=AFPM Andrew Lunn <andrew@lunn.ch> wr=
ote:
> >
> > > > +     struct vsc73xx *vsc =3D ds->priv;
> > > > +     /* FIXME: STP frames isn't forwarded at this moment. BPDU fra=
mes are
> > > > +      * forwarded only from to PI/SI interface. For more info see =
chapter
> > > > +      * 2.7.1 (CPU Forwarding) in datasheet.
> > >
> > > Do you mean the CPU never gets to see the BPDU frames?
> > >
> > > Does the hardware have any sort of packet matching to trap frames to
> > > the CPU? Can you match on the destination MAC address
> > > 01:80:C2:00:00:00 ?
> >
> > The hardware contains an embedded Intel 8054 CPU that can
> > execute programs to do pretty much anything.
> >
> > The bad news: it requires a custom SDK thingy that we do not
> > have access to.
> >
> > So far we used the chips in a bit of vanilla mode, which is all I
> > have ever seen in the systems we have and it can't do much,
> > not even add a helpful frame tag, but as can be seen from the
> > patches it can do VLAN...
> >
> > Yours,
> > Linus Walleij
>
> But even without involving the iCPU, it should be possible to inject/extr=
act
> control packets over the SI interface, using the CPU_CAPT and CPUTXDAT bl=
ock
> registers, correct?

Yes , It should work with CPU_CAPT and CPUTXDAT.

>
> IIUC, ocelot with tag_8021q does just that for STP and PTP, see
> ocelot_port_inject_frame() and ocelot_xtr_poll_frame().

I was planning to do it in the next step after making this driver
however usable.

--
Pawel Dembicki
