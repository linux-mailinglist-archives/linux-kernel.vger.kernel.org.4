Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90C0F6CB5C9
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:11:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231970AbjC1FLd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:11:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231819AbjC1FLa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:11:30 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B2C82121
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 22:11:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C9E5C60A50
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 05:11:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D7C66C433D2;
        Tue, 28 Mar 2023 05:11:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679980287;
        bh=T0M1pgvAdzRe+spfvvLVDkVSL/70Xeq1CaWoRmuHo6g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nFX55RdST9p5XWsK+lCtJ6/PsNUs1V2+T6G2aeU9AfepCCkv0U1XUxTbGxp8lxh8o
         irqBz+1HhFvQCqewbIAP9mbxD/KesGWfPayXiSukEnMbMICr57c0tZ8H8+TOzS0hFC
         2Det/vF6EfDZ2mHH04uotEowWLXRAXeFMTkU16p4=
Date:   Tue, 28 Mar 2023 07:11:24 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jerry Chuang <jerry-chuang@realtek.com>
Subject: Re: [PATCH v3 4/4] staging: rtl8192u: add '*/' on separate line in
 block comments
Message-ID: <ZCJ2_PuvCUBvlwaL@kroah.com>
References: <cover.1679945728.git.kamrankhadijadj@gmail.com>
 <140e0928531e61dc7396271a5b16a6be17514c76.1679945728.git.kamrankhadijadj@gmail.com>
 <ZCJepCj9JcOQqp0Z@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCJepCj9JcOQqp0Z@debian.me>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 10:27:32AM +0700, Bagas Sanjaya wrote:
> On Tue, Mar 28, 2023 at 12:49:09AM +0500, Khadija Kamran wrote:
> > Linux kernel coding style uses '*/' on a separate line at the end of
> > multi line comments.
> > 
> > Fix block comments by moving '*/' at the end of block comments on a
> > separate line as reported by checkpatch.pl script.
> > 
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r8192U_dm.c | 21 ++++++++++++++-------
> >  1 file changed, 14 insertions(+), 7 deletions(-)
> > 
> > diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
> > index dd9903719c20..cbae852478ea 100644
> > --- a/drivers/staging/rtl8192u/r8192U_dm.c
> > +++ b/drivers/staging/rtl8192u/r8192U_dm.c
> > @@ -244,7 +244,8 @@ void init_rate_adaptive(struct net_device *dev)
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *---------------------------------------------------------------------------*/
> > + *---------------------------------------------------------------------------
> > + */
> > <snipped>...
> >  void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
> >  {
> >  	struct delayed_work *dwork = to_delayed_work(work);
> > @@ -2407,7 +2413,8 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *---------------------------------------------------------------------------*/
> > + *---------------------------------------------------------------------------
> > + */
> 
> While at above can you please turn these comments above into kernel-doc
> comments (see Documentation/doc-guide/kernel-doc.rst for how to write
> one)? This requires a placeholder doc where you can write e.g. overview
> of the driver and how it is used. The doc should be in
> Documentation/driver-api/staging/ (since this is staging driver).

No, these are static functions, or just normal internal-to-the-driver
functions, they do not need kerneldoc or any Documentation/* entries,
sorry.

greg k-h
