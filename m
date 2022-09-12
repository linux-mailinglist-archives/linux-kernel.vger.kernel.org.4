Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C25755B5510
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:13:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229741AbiILHNh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:13:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51290 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbiILHNa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:13:30 -0400
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 427AC18396
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:13:26 -0700 (PDT)
Received: by mail-il1-x12c.google.com with SMTP id l16so4098394ilj.2
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 00:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=5PBnObJ86DaSFv/Dn+kEE30YGOmbqTKM2FIWKrmzEvs=;
        b=nj4h3bvdtfVaZzfH46YJcL9svN/8TAcbNX2q+B1DTNlqug/vJ4J0TCl3u2aQNPycTR
         WJ2caeawWQG9kAGbx4uFSrsYp5m3ACQP48rUvdDi436AzTfnx314k9mw1ceQJQoNwNZA
         yV3cPc5O3HJpsofmOsdtspw0TXhN1GRnl25xavdNSFDsNl4WUzwXzoTxVS6MqaIH3x0t
         N+JO68+U9MmZcZQNtf0SB7NACr6yjgZONnyoC9ov+pMWZSAmbbCsnXRmE1NNfbq5VKmN
         kbJ3d+CBncuVNjxWFv2CHsPkF9JJw3b8F9LgGb0esZlg5xdlmXJUDkSQVpXvAlEKKFD4
         Lorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=5PBnObJ86DaSFv/Dn+kEE30YGOmbqTKM2FIWKrmzEvs=;
        b=LY+e7Y/IRWZU8747Vg4uSGf+OvpkoGUnQTF5lgSKuYDOwYpa+COHasuA9Wxck+u5RA
         ceciSOsPVoxXVIQVEflzZkwN0Ms/8KqbSu4ab+psI37XHfFlqpnEpyrvH1ic1ILjrwMI
         gKFZOeiyTFVUaAsBGRTDz+E1WgkVDjyPbtysMkwOQYSI++D2YqyY2Ioju7Yf3s2cN/P3
         XTB+V09V06snEhr8Cnbw5GbWjMM+EshDXUMRa7OKpiZdhkMtODjqkUBdoQLwC1k/r+7P
         TC+CNiX/dLp+ONLRmwzeXG9B82oN7E0Ik1vdbmLLi04jSKZb3KfdtUDMJ8cWBj+tnQL8
         z1lw==
X-Gm-Message-State: ACgBeo1aCzPfp+01Rpsae93bwosRG2gpfiFOwDSpWzS7M5hajozMJuEz
        Xm1nuMbq4PbhwQgyr5F9LeH/Gg==
X-Google-Smtp-Source: AA6agR4h68SwArBaqrwAkoqMDfX7pIrJeWDWGA9a/gSWqxYxYvoeaqxF1am9FyF7c4ZaY6qyVx4RKA==
X-Received: by 2002:a05:6e02:1c2e:b0:2f3:28de:ead5 with SMTP id m14-20020a056e021c2e00b002f328deead5mr9564226ilh.209.1662966805477;
        Mon, 12 Sep 2022 00:13:25 -0700 (PDT)
Received: from google.com ([2620:15c:183:200:50c7:aba9:8225:aea8])
        by smtp.gmail.com with ESMTPSA id a1-20020a92d101000000b002f11fc22a9fsm3081709ilb.37.2022.09.12.00.13.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Sep 2022 00:13:25 -0700 (PDT)
Date:   Mon, 12 Sep 2022 01:13:21 -0600
From:   Yu Zhao <yuzhao@google.com>
To:     Liam Howlett <liam.howlett@oracle.com>
Cc:     "maple-tree@lists.infradead.org" <maple-tree@lists.infradead.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH v14 67/70] mm/vmscan: Use vma iterator instead of vm_next
Message-ID: <Yx7cEVhKvG3DLQkg@google.com>
References: <20220906194824.2110408-1-Liam.Howlett@oracle.com>
 <20220906194824.2110408-68-Liam.Howlett@oracle.com>
 <Yx7XzNBMbcdgTxa9@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yx7XzNBMbcdgTxa9@google.com>
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

On Mon, Sep 12, 2022 at 12:55:08AM -0600, Yu Zhao wrote:
> On Tue, Sep 06, 2022 at 07:49:05PM +0000, Liam Howlett wrote:
> > Use the vma iterator in in get_next_vma() instead of the linked list.
> > 
> > Suggested-by: Yu Zhao <yuzhao@google.com>
> 
> Apologies for the bad suggestion.
> 
> > --- a/mm/vmscan.c
> > +++ b/mm/vmscan.c
> > @@ -3776,23 +3776,14 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
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
> > +	for_each_vma_range(vmi, args->vma, end) {
> > +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
> >  			continue;
> > -		}
> > -
> > -		if (end && end <= args->vma->vm_start)
> > -			return false;
> 
> Here the original code leaves args->vma pointing the first vma out of
> the range [start, end). This allows the caller (page table walker) to
> resume at that vma, if it chooses to.
  ^^^^^^ continue (without releasing mmap_lock)

> With for_each_vma_range(), under the same condition, args->vma is set to
> NULL. And the page table walker may terminate prematurely. Apparently I
> overlooked until I was told MGLRU in mm-unstable is slower than itself
> on 6.0-rc4 yesterday.
> 
> > -
> > -		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> > -			args->vma = args->vma->vm_next;
> > -			continue;
> > -		}
> >  
> >  		*vm_start = max(start, args->vma->vm_start);
> >  		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;
> 
> The following should work properly. Please take a look. Thanks!
> 
> ---
>  mm/vmscan.c | 12 +++---------
>  1 file changed, 3 insertions(+), 9 deletions(-)
> 
> diff --git a/mm/vmscan.c b/mm/vmscan.c
> index 11a86d47e85e..b22d3efe3031 100644
> --- a/mm/vmscan.c
> +++ b/mm/vmscan.c
> @@ -3776,23 +3776,17 @@ static bool get_next_vma(unsigned long mask, unsigned long size, struct mm_walk
>  {
>  	unsigned long start = round_up(*vm_end, size);
>  	unsigned long end = (start | ~mask) + 1;
> +	VMA_ITERATOR(vmi, args->mm, start);
>  
>  	VM_WARN_ON_ONCE(mask & size);
>  	VM_WARN_ON_ONCE((start & mask) != (*vm_start & mask));
>  
> -	while (args->vma) {
> -		if (start >= args->vma->vm_end) {
> -			args->vma = args->vma->vm_next;
> -			continue;
> -		}
> -
> +	for_each_vma(vmi, args->vma) {
>  		if (end && end <= args->vma->vm_start)
>  			return false;
>  
> -		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args)) {
> -			args->vma = args->vma->vm_next;
> +		if (should_skip_vma(args->vma->vm_start, args->vma->vm_end, args))
>  			continue;
> -		}
>  
>  		*vm_start = max(start, args->vma->vm_start);
>  		*vm_end = min(end - 1, args->vma->vm_end - 1) + 1;
> -- 
> 2.37.2.789.g6183377224-goog
