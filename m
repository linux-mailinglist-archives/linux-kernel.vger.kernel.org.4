Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C744169E549
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 17:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234638AbjBUQ56 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 11:57:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234912AbjBUQ5u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 11:57:50 -0500
Received: from mr85p00im-zteg06011501.me.com (mr85p00im-zteg06011501.me.com [17.58.23.182])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C989211D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 08:57:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=me.com; s=1a1hai;
        t=1676998668; bh=LGdUnPSYhPebUFlFuinp+U3AI4mwBiZXzxkqFitQAjk=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=Swhj8mQ9wIBGrCY8sF2EyX9wREfJ7P+x3YEQKj+cej3iKQSbGqeBCoUmlE3e8UguV
         GVyY/2ZYM2bw1JBbe5VWcQVc2R/FVtJljf7RdydKwQaJUGA/XL3hhLdmOyxRywfmYX
         fItFVXEcGbRAg6BAofVApAJpB0rq+t3wSBE518H7ShvJ8qV03Ka61wE1BEe4j5vvpU
         GF8HzZA+B7LwdW/aCJ1F7dOuVRSdYPFDd/dkukd5R6r/1UoQVnn3WkESsaSRrjPMl0
         DrF4bMLMi1IkoJihySaNDWt24ro4E47mGB45DzsycS1FYdz7dg5LgilHmh3RRoo1Yn
         q5EHndMAu7pBw==
Received: from imac101 (mr38p00im-dlb-asmtp-mailmevip.me.com [17.57.152.18])
        by mr85p00im-zteg06011501.me.com (Postfix) with ESMTPSA id 7B190482315;
        Tue, 21 Feb 2023 16:57:46 +0000 (UTC)
Date:   Tue, 21 Feb 2023 17:57:41 +0100
From:   Alain Volmat <avolmat@me.com>
To:     Mark Brown <broonie@kernel.org>, Wolfram Sang <wsa@the-dreams.de>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
Subject: Re: linux-next: manual merge of the spi tree with the i2c tree
Message-ID: <Y/T4BTCCzIWzE1oe@imac101>
Mail-Followup-To: Mark Brown <broonie@kernel.org>,
        Wolfram Sang <wsa@the-dreams.de>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Wolfram Sang <wsa@kernel.org>
References: <20230216113035.3050871a@canb.auug.org.au>
 <CAMuHMdVuudSDrWguMJiHsZ3GJhs+muK566M5GqK2vfMyBeo2pQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMuHMdVuudSDrWguMJiHsZ3GJhs+muK566M5GqK2vfMyBeo2pQ@mail.gmail.com>
X-Proofpoint-ORIG-GUID: MeMvgzMQWiFnEy1KrMx2UW9R99Kz5wfG
X-Proofpoint-GUID: MeMvgzMQWiFnEy1KrMx2UW9R99Kz5wfG
X-Proofpoint-Virus-Version: =?UTF-8?Q?vendor=3Dfsecure_engine=3D1.1.170-22c6f66c430a71ce266a39bfe25bc?=
 =?UTF-8?Q?2903e8d5c8f:6.0.425,18.0.816,17.11.62.513.0000000_definitions?=
 =?UTF-8?Q?=3D2022-01-18=5F01:2022-01-14=5F01,2022-01-18=5F01,2021-12-02?=
 =?UTF-8?Q?=5F01_signatures=3D0?=
X-Proofpoint-Spam-Details: rule=notspam policy=default score=0 mlxscore=0 bulkscore=0 suspectscore=0
 adultscore=0 phishscore=0 clxscore=1011 malwarescore=0 mlxlogscore=999
 spamscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2209130000 definitions=main-2302210142
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark, Wolfram,

should I update something to avoid this conflict before you push the
pull request for v6.3 ?

Cheers,
Alain


On Tue, Feb 21, 2023 at 10:11:03AM +0100, Geert Uytterhoeven wrote:
> Hi Stephen,
> 
> On Thu, Feb 16, 2023 at 1:37 AM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > Today's linux-next merge of the spi tree got a conflict in:
> >
> >   MAINTAINERS
> >
> > between commit:
> >
> >   b3de755d6041 ("dt-bindings: i2c: i2c-st: convert to DT schema")
> >
> > from the i2c tree and commit:
> >
> >   7ec844a2c753 ("spi: spi-st-ssc: convert to DT schema")
> >
> > from the spi tree.
> >
> > I fixed it up (see below) and can carry the fix as necessary. This
> > is now fixed as far as linux-next is concerned, but any non trivial
> > conflicts should be mentioned to your upstream maintainer when your tree
> > is submitted for merging.  You may also want to consider cooperating
> > with the maintainer of the conflicting tree to minimise any particularly
> > complex conflicts.
> >
> > --
> > Cheers,
> > Stephen Rothwell
> >
> > diff --cc MAINTAINERS
> > index 71e92d3c51c6,daa33e7bb457..000000000000
> > --- a/MAINTAINERS
> > +++ b/MAINTAINERS
> > @@@ -2791,7 -2925,8 +2791,8 @@@ M:      Patrice Chotard <patrice.chotard@fos
> >   L:    linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
> >   S:    Maintained
> >   W:    http://www.stlinux.com
> > + F:    Documentation/devicetree/bindings/spi/st,ssc-spi.yaml
> >  -F:    Documentation/devicetree/bindings/i2c/i2c-st.txt
> >  +F:    Documentation/devicetree/bindings/i2c/st,sti-i2c.yaml
> >   F:    arch/arm/boot/dts/sti*
> >   F:    arch/arm/mach-sti/
> >   F:    drivers/ata/ahci_st.c
> 
> Thanks, but please preserve sort order.
> 
> Gr{oetje,eeting}s,
> 
>                         Geert
> 
> -- 
> Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org
> 
> In personal conversations with technical people, I call myself a hacker. But
> when I'm talking to journalists I just say "programmer" or something like that.
>                                 -- Linus Torvalds
