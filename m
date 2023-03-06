Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31C246AB73D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 08:49:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229689AbjCFHs7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 02:48:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjCFHs5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 02:48:57 -0500
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD86F9024
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 23:48:55 -0800 (PST)
Received: by mail-lj1-x22c.google.com with SMTP id g18so8672741ljl.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Mar 2023 23:48:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678088934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=tU7WT2qxwujzjjMyDpG88kr9l/E98M2ObflfoXUtYXA=;
        b=KBKLoFSBRxiVMNR697rZcHI3xo8n3h+NVP0CD8K1uHKmLCOUMmjc7WOf5q9FO3rMyR
         r31vAxiiz5XvcyBUBB10cWblZVLjYYK28y3xraraatUCzKHNx2xpSfDQpVNFvit59PsH
         srJ2P43mACHUrGEUyXn9JEua5mNYY25g+FBFR+d78Ekqfq8atg+Se3lq+5AGmT05FE99
         4qtg3atwACB9yfTdEt/uQ0MKyCTEJMfYIWXm6wLBEUCIOx0nWOnON7zzgorS6GwGVZXU
         MNpnuO/F4zx9zXRIKrqdhrAhS7l6bJQoWkTE/bne4/UqHs0BGipiBa+LQHloscgJxnU+
         5feQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678088934;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tU7WT2qxwujzjjMyDpG88kr9l/E98M2ObflfoXUtYXA=;
        b=8RMg1r2VWsnh1yZYU26oHG+Vpmv6tKAy7VEniqUQ56lRjdaCo3Q+Bx//nj5I6NfOgl
         4nwIPTV1+9nqGfvoJXPiYamyMY6wKroAxBk5Y81xCKyOwtmqRvNAv2Tew9/aJECezBcM
         iETZB+gDArcAsYj/QryI2C09Yc3EsmPvSk9zP3jw52YAbtAwmemOBuwMuaVKPSUFvE0i
         3mX+E1mgplnqddjBHea3gwEob5qlp9UCShGtI6GFaZRV8jhKrNNGLzw2U9KU9/hoQvCp
         0HcTQvmaSa91kHeeyYCzXU2KXo9K10l9kzQ7QKVFSSyWz8o2oXobufqNGArcMtNR6053
         h5Ug==
X-Gm-Message-State: AO0yUKVeuE2E2aSa5aNx8DthZZ55FmhzQEFr6coAPy9LTiH527QoFhQp
        1v963uf6P0GnrmukmywtkXN3jcHwJTw=
X-Google-Smtp-Source: AK7set+q7RqpcZDH7x+VEP8f6bJoWZhpwfLXWvPzSxlSu89UL59HkW3xgsDMYIfmX/m/hI1ROC7+bg==
X-Received: by 2002:a05:651c:546:b0:295:c3fe:86d6 with SMTP id q6-20020a05651c054600b00295c3fe86d6mr3409272ljp.15.1678088933980;
        Sun, 05 Mar 2023 23:48:53 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (c-8ff371d5.879159-0-69706f6e6c79.bbcust.telenor.se. [213.113.243.143])
        by smtp.gmail.com with ESMTPSA id y16-20020ac24470000000b004dc4becfcd6sm1523678lfl.54.2023.03.05.23.48.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Mar 2023 23:48:53 -0800 (PST)
Date:   Mon, 6 Mar 2023 08:48:52 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <ZAWa5NpBHrPhaNWA@combine-ThinkPad-S1-Yoga>
References: <Y9/xXHvOAwfqoDxn@combine-ThinkPad-S1-Yoga>
 <3cb45313-209a-8190-12f8-6a2d49e4173b@wanadoo.fr>
 <Y+A+HF1vDeRIqye5@combine-ThinkPad-S1-Yoga>
 <Y+DL3O5lcMyZ/aNR@kroah.com>
 <Y+H9BT8Am4Ik2ZDA@combine-ThinkPad-S1-Yoga>
 <Y+IJgxF52lpgk0RC@ubun2204.myguest.virtualbox.org>
 <ZAVxo6WHGu3kO1nl@combine-ThinkPad-S1-Yoga>
 <ZAV7xvr3BCqByjy6@ubun2204.myguest.virtualbox.org>
 <ZAWAyyNt0rgrpA1l@combine-ThinkPad-S1-Yoga>
 <ZAWPk12Fz0gxaqzB@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAWPk12Fz0gxaqzB@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 12:30:35PM +0530, Deepak R Varma wrote:
> On Mon, Mar 06, 2023 at 06:57:31AM +0100, Guru Mehar Rachaputi wrote:
> > On Mon, Mar 06, 2023 at 11:06:06AM +0530, Deepak R Varma wrote:
> > > On Mon, Mar 06, 2023 at 05:52:51AM +0100, Guru Mehar Rachaputi wrote:
> > > > On Tue, Feb 07, 2023 at 01:49:15PM +0530, Deepak R Varma wrote:
> > > > 
> > > > Hej Deepak,
> > > > 
> > > > I have a problem in sending patchset through mutt.
> > > > I have been trying sending to my own mail address but it won't work.
> > > 
> > > This could be because of mutt configuration. There are some additional checks if
> > > you are trying to use mutt with gmail. Search over google or lore old posts to
> > > know more about it. The important aspect is to configure and test mutt well
> > > before you use it for sending out patches.
> > > 
> > > > 
> > > > When sending patchset I think we should use "In-Reply-To" flag and
> > > > include "Message-ID" to which we want this to be in series to. I tried
> > > > both "git send-email" feature and mutt "forwarding feature".
> > > 
> > > I have not used "git send-email", so can't help you there. But mutt has worked
> > > very well for me. Ensure you are reading and following the instructions from
> > > this page well: https://kernelnewbies.org/Outreachyfirstpatch
> > >
> > 
> > So for example from these patches: 0.patch, 1.patch
> > how to use "mutt -H" to send patches in one thread?
> > 
> > if first one is: mutt -H 0.patch
> > then should second one be: mutt -H 1.patch In-Reply-To: Message-ID?
> 
> Try this out by sending to yourself and you will know :)
> 
> There is a section "Using git format-patch to send patchsets" in the link I sent
> in my last email. Please read that.
> 
> Deepak.
>

I tried it and it won't work.
My question itself was how to use mutt to send patchset? which is not
clear on the site.

I have no problem in sending one single patch through mutt.

To be more clear:
https://lore.kernel.org/lkml/cover.1666299151.git.drv@mailo.com/
at above link, you submitted patchset.

How to send this series using mutt?
If I use "mutt -H x.patch" for every patch file they are seperate emails
in my inbox.

> > 
> > 
> > > > 
> > > > Another issue is, how to attach patch file from inside mutt(for example: 
> > > > "mutt -H x.patch" from command line is used to extract header and body of a 
> > > > mail in mutt)?
> > > 
> > > Why do you want to do that?
> > > Build a patch file using "git format-patch" and then use "mutt -H" to send the
> > > patch. Both the commands work directly from the command line. If there is a need 
> > > for any additional attachments in support of your patch [configs, logs, trace as
> > > evidence, test outcomes etc], you can attach those from within the "mutt -H"
> > > execution context.
> > > 
> > > I suggest testing mutt well before you start sending any patches out by sending
> > > the patches to yourself. Do not use any kernel mailing list for testing.
> > > 
> > > 
> > > Regards,
> > > Deepak.
> > > 
> > > > 
> > > > 
> > > > -- 
> > > > Thanks & Regards,
> > > > Guru
> > > > 
> > > 
> > > 
> > 
> > -- 
> > Thanks & Regards,
> > Guru
> > 
> 
> 

-- 
Thanks & Regards,
Guru
