Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C54406C14DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 15:36:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231588AbjCTOgO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 10:36:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231479AbjCTOgK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 10:36:10 -0400
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ADF4F1A651
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:36:08 -0700 (PDT)
Received: by mail-ed1-x52c.google.com with SMTP id cn12so1965785edb.4
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 07:36:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679322967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+bhKdJGctfgNktjxuVj2so7dX31mlyALoONZ3xTxQAo=;
        b=h8UPhcIEH39Ywj5eMgZz0xyTP3unUC/KUfkRJw0CqfGPlEKN6SwKqG2gqt1qfYfKz8
         UCy6FmSEU6W7FJdpoEKE5cBmfQuvwRdvomX+bZRIIUpHIwRsKgXNLAuaQvndtkd17GzJ
         HJK4SKYWulZhCWvfwkMozsbjVthDUgWwl2fold1owMQTDwa6vsG6ivVxdFTu/iTccaRy
         RRH/I+NOLyu0XndnjKft6VjQ7okAs7qb9X4s60zwKW+2jmFN/ty7U3NqEOSZxHkV379c
         mhV4P2VKedk0b7yxKVEddlF89/2DHCvGPs959aXjJOrEPBZjE/RrqN2xIicXLCYG+AUy
         4lLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679322967;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+bhKdJGctfgNktjxuVj2so7dX31mlyALoONZ3xTxQAo=;
        b=7W/ULa0L8o35DqGbE5neTm2yU9/zJ+yMy6jTPenQYlDhj5i4QcdIF0UCf6tLlHJ0jm
         JD0YbMGpnazX1yMWxFXGiV+B/z7wfrxCNL4sJFmZ8vukftzfT/kbpLrejPKVx3H0Vkdw
         UJHaTg42yODSNKP/JJGhdVzS2eutnsdTdrYD0Rya6x8n5V+GfwG10Lnmfmc12HXJYoBc
         0NiVauzLVEUs18aGfpUXSaumOwX0itQlhLNbufu/Z1NBN3hUua7Kx0j8iyZFSdjerrbU
         YabcDGGFrnpilxPGnGh/NH+Pr9CKTUxFe87WTPG2wQLWPt66aeZWeRcXfENS/Tubfnes
         1z7g==
X-Gm-Message-State: AO0yUKWNvJXNsKnOEjto8Lx1K3eaq2Q+UJlzxCD4DYt07SrIUzbucvJ9
        8QU+UhS8ADCKSkmfqy6LEgCGMm73sFpUTefTrv0=
X-Google-Smtp-Source: AK7set8jbwJ62Rb4/CWNBz2G/at5rbfmgI979Xo7rDZoF8x9yzaT6t4b5n/rH43xpuzCDJQl76yolQ==
X-Received: by 2002:aa7:c658:0:b0:4fb:e14:c25b with SMTP id z24-20020aa7c658000000b004fb0e14c25bmr12070380edr.33.1679322966785;
        Mon, 20 Mar 2023 07:36:06 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id b44-20020a509f2f000000b004c09527d62dsm4969535edf.30.2023.03.20.07.36.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Mar 2023 07:36:06 -0700 (PDT)
Date:   Mon, 20 Mar 2023 19:36:03 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     outreachy@lists.linux.dev,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] staging: axis-fifo: initialize timeouts in init only
Message-ID: <ZBhvU/USP0es8e4P@khadija-virtual-machine>
References: <ZBN3XAsItCiTk7CV@khadija-virtual-machine>
 <2222576.3ZeAukHxDK@suse>
 <ZBf+XDN8GM0xDDCq@khadija-virtual-machine>
 <3180435.l52yBJDM9G@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3180435.l52yBJDM9G@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 20, 2023 at 02:38:24PM +0100, Fabio M. De Francesco wrote:
> On lunedì 20 marzo 2023 07:34:04 CET Khadija Kamran wrote:
> > On Fri, Mar 17, 2023 at 11:29:25AM +0100, Fabio M. De Francesco wrote:
> > > Khadija,
> > > 
> > > Congratulations for having your first patch in Linux, via Greg's staging
> > > tree.
> > > 
> > > It will take some time before it reaches mainline, although it is already 
> on
> > > its way to get upstream.
> > 
> > Thank you! :)
> > 
> > > On giovedì 16 marzo 2023 21:09:00 CET Khadija Kamran wrote:
> > > > Initialize the module parameters, read_timeout and write_timeout once in
> > > > init().
> > > > 
> > > > Module parameters can only be set once and cannot be modified later, so 
> we
> > > > don't need to evaluate them again when passing the parameters to
> > > > wait_event_interruptible_timeout().
> > >


Hey Fabio,
I am talking about this below:


> > > Greg made you (and indirectly me notice) that the statement above is a 
> kind
> > > of short-circuit because it misses to make the readers notice that you are
> > > dealing with specific permissions granted to these two module's 
> parameters.
> 
> Only "read" permissions for owner, group, others.
> Obviously, when the module is initialized, "insmod" can pass actual values to 
> the arguments. The point is that from that moment onward nobody is allowed to 
> change the initial values associated with this variables, but they can still 
> be read at will.
> 
> > I am trying to make sense of this. As the permissions do not allow
> > write, so the value cannot be configured afterwards.
> 
> Yes, if with "afterwards" you are intending after they are set at insmod runs. 
> 
> > Instead of saying 'cannot be modified later', we should talk more about
> > permissions here too.
> 
> I'm confused by this statement. Can you please rephrase?
> 
> > Am I getting it right?
> 
> Not sure, it depends on what you meant with the previous phrase.

As you said above that the commit message makes the reader miss the
permission details, so should we write more about permissions in the
description?


>  
> > Thank you!
> > 
> > Regards,
> > Khadija
> 
> You're welcome!
> 
> So, thanks for working on this patch as long as it takes to get it done. 
> 
> I think the lesson to be learned is that in our community there are barriers 
> to the entry of substandard products and therefore people have to do their 
> best if they really want to see their work applied.


Yes, you are right. Due to this reason, the whole process is making me
learn a lot. I am really glad to be a part of it ^-^ 


> These tasks are not for the "faints of heart" :-)
> 
> Fabio
>

Regards,
Khadija :)


> 
> 
