Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551B35B61FB
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 22:01:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229768AbiILUBj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 16:01:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiILUBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 16:01:34 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CD1629822
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 13:01:33 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id y15so4531578iof.13
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 13:01:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=DwQSBEyWD+dVMVAamntK7ddEp9ofjwaI6cPcvBjqONM=;
        b=J+TdksWqn2lqUbi7rCfoRmDP7OYXHvFPgHRgOq45zsjEG9dGGgWN15O11c98EXSgAk
         Kt7HJLMxpg6QS2aG8wOmGs8sU3MhiWYc90f01zeIYV4sTijKbqqv+j85P+3SjGo26Zrs
         3CiryQKktyjf7kI0gFLPtByQi3bEJwyuUdfu3Hw8n6GZpmQwEwsruEjAxbGpRJgqTGB2
         sBAFT6hd1TEm6RSOgzEXrPSLaTyzkV1SkztGn8Dx56Law0IV6nLxVX88tpwbutZUe2yB
         wuQJr+BjnDdg9EZGJ3f2hCdB4tgACORuvaUDrUbWsmk8IzV1mOUxxaM7P/1vM3AusfHV
         xYYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=DwQSBEyWD+dVMVAamntK7ddEp9ofjwaI6cPcvBjqONM=;
        b=vM6SSOcrFE/+HvJf5HB3jt7QB/t0E1Q/CQ+XsjMS0XR4lIa0i4Gp4+Q9by9yDflKv2
         KxeY+9Y9fQCiFbLYTpLwZik16rLdQsIJp9tBRibn96a/vKNdn+6AJJFtbfNDOASSx2Ua
         WyFhjNjv5sMOGjC5Xpdta72TLWmVO62DQHQBJEg6a21bq/i+//5RsnmIpa5dfCK8aaGC
         V34dQPqRJOBI0zAqHELo98WeTAu5+/fCj/qDKvUD5tjPJ32rti7tXNz3u0mbcKmw3BIq
         ykyIcDurJZQoiZYwaIfmJ2FfCROVhChry/Sn3f504QsB4NSZ+c02pBQOg0QcXDMg8Rkb
         AzTg==
X-Gm-Message-State: ACgBeo2UrE8v3r/1yEEH8FRNcN6bNDBRJvaHQsd2mhHfJdCKAbHlWO2t
        TN1erzG2dDjwjM27z08DTiNyZg==
X-Google-Smtp-Source: AA6agR640Uua8S9D1v7Hi2bivOO5Xp3LxvxDTFKajKymX9DX0o0u2EdwBQP+K7DcYPG7SQ1FPWo2CQ==
X-Received: by 2002:a5d:8a13:0:b0:69e:2133:4b38 with SMTP id w19-20020a5d8a13000000b0069e21334b38mr9029440iod.106.1663012892783;
        Mon, 12 Sep 2022 13:01:32 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:590f:8668:7af6:56d])
        by smtp.gmail.com with ESMTPSA id s3-20020a92cb03000000b002eac43d2013sm3945985ilo.43.2022.09.12.13.01.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 13:01:32 -0700 (PDT)
Date:   Mon, 12 Sep 2022 14:01:28 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Liam Howlett <liam.howlett@oracle.com>,
        "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of vm_next
Message-ID: <Yx+QGOgHg1Wk8tGK@google.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-68-Liam.Howlett@oracle.com>
 <Yx7XzNBMbcdgTxa9@google.com>
 <20220912124559.f1f5c26b882325fe5e5c5cce@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912124559.f1f5c26b882325fe5e5c5cce@linux-foundation.org>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 12:45:59PM -0700, Andrew Morton wrote:
> On Mon, 12 Sep 2022 00:55:08 -0600 Yu Zhao <yuzhao@google.com> wrote:
> 
> > 
> > The following should work properly. Please take a look. Thanks!
> > 
> > ---
> >  mm/vmscan.c | 12 +++---------
> >  1 file changed, 3 insertions(+), 9 deletions(-)
> > 
> > diff --git a/mm/vmscan.c b/mm/vmscan.c
> > index 11a86d47e85e..b22d3efe3031 100644
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3776,23 +3776,17 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
> >  {
> >  	unsigned long start = round_up(*vm_end, size);
> >  	unsigned long end = (start | ~mask) + 1;
> > +	VMA_ITERATOR(vmi, args->mm, start);
> >  
> >  	VM_WARN_ON_ONCE(mask & size);
> >  	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
> >  
> > -	while (args->vma) {
> > -		if (start >= args->vma->vm_end) {
> > -			args->vma = args->vma->vm_next;
> > -			continue;
> > -		}
> > -
> > +	for_each_vma(vmi, args->vma) {
> >  		if (end && end <= args->vma->vm_start)
> >  			return false;
> >  
> > -		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> > -			args->vma = args->vma->vm_next;
> > +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
> >  			continue;
> > -		}
> >  
> >  		*vm_start = max(start, args->vma->vm_start);
> >  		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;
> 
> What does this apply to?

The above replaces the original patch in mm-unstable.

> It's almost what is in mm-unstable/linux-next
> at present?

Yes, almost.

> static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk *args,
> 			 unsigned long *vm_start, unsigned long *vm_end)
> {
> 	unsigned long start = round_up(*vm_end, size);
> 	unsigned long end = (start | ~mask) + 1;
> 	VMA_ITERATOR(vmi, args->mm, start);
> 
> 	VM_WARN_ON_ONCE(mask & size);
> 	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
> 
> 	for_each_vma_range(vmi, args->vma, end) {
> 		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
> 			continue;
> 
> 		*vm_start = max(start, args->vma->vm_start);
> 		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;
> 
> 		return true;
> 	}
> 
> 	return false;
> }
> 
> for_each_vma_range versus for_each_vma.

The diff between the original patch and this one, in case you prefer to
fix it atop rather than amend.

diff --git a/mm/vmscan.c b/mm/vmscan.c
index a7c5d15c1618..cadcc3290918 100644
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@ -3776,7 +3776,10 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
 	VM_WARN_ON_ONCE(mask & size);
 	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
 
-	for_each_vma_range(vmi, args->vma, end) {
+	for_each_vma(vmi, args->vma) {
+		if (end && end <= args->vma->vm_start)
+			return false;
+
 		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
 			continue;
 
