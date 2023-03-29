Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 585F16CDA2D
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 15:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229805AbjC2NKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 09:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229687AbjC2NKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 09:10:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1743BD2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:10:15 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o24-20020a05600c511800b003ef59905f26so9562338wms.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 06:10:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680095413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QGnQ8C4HRcvejmENRdw1kMet7sBZQDht8BGNmpDUJaw=;
        b=SJdkXHS4SLOb+7UNHPjE8qpmZZn+8nT+sRrCtOp5fw/lIXWDIH5evg+XsJXeezM2Wy
         Jq8tuEnK7CoLpwbY52iYLRNodu3Wc104Gw+swgyn/jWsZzmebbIbwenm82xMVF2APHtl
         98M2fwfLqRpOUPn0uAeBcD0HVfxaz0wsiCj8kX2CIfqKroBnLXBz1NqsICitt5WwJujX
         UH9dJH/yy9jHMiZTmdk0WYvqLfgmRVVmwRVni1oc4FiSc5Z81y8Gs0+69w3QAHl4b0MS
         Z9xrqyToorCInwKe4FwFjbeS0MwzK65+HIkQ0IcPXOQQfYtJHbOJZHlDYCF5yNcHf1ri
         6kFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680095413;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QGnQ8C4HRcvejmENRdw1kMet7sBZQDht8BGNmpDUJaw=;
        b=F4ZyHKKgqp6q0onFB7K0jWXjZRspT1oGizW4IXo7sfqCQpaKdzyNqJ14yHg0mOIavJ
         8PCy0Q4lJ1Y4FEvODHJ7qsUYNwsPlQzbFtyILYpkiJXJ5Wxdak2XSOmqqwPgiKVoPKHq
         c0yNrSyPaHzYcVRWXQ4R56sVNSEze/JyHXXM19QKvewQT6sMPJgMWu9uagjHUAkg8hOx
         YV1SKCeG5lzbhktkiAQM0wxAN55lakjVl3cUrIm7RZ0TT56Wjx3Y2Vrwz4buPuCcBKmj
         18kFyY8+yqOhCLIL63PXiF1+QDdauiZNJL7jgfVJNmYEq+7/90Y350yxcs1zVOvhylOn
         O97g==
X-Gm-Message-State: AO0yUKV0f5wINBu7wN8zEbAufsv4W11suCaj5GV3TiTwWKeV9QzqO/Ta
        Z6gEuO8mjDw7pnqfnh45ihchBg==
X-Google-Smtp-Source: AK7set+tB9GEU2YsRQ+ECGcUsQVXdByqwXkqyRjbdcDM0fN4inAseVa18iI2Bwo6DXK2StDRRwpXEg==
X-Received: by 2002:a05:600c:20a:b0:3ee:5fa:5294 with SMTP id 10-20020a05600c020a00b003ee05fa5294mr14961305wmi.23.1680095413534;
        Wed, 29 Mar 2023 06:10:13 -0700 (PDT)
Received: from google.com (65.0.187.35.bc.googleusercontent.com. [35.187.0.65])
        by smtp.gmail.com with ESMTPSA id iv19-20020a05600c549300b003ef69873cf1sm2465928wmb.40.2023.03.29.06.10.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 06:10:13 -0700 (PDT)
Date:   Wed, 29 Mar 2023 14:10:09 +0100
From:   Vincent Donnefort <vdonnefort@google.com>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org, kernel-team@android.com
Subject: Re: [PATCH v2 1/2] ring-buffer: Introducing ring-buffer mapping
 functions
Message-ID: <ZCQ4sXq0gmkgJvIe@google.com>
References: <20230322102244.3239740-1-vdonnefort@google.com>
 <20230322102244.3239740-2-vdonnefort@google.com>
 <20230328224411.0d69e272@gandalf.local.home>
 <ZCQCsD9+nNwBYIyH@google.com>
 <20230329070353.1e1b443b@gandalf.local.home>
 <ZCQtpbyWrjliJkdg@google.com>
 <20230329084735.6c4a9229@rorschach.local.home>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230329084735.6c4a9229@rorschach.local.home>
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

On Wed, Mar 29, 2023 at 08:47:35AM -0400, Steven Rostedt wrote:
> On Wed, 29 Mar 2023 13:23:01 +0100
> Vincent Donnefort <vdonnefort@google.com> wrote:
> 
> > On Wed, Mar 29, 2023 at 07:03:53AM -0400, Steven Rostedt wrote:
> > > On Wed, 29 Mar 2023 10:19:44 +0100
> > > Vincent Donnefort <vdonnefort@google.com> wrote:
> > >   
> > > > > I've been playing with this a bit, and I'm thinking, do we need the
> > > > > data_pages[] array on the meta page?
> > > > > 
> > > > > I noticed that I'm not even using it.
> > > > > 
> > > > > Currently, we need to do a ioctl every time we finish with the reader page,
> > > > > and that updates the reader_page in the meta data to point to the next page
> > > > > to read. When do we need to look at the data_start section?    
> > > > 
> > > > This is for non-consuming read, to get all the pages in order.  
> > > 
> > > Yeah, I was trying to see how a non consuming read would work, and was
> > > having issues figuring that out without the tail page being updated.  
> > 
> > Would the userspace really need to know where is the tail page? It can just stop
> > whenever it finds out a page doesn't have any events, and make sure it does not
> > loop once back to the head?
> 
> I'm trying to come up with a possible algorithm that doesn't need
> ioctls. It would need to know if the writer moved or not. Probably need
> a counter that gets incremented every time the writer goes to a new page.

The v2 of this series only updates the head page in the update ioctl
(ring_buffer_update_meta_page()) Couldn't find a nice way around that as it can
be either updated by the reader or the writer. So the best solution seemed a
call to set_head_page().

[...]
