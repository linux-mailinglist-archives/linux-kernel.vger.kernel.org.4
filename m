Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2808A5FD802
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 12:59:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229519AbiJMK67 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 06:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJMK6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 06:58:55 -0400
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C34CFFC1FF;
        Thu, 13 Oct 2022 03:58:54 -0700 (PDT)
Received: by mail-ej1-f53.google.com with SMTP id 13so3088279ejn.3;
        Thu, 13 Oct 2022 03:58:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Lph9QewdspU86uTpI642hBsrAlRtNCeQ+DaqfFhG9U=;
        b=wNormfg4f1ueuirBSjKx/TFRXPF5OMadrsxrRlu4uXpK6cakYwVhGd1LsKfiCUZqGM
         unZTn+6+Lf3l00XQcMlddvJwg+KVriFyt6A+lTa1yce/mPQVYiMtG6SqEjgsEHogJDkI
         8bXkfCHvAJzCEysoJvAzHxWj3Bb28xiB2g+wz5LZ5AEBUz5UVIlC8LoTDQlMsGkFGXRK
         PFCU1gdg2Vso/iZr9dhFIXnVfoYnyRWg7aB88MgibZ+wc62O94kanDdNzEf2ZNzj7R/U
         3CUwAETEeqE4Y378UQvWdMAVArH1evzxsB5lWea4o8xxTLJ5kCt+beabyK0QXVIj8/gl
         AaNw==
X-Gm-Message-State: ACrzQf2FHDE6DFcwp9AkCfFY3ZiKUcQyePPdeKnPXq9QwEZTNqit0ZFB
        YYfRyGwyJVot2ocP2iM4Za+WXJrS9eBLzNJqz/0=
X-Google-Smtp-Source: AMsMyM7batjO0NidwoBTmwYpBKA6THbna2UbS/u8Aj+2m7wZ7toM20QkeWYdXlu49EO/uyOyf238l4rwr5YFgfq5zSA=
X-Received: by 2002:a17:907:2c59:b0:78d:8e03:134 with SMTP id
 hf25-20020a1709072c5900b0078d8e030134mr21769639ejc.310.1665658733244; Thu, 13
 Oct 2022 03:58:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220922133800.12918-1-rui.zhang@intel.com> <5af2d8bb-8591-78f6-8102-6f7d0df33d98@intel.com>
 <9a1ae0b5d7a5ee3c870195e942d58bdd9b3b71db.camel@intel.com>
In-Reply-To: <9a1ae0b5d7a5ee3c870195e942d58bdd9b3b71db.camel@intel.com>
From:   Len Brown <lenb@kernel.org>
Date:   Thu, 13 Oct 2022 12:58:41 +0200
Message-ID: <CAJvTdKkYTQzY1UsH_o2QdN1bS4gVfT87bEwMvgUXYwd+VFD+=w@mail.gmail.com>
Subject: Re: [PATCH V3 0/8] x86/topology: Improve CPUID.1F handling
To:     Zhang Rui <rui.zhang@intel.com>
Cc:     Dave Hansen <dave.hansen@intel.com>, linux-kernel@vger.kernel.org,
        x86@kernel.org, linux-hwmon@vger.kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, peterz@infradead.org, corbet@lwn.net,
        fenghua.yu@intel.com, jdelvare@suse.com, linux@roeck-us.net,
        len.brown@intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series of BUG FIXES needs to be marked for -stable.

What testing is it waiting for?
I don't see upstream, in linux-next or in tip -- which means that
nobody is testing it.

Are we supposed to be pulling from the URL below to get the latest???

The latest Intel Hybrid CPUs are sort of a mess without this series.
Distros will need to back-port it.

thanks,
-Len

On Fri, Sep 23, 2022 at 10:40 AM Zhang Rui <rui.zhang@intel.com> wrote:
>
> Hi, Dave,
>
> On Thu, 2022-09-22 at 09:53 -0700, Dave Hansen wrote:
> > > Changes since V2:
> > >  - changelog improvements based on Peter' feedback
> > >  - Remove combined tags
> >
> > I fixed those up and started testing your v2 yesterday.
>
> Thanks for doing this.
>
> >   Can you
> > double-check that this:
> >
> >
> > https://git.kernel.org/pub/scm/linux/kernel/git/daveh/devel.git/log/?h=cpuid1f
> >
> > Looks the same as your v3?
>
> There is no code difference.
> Just that I have updated the subject and changelog of patch 1/8 per
> Peter' suggestion
> https://lore.kernel.org/lkml/8496afee057d63b83a7ff02ec7f1de8c2d0e97ae.camel@intel.com/
>
> thanks,
> rui
>


-- 
Len Brown, Intel
