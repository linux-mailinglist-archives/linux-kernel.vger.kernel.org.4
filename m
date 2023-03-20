Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E65B36C0A5D
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 07:09:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCTGJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 02:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCTGJQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 02:09:16 -0400
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5796A76B9
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:09:14 -0700 (PDT)
Received: by mail-ed1-x529.google.com with SMTP id z21so42345062edb.4
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 23:09:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679292552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=B7UOiw41bpLJve3LKKjgnQqbxjPTHaQhG5RB2MINhKQ=;
        b=SctT/Tkm/ivkqQkfVBpFtE7T/joHnHzcdEyHTJF0vqOrdSOpJjNXtNZMRHMkwu/iuL
         i5mk2R6Ce8BWJzubNGuGVykUorOapK3hQNmMUOEVgTQKh6beZW8mnBnnOprk35MzHUjc
         6ynFlGb4lfo44GRMGAJ8GbFkW8nxhTjV8ri0e4Wx9g6vfLd3Yq/CCvsDkAnw2H8kEcom
         e9v5OavtRdNMLWUYyejMibRVMIXde4ZtgsoPhtT8fQM4iIWJ5Vcxqegn7Gn+c+3T05m2
         xYrjeCcrhfPjldgAhl5kmjLewDtNOwwQTocdUEQFvk1pZBuA2UXO2Ol8nF+0K3XzJpaO
         7aKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679292552;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7UOiw41bpLJve3LKKjgnQqbxjPTHaQhG5RB2MINhKQ=;
        b=l0OeA/UrATBJqZiigHcYjAAchigbYrzyeiEjR7730VWSid95j2csL4ODxeE4TOelZv
         SN8DfVUU3kyfpJfYnMaNtnhUFkT5HIC0ydiEpO5J4k6GbruN16Y/PzlRq/MUNXy6VBhc
         ynm/w5cLHuBZALjkiQteXX9ZlrDmTYPHmHdpFuhXYcB1fDhL8EyMAe95HUjz6XkiaIJQ
         RMQdgs0TnljP1xPJzju58wvJ26figWeMuw9wvwSaoMk1ARa2krSGXrkaxROm7Vq/UewM
         f7YzqgPn32Rfk1SrTxOExZmYOQcLWTRfJSdX+1xAajc6ZnaM359QPXQiifGa5tluxCe0
         R2PA==
X-Gm-Message-State: AO0yUKUbCrDK6QWi22sz8jzMR8NtpIug6e1kPaq3ASPNtfk70iA7EDM9
        8wiMhqpNLq2dw1LGTtploJ7xFA+4BNpPCPfb
X-Google-Smtp-Source: AK7set///LL3/LUcKa4wejbguEjJf3lHvo8oqS3aIVB6f/6JY4Aq2YUilOD/xGkq/E/nILjev1ahIQ==
X-Received: by 2002:a17:906:3393:b0:8b1:7fa:6588 with SMTP id v19-20020a170906339300b008b107fa6588mr7815475eja.12.1679292552481;
        Sun, 19 Mar 2023 23:09:12 -0700 (PDT)
Received: from khadija-virtual-machine ([39.41.14.14])
        by smtp.gmail.com with ESMTPSA id gy15-20020a170906f24f00b00932bfab0fcesm2973754ejb.55.2023.03.19.23.09.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Mar 2023 23:09:12 -0700 (PDT)
Date:   Mon, 20 Mar 2023 11:09:09 +0500
From:   Khadija Kamran <kamrankhadijadj@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     outreachy@lists.linux.dev, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v8] staging: axis-fifo: initialize timeouts in init only
Message-ID: <ZBf4hUBVnqkw9xGs@khadija-virtual-machine>
References: <ZBN3XAsItCiTk7CV@khadija-virtual-machine>
 <ZBQTIVk0zsgv1hMH@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZBQTIVk0zsgv1hMH@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 17, 2023 at 08:13:37AM +0100, Greg Kroah-Hartman wrote:
> On Fri, Mar 17, 2023 at 01:09:00AM +0500, Khadija Kamran wrote:
> > Initialize the module parameters, read_timeout and write_timeout once in
> > init().
> > 
> > Module parameters can only be set once and cannot be modified later, so we
> > don't need to evaluate them again when passing the parameters to
> > wait_event_interruptible_timeout().
> 
> I feel like we are being too picky here, but this isn't the correct
> wording.  It is possible for module parameters to be modified "later",
> if the permissions on the parameter are set to allow this.  But that's
> not what this driver does here, so this might be better phrased as:
> 
>   The module parameters in this driver can not be modified after
>   loading, so they can be evaluated once at module load and set to
>   default values if needed at that time.
> 
> > Convert datatype of {read,write}_timeout from 'int' to 'long int' because
> > implicit conversion of 'long int' to 'int' in statement
> > '{read,write}_timeout = MAX_SCHEDULE_TIMEOUT' results in an overflow.
> > 
> > Change format specifier for {read,write}_timeout from %i to %li.
> 
> You are listing all of _what_ you do here, not really _why_ you are
> doing any of this.
> 
> Anyway, if I were writing this, here's what I would say as a changelog
> text:
> 
>   The module parameters, read_timeout and write_timeout, are only ever
>   evaluated at module load time, so set the default values then if
>   needed so as to not recompute the timeout values every time the driver
>   reads or writes data.
> 
> 
> And that's it, short, concise, and it explains why you are doing this.
> 
> Writing changelog comments are almost always harder than actually
> writing the patch (at least for me.)  So don't feel bad, it take a lot
> of experience doing it.
> 
> All that being said, I think we are just polishing something that
> doesn't need to really be polished anymore, so let me go just apply this
> patch as-is to the tree now so you can move on to a different change.
> You've put in the effort here, and I don't want you to get bogged down
> in specifics that really do not matter at all overall (like the memory
> size of your vm...)
>


Okay Great! Thank you Greg!

Regards,
Khadija


> thanks,
> 
> greg k-h
