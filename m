Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 572F4624F36
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 02:07:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231260AbiKKBHS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 20:07:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229536AbiKKBHM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 20:07:12 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86E2C4D5FB
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:07:11 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id k22so3600834pfd.3
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 17:07:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=rA3+wKh3EdaWBw0rOv2qo0sGAH/sOd4ZXXqLc1LTopw=;
        b=DdFDHSzgzBO799XV6cwlfQyrsaUFQfKLoyLDeFNweuqt4Qrtb+nc8ghCYTIrkx/j2P
         PnzLO06BBVEQgEwvdzD2TWOVP2yAuC7LAtuAm6VSnPPfaK8QxytA7yv0OhxbCpBs9smZ
         wsyMLwblWLdjNNrI3iGJim6hgHcwgAX0vCVYA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rA3+wKh3EdaWBw0rOv2qo0sGAH/sOd4ZXXqLc1LTopw=;
        b=I+8yxJ33I5Mh4QoXNbCpqLInpsU6+G1Iwk+hgZBfdjmyo6Q3ilDsun/ghfNUFKteCl
         pkVZYbFLk43EjXGRK9gYee7V7cXU3LrhYu00KIU2Z61tBv7GuQI5cwdKwyT33XP5mL2M
         RP3KQThJmDrcwqOYoi9UEjzSbD+MEy1QEJ2h+UXOKEzUWytzVhmGfpflYK3vVl/NkZey
         nYf5vpd3j7OKJnZqrg5ERJrwjn+IHnGaqmZzwQdRI0fLWCK2qy1wf7ilUNBjhiawqM5Z
         FWEMkyJZozPYPXf22HnMOctuVH3gsOl92WosY4Tizz+fZmXcZOrGI1KvWXrCC3fimYEb
         Ytig==
X-Gm-Message-State: ANoB5pnNDb2UGrAsSME6eRCpVMSTsUqCPoSQb71iBCiBLw9nlL3YJ3FA
        pbD4CREcrfGaYY7WF5lEvR0KD9aTyRuqJA==
X-Google-Smtp-Source: AA0mqf4QbRuENAhj2rhhocwrW/mhpTBLaySMxyAj6wGq7XTFY5BUYUpXVNB8zenf7vDccyzsrSeWVA==
X-Received: by 2002:aa7:8092:0:b0:56d:8145:3faa with SMTP id v18-20020aa78092000000b0056d81453faamr94514pff.75.1668128831068;
        Thu, 10 Nov 2022 17:07:11 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id nn14-20020a17090b38ce00b00213d28a6dedsm3709254pjb.13.2022.11.10.17.07.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 10 Nov 2022 17:07:10 -0800 (PST)
Date:   Fri, 11 Nov 2022 10:07:06 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 4/9] zsmalloc: make huge class watermark zs_pool member
Message-ID: <Y22gOgLJJvB/5/d+@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-5-senozhatsky@chromium.org>
 <Y216Xq8V8InFQyms@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y216Xq8V8InFQyms@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/10 14:25), Minchan Kim wrote:
> On Mon, Oct 31, 2022 at 02:41:03PM +0900, Sergey Senozhatsky wrote:
> > We will permit per-pool configuration of pages per-zspage value,
> > which changes characteristics of the classes and moves around
> > huge class size watermark. Thus huge class size needs to be
> > a per-pool variable.
> 
> I think part of code in previous patch should move here since
> you are creating the feature in this patch:

What do you mean? This patch - make huge_class_size a pool value - looks
completely independent to me.

> BTW, I am wondering we really need to jump the per-pool config
> option over global general golden ratio and/or smarter approach
> to optimize transparently depending on how much memory we have
> wasted.

I like the per-zspool value.

Dynamic zspage sizing is going to be very very difficult if possible at
all. With different zspage limits we create different size class clusters
and we also limit huge size class watermark. So if we say, increase the
zspage length value, then we have more size classes: but in order for us
to actually start saving memory we need to move objects that waste
memory in previous cluster configuration to new classes. It's even more
complex with huge objects. When we say move huge size class watermark
from 3264 to 3632 then in order to actually save memory we need to
recompress huge objects and put them into size classes that are between
3264 and 3632.

And that's only half. We also can lower the zspage length limit and
we'll have less size classes (because they merge more) and move huge
size class watermark from 3632 back to 3264. How do we handle this?

I really think that per-zspool knob is the easiest way. And it doesn't
block us from doing any improvements in the future.
