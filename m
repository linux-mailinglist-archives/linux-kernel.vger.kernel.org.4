Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1A15616E48
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 21:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230368AbiKBUHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230380AbiKBUH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 16:07:26 -0400
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92FFBF2A
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 13:07:25 -0700 (PDT)
Received: by mail-pj1-x1036.google.com with SMTP id o7so14073779pjj.1
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=moK7+sMOMULoftfZaVBsMzmR/Xim4ClEpYiki4yAnI4=;
        b=QVTusBD249bMzTQ9oIKcVcRv33b8XOmbDsu+5EeR+ZxLFUKXIdLu2aQATF8dD9wHBy
         F8egS+d8AWjVWHrazF+8DJmVooLbv8fsf9FLhvMRMQyaxSv9pV0rQLkymIDo0ox5goYU
         8aIN/LKcGwKFGgRX0Y7SSonK/vd/3zYoc9JM10krebizr6ttM5llr7ZQBmItJk+67Wu4
         aS5RQrJhJvTgK2kTj1Ys47j24+qHYsLztyszSTgdMby0Zr22WMFz3yXdnym7YzWAHAMZ
         n+Emg/uQCK3GpVtXbA4fTGpvWfhUVC4PvX1JdTBHeAhZC9+ebMWoSUhzqjHsbvfL0FlU
         efKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=moK7+sMOMULoftfZaVBsMzmR/Xim4ClEpYiki4yAnI4=;
        b=rvO07FY7A0BYpi/jXIAUX2XRxGHP08uiJY712+DiSRrpI2wsc/UE+RMhm9st/rDNaQ
         s9a0R19P82v8zQbRbbPwRaWXWbGLLGctn4QPjgpyg8gRGGo2leudJz84zgdiHX3Nj/as
         knRy4ATPWvraWCuiqXgYsSoIMzNpp28aEMc+Exm03x1uuxjx8cAL8iQ2WYZYV3755nuC
         wAa4mPDwY93rvbeMpCn3UHLeDG2UTfPE6TNS9e5Wxxm4tCV4BX2N8BUzvQ4Mky6ril5Q
         RYzYbD3NEXN6ckJFLbX4qzrSlk9Oyn+ZDm79l/GdG3qRuV08WS2IKxKBEsElQH0eyNfH
         J5QQ==
X-Gm-Message-State: ACrzQf2hN81MBMx757gmxv080U7nflQ8+dHNGjCfFqhs3ZbVyYKTn1+W
        0wVcv2GVhFwIyFMtaWroesk=
X-Google-Smtp-Source: AMsMyM7p5dSQBrLp/ECaJV7LKS+LtRzGMbCjX/vGcorGjD3o1s8QxnD7RcP0sKD1/KmDojOisu7qSQ==
X-Received: by 2002:a17:902:7598:b0:178:3f96:4ffc with SMTP id j24-20020a170902759800b001783f964ffcmr27343250pll.53.1667419644927;
        Wed, 02 Nov 2022 13:07:24 -0700 (PDT)
Received: from google.com ([2620:15c:211:201:3fd5:8614:6eb0:846b])
        by smtp.gmail.com with ESMTPSA id jc13-20020a17090325cd00b0017f7e0f4a4esm8701928plb.35.2022.11.02.13.07.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 13:07:24 -0700 (PDT)
Sender: Minchan Kim <minchan.kim@gmail.com>
Date:   Wed, 2 Nov 2022 13:07:22 -0700
From:   Minchan Kim <minchan@kernel.org>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 0/9] zram: Support multiple compression streams
Message-ID: <Y2LN+tMDkVo/7XTI@google.com>
References: <20221018045533.2396670-1-senozhatsky@chromium.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221018045533.2396670-1-senozhatsky@chromium.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 01:55:24PM +0900, Sergey Senozhatsky wrote:
> Hello,
> 
> 	This series adds support for multiple (per-CPU)
> compression streams (at point only 2). The main idea is that
> different compression algorithms have different characteristics
> and zram may benefit when it uses a combination of algorithms:
> a default algorithm that is faster but have lower compression
> rate and a secondary algorithm that can use higher compression
> rate at a price of slower compression/decompression.
> 
> 	There are several use-case for this functionality:
> 
> - huge pages re-compression: zstd or deflate can successfully
> compress huge pages (~50% of huge pages on my synthetic ChromeOS
> tests), IOW pages that lzo was not able to compress.
> 
> - idle pages re-compression: idle/cold pages sit in the memory
> and we may reduce zsmalloc memory usage if we recompress those
> idle pages.
> 
> 	User-space has a number of ways to control the behavior
> and impact of zram recompression: what type of pages should be
> recompressed, size watermarks, etc. Please refer to documentation
> patch.

Hi Sergey,

First of all, I am really sorry to attend the party too late.

I absolutely agree the feature is really useful and even I am
thinking to support multiple comression trials on the fly for
future. So I'd like to introduce the feature more general shape
to be extended later so review will go.

Thanks!
