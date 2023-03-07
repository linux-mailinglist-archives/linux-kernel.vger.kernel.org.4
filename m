Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C69876AD8E8
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 09:14:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230019AbjCGIOf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 03:14:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229978AbjCGIO3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 03:14:29 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DEFC32CC4
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 00:14:21 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id o12so48896071edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 00:14:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678176859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=pr+26vzgDeJLqQAilu40dzjhbxI+5AdQEIXA0XhigQ4=;
        b=I40usB2+N6+NwnCF8DcVqyFjns5MSIbiMdgHHJjiRu6kZIbAmwQmv4RYdcx+dAS97T
         hP0UPRRUB0mdPsF6x+tukcJ7ptBXN4DBVk5iJQf5MTSjZf/O9aM1hjLokwfoMV0ana73
         zstvzYMro2PYHN3hxpUWRl5SoxJ4dHG0B3ugTZSHFCVI/GiFV+aVK1gw8/jCUHm/DcLj
         P+blCXHyd187Vt0W4+VKH5OfcF2uUS6CNfbeCafquLFIrXgxybt6VcC52RB0m4KAdzlr
         hJWEozAScLCnpDXw0DGATMX4ngvvN07k8WOmXbCgyfDDHrKF6Qqh4bn0k1QTd4+nrxyY
         rMNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678176859;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pr+26vzgDeJLqQAilu40dzjhbxI+5AdQEIXA0XhigQ4=;
        b=eBlc2LKReHavBpqJEsgpO1C2MB37XxF5usYMOsQ6FfklSH/un66bBlG8h9h8gMJ78K
         /2VV11SfSFALqraLU5tSMvaxbaoAaV67xAR196J5DoNIUtz5TQOByPNva8lmyzy1ev7x
         u+pzEShinkGvnBd4JatY8aH0Josfl7jM8C0EwNozRbJmnngm/UPXOZSFST79WbLl4qj2
         j/IGrl28AKk78JZSyf5oSDVXXx+sCpsCseXxZhILkEemyrWu/MGkeJMLyVnM90Ir9+9g
         2XUbceQX1th/3hs+m6xpZy1kqt13FFzni7QdT8RmLkDRTcq8U/uSpuzg74McwJoUDo2K
         2U+w==
X-Gm-Message-State: AO0yUKWRUQq88o7CNwormrf1LufY3E1wvSCAALhMuqGkTnB4Rn8WR/vS
        aaJd4JRT83ScKryTKpCpnqw=
X-Google-Smtp-Source: AK7set9LaU77Vnz/a360K5BNHzMQ6d+5u3gkBAh7Qemwh4uPH0gs17KtV+U0lChgGtgbfwmmDXvDfA==
X-Received: by 2002:a17:906:328c:b0:87d:eff1:acc8 with SMTP id 12-20020a170906328c00b0087deff1acc8mr13535611ejw.48.1678176859560;
        Tue, 07 Mar 2023 00:14:19 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id o21-20020a170906289500b008ef42f9cf48sm5660380ejd.82.2023.03.07.00.14.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Mar 2023 00:14:19 -0800 (PST)
Date:   Tue, 7 Mar 2023 11:14:16 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Khadija <kamrankhadijadj@gmail.com>, outreachy@lists.linux.dev,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: axis-fifo: alignment should match opening
 parenthesis in axis-fifo.c
Message-ID: <2daec4ed-9553-466f-ac42-315545b9b0be@kili.mountain>
References: <ZAZSmPpB6fcozGa4@khadija-virtual-machine>
 <alpine.DEB.2.22.394.2303062202500.3050@hadrien>
 <CACcTnM5GR0ZM5WBaL+BDEK_0QJGr6h2t4tnsnjerHta_nq6Tmg@mail.gmail.com>
 <ab0fd80-22c-d982-2f4-6fa5f43f858@inria.fr>
 <78d1ea82-ef18-42b2-8a8e-27ee3c7ad55f@kili.mountain>
 <aebfe9ab-3fec-d718-6e7-1cddac2b20a4@inria.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <aebfe9ab-3fec-d718-6e7-1cddac2b20a4@inria.fr>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 09:07:37AM +0100, Julia Lawall wrote:
> 
> 
> On Tue, 7 Mar 2023, Dan Carpenter wrote:
> 
> > On Tue, Mar 07, 2023 at 08:49:55AM +0100, Julia Lawall wrote:
> > >
> > >
> > > On Tue, 7 Mar 2023, Khadija wrote:
> > >
> > > > Hey Julia! Thank you for the feedback. I will make the following changes and
> > > > resend the patch:
> > > > 1. Correct the patch description that is right under the subject line (make
> > > > it precise and imperative) and make sure that it does not have more than 70
> > > > characters per line.
> > > > 2. Adjust all the arguments of wait_event_interruptible_timeout so that they
> > > > are lined up. All of them should begin right under ( .
> > >
> > > The problem here is that the ( is really far to the right.  My opinion is
> > > that the position of the second argument (ie the first one that is on a
> > > line of its own) is ok in this case.  So you can leave that one where it
> > > is and line up the other one.
> > >
> >
> > I kind of like lining things up like this.  I think if you can't align
> > things with the parens, then it's nice to at least use two tabs.  It's
> > not kernel style or anyone's style explicitly, but I kind of like it.
> >
> > It doesn't make checkpatch happy.
> >
> > I guess I probably wouldn't bother sending this patch.  To controversial.
> > I'd just move on to something else.  It's not like there is a shortage
> > of stuff to do.  One idea in this file is that you could use
> > sysfs_emit() in sysfs_read() and get rid of char tmp[32]; buffer.
> 
> Dan, the problem is not that the argument is to the left of the (
> 
> The problem is that the last argument is indented exactly as though it
> were an argument of the second argument.  But it's not.  You have to count
> the parentheses to see that.  It's very misleading.
> 

True.  I get that.  I guess any change which fixes that is worth
applying.

regards,
dan carpenter

