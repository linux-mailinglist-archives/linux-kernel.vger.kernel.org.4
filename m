Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC646C13A0
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231320AbjCTNjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:39:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231425AbjCTNi5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:38:57 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAA7C25E27
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:38:27 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id y14so10384954wrq.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679319506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=51uVJkyDalBaEbq0Zr1Qk2lA5Oa+MTvPoyiLzc1llIo=;
        b=nhasUHpFJPxVNmsU6YfL1uZpowS+Py5R20L9AFDutR02F9olSs2zd8Ffh89QfssGv0
         eOIDPccFzSdivxdpcsK3z4nTZ6EszJQ9oJhnbnHxDgfRtNYh08EBpk/fbT1vDTi2YnRy
         eQiKUDKQMHldEqESLa7DsZgNlV3TU5e6j60WW5Lpe5LtKFJMtgJdx6oUTw582olXKrw2
         JnGtKtvdkgAiyhNmiQk1PKW11e6L2oixZZL4ld++dUCdity3udyQxwDsVFm7iGMd+S8F
         Qq9q354lxuehDk/FYJhSFjp0KHufJZ+rMhAt3kQin/74NLTOqPWF3UccJ6nQHwcbigH8
         DDUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679319506;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=51uVJkyDalBaEbq0Zr1Qk2lA5Oa+MTvPoyiLzc1llIo=;
        b=w5GsNDfIUzjoEky9Fo+Y1iNtR6Hfxn1/R76Wnj0RD6CJs+TI+X3DPgtSd1q50fit+v
         3fPfefxtJLONVf/Z5V9G4SvftUAmo0oHXSnxFZusx/seu5jQZ1jd++WXTUaRay+MR9C/
         ZUwpe9uonMPV7dTjhuGPRg1xOZvfRAWWpMv5l7ELD7s8wn5EvGOWn0eRHVin5tT8TmDc
         I79eKM/barKNKYhTsGyS9d69PI9mkcU/vjo3LKUMnAA9Tq340NChPRbXbSZ548BXmPnT
         AXOvW2o0+xgLe9tHiwwsLvcGkd3PbWmylIS+NW+gP8pxDqcYrHqSu9p9zNxd+fVmvsDw
         xqyA==
X-Gm-Message-State: AO0yUKVoBtmiXzdynnLThIMSi+btG/XoRoqbKgijOOV3HqZ/YFJa//+A
        0tbmJiRx3eRd8QHcUNxBEhk=
X-Google-Smtp-Source: AK7set9dxahlNH0DGyVFe9/275dtO0/1JI4UTKq43T21QYcGw218o0XVMUU6mRcx6Rjjkw1DubpEgA==
X-Received: by 2002:adf:eb0f:0:b0:2d6:6af:4891 with SMTP id s15-20020adfeb0f000000b002d606af4891mr4374015wrn.3.1679319506046;
        Mon, 20 Mar 2023 06:38:26 -0700 (PDT)
Received: from suse.localnet (host-79-35-102-94.retail.telecomitalia.it. [79.35.102.94])
        by smtp.gmail.com with ESMTPSA id y16-20020a5d4ad0000000b002d51d10a3fasm5668309wrs.55.2023.03.20.06.38.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 06:38:25 -0700 (PDT)
From:   "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
To:     Khadija Kamran <kamrankhadijadj@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] staging: axis-fifo: initialize timeouts in init only
Date:   Mon, 20 Mar 2023 14:38:24 +0100
Message-ID: <3180435.l52yBJDM9G@suse>
In-Reply-To: <ZBf+XDN8GM0xDDCq@khadija-virtual-machine>
References: <ZBN3XAsItCiTk7CV@khadija-virtual-machine> <2222576.3ZeAukHxDK@suse>
 <ZBf+XDN8GM0xDDCq@khadija-virtual-machine>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset="iso-8859-1"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On luned=EC 20 marzo 2023 07:34:04 CET Khadija Kamran wrote:
> On Fri, Mar 17, 2023 at 11:29:25AM +0100, Fabio M. De Francesco wrote:
> > Khadija,
> >=20
> > Congratulations for having your first patch in Linux, via Greg's staging
> > tree.
> >=20
> > It will take some time before it reaches mainline, although it is alrea=
dy=20
on
> > its way to get upstream.
>=20
> Thank you! :)
>=20
> > On gioved=EC 16 marzo 2023 21:09:00 CET Khadija Kamran wrote:
> > > Initialize the module parameters, read_timeout and write_timeout once=
 in
> > > init().
> > >=20
> > > Module parameters can only be set once and cannot be modified later, =
so=20
we
> > > don't need to evaluate them again when passing the parameters to
> > > wait_event_interruptible_timeout().
> >=20
> > Greg made you (and indirectly me notice) that the statement above is a=
=20
kind
> > of short-circuit because it misses to make the readers notice that you =
are
> > dealing with specific permissions granted to these two module's=20
parameters.
> >=20
> > Please take a look at the permissions associated with those parameters:
> >=20
> > module_param(write_timeout, long, 0444);
> > module_param(read_timeout, long, 0444);
> >=20
> > Can you understand what '0444' stands for? What if their permissions we=
re
> > instead something like '0666' or '0664'?
>=20
> Hey Fabio!
>=20
> I understand that 0444 shows read permissions only.

Yes, correct.

Only "read" permissions for owner, group, others.
Obviously, when the module is initialized, "insmod" can pass actual values =
to=20
the arguments. The point is that from that moment onward nobody is allowed =
to=20
change the initial values associated with this variables, but they can stil=
l=20
be read at will.

> I am trying to make sense of this. As the permissions do not allow
> write, so the value cannot be configured afterwards.

Yes, if with "afterwards" you are intending after they are set at insmod ru=
ns.=20

> Instead of saying 'cannot be modified later', we should talk more about
> permissions here too.

I'm confused by this statement. Can you please rephrase?

> Am I getting it right?

Not sure, it depends on what you meant with the previous phrase.
=20
> Thank you!
>=20
> Regards,
> Khadija

You're welcome!

So, thanks for working on this patch as long as it takes to get it done.=20

I think the lesson to be learned is that in our community there are barrier=
s=20
to the entry of substandard products and therefore people have to do their=
=20
best if they really want to see their work applied.

These tasks are not for the "faints of heart" :-)

=46abio



