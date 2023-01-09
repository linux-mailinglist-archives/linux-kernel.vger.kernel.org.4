Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CFFD663396
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 22:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237499AbjAIV5m (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 16:57:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235335AbjAIV5j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 16:57:39 -0500
Received: from mail-il1-x130.google.com (mail-il1-x130.google.com [IPv6:2607:f8b0:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8FEBC5
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 13:57:38 -0800 (PST)
Received: by mail-il1-x130.google.com with SMTP id h26so5564625ila.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 13:57:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mpprSQLash1JjtGcVOC2uBMzhrS34XgrKB7EUA5ofFQ=;
        b=iNQqE0t54cDcMDepVodG26uZNcl2cwplYAaO95/e+TgG6GdYHVzO5tXwYPYU8OV2Xs
         mvmFUEoHzkdUw4rMcvG4uRywPSgT/LHuXCaCYC2Lndry2MuDnr+Sfip5kBN02Bs53DXX
         4Ih0oNGX5+Dsmj/BtINn8Bbo1OfK/cBbrAVz9hYSXmJVbYGA15l/ZW7ha1j+9iO/ogbN
         A/Z9WbvqvgtR7jID1JCOL1Toj3IFJnJKQVPtHGbvOIFYxpcgxAJ+/wDoWIkmaq9kzZ6Z
         rL1k77G/2saWvLV3+qniPKLvMqgV9ax+3asNwHXLAmmLc3nGx/OIdLr5ZuQmlm6x/v50
         GxAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mpprSQLash1JjtGcVOC2uBMzhrS34XgrKB7EUA5ofFQ=;
        b=JWpCVmwp0xUYwOfOzEAaHZcqL9uIEp9aZI5Co5u5OwzZYLL8B7+hFJx+W2g3gUPvcM
         CKZ74MHtExj50n3VqMB5T7bMOJggQ96oI099hQSKZKwskn7+ICLzy0tHuhMVwsJ07rZU
         d6J+T4aginEHBGp3+ZLkZy7lj85rBZ599j3i0mbDUO3siuSVVXmu68cnDeMUORZDjY7j
         MzZfQVXFTalkILrsOt9fuNwQeUz4DvM6sM92grFS8aXybue+TniaANU/mhyVYgY35N90
         vvFhJFO65GkJ6eSk+0kMM+EfHZD1J5pWjCp4I11upm2/zquQs7zSQcQjzTSNsQW7zPbz
         Ft0g==
X-Gm-Message-State: AFqh2ko7RyUbRptlBeNOQ7bt8TDfuj8MHxuxKvQ7h8W9mGi6YW2KgY6j
        QDdIgtBxT02N6/bVuNeGODd4LQ==
X-Google-Smtp-Source: AMrXdXt4MYeZwrpGt3W51HEroht98TitmjFF+Hb5hFax2i5FVOJiT07Z7uh1ngWVFevpdlTOZgJvrg==
X-Received: by 2002:a92:c151:0:b0:303:9c30:7eff with SMTP id b17-20020a92c151000000b003039c307effmr10063239ilh.2.1673301457640;
        Mon, 09 Jan 2023 13:57:37 -0800 (PST)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w22-20020a02b0d6000000b0038aa0e5e9cfsm3080744jah.75.2023.01.09.13.57.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 09 Jan 2023 13:57:37 -0800 (PST)
Message-ID: <d0bb04e7-7e58-d494-0e39-6e98f3368a7b@kernel.dk>
Date:   Mon, 9 Jan 2023 14:57:36 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v4 7/7] iov_iter, block: Make bio structs pin pages rather
 than ref'ing if appropriate
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>, Jan Kara <jack@suse.cz>
Cc:     Al Viro <viro@zeniv.linux.org.uk>, Christoph Hellwig <hch@lst.de>,
        Matthew Wilcox <willy@infradead.org>,
        Logan Gunthorpe <logang@deltatee.com>,
        Christoph Hellwig <hch@infradead.org>,
        Jeff Layton <jlayton@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230109173513.htfqbkrtqm52pnye@quack3>
 <167305160937.1521586.133299343565358971.stgit@warthog.procyon.org.uk>
 <167305166150.1521586.10220949115402059720.stgit@warthog.procyon.org.uk>
 <2008444.1673300255@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <2008444.1673300255@warthog.procyon.org.uk>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/9/23 2:37?PM, David Howells wrote:
> Jan Kara <jack@suse.cz> wrote:
> 
>> So currently we already have BIO_NO_PAGE_REF flag and what you do in this
>> patch partially duplicates that. So either I'd drop that flag or instead of
>> bi_cleanup_mode variable (which honestly looks a bit wasteful given how we
>> microoptimize struct bio) just add another BIO_ flag...
> 
> I'm fine with translating the FOLL_* flags to the BIO_* flags.  I could add a
> BIO_PAGE_PINNED and translate:
> 
> 	FOLL_GET => 0
> 	FOLL_PIN => BIO_PAGE_PINNED
> 	0	 => BIO_NO_PAGE_REF
> 
> It would seem that BIO_NO_PAGE_REF can't be set for BIO_PAGE_PINNED because
> BIO_NO_PAGE_REF governs whether bio_release_pages() calls
> __bio_release_pages() - which would be necessary.  However, bio_release_page()
> can do one or the other on the basis of BIO_PAGE_PINNED being specified.  So
> in my patch I would end up with:
> 
> 	static void bio_release_page(struct bio *bio, struct page *page)
> 	{
> 		if (bio->bi_flags & BIO_NO_PAGE_REF)
> 			;
> 		else if (bio->bi_flags & BIO_PAGE_PINNED)
> 			unpin_user_page(page);
> 		else
> 			put_page(page);
> 	}

Let's please make this a bit more readable with:

static void bio_release_page(struct bio *bio, struct page *page)
{
	if (bio->bi_flags & BIO_NO_PAGE_REF)
		return;
	if (bio->bi_flags & BIO_PAGE_PINNED)
		unpin_user_page(page);
	else
		put_page(page);
}

-- 
Jens Axboe

