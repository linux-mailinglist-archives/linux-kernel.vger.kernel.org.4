Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49C66F581F
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 14:47:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229890AbjECMrI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 08:47:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229691AbjECMrD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 08:47:03 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBE649DE;
        Wed,  3 May 2023 05:47:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9755162D38;
        Wed,  3 May 2023 12:47:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 03472C433A4;
        Wed,  3 May 2023 12:47:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683118021;
        bh=EgiNiJbh15KE0Ia15kPVvnW13bZZDq3+PSwMvLc6Ois=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=NIfzEJ7naztoKrOkIDAEykRjVdZFitWMFmR0Pw+XFLAM0/K3e6QOJUVsWQIorOu4p
         R7IIJb/74do45Btc5opX6zgBz1ejVpZPVZ2oZh0n8ZqkZjewhTbUG1POz0evYzWPAk
         9uItN64Yt294K/8vbdCEg9OaDadt9VJymhJ0Svj19GrNTrMlXuBf0/6p1UdGUvAOCp
         33yx3Uor/9Te4cpXJMW8tncCEq7uf7x3HhCOaVdRD7TzBe0DpM4A0ktbnRdTiE3TOB
         9hXY79QgD+FjTRFKJfvUEOIIMR/XpTFVuaW+g4o2Hv7DWfKnMCNDcjWTeDMngMce/i
         AH+I4O9Hb7KJg==
Received: by mail-ej1-f46.google.com with SMTP id a640c23a62f3a-9505214c47fso1008666466b.1;
        Wed, 03 May 2023 05:47:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDxAckV5g6bsz9JGhlz3ikGiia6+p4T3KTkSuJixOXdMnH+AHX+e
        zVMpDGG6bydb9zuRYhygC9lNAP1amGr/RXiolWs=
X-Google-Smtp-Source: ACHHUZ6IKHwFYCLYB5LqHR+3pNixMRRo4M6Cb27Yi39KHRdvN38tYrtbttUydFJNM4Zdu4mTeivPqROz4c/tClebcKQ=
X-Received: by 2002:a17:906:6a1f:b0:94e:dbf7:2dfe with SMTP id
 qw31-20020a1709066a1f00b0094edbf72dfemr3509786ejc.11.1683118019168; Wed, 03
 May 2023 05:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230322052504.2629429-1-peng.fan@oss.nxp.com>
 <20230322052504.2629429-11-peng.fan@oss.nxp.com> <20230405130649.GA11367@dragon>
 <DU0PR04MB94178755C624BCBE25D8073C88919@DU0PR04MB9417.eurprd04.prod.outlook.com>
 <20230406014013.GJ11367@dragon> <ZEDzkhtUiUxQ0V4d@kroah.com> <20230503010731.GA31464@dragon>
In-Reply-To: <20230503010731.GA31464@dragon>
From:   Shawn Guo <shawnguo@kernel.org>
Date:   Wed, 3 May 2023 20:46:46 +0800
X-Gmail-Original-Message-ID: <CAJBJ56+DOuMa+-k2sspV7mKdHPpqAS38epbwOAmfC-42Bq-MfQ@mail.gmail.com>
Message-ID: <CAJBJ56+DOuMa+-k2sspV7mKdHPpqAS38epbwOAmfC-42Bq-MfQ@mail.gmail.com>
Subject: Re: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb compatible
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Peng Fan <peng.fan@nxp.com>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        Xu Yang <xu.yang_2@nxp.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, Jun Li <jun.li@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023 at 9:07=E2=80=AFAM Shawn Guo <shawnguo@kernel.org> wrot=
e:
>
> On Thu, Apr 20, 2023 at 10:10:58AM +0200, Greg KH wrote:
> > On Thu, Apr 06, 2023 at 09:40:13AM +0800, Shawn Guo wrote:
> > > On Thu, Apr 06, 2023 at 01:18:43AM +0000, Peng Fan wrote:
> > > > Hi Shawn,
> > > >
> > > > > Subject: Re: [PATCH V7 10/10] ARM64: dts: imx7ulp: update usb com=
patible
> > > > >
> > > > > On Wed, Mar 22, 2023 at 01:25:04PM +0800, Peng Fan (OSS) wrote:
> > > > > > From: Peng Fan <peng.fan@nxp.com>
> > > > > >
> > > > > > Per binding doc, update the compatible
> > > > > >
> > > > > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > > >
> > > > > ARM: dts: imx7ulp: ...
> > > > >
> > > > > Fixed it up and applied all DTS patches.
> > > > [Peng Fan]
> > > >
> > > > Thanks for the fix. But I think Greg already applied the patchset.
> > >
> > > Okay, I will drop them from my tree, but ...
> > >
> > > Greg,
> > >
> > > May I suggest a couple of things on the future process?
> > >
> > > - Could you leave i.MX DTS patches to me, so that we can avoid potent=
ial
> > >   merge conflicts?
> >
> > How am I supposed to know this?
>
> Aren't we using patch prefix to tell the target subsystem?
>
> > Our tools take the whole patch series,
> > not individual ones.  If someone wants patches to go through different
> > trees, then they need to submit them as different patch series,
> > otherwise it makes no sense.
>
> It's a quite common practice that people send a series containing
> multiple patches targeting different subsystems, as that's what
> reviewers have been asking for sake of completeness.  So we are asking
> for two opposite things from what I can see.

Never mind.  I think I will just start pushing people to send DTS
changes as separate patchset.

Shawn
