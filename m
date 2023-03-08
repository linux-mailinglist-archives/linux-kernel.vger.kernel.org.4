Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DCA66B1020
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:24:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229963AbjCHRX5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:23:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjCHRXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:23:23 -0500
Received: from mail-lj1-x232.google.com (mail-lj1-x232.google.com [IPv6:2a00:1450:4864:20::232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5D313B0F4
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 09:23:13 -0800 (PST)
Received: by mail-lj1-x232.google.com with SMTP id z5so17353146ljc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Mar 2023 09:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678296191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LNWXfkA/VElZCzTndG/AybBAJC3S60n0GhnxwQn3ifE=;
        b=L+UhgUknsSlFSx3k5GPRw0HrOa2sfjA+rj3RFkCBTKQN1q7X+7XuICwojfnnTr89TN
         GkYE2R+iU0d5ITkRHZd50ER+dK8xUbj+c7/+UfyPfx0daquRxYskiEnIoO8fmXd3waI1
         bLfavBvh8JuFjLJZUbg/24MBkAYDRdZ6GUseOrw6yDE7S8ckLeUyYB035gnaUc8ZkDPQ
         jtXkMSs+NAT7DdFXQVgKkCGy7JeG5M7mY7Q/lME3O3OeFb8m6wnGbzPZyoUbKwoAIysg
         DotZPXvuWNS6IIi4ulQ52pknFd/WFbVDbuKkdiA2J/CFEIFEmS9v+Vj/fh/0c6ck8nC+
         ssEg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678296191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LNWXfkA/VElZCzTndG/AybBAJC3S60n0GhnxwQn3ifE=;
        b=n6IIptbvKdA9WDirim5JdntM2W+0fUZcIeb4FJ8KhT51xqr6TBBO/hk1/ZjDcD7feh
         ddxgtEAfkNP34GU4cbqIgRY6pjJ4FFTHoyBaQJDeZqBP2tbUpsCzHGGYBfbjqqlVfA+1
         3VOE0Xo2COD7iDSXjly5V/2rnh9NFl5aaVQ2eMclOKBI6ngweO/fJE7jr+7+DgZIaQn4
         65eYGqwD8Rq3r8Vj8EZTJhX7Z9ep4/n29quc7LV7k+ss3506IBCfBCgThxJFRjzwat5q
         Zq43iW2ZJZJTumVoIGW9gW1fRmkqllC2L0hrYOfhJWBxuvZQZT825EiuQ184WC5g1eKm
         kfPQ==
X-Gm-Message-State: AO0yUKVzbMiyF0UotLbE7uKE7OVihLJYHxxJPnx2fHae5I+rGwmJTYzM
        IcP8ruUq6BbvI1XHh4TDOIA=
X-Google-Smtp-Source: AK7set9BNVu5g6ur1sR1cQDSj+MlkYxsQyQy/76CpCZVD1HRAgebiobKTBK6lBz/TkrkRXH+z0a8gQ==
X-Received: by 2002:a2e:be0b:0:b0:298:592e:5646 with SMTP id z11-20020a2ebe0b000000b00298592e5646mr3391350ljq.32.1678296191190;
        Wed, 08 Mar 2023 09:23:11 -0800 (PST)
Received: from combine-ThinkPad-S1-Yoga (gw.combine.ideon.se. [85.235.7.115])
        by smtp.gmail.com with ESMTPSA id h15-20020ac250cf000000b004a0589786ddsm2408182lfm.69.2023.03.08.09.23.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Mar 2023 09:23:10 -0800 (PST)
Date:   Wed, 8 Mar 2023 18:23:09 +0100
From:   Guru Mehar Rachaputi <gurumeharrachaputi@gmail.com>
To:     Deepak R Varma <drv@mailo.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Forest Bond <forest@alittletooquiet.net>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] staging: vt6655: Macro with braces issue change to
 inline function
Message-ID: <ZAjEffh/wKeaagcN@combine-ThinkPad-S1-Yoga>
References: <Y+A+HF1vDeRIqye5@combine-ThinkPad-S1-Yoga>
 <Y+DL3O5lcMyZ/aNR@kroah.com>
 <Y+H9BT8Am4Ik2ZDA@combine-ThinkPad-S1-Yoga>
 <Y+IJgxF52lpgk0RC@ubun2204.myguest.virtualbox.org>
 <ZAVxo6WHGu3kO1nl@combine-ThinkPad-S1-Yoga>
 <ZAV7xvr3BCqByjy6@ubun2204.myguest.virtualbox.org>
 <ZAWAyyNt0rgrpA1l@combine-ThinkPad-S1-Yoga>
 <ZAWPk12Fz0gxaqzB@ubun2204.myguest.virtualbox.org>
 <ZAWa5NpBHrPhaNWA@combine-ThinkPad-S1-Yoga>
 <ZAWkzuCF9GaqnnaJ@ubun2204.myguest.virtualbox.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZAWkzuCF9GaqnnaJ@ubun2204.myguest.virtualbox.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 06, 2023 at 02:01:10PM +0530, Deepak R Varma wrote:
> On Mon, Mar 06, 2023 at 08:48:52AM +0100, Guru Mehar Rachaputi wrote:
> > On Mon, Mar 06, 2023 at 12:30:35PM +0530, Deepak R Varma wrote:
> > > On Mon, Mar 06, 2023 at 06:57:31AM +0100, Guru Mehar Rachaputi wrote:
> > > > On Mon, Mar 06, 2023 at 11:06:06AM +0530, Deepak R Varma wrote:
> > > > > On Mon, Mar 06, 2023 at 05:52:51AM +0100, Guru Mehar Rachaputi wrote:
> > > > > > On Tue, Feb 07, 2023 at 01:49:15PM +0530, Deepak R Varma wrote:
> > > > > > 
> > > > > > Hej Deepak,
> > > > > > 
> > > > > > I have a problem in sending patchset through mutt.
> > > > > > I have been trying sending to my own mail address but it won't work.
> > > > > 
> > > > > This could be because of mutt configuration. There are some additional checks if
> > > > > you are trying to use mutt with gmail. Search over google or lore old posts to
> > > > > know more about it. The important aspect is to configure and test mutt well
> > > > > before you use it for sending out patches.
> > > > > 
> > > > > > 
> > > > > > When sending patchset I think we should use "In-Reply-To" flag and
> > > > > > include "Message-ID" to which we want this to be in series to. I tried
> > > > > > both "git send-email" feature and mutt "forwarding feature".
> > > > > 
> > > > > I have not used "git send-email", so can't help you there. But mutt has worked
> > > > > very well for me. Ensure you are reading and following the instructions from
> > > > > this page well: https://kernelnewbies.org/Outreachyfirstpatch
> > > > >
> > > > 
> > > > So for example from these patches: 0.patch, 1.patch
> > > > how to use "mutt -H" to send patches in one thread?
> > > > 
> > > > if first one is: mutt -H 0.patch
> > > > then should second one be: mutt -H 1.patch In-Reply-To: Message-ID?
> > > 
> > > Try this out by sending to yourself and you will know :)
> > > 
> > > There is a section "Using git format-patch to send patchsets" in the link I sent
> > > in my last email. Please read that.
> > > 
> > > Deepak.
> > >
> > 
> > I tried it and it won't work.
> > My question itself was how to use mutt to send patchset? which is not
> > clear on the site.
> > 
> > I have no problem in sending one single patch through mutt.
> > 
> > To be more clear:
> > https://lore.kernel.org/lkml/cover.1666299151.git.drv@mailo.com/
> > at above link, you submitted patchset.
> > 
> > How to send this series using mutt?
> > If I use "mutt -H x.patch" for every patch file they are seperate emails
> > in my inbox.
> 
> The following command creates cover letter and patches as a threads
> 
> git format-patch -o /tmp/ --cover-letter -n --thread=shallow commitIDx^..commitIDy
> 
> Send cover-letter and patches with mutt -H XXXXX command
> 
> Note: Cover letter us optional. If you do not have one, the patches will still
> be threaded.
> 
> HTH
> Deepak.
> 
>
I get it now, thank you deepak :)
> 
> 
> > 
> > > > 
> > > > 
> > > > > > 
> > > > > > Another issue is, how to attach patch file from inside mutt(for example: 
> > > > > > "mutt -H x.patch" from command line is used to extract header and body of a 
> > > > > > mail in mutt)?
> > > > > 
> > > > > Why do you want to do that?
> > > > > Build a patch file using "git format-patch" and then use "mutt -H" to send the
> > > > > patch. Both the commands work directly from the command line. If there is a need 
> > > > > for any additional attachments in support of your patch [configs, logs, trace as
> > > > > evidence, test outcomes etc], you can attach those from within the "mutt -H"
> > > > > execution context.
> > > > > 
> > > > > I suggest testing mutt well before you start sending any patches out by sending
> > > > > the patches to yourself. Do not use any kernel mailing list for testing.
> > > > > 
> > > > > 
> > > > > Regards,
> > > > > Deepak.
> > > > > 
> > > > > > 
> > > > > > 
> > > > > > -- 
> > > > > > Thanks & Regards,
> > > > > > Guru
> > > > > > 
> > > > > 
> > > > > 
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
