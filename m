Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82DFF715837
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:19:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230213AbjE3ITK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:19:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230070AbjE3ITE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:19:04 -0400
Received: from aposti.net (aposti.net [89.234.176.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75F5B9D;
        Tue, 30 May 2023 01:19:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=crapouillou.net;
        s=mail; t=1685434738;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cndrBEvjoH1OeoZKeuFmD3TUrxxCWmRRuavFehVpiWY=;
        b=TT/23ooijGYmeBgg9uNwMITdnarWa/ig/g4ZSbKScrFBjNQgY+1azzKkhHYpdU7nkt4OX5
        zOauVwdS0FCM3twOBJO5Ze9ofADGEYy2wOujWu9pCsJlO21sIm24UddOP4ore74R+7PQdj
        Y48fy2eOcIU6PT3+8jl9p43imOFS5lA=
Message-ID: <45a42e25658393e3767071960214b0ff47f0737b.camel@crapouillou.net>
Subject: Re: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and
 M5150
From:   Paul Cercueil <paul@crapouillou.net>
To:     "Maciej W. Rozycki" <macro@orcam.me.uk>,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Cc:     linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Date:   Tue, 30 May 2023 11:18:56 +0300
In-Reply-To: <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
References: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
         <alpine.DEB.2.21.2305300321520.25569@angie.orcam.me.uk>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maciej,

Le mardi 30 mai 2023 =C3=A0 09:03 +0100, Maciej W. Rozycki a =C3=A9crit=C2=
=A0:
> On Mon, 29 May 2023, Jiaxun Yang wrote:
>=20
> > M5150 and P5600 are two MIPS32R5 kernels, however as MIPS32R5 is
> > backward compatible with MIPS32R2 there is no reason to forbid
> > M5150 and P5600 on MIPS32R2 kernel.
>=20
> =C2=A0What problem are you trying to solve?=C2=A0 The CONFIG_SYS_HAS_CPU_=
*
> settings=20
> denote overall platform's support for the given CPU and have nothing
> to do=20
> with what architecture level a given kernel has been configured for.=C2=
=A0
> You=20
> do need to get the settings right for your platform, just as you do
> in=20
> 2/2, but this 1/2 part looks wrong to me.
>=20
> =C2=A0NB CPU_4KEC is double-listed as R1 and R2 because early revisions o=
f
> the=20
> 4KEc core were actually R1 before switching to R2, so this CPU can
> report=20
> either revision.
>=20
> =C2=A0I don't know why CPU_XBURST is also listed as both R1 and R2, the
> history=20
> looks convoluted with no explanation.=C2=A0 Paul, is the CPU also dual-
> revision=20
> or is it just a bug and it is supposed to be listed under one ISA
> revision
> only, presumably R2?

The XBurst CPU is R1 in older Ingenic SoCs (JZ4760B and older), and R2
in newer SoCs (JZ4770 and newer).

Cheers,
-Paul
