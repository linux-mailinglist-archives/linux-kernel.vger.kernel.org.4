Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 257F86020F3
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 04:11:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231321AbiJRCL1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 22:11:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231301AbiJRCLG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 22:11:06 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E7E8FD78
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:10:29 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso15981655pjf.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 19:10:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pXq7vl1l4DCjha3jqz1NjXeWrlpGUKnIqvQa04QtbZg=;
        b=ajKiCjw2GqkqjmR7+UI5hnJevb9nOayKTSN8Hl8the106FXQFlJrH8Mcjx/MWGnIa3
         OHZ7VQictyh+NrqyMc0IFrEkAmO5/icu3OiRD7g7OYPNI2I/2ACK7uyneihMwI8F2CNI
         ArL1/oXS9AzLQwfNifqbHcqo56Nw4oo7yznig=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXq7vl1l4DCjha3jqz1NjXeWrlpGUKnIqvQa04QtbZg=;
        b=LXjeEu5tmwfMZx6eT5EpWYp1SMyPWJvYxH95vA8qk5gzUpMZr2DWKMgV6pdL2rsDvc
         34keDDtHjiYOTsgYEbVbTxeAEC4ZUfh74OK4MmU6dZqKRsmuwwsVFKrURgUamVrQiTs6
         G2mIP0/fCGghuLm5b1hmFMu5LSHQ1CXql4u94eX2DLN6LBCpi7tGKH9mQj0AgeuhdYa3
         8Ed5n2LGBJDDkI8dtCrTxGEdayEPLVbq5nz4OUvit+bwsNx/fdQsQMeLJeBU75OlvVYy
         tp18kee/+rLP3OS+BH5K84cnP0MK4cHrrYVS/0VKj4ji8pMDiYuZzDDQPwFqtqpPE6d9
         QkCg==
X-Gm-Message-State: ACrzQf0KzmvfpZgxAv/EpcvRKYZ3yMPWwlOGoVCU5U+9IIgcm1Jl5MFX
        5gtIKqrT2D++jSmoEP6r8oYY/w==
X-Google-Smtp-Source: AMsMyM71fQoy5ngCHvweGrpSziaR3QQE8FA2xSRdyGylOxe1SdKkG87lNq3RrvB/UbXpDBOEBcjUkQ==
X-Received: by 2002:a17:902:c792:b0:17f:9255:3185 with SMTP id w18-20020a170902c79200b0017f92553185mr647099pla.100.1666059019750;
        Mon, 17 Oct 2022 19:10:19 -0700 (PDT)
Received: from google.com ([240f:75:7537:3187:58b4:95a3:4654:2a9f])
        by smtp.gmail.com with ESMTPSA id a5-20020a17090a740500b0020d526cc147sm10352314pjg.46.2022.10.17.19.10.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Oct 2022 19:10:19 -0700 (PDT)
Date:   Tue, 18 Oct 2022 11:10:15 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Minchan Kim <minchan@kernel.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv3 8/8] zram: correct typos
Message-ID: <Y04LB3/hLrG00Zln@google.com>
References: <20221009090720.1040633-1-senozhatsky@chromium.org>
 <20221009090720.1040633-9-senozhatsky@chromium.org>
 <20221017170844.3284c18376b16713c09b315b@linux-foundation.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221017170844.3284c18376b16713c09b315b@linux-foundation.org>
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/10/17 17:08), Andrew Morton wrote:
> On Sun,  9 Oct 2022 18:07:20 +0900 Sergey Senozhatsky <senozhatsky@chromium.org> wrote:
> 
> > Trivial comment typos fixes.
> > 
> > --- a/drivers/block/zram/zram_drv.c
> > +++ b/drivers/block/zram/zram_drv.c
> > @@ -759,7 +759,7 @@ static ssize_t writeback_store(struct device *dev,
> >  			zram_slot_unlock(zram, index);
> >  			/*
> >  			 * Return last IO error unless every IO were
> > -			 * not suceeded.
> > +			 * not succeeded.
> 
> That's a pretty awkward sentence.  Why not "unless every IO failed".
> 
> If that's indeed what we're doing here.  Sounds odd.  What do we return
> if all IOs indeed failed?

Hmm, yes, I didn't consider re-phrasing this comment but we probably
should do so. What we have there is

	while (nr_pages_to_write--) {
		err = submit_bio_wait();
		if (err) {
			ret = err;
			continue;
		}
	}
	return ret;

zram objects are independent and bio errors on individual writes are
non-fatal, if we failed to write-back a zram object (page) we just
continue and try to write the next one; at the same time we need to
signal user-space that some of those writes failed (doesn't matter
which ones or how many). That loop used to look as follows (as far
as I can tell):

	while (nr_pages_to_write--) {
		ret = submit_bio_wait();
	}
	return ret;

Notice how `ret' would get overwritten all the time, so we if we had,
say, a successful submit_bio_wait, then an unsuccessful one and a
successful one again, we would lose the track of the bio error that
happened on the second iteration and will always return 0 to user-space.
*Unless* the last (or all) submit_bio_wait() also failed, in which case
`ret' would hold the correct error code.

Will something like this look less awkward to you?

---

diff --git a/drivers/block/zram/zram_drv.c b/drivers/block/zram/zram_drv.c
index ecbc5963b5b8..23f1655b7837 100644
--- a/drivers/block/zram/zram_drv.c
+++ b/drivers/block/zram/zram_drv.c
@@ -758,8 +758,12 @@ static ssize_t writeback_store(struct device *dev,
 			zram_clear_flag(zram, index, ZRAM_IDLE);
 			zram_slot_unlock(zram, index);
 			/*
-			 * Return last IO error unless every IO were
-			 * not succeeded.
+			 * BIO errors are not fatal, we continue and simply
+			 * attempt to writeback the remaining objects (pages).
+			 * At the same time we need to signal user-space that
+			 * some writes (at least one, but also could be all of
+			 * them) were not successful and we do so by returning
+			 * the most recent BIO error.
 			 */
 			ret = err;
 			continue;
