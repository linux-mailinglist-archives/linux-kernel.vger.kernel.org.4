Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588EC6B8D44
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:27:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbjCNI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjCNI04 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:26:56 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CACC38E8F;
        Tue, 14 Mar 2023 01:25:33 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id B801220B15;
        Tue, 14 Mar 2023 09:25:28 +0100 (CET)
Date:   Tue, 14 Mar 2023 09:25:24 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Shawn Guo <shawnguo@kernel.org>
Cc:     Francesco Dolcini <francesco@dolcini.it>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Philippe Schenker <dev@pschenker.ch>,
        devicetree@vger.kernel.org, Sascha Hauer <s.hauer@pengutronix.de>,
        NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        Philippe Schenker <philippe.schenker@toradex.com>,
        linux-kernel@vger.kernel.org,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>
Subject: Re: [PATCH v1 03/25] arm64: dts: colibri-imx8x: Sort properties
Message-ID: <ZBAvdI/Y0RL7Xf7/@francesco-nb.int.toradex.com>
References: <20230308125300.58244-1-dev@pschenker.ch>
 <20230308125300.58244-4-dev@pschenker.ch>
 <9d213504-d457-21a6-d467-41d8783d53d3@linaro.org>
 <ZAnOwaXpcqI30jFi@francesco-nb.int.toradex.com>
 <20230314081735.GE143566@dragon>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230314081735.GE143566@dragon>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 04:17:35PM +0800, Shawn Guo wrote:
> On Thu, Mar 09, 2023 at 01:19:13PM +0100, Francesco Dolcini wrote:
> > Hello Krzysztof, first thanks for your review.
> > 
> > Let's try to get some clarity on this with the help of Shawn.
> > 
> > On Wed, Mar 08, 2023 at 01:57:38PM +0100, Krzysztof Kozlowski wrote:
> > > On 08/03/2023 13:52, Philippe Schenker wrote:
> > > > From: Philippe Schenker <philippe.schenker@toradex.com>
> > > > 
> > > > Sort properties according to the following order and inside these
> > > > alphabetically.
> > > > 
> > > > 1. compatible
> > > > 2. reg
> > > > 3. standard properties
> > > > 4. specific properties
> > > > 5. status
> > > 
> > > Is this approved coding style for IMX DTS?
> > 
> > I 100% understand your concerns here.
> > 
> > With that said let me try to briefly explain the reasoning here, in
> > various threads we were asked in the past to move node around based on
> > some not 100% defined rules [0][1].
> > 
> > On Sun, 2023-01-29 at 11:19 +0800, Shawn Guo wrote:
> > >> +&usbotg1 {
> > >> +	adp-disable;
> > >> +	ci-disable-lpm;
> > >> +	hnp-disable;
> > >> +	over-current-active-low;
> > >> +	pinctrl-names = "default";
> > >> +	pinctrl-0 = <&pinctrl_usbotg1>;
> > >
> > >We generally want to put such generic properties before device specific
> > >ones.
> > 
> > In addition to that we find convenient to have properties sorted
> > alphabetically when no other rule is available, it just prevents any
> > kind of discussion, minimize merge conflicts and make comparing files
> > easier.
> > 
> > I also agree that the difference between "generic"/"specific" is fuzzy
> > at best.
> > 
> > With all that said ...
> > 
> > Shawn: What should we do? We can of course avoid any kind of re-ordering
> > from now on.
> 
> We are practically asking for 1, 2 and 5 for i.MX DTS files, but pretty
> flexible for the rest.
> 
> > I am fine to be very pragmatic here, no-reordering on existing DTS
> > files, newly added DTS files we discuss whatever is the reasoning of the
> > reviewer/maintainer on a case-by-case basis.
> 
> Sounds good to me!  While I personally like your ordering, I do not want
> it to churn the existing DTS files.

Agreed.

> 
> I'm happy to take this patch as a special case though :)

Philippe just rebased all the stuff getting rid of the sort commit :-)
No special case needed, he will send an updated series in a hour.

Thanks a lot,
Francesco

