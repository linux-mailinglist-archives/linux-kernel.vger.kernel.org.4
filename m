Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98BDC6CEC67
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 17:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230419AbjC2PIo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 11:08:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2PIm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 11:08:42 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E05840D9
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:08:23 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id m2so16084538wrh.6
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 08:08:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680102502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cLqJhQMaFDVDwir91iG5u9uTplZGw8VD4gR41F8nB1k=;
        b=KhvUbJT4Av7xzTMbSWNOO1siZ0qNc+lIz9Lt48+ImwgXApDJw9+g+VMgMWVuVOCUfB
         +4QM8tSCHX7sovgz1XmVWkPQhBrYi/bfd/6HddiRQvQ2AS23lQf84eJBz89GMhPN2xKm
         eKEOvYUJECI5OxN8GRnKuKOaldUtW1GOWdNgPF3q922ey1Xxsg+/Mzi+d9TXlk4lRp4b
         v/gcVm9QYfF/rj0xlAvglj3AV5LQlv+VZnuGj3jJwzjDyabWiwT4PgfoHXdK4W/p1GF8
         sKt5FVZrxiM1cCr6LkchYzJwMUKpdE9FxAeC3pPXPuAIvVy4Vbo00tlbsc1t3a3+mZVl
         kk2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680102502;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cLqJhQMaFDVDwir91iG5u9uTplZGw8VD4gR41F8nB1k=;
        b=N1aBvrK+kXVOi38vwWF7N88CXb1ykungeClQOHR9mAzuu8gq4vQdVC6yVpwpVKNanJ
         gfPLDHdDPa3zwRWgT7t01IEPxkupLB1TSiYS6R56E02EJnl2kNbVMoGx7Gbr9P6vIGfp
         GiWAWZoK8KYTcuONLGqyEtvKHZtK1OyPc4tTlwvjqKjpVmHPSXEGQ7k29ZTRizWIKqIe
         IgZNVYM0aaGjoSFLeYM5cust/06rE86KzAARePiXlx0t6jD92r1RaqQ1DiS6STQDCpKa
         +VxgC+L+PK+w24pZtSYyCMBNlhqrYmGztcMGEh8ywpIMqAQA4vsBor5MpYRpx6qZxSq6
         CPUQ==
X-Gm-Message-State: AAQBX9fD9rhy5fnjdW1gl5PKDwuWtDSTOIS98QP9caE88/VerFS+c7c8
        CyG9N4hgyBiQA3Bziyjk49yx7Q==
X-Google-Smtp-Source: AKy350bDav8MHFZ7bINEHrERRe/L0sIk0whGqY5osDPnWzGNlG1THJmIYgUxk+Dc0oXbNARD7NRi4w==
X-Received: by 2002:adf:e90b:0:b0:2d4:751d:675b with SMTP id f11-20020adfe90b000000b002d4751d675bmr15047399wrm.35.1680102502068;
        Wed, 29 Mar 2023 08:08:22 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id a7-20020adff7c7000000b002c70ce264bfsm30710058wrq.76.2023.03.29.08.08.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 08:08:21 -0700 (PDT)
Date:   Wed, 29 Mar 2023 16:08:17 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCRUYQHORVund9PC@google.com>
References: <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
 <20230329085106.046a8991@rorschach.local.home>
 <ZCQ2jW5Jl/cWCG7s@google.com>
 <20230329091107.408d63a8@rorschach.local.home>
 <ZCQ9m5K34Qa9ZkUd@google.com>
 <20230329093602.2b3243f0@rorschach.local.home>
 <ZCRDXaTVfNwxdRJZ@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCRDXaTVfNwxdRJZ@google.com>
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 02:55:41PM +0100, Vincent Donnefort wrote:
> On Wed, Mar 29, 2023 at 09:36:46AM -0400, Steven Rostedt wrote:
> > On Wed, 29 Mar 2023 14:31:07 +0100
> > Vincent Donnefort <vdonnefort@google.com> wrote:
> > 
> > > We can say we update cpu_buffer->reader_page->read on the get_reader_page ioctl,
> > > to the most recent value possible, which will have the consequence of actually
> > > "flushing" those events?
> > 
> > Yes. It should be no different than doing a normal read of the
> > trace_pipe_raw file, which does the same.
> > 
> > > 
> > > If the reader decides to read events past this value then it just can't expect
> > > them to not be duplicated?
> > > 
> > > I suppose it'd be down the reader to store meta->read somehwere?
> > > 
> > >    prev_read = meta->read
> > >    ioctl(fd, TRACE_MMAP_IOCTL_GET_READER_PAGE)
> > >    /* read events from prev_read to meta->read */
> > 
> > Yes, in fact it shouldn't need to call the ioctl until after it read it.
> > 
> > Maybe, we should have the ioctl take a parameter of how much was read?
> > To prevent races?
> 
> Races would only be with other consuming readers. In that case we'd probably
> have many other problems anyway as I suppose nothing would prevent another one
> of swapping the page while our userspace reader is still processing it?
> 
> I don't know if this is worth splitting the ABI between the meta-page and the
> ioctl parameters for this?
> 
> Or maybe we should say the meta-page contains things modified by the writer and
> parameters modified by the reader are passed by the get_reader_page ioctl i.e.
> the reader page ID and cpu_buffer->reader_page->read? (for the hyp tracing, we
> have up to 4 registers for the HVC which would replace in our case the ioctl)

Or we can keep everything in the meta-page but update the "reader bits" only
during the get_reader_page ioctl.

I can prepare something around those lines for the v3.

> 
> > 
> > That is, it should pass in the page->commit that it used to to read the
> > pages.
> > 
> > -- Steve
