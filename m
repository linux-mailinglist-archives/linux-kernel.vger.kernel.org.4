Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208A072F496
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 08:19:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242834AbjFNGTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 02:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233905AbjFNGSk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 02:18:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 030CA1BC5;
        Tue, 13 Jun 2023 23:18:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6B02963357;
        Wed, 14 Jun 2023 06:18:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 60A47C433C8;
        Wed, 14 Jun 2023 06:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686723517;
        bh=p8cT3KGfD9ibYP9ueE0C4NUvbnC63jpDlwsJbEABoLI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=wAmAyOwaJxR1VlRrX8Y81G7/mRK8AJt6LkRLuRuhnpihiVABk0MkC22f+CVz5rTpg
         1/t7xBznBl+/6TjX1D3LqnBzRMVTHp/kRzof3AHvOe5WIHODMF3wEfZSqH0MU1xvYL
         zskGDpUomY90FAw4lST7rP78I2PgxAd/PbrzHu4U=
Date:   Wed, 14 Jun 2023 08:18:34 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Pawel Laszczak <pawell@cadence.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "Daisy.Barrera@siriusxm.com" <Daisy.Barrera@siriusxm.com>,
        "Cliff.Holden@siriusxm.com" <Cliff.Holden@siriusxm.com>,
        "tony@atomide.com" <tony@atomide.com>,
        "jdelvare@suse.de" <jdelvare@suse.de>,
        "neal_liu@aspeedtech.com" <neal_liu@aspeedtech.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "egtvedt@samfundet.no" <egtvedt@samfundet.no>,
        "biju.das.jz@bp.renesas.com" <biju.das.jz@bp.renesas.com>,
        "herve.codina@bootlin.com" <herve.codina@bootlin.com>
Subject: Re: [PATCH v4 4/4] MAINTAINERS: add Cadence USBHS driver entry
Message-ID: <2023061442-showgirl-cradling-159d@gregkh>
References: <20230602102644.77470-1-pawell@cadence.com>
 <20230602102644.77470-5-pawell@cadence.com>
 <2023061350-calcium-follow-8649@gregkh>
 <BYAPR07MB53817FEF19052C31CFC965C2DD5AA@BYAPR07MB5381.namprd07.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BYAPR07MB53817FEF19052C31CFC965C2DD5AA@BYAPR07MB5381.namprd07.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 05:45:46AM +0000, Pawel Laszczak wrote:
> 
> >
> >On Fri, Jun 02, 2023 at 06:26:44AM -0400, Pawel Laszczak wrote:
> >> Patch adds entry for USBHS (CDNS2) driver into MAINTARNERS file
> >>
> >> Signed-off-by: Pawel Laszczak <pawell@cadence.com>
> >> ---
> >>  MAINTAINERS | 6 ++++++
> >>  1 file changed, 6 insertions(+)
> >>
> >> diff --git a/MAINTAINERS b/MAINTAINERS index
> >> c269a15609e2..8b289d52d983 100644
> >> --- a/MAINTAINERS
> >> +++ b/MAINTAINERS
> >> @@ -4523,6 +4523,12 @@ T:	git
> >git://git.kernel.org/pub/scm/linux/kernel/git/peter.chen/usb.git
> >>  F:	drivers/usb/cdns3/
> >>  X:	drivers/usb/cdns3/cdns3*
> >>
> >> +CADENCE USBHS DRIVER
> >> +M:	Pawel Laszczak <pawell@cadence.com>
> >> +L:	linux-usb@vger.kernel.org
> >> +S:	Maintained
> >
> >This isn't part of your job description?  Why doesn't Cadence allow you to do
> >that?  That's not good on a bunch of levels, have you seen the
> >Documentation/process/contribution-maturity-model.rst file yet?
> >
> 
> I have read it now, but I don't understand where I made mistake.
> I guess that I should not be added as maintainer. Am I right?
> 
> I responsible for:
> 1. developing USBHS driver
> 2. upstreaming USBH driver
> 3. fixing issue detected by me or by our customers.

It's the "S: Maintained" line I am curious about.  "Maintained" means
"Someone actually looks after it.", while if you put "Supported" that
means "Someone is actually paid to look after this."

The difference is the first is usually on your own time as a best-effort
on your part, the second is that it is part of your job from your
employer.

If Cadence doesn't allow you to do maintaince work on company time, then
the entry is correct as you wrote it.  Otherwise you might want to
change that.  See the top of the MAINTAINERS file for the other options
you have here for this field if neither of these are correct.

thanks,

greg k-h
