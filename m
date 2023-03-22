Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8DA96C4B27
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 13:56:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230454AbjCVM4p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 08:56:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230448AbjCVM4o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 08:56:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E85A5D8A1;
        Wed, 22 Mar 2023 05:56:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E7EAE620D7;
        Wed, 22 Mar 2023 12:56:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54807C433A0;
        Wed, 22 Mar 2023 12:56:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679489801;
        bh=pFBXYdxdFklmnPVMqDW3np+O3CSV0Nc/150QPIQEDko=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=B1YqJ662CNRHq1SZZ5xOnh8JZWS5raGfq0N8HP4Ui1eqjznKBGcNLyknUY5pMRoe5
         bjAgEs+5gvX4iHoTQB5NKwDQWtGHaS1YkCrBUcfNJjdgaINaMVknMV260jrfbobz1z
         R4y0oUjl+b3njnY3dXf1kBEoeE95No6VoXmjz4gtExGMkdLhrX0C7pdoeSCJRx+7no
         ncZaQG2cAfBFaaTCLVdjswDPeVHcK7HLTR1Nxdy8tmuc8FQLbCyPb/hlo7qNBzlWm4
         stU5rExSIY1Qya/lJnjLsEF5IksVXnozsbRSYjGf/6X7FXzillc9kgNTQI7BVv7tja
         2Bb0SS8IwVB5g==
Received: by mail-yb1-f180.google.com with SMTP id e65so20817059ybh.10;
        Wed, 22 Mar 2023 05:56:41 -0700 (PDT)
X-Gm-Message-State: AAQBX9fQoULuSVbPqqNd292FwlBJATH/Fd7t7JFhC4kyvc8Cbdl7TMHp
        OT0gG6PYOCmXl8esQOvl32iBw3qbqvhabyD6VQ==
X-Google-Smtp-Source: AKy350bdJZMyzaTU1EssNK+DI7EbAc1FdWvsdKrzrsaQLrlv+0e71ugQkgXFJRYmdHQVGZUfpbVoUPOCBzQN8RX6K70=
X-Received: by 2002:a05:6902:283:b0:b33:531b:3dd4 with SMTP id
 v3-20020a056902028300b00b33531b3dd4mr3273257ybh.1.1679489800138; Wed, 22 Mar
 2023 05:56:40 -0700 (PDT)
MIME-Version: 1.0
References: <20230316122741.577663-1-herve.codina@bootlin.com>
 <20230316122741.577663-2-herve.codina@bootlin.com> <96b01241-d57d-a460-4a8b-9e83eaab24ae@linaro.org>
 <167930560089.26.8624952010101991814@mailman-core.alsa-project.org>
 <20230320185127.GA2233912-robh@kernel.org> <20230322112056.7ffcd503@bootlin.com>
In-Reply-To: <20230322112056.7ffcd503@bootlin.com>
From:   Rob Herring <robh@kernel.org>
Date:   Wed, 22 Mar 2023 07:56:29 -0500
X-Gmail-Original-Message-ID: <CAL_JsqK-=9BJEbEUji0ac=cXqBz3ijD5m33MBPyms-9O44gvag@mail.gmail.com>
Message-ID: <CAL_JsqK-=9BJEbEUji0ac=cXqBz3ijD5m33MBPyms-9O44gvag@mail.gmail.com>
Subject: Re: [PATCH v2 1/7] dt-bindings: misc: Add the Lantiq PEF2466 E1/T1/J1 framer
To:     Herve Codina <herve.codina@bootlin.com>,
        alsa-devel-owner@alsa-project.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Takashi Iwai <tiwai@suse.com>, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, alsa-devel@alsa-project.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 22, 2023 at 5:21=E2=80=AFAM Herve Codina <herve.codina@bootlin.=
com> wrote:
>
> Hi Rob,
>
> On Mon, 20 Mar 2023 13:51:27 -0500
> Rob Herring <robh@kernel.org> wrote:
>
> > On Mon, Mar 20, 2023 at 10:46:19AM +0100, Herve Codina via Alsa-devel w=
rote:
> > > Received: by alsa1.perex.cz (Postfix, from userid 50401) id 16494F802=
7B;
> > >  Mon, 20 Mar 2023 10:46:37 +0100 (CET)
> > > X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on alsa1.pere=
x.cz
> > > X-Spam-Level:
> > > X-Spam-Status: No, score=3D-5.2 required=3D5.0 tests=3DDKIM_SIGNED,DK=
IM_VALID,
> > >  DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
> > >  URIBL_BLOCKED shortcircuit=3Dno autolearn=3Dham autolearn_force=3Dno
> > >  version=3D3.4.6
> > > Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net
> > >  [217.70.183.198]) (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384
> > >  (256/256 bits)) (No client certificate requested) by alsa1.perex.cz
> > >  (Postfix) with ESMTPS id 3FF5FF80105 for <alsa-devel@alsa-project.or=
g>;
> > >  Mon, 20 Mar 2023 10:46:22 +0100 (CET)
> > > DKIM-Filter: OpenDKIM Filter v2.11.0 alsa1.perex.cz 3FF5FF80105
> > > Authentication-Results: alsa1.perex.cz; dkim=3Dpass (2048-bit key,
> > >  unprotected) header.d=3Dbootlin.com header.i=3D@bootlin.com
> > >  header.a=3Drsa-sha256 header.s=3Dgm1 header.b=3Dm4O7nLC1
> > > Received: (Authenticated sender: herve.codina@bootlin.com) by
> > >  mail.gandi.net (Postfix) with ESMTPSA id 40453C0009; Mon, 20 Mar 202=
3
> > >  09:46:20 +0000 (UTC)
> > > DKIM-Signature: v=3D1; a=3Drsa-sha256; c=3Drelaxed/relaxed; d=3Dbootl=
in.com; s=3Dgm1;
> > >  t=3D1679305582;
> > >  h=3Dfrom:from:reply-to:subject:subject:date:date:message-id:message-=
id:
> > >   to:to:cc:cc:mime-version:mime-version:content-type:content-type:
> > >   content-transfer-encoding:content-transfer-encoding:
> > >   in-reply-to:in-reply-to:references:references;
> > >  bh=3DIeu9Fv38se4lD4z/BVXUHLrVJL9Tx5iKWZgvO8X+VoY=3D;
> > >  b=3Dm4O7nLC1LPZDOI5eM/hmgqouxdkin2veA6CvJhT9kU9rGQALB3ya2fuybMfDvrkT=
qqBjEd
> > >  j6DAxXMgOKgwuUfEsZsp3BFJpoii00hSaf0r2uIbnnGcUrDGVQqUQVEqv51O6VBqnrVi=
Qk
> > >  PstlJM0lcE9R/AFASd5D/HQGoYYyRY+NKT7xt8g1Ax23Yk/tUG59LXku/skn/4faSLod=
nU
> > >  vV2ng3VMUcoLuvSMJtdYY3hrXEWqUrW1ZogxAFHJNiKuyOELmqZGmNo4B4yAFOEcqqya=
no
> > >  /f4m/7BtT7X1wwPvGu29gg+0aOFrGQq5kb4UNrMoriSQyKnxPRha8zL3J2Jckw=3D=3D
> > > Date: Mon, 20 Mar 2023 10:46:19 +0100
> > > From: Herve Codina <herve.codina@bootlin.com>
> > > To: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > > Subject: Re: [PATCH v2 1/7] dt-bindings: misc: Add the Lantiq PEF2466
> > >  E1/T1/J1 framer
> > > Message-ID: <20230320104619.468a304b@bootlin.com>
> > > In-Reply-To: <96b01241-d57d-a460-4a8b-9e83eaab24ae@linaro.org>
> > > References: <20230316122741.577663-1-herve.codina@bootlin.com>
> > >  <20230316122741.577663-2-herve.codina@bootlin.com>
> > >  <96b01241-d57d-a460-4a8b-9e83eaab24ae@linaro.org>
> > > Organization: Bootlin
> > > X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
> > > MIME-Version: 1.0
> > > Content-Type: text/plain; charset=3DUTF-8
> > > Content-Transfer-Encoding: quoted-printable
> > > Message-ID-Hash: AJZF4VHU24ASVVBCPRMLJCDG4ZDX55LB
> > > X-Message-ID-Hash: AJZF4VHU24ASVVBCPRMLJCDG4ZDX55LB
> > > X-MailFrom: herve.codina@bootlin.com
> > > X-Mailman-Rule-Misses: dmarc-mitigation; no-senders; approved; emerge=
ncy;
> > >  loop; banned-address; member-moderation;
> > >  header-match-alsa-devel.alsa-project.org-0;
> > >  header-match-alsa-devel.alsa-project.org-1; nonmember-moderation;
> > >  administrivia; implicit-dest; max-recipients; max-size; news-moderat=
ion;
> > >  no-subject; digests; suspicious-header
> > > CC: Rob Herring <robh+dt@kernel.org>, Krzysztof Kozlowski
> > >  <krzysztof.kozlowski+dt@linaro.org>, Liam Girdwood <lgirdwood@gmail.=
com>,
> > >  Mark Brown <broonie@kernel.org>, Derek Kiernan <derek.kiernan@xilinx=
.com>,
> > >  Dragan Cvetic <dragan.cvetic@xilinx.com>, Arnd Bergmann <arnd@arndb.=
de>,
> > >  Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Takashi Iwai
> > >  <tiwai@suse.com>, linux-kernel@vger.kernel.org,
> > >  devicetree@vger.kernel.org, alsa-devel@alsa-project.org, Christophe =
Leroy
> > >  <christophe.leroy@csgroup.eu>, Thomas Petazzoni
> > >  <thomas.petazzoni@bootlin.com>
> > > X-Mailman-Version: 3.3.8
> > > Precedence: list
> > > List-Id: "Alsa-devel mailing list for ALSA developers -
> > >  http://www.alsa-project.org" <alsa-devel.alsa-project.org>
> > > Archived-At: <https://mailman.alsa-project.org/hyperkitty/list/alsa-d=
evel@alsa-project.org/message/AJZF4VHU24ASVVBCPRMLJCDG4ZDX55LB/>
> > > List-Archive: <https://mailman.alsa-project.org/hyperkitty/list/alsa-=
devel@alsa-project.org/>
> > > List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=3Dhelp=
>
> > > List-Owner: <mailto:alsa-devel-owner@alsa-project.org>
> > > List-Post: <mailto:alsa-devel@alsa-project.org>
> > > List-Subscribe: <mailto:alsa-devel-join@alsa-project.org>
> > > List-Unsubscribe: <mailto:alsa-devel-leave@alsa-project.org>
> >
> > The alsa-devel list doesn't seem to like your emails. The archives
> > (lore) has 2 copies with the 2nd having the original headers in the
> > body. I'm seeing this recently on other senders too. Best I can tell is
> > you sent this as quoted-printable.
> >
> > Rob
>
> I don't known what happened with alsa-devel list.
>
> For this answer, I tried to force '8bit' encoding instead of quoted-print=
able.
> Let me know if it is better.

Nope, still the same issue:

https://lore.kernel.org/all/167948048307.26.16805930109507404147@mailman-co=
re.alsa-project.org/

I added the alsa-devel owner. Maybe they know what's happening.

Rob
