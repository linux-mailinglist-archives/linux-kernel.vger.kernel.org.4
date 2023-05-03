Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EF426F4FCE
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 07:57:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229536AbjECF5g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 01:57:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjECF5e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 01:57:34 -0400
X-Greylist: delayed 121 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 02 May 2023 22:57:31 PDT
Received: from sender4-op-o12.zoho.com (sender4-op-o12.zoho.com [136.143.188.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE74C1FE3
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 22:57:31 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1683093311; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=dXf/z6T3UZCv+texqamhmD8WP+ySIcT8+mX4YjiIwp3ksH9l0AwHJk8exPIQpHv7jxwD8ih2IvKeQdgbN7/aIMh6cSLiq9yFMvach4NLaSsApwH4pZ79Q2dE0+er7wR8oM0z2HkDB9VxsElDfNJtDa9rl+ZUjobX2pOtsJ0Diww=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1683093311; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=+NVmQ6ZP5n0PV0Ca3kCz5g0tcHZhKEg4OMuMhJVciXo=; 
        b=d8GGDXSgdeCo9x8iwJmIJfyukfwY7iqH0LnTqzC16YA1CoGVSlhBklln2AdM9KEc5ca/Yi3ptNEPwzy284mhy9oszNQCm6Ji0VSfNDknSlc+YrZsB9L2raREkFA1oRcVNWilra5ZsrcHoTGzJnQFVLAZZlLfvFzrbk1dBs3TA7g=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=icenowy.me;
        spf=pass  smtp.mailfrom=uwu@icenowy.me;
        dmarc=pass header.from=<uwu@icenowy.me>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1683093311;
        s=zmail; d=icenowy.me; i=uwu@icenowy.me;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:In-Reply-To:References:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=+NVmQ6ZP5n0PV0Ca3kCz5g0tcHZhKEg4OMuMhJVciXo=;
        b=aPZBAYz49O8UFO+n13fU7Y1tnR+1aqUzikkCGb3bNVs3K5wJ+dIO9xKWfXrZEmEi
        VADEEVxnyWF1cOA9wcYwh9LNwCHEw/uPJ+GGyy748NgKPPGDdg9nSFE6r4i3JzM1Dpc
        nNT4E/mgjrp1NSLxil87xo/nL/5qM0Wzlt85Wi4Q=
Received: from edelgard.fodlan.icenowy.me (120.85.97.113 [120.85.97.113]) by mx.zohomail.com
        with SMTPS id 1683093310083649.8294996152783; Tue, 2 May 2023 22:55:10 -0700 (PDT)
Message-ID: <8bb0baa57a92a778a83618e1f4de8f28f4a15ee0.camel@icenowy.me>
Subject: Re: Atish is looking at the excessive bouncing
From:   Icenowy Zheng <uwu@icenowy.me>
To:     Atish Patra <atishp@atishpatra.org>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>
Cc:     linux-riscv@lists.infradead.org
Date:   Wed, 03 May 2023 13:55:00 +0800
In-Reply-To: <CAOnJCULybsPrygGe6easQUgFTXOSUFQ+nOPEYp57F-vkvhuHLQ@mail.gmail.com>
References: <mhng-f3c5429e-4361-4068-b88c-fb528681881a@palmer-ri-x1c9a>
         <CAOnJCULybsPrygGe6easQUgFTXOSUFQ+nOPEYp57F-vkvhuHLQ@mail.gmail.com>
Organization: Anthon Open-Source Community
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=E5=9C=A8 2023-05-03=E6=98=9F=E6=9C=9F=E4=B8=89=E7=9A=84 00:00 +0530=EF=BC=
=8CAtish Patra=E5=86=99=E9=81=93=EF=BC=9A
> On Tue, May 2, 2023 at 11:17=E2=80=AFAM Palmer Dabbelt <palmer@rivosinc.c=
om>
> wrote:
> >=20
> > We're not sure what happened, but it looks like a lot of people are
> > getting dropped from the list due to excessive bounces.=C2=A0 Seems to
> > have
> > started recently, possibly today or over the weekend.=C2=A0 We've alway=
s
> > had
> > some issues with the bounces, but they're a lot worse.
> >=20
>=20
> All the bounces are related to the gmail server which treats genuine
> patches as bounce messages.
> mailman server disables the membership if it gets too many bounce
> backs from the recipient.
> It seems the mailman server can't do much about it until the issue is
> fixed in the gmail server.
> We have increased the bounce threshold significantly in order to
> avoid
> disabling subscriptions.
> If you still get one, please reenable it manually. You should receive
> one reminder email for that as well.
> There is no other solution at this time. Sorry for the inconvenience.

Well, by the way, my mail server (Zoho), is also always receiving
bounce reminder.

I don't know how this happens yet.

>=20
> I have included the broader kernel mailing list in the hope to see if
> anybody else is also facing similar problems.
> It would be great if anybody working for the Google/gmail team can
> raise this issue internally.
>=20
> > Sorry for the headaches.
> >=20
> > _______________________________________________
> > linux-riscv mailing list
> > linux-riscv@lists.infradead.org
> > http://lists.infradead.org/mailman/listinfo/linux-riscv
>=20
>=20
>=20

