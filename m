Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A6BC6CA158
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 12:26:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233658AbjC0K0y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 06:26:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233128AbjC0K0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 06:26:36 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 154D42128
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:26:27 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id y14so8179969wrq.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 03:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679912785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VqQ8VSOs059u+930ZGWsVqFbCaxhg+pQW8jwX08LpsM=;
        b=S8WB0pxBxVtKoOvG7yA//KBUCV3K15P8YcaHzE/nENaLtnYQBWHa+1DWNdEcKrcFDY
         10CbT3XJb5haW6E0XD1dE1+CV2qjYEJA+YwvtP5IW7V6F/YpA7IfxOcrLbCmeoD85EEN
         DM8EmbaCo1wu6MVRs5xqmrABoSOC0khpXfaMa12kPiJLeExc4dDBRs2B2t6hwnk398k2
         KVRJBVnITd3Tn/VJG6CvZtbAwAWvu7OXsQXCuSLbin9gwjmHBGYJgVD/x1ED0G8SE18H
         obgbK5CzG9rXVHeAEm9+lbuxCZDhUl/7Jl2BN/5NlLJ1BSTrpV1EP3ShPn/J8haAW/cM
         vyOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679912785;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VqQ8VSOs059u+930ZGWsVqFbCaxhg+pQW8jwX08LpsM=;
        b=y/g+Y4DBH+KvvItn6bl4/o/GPcFOh7gLxr70Swmno9+obe6mLi2O/oMPyPvW2K4YqZ
         +GQRhlyxeqEUcdIfD5UKXs7X0izNMFPUOBIJIKqASN3ts6WfDi0RNv4X46sSJN612R3c
         odxv4XzzSpSjAD7eM/aIySfAEA/XtF908+E/K1lA2gmFKJ7PFYMdbe3O1Gmcm5/YZe8F
         lkM7oZOaD2F+YNiBEncqJePgSysnoEtLXm9e0IsmX8PeVsZ7sFsZYyDbeTFD5Mqwgg/d
         5BtSstXbhZusdh1CyLuW3qHIjblxjGj+tQcF3seXbh2k8nxRn++LamHfczFH9S3feaG2
         ahhw==
X-Gm-Message-State: AAQBX9fN1hYT7f5ORQ1HiYFZX9cX+G10jcxfyiU4PpWvVO8RpOYxCg6A
        6RGhJqpg79YNplBTj5YZpkGx4WBrjrN5b003PaU=
X-Google-Smtp-Source: AKy350agmst9PQwKSSj2jTRGjh3L7qPTS+8HAKN36g2fy/qR5PY3rI0dQZlHFRZfiEEgpuQ+1vlKxA==
X-Received: by 2002:adf:db0a:0:b0:2df:7c0a:df33 with SMTP id s10-20020adfdb0a000000b002df7c0adf33mr3605545wri.30.1679912785146;
        Mon, 27 Mar 2023 03:26:25 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id n6-20020a5d4c46000000b002c55ec7f661sm24764603wrt.5.2023.03.27.03.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 03:26:24 -0700 (PDT)
Date:   Mon, 27 Mar 2023 15:26:22 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Alison Schofield <alison.schofield@intel.com>
Cc:     outreachy@lists.linux.dev,
        Vaibhav Hiremath <hvaibhav.linux@gmail.com>,
        Johan Hovold <johan@kernel.org>, Alex Elder <elder@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        greybus-dev@lists.linaro.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: greybus: merge split lines
Message-ID: <ZCFvTndYXmPvQunt@khadija-virtual-machine>
References: <ZBgYsqkpdYpGQniB@khadija-virtual-machine>
 <ZBnZj3JbTOsplHvw@khadija-virtual-machine>
 <ZBnc3qWTSeWw0Ulo@aschofie-mobl2>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBnc3qWTSeWw0Ulo@aschofie-mobl2>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 09:35:42AM -0700, Alison Schofield wrote:
> On Tue, Mar 21, 2023 at 09:21:35PM +0500, Khadija Kamran wrote:
> > On Mon, Mar 20, 2023 at 01:26:33PM +0500, Khadija Kamran wrote:
> > > If condition and spin_unlock_...() call is split into two lines, merge
> > > them to form a single line.
> > > 
> > > Suggested-by: Deepak R Varma drv@mailo.com
> > > Signed-off-by: Khadija Kamran <kamrankhadijadj@gmail.com>
> > > ---
> > > 
> > > Changes in v3:
> > >  - Removing tab to fix line length results in a new checkpatch warning,
> > >    so let the fix length be as it is.
> > > Changes in v2:
> > >  - Rephrased he subject and description
> > >  - Merged if_condition() and spin_unlock...() into one line
> > >  - Link to patch:
> > >  https://lore.kernel.org/outreachy/ZAusnKYVTGvO5zoi@khadija-virtual-machine/
> > > 
> > > Link to first patch:
> > > https://lore.kernel.org/outreachy/ZAtkW6g6DwPg%2FpDp@khadija-virtual-machine/
> > > 
> > >  drivers/staging/greybus/arche-platform.c | 6 ++----
> > >  1 file changed, 2 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/staging/greybus/arche-platform.c b/drivers/staging/greybus/arche-platform.c
> > > index fcbd5f71eff2..6890710afdfc 100644
> > > --- a/drivers/staging/greybus/arche-platform.c
> > > +++ b/drivers/staging/greybus/arche-platform.c
> > > @@ -176,12 +176,10 @@ static irqreturn_t arche_platform_wd_irq(int irq, void *devid)
> > >  				 * Check we are not in middle of irq thread
> > >  				 * already
> > >  				 */
> > > -				if (arche_pdata->wake_detect_state !=
> > > -						WD_STATE_COLDBOOT_START) {
> > > +				if (arche_pdata->wake_detect_state != WD_STATE_COLDBOOT_START) {
> > >  					arche_platform_set_wake_detect_state(arche_pdata,
> > >  									     WD_STATE_COLDBOOT_TRIG);
> > > -					spin_unlock_irqrestore(&arche_pdata->wake_lock,
> > > -							       flags);
> > > +					spin_unlock_irqrestore(&arche_pdata->wake_lock, flags);
> > >  					return IRQ_WAKE_THREAD;
> > >  				}
> > >  			}
> > > --
> > > 2.34.1
> > >
> > 
> > Hey Outreachy Mentors,
> > 
> > Kindly take a look at this patch and let me know if it is okay to work
> > on this file or should I look for other cleanup patches.
> 
> Hi Khadija,
> 
> I thought you were abandoning *this* patch, and doing a refactor on
> the function.  I'd expect that would be a new patch, probably a
> patchset. One where you align the work based on the 'rising' and
> 'falling' detection, 

Hey Alison,

Can you please elaborate that what do you mean by aligning on the basis
of rising and falling detection. Are you perhaps saying that I should
group the rising detection and group the falling detection separately?

> and perhaps a second patch that centralizes
> the unlock and return.

To do this I should make the use of goto statement, right?

So the next patchset should be:
Patch 1: merge split lines
Patch 2: align on the basis of rising and falling detection
Patch 3: use goto statement to centralize unlock and return

Kindly guide me.

Regards,
Khadija

> 
> Is there some other concern with working on this file?
> 
> Alison
> 
> > 
> > Thank you for your time.
> > Regards,
> > Khadija
> > 
> > 
