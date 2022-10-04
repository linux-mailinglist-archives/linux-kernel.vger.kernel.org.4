Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 303A65F456C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 16:26:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229647AbiJDO0n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 10:26:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbiJDO0l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 10:26:41 -0400
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 527475F7FE;
        Tue,  4 Oct 2022 07:26:40 -0700 (PDT)
Received: by mail-pg1-x52a.google.com with SMTP id 78so12828923pgb.13;
        Tue, 04 Oct 2022 07:26:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=a7J7IosKfoRArNJboZpXhy19uGdQlz1RYOvunk4d6kQ=;
        b=jE3nLP2UVGvlNA2xqINAjLS3bhyyAt4580FWyyiA+If8F93KOaWZ52Bg3gw/zS04PA
         D3tl8bbtF9xa3nPXbzTDLiajzy+6hvPe7C0Yvwg2TX7H71a6toNLRrWbCAu6AWSsRnH0
         8Aed4el8Q7Mg9IWcdNoeLGB0jEemS1k0ReCrP2n4ZhWiM9h3aFjomydd4tSb1YnHwZyl
         es4+2uhnjWeBCjLXLme71uW+JLxDIJYjYy2GwQHzUQm/xwDJmEB93/ouFavmcy1VoKUf
         Of8IKrN4FQ61K79d3QOVYNNxUbfEOn+0yM9Ylf+8Jw8N6Ui/hmsqHFMYidK1UrR9HcWY
         Fe1A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=a7J7IosKfoRArNJboZpXhy19uGdQlz1RYOvunk4d6kQ=;
        b=iwvsoL4dX3bIz7FFJyq0VSstcQiIC1mkVGpfBkDQbdC6rLT8OYcUSnR4ytgfSQbUce
         uQrp2lgwam7vKzoLys0duMpqwoFrzjEnuY+DHlX6fX/Cxg/NqP2ioh+EqrmRIl6Qk+TX
         z9Tek7Aq4ZRlWQuF2dAuI3U6dC4FeuVPfGqwgbxn7dB5W6y1hyde5PkvBcYM7O2wkX0o
         JMATn5d4ozj7CUyU/q6AifOTQ/U1fU1i2ACV0lrMsmDvqAEkdYk5IFHw3K2UhNKzfOgO
         RzzkOyyzmU8n6fHosXOI7hYpX0GGZQ5YkRcBCgiOI9RX0nOG6GdC+08AtBj3cqhylYwp
         Ygkg==
X-Gm-Message-State: ACrzQf1Uu9mLQOFSQjBobOeEpMfKwKgD7MfkbiriwxvNMpaqaO4/e7oD
        oP+jb0edJfMBXfaY744PtpUqRCp9XGW4Pw==
X-Google-Smtp-Source: AMsMyM6H4kalTnP6SQVpdm2v2jEkC7PR9kLBjv9LBaVqcu76PkEZoYVv67wxWEXx865HLykHnWQXQQ==
X-Received: by 2002:a05:6a00:1a07:b0:541:6060:705d with SMTP id g7-20020a056a001a0700b005416060705dmr28410815pfv.61.1664893599629;
        Tue, 04 Oct 2022 07:26:39 -0700 (PDT)
Received: from hyeyoo ([114.29.91.56])
        by smtp.gmail.com with ESMTPSA id 18-20020a630b12000000b00434d9ba7817sm8538426pgl.30.2022.10.04.07.26.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 07:26:38 -0700 (PDT)
Date:   Tue, 4 Oct 2022 23:26:33 +0900
From:   Hyeonggon Yoo <42.hyeyoo@gmail.com>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Hugh Dickins <hughd@google.com>, Vlastimil Babka <vbabka@suse.cz>,
        David Laight <David.Laight@aculab.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, rcu@vger.kernel.org
Subject: Re: amusing SLUB compaction bug when CC_OPTIMIZE_FOR_SIZE
Message-ID: <YzxCmR3dGJz45NVD@hyeyoo>
References: <ea96c78c-e1dc-1364-e91-51909f82388b@google.com>
 <YzPgTtFzpKEfwPbK@hyeyoo>
 <YzRQvoVsnJzsauwb@google.com>
 <35502bdd-1a78-dea1-6ac3-6ff1bcc073fa@suse.cz>
 <ff905c1e-5eb3-eaf8-46de-38f189c0b7a5@google.com>
 <de71b83a-c82c-4785-ef5a-3db4f17bbc8d@suse.cz>
 <bcecece-f7ce-221d-1674-da3d5ab3fef@google.com>
 <YzkmErHFyYW3awRn@hyeyoo>
 <YzsVM8eToHUeTP75@casper.infradead.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YzsVM8eToHUeTP75@casper.infradead.org>
X-Spam-Status: No, score=-0.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,HK_RANDOM_ENVFROM,
        HK_RANDOM_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 03, 2022 at 06:00:35PM +0100, Matthew Wilcox wrote:
> On Sun, Oct 02, 2022 at 02:48:02PM +0900, Hyeonggon Yoo wrote:
> > Just one more thing, rcu_leak_callback too. RCU seem to use it
> > internally to catch double call_rcu().
> > 
> > And some suggestions:
> > - what about adding runtime WARN() on slab init code to catch
> >   unexpected arch/toolchain issues?
> > - instead of 4, we may use macro definition? like (PAGE_MAPPING_FLAGS + 1)?
> 
> I think the real problem here is that isolate_movable_page() is
> insufficiently paranoid.  Looking at the gyrations that GUP and the
> page cache do to convince themselves that the page they got really is
> the page they wanted, there are a few missing pieces (eg checking that
> you actually got a refcount on _this_ page and not some random other
> page you were temporarily part of a compound page with).
> 
> This patch does three things:
> 
>  - Turns one of the comments into English.  There are some others
>    which I'm still scratching my head over.
>  - Uses a folio to help distinguish which operations are being done
>    to the head vs the specific page (this is somewhat an abuse of the
>    folio concept, but it's acceptable)
>  - Add the aforementioned check that we're actually operating on the
>    page that we think we want to be.
>  - Add a check that the folio isn't secretly a slab.
> 
> We could put the slab check in PageMapping and call it after taking
> the folio lock, but that seems pointless

I partially agree with this patch. I actually like it.

> It's the acquisition of
> the refcount which stabilises the slab flag, not holding the lock.

But can you please elaborate how this prevents race between
allocation & initialization of a slab and isolate_movable_page()?

Or maybe we can handle it with frozen folio as Vlastimil suggested? ;-) 

> diff --git a/mm/migrate.c b/mm/migrate.c
> index 6a1597c92261..a65598308c83 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -59,6 +59,7 @@
>  
>  int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  {
> +	struct folio *folio = page_folio(page);
>  	const struct movable_operations *mops;
>  
>  	/*
> @@ -70,16 +71,23 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	 * the put_page() at the end of this block will take care of
>  	 * release this page, thus avoiding a nasty leakage.
>  	 */
> -	if (unlikely(!get_page_unless_zero(page)))
> +	if (unlikely(!folio_try_get(folio)))
>  		goto out;
>  
> +	/* Recheck the page is still part of the folio we just got */
> +	if (unlikely(page_folio(page) != folio))
> +		goto out_put;
> +
>  	/*
> -	 * Check PageMovable before holding a PG_lock because page's owner
> -	 * assumes anybody doesn't touch PG_lock of newly allocated page
> -	 * so unconditionally grabbing the lock ruins page's owner side.
> +	 * Check movable flag before taking the folio lock because
> +	 * we use non-atomic bitops on newly allocated page flags so
> +	 * unconditionally grabbing the lock ruins page's owner side.
>  	 */
> -	if (unlikely(!__PageMovable(page)))
> -		goto out_putpage;
> +	if (unlikely(!__folio_test_movable(folio)))
> +		goto out_put;
> +	if (unlikely(folio_test_slab(folio)))
> +		goto out_put;
> +
>  	/*
>  	 * As movable pages are not isolated from LRU lists, concurrent
>  	 * compaction threads can race against page migration functions
> @@ -91,8 +99,8 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	 * lets be sure we have the page lock
>  	 * before proceeding with the movable page isolation steps.
>  	 */
> -	if (unlikely(!trylock_page(page)))
> -		goto out_putpage;
> +	if (unlikely(!folio_trylock(folio)))
> +		goto out_put;

I don't know much about callers that this is trying to avoid race aginst...

But for this to make sense, I think *every users* that doing their stuff with
sub-page of a compound page should acquire folio lock and not page lock
of sub-page, right?


>  	if (!PageMovable(page) || PageIsolated(page))
>  		goto out_no_isolated;
> @@ -106,14 +114,14 @@ int isolate_movable_page(struct page *page, isolate_mode_t mode)
>  	/* Driver shouldn't use PG_isolated bit of page->flags */
>  	WARN_ON_ONCE(PageIsolated(page));
>  	SetPageIsolated(page);
> -	unlock_page(page);
> +	folio_unlock(folio);
>  
>  	return 0;
>  
>  out_no_isolated:
> -	unlock_page(page);
> -out_putpage:
> -	put_page(page);
> +	folio_unlock(folio);
> +out_put:
> +	folio_put(folio);
>  out:
>  	return -EBUSY;
>  }

-- 
Thanks,
Hyeonggon
