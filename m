Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D235691845
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Feb 2023 07:05:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231248AbjBJGFX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 01:05:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230443AbjBJGFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 01:05:21 -0500
Received: from mail-ej1-x631.google.com (mail-ej1-x631.google.com [IPv6:2a00:1450:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABB987432C
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 22:05:01 -0800 (PST)
Received: by mail-ej1-x631.google.com with SMTP id hx15so12989860ejc.11
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 22:05:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=cyCw7uGS0lODDxQUej9sN3LcUc0Kv+YA1s/fVgdFQf8=;
        b=TppZacDmVjKVMWV/vD8YkcVqNiaV7HzEMkP7UDXDdvUhGWQlLkys0mCqHqresMC2CT
         qxFvG7R5LNjmQllm7R91eT2P5WMNBLrUpfwsdL/Zk5U0T5zrGPYEkRPZ2JqF41dMZb+E
         7GWGDZNgdJDhfYD41mHZpKwqpOvRSDcbzvUTqMH+Ru30tCrcDXcfn+Cm4UmT4Gh1Y8uz
         H4QJlFk2gZenlW4gyMtW5tgnp2UkPC/7+LtZodjrSnj5Nxzp9N5eWPZOryhXP+fN0oAM
         mMuRLCfhwuYHy3g1awRfBb1+3kWZ/t6BEZl64eCQis2niB+ha6JuTsrbsfP4Ahk/jM0V
         Xovw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=cyCw7uGS0lODDxQUej9sN3LcUc0Kv+YA1s/fVgdFQf8=;
        b=TL06Q7n31B4FCG5/X8eQQJzSgxDI82pLnHoXsm7r9CRdDZXFHehd91awmDXEcGZPhZ
         NMLPEXLkjnwRTMbCN0DCFRA+83y04WCwpxtY21SEWGflMfk1MrcR2oZUdUYaErgMwt92
         TbfVHzfkwOoK+Tr6ZOigyBiwHgINMxMHl9c/c5dG8G90QYiERXd+/W5mPtN0VNRLWxZJ
         0oU2B3PperuJwl88JsJeTlFWvoFh1MNoi/UrIouRIxWJGr7sqniBA61tpzLpjThDaGQr
         EOIIkCZ4QmycYoCKRjeNJHq4IEsevCRkA16fGpf/rRy7o/uiJXdrzYrTZB9OZqUlB3qK
         RZZg==
X-Gm-Message-State: AO0yUKXz9vO5WXdCGI1/SroFFnQdp8kPCTkSB7YnTu5pyIDfw/Ipw1r9
        BjrZHdV0dnT1ZYeqJlC1cDuyKIgj91wVXasst6/urQ==
X-Google-Smtp-Source: AK7set/KLIAuxzZ+iPqGSHKHgnZWT2zlp8hBwI1EZmGk82kj4+nvJtI58SDulBnhhn5DVxhopTqXWx5I1CP0H9rR1to=
X-Received: by 2002:a17:906:2a4c:b0:87a:3b3f:b9da with SMTP id
 k12-20020a1709062a4c00b0087a3b3fb9damr1057585eje.10.1676009100038; Thu, 09
 Feb 2023 22:05:00 -0800 (PST)
MIME-Version: 1.0
References: <20230206092559.2722946-1-senozhatsky@chromium.org>
 <20230206092559.2722946-3-senozhatsky@chromium.org> <CAJD7tka_DFfFu2Ji-HAdw066J2MkmxzrYVQp6pHUAAQhz6Y7EA@mail.gmail.com>
 <Y+GtsM6vJge90LHe@google.com> <Y+XG4mWPi4X9/hHZ@google.com>
 <CAJD7tka3s84v9-ZA-OZkBkina6MByCSFnKXwv+hq8o8nZSZoyg@mail.gmail.com>
 <Y+XIR64RyVv0EfTx@google.com> <CAJD7tkaLtuNL_=WtcMsZ_orSwRMhN3K7vF8PWcxLRXKc6Z8uGQ@mail.gmail.com>
 <Y+Xbt4uJ/214xnR5@google.com>
In-Reply-To: <Y+Xbt4uJ/214xnR5@google.com>
From:   Yosry Ahmed <yosryahmed@google.com>
Date:   Thu, 9 Feb 2023 22:04:23 -0800
Message-ID: <CAJD7tka73PT8ka78rJBnd0JMtfjLY7SAr953MKNbZy5+icHD8g@mail.gmail.com>
Subject: Re: [PATCH 2/2] zsmalloc: fine-grained inuse ratio based fullness grouping
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 9, 2023 at 9:53 PM Sergey Senozhatsky
<senozhatsky@chromium.org> wrote:
>
> On (23/02/09 21:15), Yosry Ahmed wrote:
> > > We need to be able to do zs_stat_get(class, CLASS_USAGE_70) or
> > > zs_stat_get(class, CLASS_USAGE_10) in zs_stats_size_show() to
> > > show class's fullness stats.
> >
> > If we use #define FULLNESS_GROUPS 10 for example, we can break down
> > struct zs_size_stat from a single array to two arrays, one of the for
> > fullness groups and the other one for the rest of the stats (e.g.
> > OBJ_USED). We can have different helpers to update each, the former
> > taking in a fullness value (0 to FULLNESS_GROUPS-1), and the latter an
> > enum. WDYT?
>
> Wouldn't this be more code to review, maintain though? I mean,
> what do we gain with this - fewer values in enum?

I don't feel very strongly, but the patch above has a lot of hardcoded
values, multiple enums & static arrays. If we want to change the
number of fullness groups to 5 or 20, we modify all of them. Just
trying to make the code cleaner. If you think it will add a lot more
code to review/maintain, then maybe it's not worth it. I didn't really
give it a lot of thought.
