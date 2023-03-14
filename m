Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C20E46B8CEF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 09:19:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229701AbjCNISr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 04:18:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCNISG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 04:18:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D18D54D2A9;
        Tue, 14 Mar 2023 01:17:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4C40161640;
        Tue, 14 Mar 2023 08:17:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B1CBC433D2;
        Tue, 14 Mar 2023 08:17:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678781862;
        bh=Xi2794rdLlEIsfm3cg4qF1ROjcOdCNpLbzUABC/gRQc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UzbwfGVIDSHLMLIkX+l3tn4KjEkfQkXi6RDxwh7iaaeUsJOfJiLLVQmX4LMhJuLJZ
         +JaJlQS4iVuNHM/IsYnVjDiGD/Ytj7WdhN1hn7kFjZvmMg2FtzYAUrnk9CoQ77dVTi
         32gDeMtT7faxnhvv269AeWv+rjEyCBwW0PzQw+j/tlTPoecrX4Oa4x8pPBcXtDlbnm
         p2V4mHJhLBvcccYkVARBeMO63/cffNLPhLEfIbey24Lpa/FH3/HSnFJYsUFTeS+Ffy
         YC/1OObK8qetusWHAkga/TO6zbTxwaHO8Yz0betHqlsa4xQUfiMaMbk44ecMEHJm3S
         +3sMPf9vXoAWQ==
Date:   Tue, 14 Mar 2023 16:17:35 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
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
Message-ID: <20230314081735.GE143566@dragon>
References: <20230308125300.58244-1-dev@pschenker.ch>
 <20230308125300.58244-4-dev@pschenker.ch>
 <9d213504-d457-21a6-d467-41d8783d53d3@linaro.org>
 <ZAnOwaXpcqI30jFi@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAnOwaXpcqI30jFi@francesco-nb.int.toradex.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 09, 2023 at 01:19:13PM +0100, Francesco Dolcini wrote:
> Hello Krzysztof, first thanks for your review.
> 
> Let's try to get some clarity on this with the help of Shawn.
> 
> On Wed, Mar 08, 2023 at 01:57:38PM +0100, Krzysztof Kozlowski wrote:
> > On 08/03/2023 13:52, Philippe Schenker wrote:
> > > From: Philippe Schenker <philippe.schenker@toradex.com>
> > > 
> > > Sort properties according to the following order and inside these
> > > alphabetically.
> > > 
> > > 1. compatible
> > > 2. reg
> > > 3. standard properties
> > > 4. specific properties
> > > 5. status
> > 
> > Is this approved coding style for IMX DTS?
> 
> I 100% understand your concerns here.
> 
> With that said let me try to briefly explain the reasoning here, in
> various threads we were asked in the past to move node around based on
> some not 100% defined rules [0][1].
> 
> On Sun, 2023-01-29 at 11:19 +0800, Shawn Guo wrote:
> >> +&usbotg1 {
> >> +	adp-disable;
> >> +	ci-disable-lpm;
> >> +	hnp-disable;
> >> +	over-current-active-low;
> >> +	pinctrl-names = "default";
> >> +	pinctrl-0 = <&pinctrl_usbotg1>;
> >
> >We generally want to put such generic properties before device specific
> >ones.
> 
> In addition to that we find convenient to have properties sorted
> alphabetically when no other rule is available, it just prevents any
> kind of discussion, minimize merge conflicts and make comparing files
> easier.
> 
> I also agree that the difference between "generic"/"specific" is fuzzy
> at best.
> 
> With all that said ...
> 
> Shawn: What should we do? We can of course avoid any kind of re-ordering
> from now on.

We are practically asking for 1, 2 and 5 for i.MX DTS files, but pretty
flexible for the rest.

> I am fine to be very pragmatic here, no-reordering on existing DTS
> files, newly added DTS files we discuss whatever is the reasoning of the
> reviewer/maintainer on a case-by-case basis.

Sounds good to me!  While I personally like your ordering, I do not want
it to churn the existing DTS files.

I'm happy to take this patch as a special case though :)

Shawn
