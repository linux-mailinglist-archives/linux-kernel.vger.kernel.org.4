Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23B4F5EB676
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 02:50:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229524AbiI0AuF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 20:50:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbiI0AuC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 20:50:02 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F61020182;
        Mon, 26 Sep 2022 17:50:01 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id p1-20020a17090a2d8100b0020040a3f75eso8561193pjd.4;
        Mon, 26 Sep 2022 17:50:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=anOfjEKm49o/rbXtkTtCMIqjAWrFaD+tdksXbREFKb4=;
        b=Zg8ohBnyKsIgxhxGL39sNzgFwPjnmHwuABBZxWwKb2v491mAMO2h45I7t3mODFvXBx
         5mFMNFVd6Xi5XKsrWVSY0ABYH5pkRumTx+Tya8nXA4wBXZW8fBCcD22u3W5ZA/LNsK1T
         SAI0mFAqmpFCDPVQy4Mp8PDwxSqHs2X4sEJuW2EYtjWWMUhd7NjrhRkWJ7fqujPW9wvv
         RwFr8j6laOaU+ERCvcM3qq4dG1qevc/tGAhx9D/vXoYJ2HUbYLydgF5G/VRm5jNVGw9J
         pFfbrv+d2eOhd5PgGG2C+bAhHrG4iioDKB0dVCsJiRoTbL+b8b93ak4gzAdgvl7RXUiD
         aVYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=anOfjEKm49o/rbXtkTtCMIqjAWrFaD+tdksXbREFKb4=;
        b=gULNBWVA3vmlmWby5rVWEDvoiuvq3G5e7FZV129bRvTZFeP924PbePwIGVEeSC5CQQ
         r5+ylWBP1t/ErzbqBQDLF2EqrlJLRmznrlqrvwb4mko6GtYru+w/4p89XuvH4+Nf+SAF
         rTEql8fyskqDNFK8WJRFIkM9dvnrlwSZ6UBykgFO0FqfmKX12efuAn+7VReEGq1mHvsy
         R3KxzpEe6MDQbuwfTjbxgVW6JQXj91vzV+8o3BiCfmrWr0iRkiVmZCIXRxqV+Bc+uytn
         CS+Lijeelesu7sy4s9Jd8/pI5Di+bEi+JgG4XUOclTqNG8Fy9yH7SWSPfYIKwBOSlR10
         PwnA==
X-Gm-Message-State: ACrzQf16hy+WtpRXd0Hl0KHWTrpf7kMku3p8Fvq/NkwduYoYF3nRwWDl
        f2t4O4aXq5Hoku7YhzhuhF4=
X-Google-Smtp-Source: AMsMyM5xGeW0V0jX7yPgbGYUjz8ZBfPA4vZGsY8Qlgx6EbUzcb8RIoU+1i+yhG8zxvc/ni0paQIcXA==
X-Received: by 2002:a17:90b:4c8a:b0:202:b3cd:f960 with SMTP id my10-20020a17090b4c8a00b00202b3cdf960mr1534138pjb.129.1664239800615;
        Mon, 26 Sep 2022 17:50:00 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id w16-20020aa79a10000000b0053639773ad8sm134914pfj.119.2022.09.26.17.49.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 17:49:59 -0700 (PDT)
Date:   Tue, 27 Sep 2022 09:49:52 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Jonathan Corbet <corbet@lwn.net>, Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Roman Gushchin <roman.gushchin@linux.dev>, kernel@openvz.org,
        Kees Cook <keescook@chromium.org>,
        Roman Gushchin <guro@fb.com>, Jann Horn <jannh@google.com>,
        Vijayanand Jitta <vjitta@codeaurora.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCH v2] mm: Make failslab writable again
Message-ID: <YzJIsFZQoCEYntvR@hyeyoo>
References: <20220920121111.1792905-1-alexander.atanasov@virtuozzo.com>
 <Yyr1xONdw8dBgsKr@hyeyoo>
 <30063d97-69f0-bea2-9d59-108140995bfc@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <30063d97-69f0-bea2-9d59-108140995bfc@virtuozzo.com>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 23, 2022 at 10:34:28AM +0300, Alexander Atanasov wrote:
> Hello,
> 
> On 21.09.22 14:30, Hyeonggon Yoo wrote:
> > On Tue, Sep 20, 2022 at 03:11:11PM +0300, Alexander Atanasov wrote:
> > > In (060807f841ac mm, slub: make remaining slub_debug related attributes
> > > read-only) failslab was made read-only.
> > > I think it became a collateral victim to the two other options for which
> > > the reasons are perfectly valid.
> > > Here is why:
> > >   - sanity_checks and trace are slab internal debug options,
> > >     failslab is used for fault injection.
> > >   - for fault injections, which by presumption are random, it
> > >     does not matter if it is not set atomically. And you need to
> > >     set atleast one more option to trigger fault injection.
> > >   - in a testing scenario you may need to change it at runtime
> > >     example: module loading - you test all allocations limited
> > >     by the space option. Then you move to test only your module's
> > >     own slabs.
> > >   - when set by command line flags it effectively disables all
> > >     cache merges.
> > 
> > Maybe we can make failslab= boot parameter to consider cache filtering?
> > 
> > With that, just pass something like this:
> > 	failslab=X,X,X,X,cache_filter slub_debug=A,<cache-name>>
> 
> > Users should pass slub_debug=A,<cache-name> anyway to prevent cache merging.
>
> It will be good to have this in case you want to test cache that is used
> early. But why push something to command line option only when it can be
> changed at runtime?

Hmm okay. I'm not against changing it writable. (it looks okay to me.)
Just wanted to understand your use case!

Can you please elaborate why booting with slub_debug=A,<your cache name>
and enabling cache_filter after boot does not work?

Or is it trying to changnig these steps,

FROM
	1. booting with slub_debug=A,<cache name>
	2. write to cache_filter to enable cache filtering
	3. setup probability, interval, times, size

TO

	1. write to failslab attribute of <cache name> (may fail it has alias)
	2. write to cache_filter to enable cache filtering
	3. setup probability, interval, times, size
?

as you may know, SLAB_FAILSLAB does nothing when
cache_filter is disabled, and you should pass slub_debug=A,<cache name> anyway
to prevent doing cache merging with <cache name>.

-- 
Thanks,
Hyeonggon
