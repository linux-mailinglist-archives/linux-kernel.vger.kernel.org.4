Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3888C6184DA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 17:38:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbiKCQik (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 12:38:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbiKCQiS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 12:38:18 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD701DA5E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 09:35:06 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id k5so2166422pjo.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 09:35:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wvuEj0nbKN1+WA2P0qBtkJX32FgYd3x0JlBhjNkSxDI=;
        b=e0JNY95/P9YXExz44lREzXETuw5bQj+rAMvnomUpDTYm5faF6isz+O8k0pKlZSRLON
         8XX/t+9EN5HxEwfpXJAYAL1GB4Ch6sazJviPoV2KfY346pHLsEHvkmwJb7BbGEIFqhfl
         rMpsmKiOJJj+/aO+sBuaISY5QWSt1EewW1bILWwK4Qxa3kewR8Xo3u4AF6YM8ht6+/w+
         7oYOciygOiLVqSgFJgdMZ26NpdmZv0pI7R3HFS8aaojntM+0dUxDpXJIDXX8A//N6MLz
         rEtfJ+NtARv3tKAw24PYiztagGAfJtAhQGoh2yssYNwERJ29rl2VpZpAEifrhVpRPUbx
         M7EA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wvuEj0nbKN1+WA2P0qBtkJX32FgYd3x0JlBhjNkSxDI=;
        b=E2kwc7P+NCdj93/idW2jwXe+lPViTeK1TVr41O2dWmNgwFln3M+xTkCQLkwLg1r9ny
         ZtgGnsALu3G2weZFqUUBKhmwocmCamkb7NLrChtMg9GCSuGUzKLXWNk43+tXzgO/Y1x1
         XY8+p7m05APNf3oNFVj0cjc6gl92ay6hIh7ZL0e/XSPJbcYjX/gK/bjTpI3J9VPjCtuS
         p+I3qozTPqwhOUO0eUoQU2UktC39LjL15UIUUBcx7401ugvOGvzN3Q4LJkoNw6lbNZUT
         bLoq1Ne6teEQjM4MnWmj0DIF9TMBg9rqwSvd2Iiu2AoPylsZ1pRBbOy5uzAVcPAw50+U
         AeIw==
X-Gm-Message-State: ACrzQf0zdtVlM02IWnl+brt3HGgrjFDtlyqOPmJ0NvdNj+aNy0CTJCmL
        EfdRbuKD7pu+PxGHgS4xkBo=
X-Google-Smtp-Source: AMsMyM4APAfVVOzLpQYDdS762oMWU50uqALnqqYmM5oioHJ1Vmqew6d/hYzzZuJ9sewUxtO4kB02sA==
X-Received: by 2002:a17:90b:4a09:b0:213:9911:5f07 with SMTP id kk9-20020a17090b4a0900b0021399115f07mr32763685pjb.160.1667493293720;
        Thu, 03 Nov 2022 09:34:53 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3d65:7dc2:c62a:5d98])
        by smtp.gmail.com with ESMTPSA id h16-20020aa796d0000000b0056c2e497b02sm964876pfq.173.2022.11.03.09.34.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 03 Nov 2022 09:34:53 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Thu, 3 Nov 2022 09:34:51 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2Ptq1GZISCD7Mor@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Mv4l+V9iCv9EMg@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 03, 2022 at 12:05:06PM +0900, Sergey Senozhatsky wrote:

< snip >

> > Just open question(I might be too paranoid?)
> > 
> > I am thinking someone want to add third comp algorithm in future
> > to balance decompression and memory efficiency.
> > 
> > If it's not too crazy idea, let's think about the interface.
> > Maybe, could we make the recomp knobs works like list?
> > 
> > # A primary comp
> > echo "A" > /zram/comp_algo
> > 
> > # Multiple secondary comps
> > echo "B threshold" > /zram/add_recomp_algo
> > echo "C threshold" > /zram/add_recomp_algo
> > echo "D threshold" > /zram/add_recomp_algo
> 
> What is the threshold here? My design approach is that ZRAM doesn't do

As your term, watermark but yeah, priority you suggested would be good
for me.

> recompression on its own, so no magic is happening automatically. It's
> the user-space that triggers recompression for selected pages when
> user-space thinks it's time to. This allows us to have various flexible
> policies and consider things that ZRAM is not even aware of: battery level,
> free memory, CPU load average, etc. E.g. no recompression when all CPUs
> are busy rendering video game, or when we are draining battery too fast,
> etc.
> 
> > "cat /zram/recomp_algo" shows the list
> > 
> > echo "C" > /zram/remove_recomp_algo
> > will remove the C algorithm in stack.
> 
> What is the use case for removal of a secondary algorithm?

Without the interface, How can we modify the selection if admin want to
change the order of second algorithms?

> 
> > My point is that we don't need to implement it atm but makes the
> > interface to open the possibility for future extension.
> > 
> > What do you think?
> 
> So, as far as I understand, we don't have reason to add remove_recomp_algo
> right now. And existing recomp_algo does not enforce any particular format,
> it can be extended. Right now we accept "$name" but can do something like
> "$name:$priority". The only thing that we probably need to do is rename
> recomp_algo to either add_recomp_algo or register_recomp_algo?

Yeah, I like the name and priority format.

Only question is how we could support algorithm selection change
under considering multiple secondary algorithms.
