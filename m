Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308066CB5D1
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 07:14:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230269AbjC1FOr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 01:14:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229747AbjC1FOo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 01:14:44 -0400
Received: from mail2-relais-roc.national.inria.fr (mail2-relais-roc.national.inria.fr [192.134.164.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BEC61BE
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 22:14:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=inria.fr; s=dc;
  h=date:from:to:cc:subject:in-reply-to:message-id:
   references:mime-version;
  bh=TJ++SQGfnBdPkdwxW2Tzbzf3MJ3odVLTt2xpAQSMS4g=;
  b=azd/nOCK71QVQImkzKffQpQWaoFFSCr31SWThTzukCjgesHfbfUwDw/J
   M98Hg/bRfYAuL3JjBDkI8LfewesddotqiDWw0J5V0Flb5VudyY3y9UMhm
   OknaXSULdXhXYQTlJ2JwHfFvzVWupEhb6c7YExHD4fg5V4jCA2eWyw1i/
   Y=;
Authentication-Results: mail2-relais-roc.national.inria.fr; dkim=none (message not signed) header.i=none; spf=SoftFail smtp.mailfrom=julia.lawall@inria.fr; dmarc=fail (p=none dis=none) d=inria.fr
X-IronPort-AV: E=Sophos;i="5.98,296,1673910000"; 
   d="scan'208";a="99414949"
Received: from 231.85.89.92.rev.sfr.net (HELO hadrien) ([92.89.85.231])
  by mail2-relais-roc.national.inria.fr with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Mar 2023 07:14:41 +0200
Date:   Tue, 28 Mar 2023 07:14:40 +0200 (CEST)
From:   Julia Lawall <julia.lawall@inria.fr>
X-X-Sender: jll@hadrien
To:     Bagas Sanjaya <bagasdotme@gmail.com>
cc:     Khadija Kamran <kamrankhadijadj@gmail.com>,
        outreachy@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Jerry Chuang <jerry-chuang@realtek.com>
Subject: Re: [PATCH v3 1/4] staging: rtl8192u: remove change history from
 comments
In-Reply-To: <ZCJcQStZ8h0m+XfF@debian.me>
Message-ID: <alpine.DEB.2.22.394.2303280714110.3298@hadrien>
References: <cover.1679945728.git.kamrankhadijadj@gmail.com> <95fff39231ebb2bb683c2a8f252a93f4845fffb1.1679945728.git.kamrankhadijadj@gmail.com> <ZCJcQStZ8h0m+XfF@debian.me>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Tue, 28 Mar 2023, Bagas Sanjaya wrote:

> On Tue, Mar 28, 2023 at 12:49:06AM +0500, Khadija Kamran wrote:
> > Remove the change history information as it is not required in the
> > comments.
>
> (also Cc: original driver author)
>
> What about below?
>
> ```
> Remove obsolete change history info as developers can simply use git to
> browse commit history of the driver.
> ```

But the information that is being removed is not part of the git history,
since it predates the introduction of the driver into the Linux kernel.

julia

>
> >
> > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > ---
> >  drivers/staging/rtl8192u/r8192U_dm.c | 45 ----------------------------
> >  1 file changed, 45 deletions(-)
> >
> > diff --git a/drivers/staging/rtl8192u/r8192U_dm.c b/drivers/staging/rtl8192u/r8192U_dm.c
> > index 6a33ca02c3dc..b1ebb776fc42 100644
> > --- a/drivers/staging/rtl8192u/r8192U_dm.c
> > +++ b/drivers/staging/rtl8192u/r8192U_dm.c
> > @@ -7,12 +7,6 @@ Module Name:
> >
> >  Abstract:
> >  	HW dynamic mechanism.
> > -
> > -Major Change History:
> > -	When		Who				What
> > -	----------	--------------- -------------------------------
> > -	2008-05-14	amy                     create version 0 porting from windows code.
> > -
> >  --*/
> >  #include "r8192U.h"
> >  #include "r8192U_dm.h"
> > @@ -274,11 +268,6 @@ void init_rate_adaptive(struct net_device *dev)
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *
> > - * Revised History:
> > - *	When		Who		Remark
> > - *	05/26/08	amy	Create version 0 porting from windows code.
> > - *
> >   *---------------------------------------------------------------------------*/
> >  static void dm_check_rate_adaptive(struct net_device *dev)
> >  {
> > @@ -1589,11 +1578,6 @@ static void dm_bb_initialgain_backup(struct net_device *dev)
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *
> > - * Revised History:
> > - *	When		Who		Remark
> > - *	05/15/2008	amy		Create Version 0 porting from windows code.
> > - *
> >   *---------------------------------------------------------------------------*/
> >  static void dm_dig_init(struct net_device *dev)
> >  {
> > @@ -1634,10 +1618,6 @@ static void dm_dig_init(struct net_device *dev)
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *
> > - * Revised History:
> > - *	When		Who		Remark
> > - *	05/27/2008	amy		Create Version 0 porting from windows code.
> >   *---------------------------------------------------------------------------*/
> >  static void dm_ctrl_initgain_byrssi(struct net_device *dev)
> >  {
> > @@ -1850,11 +1830,6 @@ static void dm_ctrl_initgain_byrssi_by_fwfalse_alarm(
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *
> > - * Revised History:
> > - *	When		Who		Remark
> > - *	05/28/2008	amy		Create Version 0 porting from windows code.
> > - *
> >   *---------------------------------------------------------------------------*/
> >  static void dm_ctrl_initgain_byrssi_highpwr(
> >  	struct net_device *dev)
> > @@ -2269,11 +2244,6 @@ static void dm_ctstoself(struct net_device *dev)
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *
> > - * Revised History:
> > - *	When		Who		Remark
> > - *	05/28/2008	amy	Create Version 0 porting from windows code.
> > - *
> >   *---------------------------------------------------------------------------*/
> >  static	void	dm_check_pbc_gpio(struct net_device *dev)
> >  {
> > @@ -2303,11 +2273,6 @@ static	void	dm_check_pbc_gpio(struct net_device *dev)
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *
> > - * Revised History:
> > - *	When		Who		Remark
> > - *	01/30/2008	MHC		Create Version 0.
> > - *
> >   *---------------------------------------------------------------------------*/
> >  void dm_rf_pathcheck_workitemcallback(struct work_struct *work)
> >  {
> > @@ -2552,11 +2517,6 @@ static void dm_rxpath_sel_byrssi(struct net_device *dev)
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *
> > - * Revised History:
> > - *	When		Who		Remark
> > - *	05/28/2008	amy		Create Version 0 porting from windows code.
> > - *
> >   *---------------------------------------------------------------------------*/
> >  static void dm_check_rx_path_selection(struct net_device *dev)
> >  {
> > @@ -2871,11 +2831,6 @@ void dm_check_fsync(struct net_device *dev)
> >   * Output:		NONE
> >   *
> >   * Return:		NONE
> > - *
> > - * Revised History:
> > - *	When		Who		Remark
> > - *	03/06/2008	Jacken	Create Version 0.
> > - *
> >   *---------------------------------------------------------------------------
> >   */
> >  static void dm_init_dynamic_txpower(struct net_device *dev)
>
> The rest is LGTM, thanks!
>
> --
> An old man doll... just what I always wanted! - Clara
>
