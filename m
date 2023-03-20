Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0446C0A77
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:17:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229767AbjCTGRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229764AbjCTGRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:17:42 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5299220A0A
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:17:24 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z21so42393344edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679293042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=h6v9X+W3g9Lp9MD6mxsN+blVRBFSCLDbas/dIhTrItQ=;
        b=WbAEnrH+g1b/13l63UI1SoKC9u7r4LqpqoU8AC++IRyfdrN2EtssmK/XLyfmiw85vi
         YhP8OvashrWH+5UYbGRq4U5Oiqvpf9XVqlDB7H+Edma3+BGkr/M/7rfYxHFya5PkdgG6
         TJq+CwVuW0UPDVgmdoCptEVEgVaBXb0WOwFcxYQFLwWxYAsPpfnE12D8tKi5gSPxcT5h
         ZGPrpPh53tIj6MmOu+ZGPi1LAi/KdVnZz4lc7+HWF1Fr5k0x4o48Zd8aTTghxMW3KfnG
         vMvxGmsHFqeUF49+qc5z6I3oFHqeWi190O8RREx6vQog3YiZB4zX6RpWrUwKcEt6Vwd3
         HIuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679293042;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=h6v9X+W3g9Lp9MD6mxsN+blVRBFSCLDbas/dIhTrItQ=;
        b=KnpUqzXeXCHAShQYrI8kap8+Y+6+Qb/ZWFu9PZqKkyeSJ0qROCJRQKOZykxWT4ny+N
         MS87LOdDPumb35ivnYQUcTvKNZxj1iF2AozEXKtvacXAwvdtcvDt2tl6N8rNAObhhLIu
         zXMx6k6d8ZcjA6CcAqDGTrbXr3Rbxh4KsnlkU/EYAk71dp9fx2iQoYLKMM5MwZR2DAGT
         C/mT7jxiE8yBnBoH227YMEasdDGs254janXNFW7n1IxZD0iq8SvO4ldLE3VHYSDMJ0rS
         QT4PidBZ9OhWGFjIQ4bSUrFf0mOZfwKkMNCrDLG3OBwyEgzBhLKCHHqMOLCKwx5N6AfL
         wNyw==
X-Gm-Message-State: AO0yUKXGpcw/dmpcWAX6ps/TOT/33Qd2R7FiZLwTV+rRHeec4Pu6MOo5
        kAHGxAC65JlBQeHLfsWgbYVHJ/F7p5Jv+VQ7
X-Google-Smtp-Source: AK7set/PMFO86QyDKguFPjFq921OFv/H3cV08pZk7oQq6IeVXUdI1IC4mXkk/+vhxP65szL3PDwz9g==
X-Received: by 2002:a17:907:3f17:b0:933:4647:a289 with SMTP id hq23-20020a1709073f1700b009334647a289mr7661024ejc.48.1679293042505;
        Sun, 19 Mar 2023 23:17:22 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id a10-20020a1709065f8a00b0092595899cfcsm3957527eju.53.2023.03.19.23.17.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:17:20 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:17:18 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     "Fabio M. De Francesco" <fmdefrancesco@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] staging: axis-fifo: initialize timeouts in init only
Message-ID: <ZBf6bhzRXRQJi6Bc@khadija-virtual-machine>
References: <ZBN3XAsItCiTk7CV@khadija-virtual-machine>
 <ZBQTIVk0zsgv1hMH@kroah.com>
 <2499410.4XsnlVU6TS@suse>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <2499410.4XsnlVU6TS@suse>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 09:58:17AM +0100, Fabio M. De Francesco wrote:
> On venerdì 17 marzo 2023 08:13:37 CET Greg Kroah-Hartman wrote:
> > On Fri, Mar 17, 2023 at 01:09:00AM +0500, Khadija Kamran wrote:
> > > Initialize the module parameters, read_timeout and write_timeout once in
> > > init().
> > > 
> > > Module parameters can only be set once and cannot be modified later, so we
> > > don't need to evaluate them again when passing the parameters to
> > > wait_event_interruptible_timeout().
> > 
> > I feel like we are being too picky here, but this isn't the correct
> > wording.  It is possible for module parameters to be modified "later",
> > if the permissions on the parameter are set to allow this.  But that's
> > not what this driver does here, so this might be better phrased as:
> > 
> >   The module parameters in this driver can not be modified after
> >   loading, so they can be evaluated once at module load and set to
> >   default values if needed at that time.
> > 
> > > Convert datatype of {read,write}_timeout from 'int' to 'long int' because
> > > implicit conversion of 'long int' to 'int' in statement
> > > '{read,write}_timeout = MAX_SCHEDULE_TIMEOUT' results in an overflow.
> > > 
> > > Change format specifier for {read,write}_timeout from %i to %li.
> > 
> > You are listing all of _what_ you do here, not really _why_ you are
> > doing any of this.
> > 
> > Anyway, if I were writing this, here's what I would say as a changelog
> > text:
> > 
> >   The module parameters, read_timeout and write_timeout, are only ever
> >   evaluated at module load time, so set the default values then if
> >   needed so as to not recompute the timeout values every time the driver
> >   reads or writes data.
> > 
> > 
> > And that's it, short, concise, and it explains why you are doing this.
> > 
> > Writing changelog comments are almost always harder than actually
> > writing the patch (at least for me.)  So don't feel bad, it take a lot
> > of experience doing it.
> 
> Thanks for helping Khadija (and also me, indirectly, because I helped them to 
> make that commit message). After a little less than 200 commits already 
> upstream, there is still to learn how to make a good changelog (which I think 
> it's not less important than the code in the patch).  
>

Hey Fabio!
I am glad to be a part of this process. Thank you for all the help
with the commit messages. :)

> > All that being said, I think we are just polishing something that
> > doesn't need to really be polished anymore,
> > so let me go just apply this
> > patch as-is to the tree now so you can move on to a different change.
> 
> Yes, thanks. It's time to move on.
>

yes, please.

> > You've put in the effort here, and I don't want you to get bogged down
> > in specifics that really do not matter at all overall (like the memory
> > size of your vm...)
> 
> You probably didn't pay attention to the problems Khadija has being 
> experiencing with memory exhaustion and compilation times. 
> 
> First time they complained had several crashes while building and messages 
> saying there was not enough available memory. Then several other problems with 
> builds' time. Finally, yesterday they wrote that "make modules_install 
> install" took "hours" (literally).
> 
> This is why I think they should also be helped with their VM configuration 
> (despite it was unrelated to the patch). They won't be able to work on some 
> projects if they cannot do quick builds and run hundreds of tests in no time 
> (e.g., I'm especially talking about Ira's and my project about the conversions 
> from kmap{,_atomic}() to kmap_local_page()).
>

Thank you Fabio!
I am waiting for your message on #kernel-outreachy. 

Regards,
Khadija

> I understand that this is only noise for you, as a maintainer. However I'm 
> pretty sure that they need help with speeding up builds and installation. The 
> projects cannot wait "hours" just for install of modules and kernel images.
> 
> Again thanks for your precious suggestions about how to improve commit 
> messages.
> 
> Fabio 
> 
> > thanks,
> > 
> > greg k-h
> 
> 
> 
> 
