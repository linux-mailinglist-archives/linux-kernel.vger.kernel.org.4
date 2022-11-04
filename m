Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6756F619F16
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 18:44:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231985AbiKDRoq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 13:44:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231971AbiKDRoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 13:44:23 -0400
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95F742F41
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 10:43:33 -0700 (PDT)
Received: by mail-pf1-x42d.google.com with SMTP id i3so5103242pfc.11
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 10:43:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ym4tTa7HJpk2L/lI6OldtK0o0jadOpOF8+GMFA83qbA=;
        b=RJ6QR4IglVEuR0hYC7lz/fpX6wgtAH99brFcbLXCLtVZxIkpLB7HbT8rXXyyHHZQ2q
         QzEJU9GX9LXDgR2m2KLJXrj7lJPYICrlC5QpJmzRxiVl1W2BeE7lle/rUAqcXDOEh0ra
         iU92VKcrwO4vjavCX8Y24xRaJe/tQXe2+qnz3+uG6JJakC+TP+qWox485vUll7I+62X5
         tqK6ID6DQP0aYieT5qrKd1DXfL1ABBya6A6JJf4Wb4FM/tD2fGm7kr+5mydalyqwxfaz
         JQ4LlEO92wjSrYaHKpENjtykxsR1cosO0LGjA4XKCobThCjtf5kEMbVNlZsg7nL5H8xS
         ixyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Ym4tTa7HJpk2L/lI6OldtK0o0jadOpOF8+GMFA83qbA=;
        b=PIUrAbeqF72z07hgtmUZ70CLQwdUmMwR8jTeXGzp3+nWeKA8EfE2PP/qxgtDg5xIBd
         hPjVvrD2dC8XPLmX+Pxeg2mcYl/XFzlVav5gRupQt5Eg1CAJrqxuTR3q+lHaTl627001
         C5OolDNn6se7RN6GClxldQHLj0GOVLu5Ve4+T3yq7X4XlgbWoRKBP4RbQxG+YswXLQCs
         VrsLopqJLPlX+Kg0zXbai9uRg2S6mDv8xOSGu3CRNIfChDyfwF1XdiLSwtv2ln4eUQUT
         7vPAq0jpraAA5d+i6+JzPn0VDl1wcqzLxQLmgUrkl0DBVAnu9hmQTcM4abmG8BDDQl5y
         s2BA==
X-Gm-Message-State: ACrzQf2ioBZcvzlpFnHwbYmqCElpO1glcih4zz0vmpC09q5mwtYkNKVe
        YsWH0Nc3WBhOtL6PufoJ9OI=
X-Google-Smtp-Source: AMsMyM6vVs4RHT4CU/n6Se1T6SbF1VMwI6DW/K9IjlT8qUrCcsN3/fCU/NKL0FRHGYsk270C8JCEjg==
X-Received: by 2002:a63:1d0f:0:b0:46e:e211:5433 with SMTP id d15-20020a631d0f000000b0046ee2115433mr31224631pgd.324.1667583813256;
        Fri, 04 Nov 2022 10:43:33 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:755f:cdcb:1bd8:5ad8])
        by smtp.gmail.com with ESMTPSA id x1-20020a633101000000b00464858cf6b0sm13848pgx.54.2022.11.04.10.43.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 04 Nov 2022 10:43:32 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Fri, 4 Nov 2022 10:43:30 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 2/9] zram: Add recompression algorithm sysfs knob
Message-ID: <Y2VPQlnEiP75mY5O@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
 <20221018045533.2396670-3-senozhatsky@chromium.org>
 <Y2LP0OWF/WTnkSne@google.com>
 <Y2Mv4l+V9iCv9EMg@google.com>
 <Y2Ptq1GZISCD7Mor@google.com>
 <Y2SEkzKSWx2iQzLl@google.com>
 <Y2Sat1/FCCT0Lia/@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2Sat1/FCCT0Lia/@google.com>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        FSL_HELO_FAKE,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 04, 2022 at 01:53:11PM +0900, Sergey Senozhatsky wrote:
> On (22/11/04 12:18), Sergey Senozhatsky wrote:
> > On (22/11/03 09:34), Minchan Kim wrote:
> > > Yeah, I like the name and priority format.
> > > 
> > > Only question is how we could support algorithm selection change
> > > under considering multiple secondary algorithms.
> > 
> > So what I was thinking about, and I'm still in the mental model that
> > re-compression is a user-space event, just like writeback, extension
> > of recompress sysfs knob with "algo_index" (or something similar) which
> > will mirror algorithm priority.
> > 
> > Example:
> > 
> > Configure 2 alternative algos, with priority 1 and 2
> > 
> > 	echo "name=lz4 priority=1" > recomp_algo
> > 	echo "name=lz5 priority=2" > recomp_algo
> > 
> > Recompress pages using algo 1 and algo 2
> > 
> > 	echo "type=huge threshold=3000 algo_idx=1" > recompress
> > 	echo "type=idle threshold=2000 algo_idx=2" > recompress
> > 
> > Maybe we can even pass algo name instead of idx.
> 
> Or pass priority= so that interface that uses algorithms has the
> same keyword that the interface that configures those algorithms.

Hmm, why do we need algo_idx here if we already set up every
fields at algorithm setup time?

My understaind(assuming default(i.e., primary) algo is lzo) is

    echo "name=lz4 priority=1" > recomp_algo
    echo "name=lz5 priority=2" > recomp_algo

    echo "type=huge threshold=3000" > recompress

It will try compress every objects which greater than 3000B with lz4 first
and then lz5 if it's stillgreater or equal than 3000(or same size class).

> 
> I still don't see many use-cases for "delete algorithm", to be honest.
> ZRAM is configured by scripts in 99.99999% of cases and it is

For the development time in the local side, people usually type in
until they will have solid script version. If we asks resetting
to zram to modify it, it's not good and consistent with other
sysfs knobs we could overwrite it to change it. How about supporting
overwritting to chage it over priority?

    echo "name=lz4 priority=1" > recomp_algo
    echo "name=lz5 priority=2" > recomp_algo

    # or I realized to change lz5 to lz7 so
    echo "name=lz6 priority=2" > recomp_algo

> quite static once it has been configured. So we probably can use
> the "don't setup algorithms that you don't need" approach, to keep
> things simpler.
