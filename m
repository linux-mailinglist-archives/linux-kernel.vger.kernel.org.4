Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391F0622E9C
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 16:01:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231738AbiKIPBW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 10:01:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiKIPBT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 10:01:19 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8A713EA2;
        Wed,  9 Nov 2022 07:01:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1668006059; bh=Ts+sgdlB5+C6h7IQKtl88MwbuV2YmEIivE+EtogLjZU=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=V86lZ59Mld67mazxAY924nJ/Tzhmr9sDGOyEVFPVw2LqY0obZtC2epmXYy/0KFhXn
         5kFYcaznOkhF5V4E6DA6hEjPSl7cRxh8dynujy856UYgydUbj9xmSgBzEfZj/2LDyn
         zm8OWtjs01LIDFXG4aqVOW5RnDyNdppWas/XpsDA=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Wed,  9 Nov 2022 16:00:58 +0100 (CET)
X-EA-Auth: IHS1m4BGBcqLRC6EvgRMlCBBHxdqtIlIEmILytXZcdrnvm64GTGqUxKeqKzxga8JJnscIH8mf8odZik6JpxuviqZNAX3tdRA
Date:   Wed, 9 Nov 2022 20:30:52 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Julia Lawall <julia.lawall@inria.fr>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, dri-devel@lists.freedesktop.org,
        linux-fbdev@vger.kernel.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: fbtft: Use ARRAY_SIZE() to get argument count
Message-ID: <Y2vApJF0eNSkOQqP@qemulion>
References: <Y1vZXUi0Bjiub8HZ@ubunlion>
 <Y1zXIjCe3LGwApWD@kroah.com>
 <Y11b0oCmle2pbRel@ubunlion>
 <alpine.DEB.2.22.394.2210291931590.2917@hadrien>
 <Y191LI7zKVRA5LEb@ubunlion>
 <Y1+YC5OuycA5hLFx@ubunlion>
 <7dc9b4d2-413-3f65-1381-b164d810c3ee@inria.fr>
 <Y2T/FA0Ws9ExS+uz@qemulion>
 <Y2UkwwUn+IaCq3wf@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2UkwwUn+IaCq3wf@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 08:12:11PM +0530, Deepak R Varma wrote:
> On Fri, Nov 04, 2022 at 05:31:24PM +0530, Deepak R Varma wrote:
> > On Mon, Oct 31, 2022 at 01:05:32PM +0100, Julia Lawall wrote:
> > >
> > >
> > > I took a look, but it's pretty complex.  You could take the code and
> > > reorganize it so that it is more readable, and then take the definition of
> > > the ARRAY_SIZE macro, to better see what is going on.
> > >
> > > julia
> > >
> >
> > Hello Greg, Julia,
> > I was able to successfully build the fbtft object file for arm architecture as
> > well. I used gcc 6.5.0 and 9.5.0 tool chains. It was successful using both. I
> > have attached the build log from my machine for your reference.
> >
> > I am also looking at the .i file and rearrange the expanded macro to understand
> > it. However, since it is built successfully, I am not sure if that is truly the
> > problem area.
> >
> > Should I resend the patch and check if it still errors the kernel build bot?
> > Anything else I can try?
>
> Looks like the change I proposed is causing nesting inside the write_reg
> function due to additional set of { & } brackets for the __VA_ARGS__ symbol.
>
> Am I understanding it right?

Hello Julia, Greg,
I am unable to reproduce this build failure on my local machine. I tried the X86
and arm based build. I am unable to troubleshoot this further. Do you have any
other suggestions? If not, I will drop this patch from my watch list.

Thank you,
./drv

>
> >
> > Thank you,
> > ./drv
>
>
>
>


