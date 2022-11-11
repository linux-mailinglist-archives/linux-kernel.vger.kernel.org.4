Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39A97625879
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 11:34:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233938AbiKKKeh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 05:34:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233897AbiKKKec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 05:34:32 -0500
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0586127910
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:34:32 -0800 (PST)
Received: by mail-pf1-x432.google.com with SMTP id b29so4525624pfp.13
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 02:34:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=+i7NWs5ElLfzzgcx0B5LRq5KgAIbsYPPgqesylV99qc=;
        b=auN3/+xhoPmbbT5Jr5mgDseb2NtTdMDLZUkWZXoWF/BlKqtpqh23AhY6vlvK9tyhO4
         TdgEl0NnEMzfzeperKZ/1cvHhOZ3lBDsui8JlcKcT8qkQycLUyTaMZ+Kjh2AS8Arlkuk
         2ACGV9xL/yLpEnN3WU3AIxlcV89LiqyOvwh8A=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+i7NWs5ElLfzzgcx0B5LRq5KgAIbsYPPgqesylV99qc=;
        b=xqp6CZFwR1FRr0P1T14W+VSdUpW6C1Zu1rv0l7Acs6qEwdzO3D2MVUhX4FUK/mdB/I
         zVhPLEprWkHSohgjx9BkmXoPqpGsFd1Aqxqjl9HyozRXvvgVtweJmO2oYUyX7klo+0wb
         L10z6gUvUhTtLylquNDKXWfPQ0NwuiinVKntmHIYc7eSqTEvkSpvi4arEtUQD/EfVe+X
         3u5lbuCgBNmcWbBZ8YxXIdyb+kZG/8+rfO+ml5GNA+ygUB1nn7HerQ8XcQ78+Q89RYWa
         lnoH/7dANJx8A6kgPPGo30rMTf1+VjlxpnudmhCdOuizuWw9bWNcR5PkuQ3Zg/H76imX
         DudQ==
X-Gm-Message-State: ANoB5plj8phscllN0Z7RECgPnNTCHOaigWqALyu24g37MYoRhix8DGWz
        SXPqxPVfpHio1JXQtcao3EvspA==
X-Google-Smtp-Source: AA0mqf48wRyFzQ1BYVpCEzg1z170CYhJdr8bvcAEjXyKB6FFAoNXQoJROj6OOCBhq7yDaKmXSEA5fw==
X-Received: by 2002:a65:6107:0:b0:46e:d2ea:1417 with SMTP id z7-20020a656107000000b0046ed2ea1417mr1173842pgu.0.1668162871558;
        Fri, 11 Nov 2022 02:34:31 -0800 (PST)
Received: from google.com ([240f:75:7537:3187:8d55:c60d:579d:741c])
        by smtp.gmail.com with ESMTPSA id t186-20020a625fc3000000b0053e8fe8a705sm1311733pfb.17.2022.11.11.02.34.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 11 Nov 2022 02:34:31 -0800 (PST)
Date:   Fri, 11 Nov 2022 19:34:26 +0900
From:   Sergey Senozhatsky <senozhatsky@chromium.org>
To:     Minchan Kim <minchan@kernel.org>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nitin Gupta <ngupta@vflare.org>, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
Subject: Re: [PATCHv4 8/9] Documentation: document zram pages_per_pool_page
 attribute
Message-ID: <Y24lMtZc5tlxVObM@google.com>
References: <20221031054108.541190-1-senozhatsky@chromium.org>
 <20221031054108.541190-9-senozhatsky@chromium.org>
 <Y22xiLFYb49TGeYm@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y22xiLFYb49TGeYm@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On (22/11/10 18:20), Minchan Kim wrote:
> > diff --git a/Documentation/admin-guide/blockdev/zram.rst b/Documentation/admin-guide/blockdev/zram.rst
> > index 010fb05a5999..4cb287520d45 100644
> > --- a/Documentation/admin-guide/blockdev/zram.rst
> > +++ b/Documentation/admin-guide/blockdev/zram.rst
> > @@ -112,7 +112,29 @@ to list all of them using, for instance, /proc/crypto or any other
> >  method. This, however, has an advantage of permitting the usage of
> >  custom crypto compression modules (implementing S/W or H/W compression).
> >  
> > -4) Set Disksize
> > +4) Set pages per-pool page limit: Optional
> > +==========================================
> > +
> > +zsmalloc pages can consist of up to ZS_DEFAULT_PAGES_PER_ZSPAGE (single)
> > +physical pages. The exact number is calculated for each zsmalloc size
> > +class during zsmalloc pool creation. ZRAM provides pages_per_pool_page
> > +device attribute that lets one adjust that limit (maximum possible value
> > +is ZS_MAX_PAGES_PER_ZSPAGE). The default limit is considered to be good
> > +enough, so tweak this value only when the changes in zsmalloc size classes
> > +characteristics are beneficial for your data patterns. The limit on the
> > +pages per zspages (currently) should be in [1,16] range; default value
> > +is 4.
> 
> I think we need to introudce pros and cons for user to decide it since
> it's not familiar with admin. I think It would need more explanation about
> zsmalloc internal(especailly zspage and size classes)

OK, agreed. I have quite a bit of info in the 0002 commit messages.
I can copy-paste some of those bits and edit them. We also have
some info the internal doc, which I can also use as a "source of
inspiration".
