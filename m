Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CE09683162
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 16:22:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233290AbjAaPWf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 10:22:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232261AbjAaPWS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 10:22:18 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C487BCE
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:20:16 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id q5so14584040wrv.0
        for <linux-kernel@vger.kernel.org>; Tue, 31 Jan 2023 07:20:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wGKPLwRk8RXj83Eiaa9f6FtkLMBApZXZ0126DZ9EkYk=;
        b=kDhqV0PA6ZQ19yC4zwz8D1Dzd8eZ0JiZY0KTNAo8B1aJNHn050qh9VRxGDNPq8KETA
         tUxU1kUND2dxy5liEKQoLRCjMCfDIrrKMKUEVFRvjg0PzUnUmGQB+oipA66rbDDpZP41
         6QmiFLkk7FtzeAzeWuqz4RqhoUfpZlh1YtmZhl5lzcDt1JE4cMwHV0n7A9nzSqCkDkW0
         vq8E6paT0UGKnAt+i5Kx9/Fv/iId0cF1Z3QxVylo+OJgNDWseBOfvZTPg3uW5fPORBS4
         E9j4Kv6IZDkCx4rIjy2E3QTQEzLgVcbpXRo/ja6feKR5DYylOY5IOyzZNzLExmME5Pul
         VNTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wGKPLwRk8RXj83Eiaa9f6FtkLMBApZXZ0126DZ9EkYk=;
        b=DqlrkWOrh7YisX6bWMvC7ppjq5OzyYKijAujL28PhG3TcX0zZ6i2P3VBphgP3tx5+g
         OwHwvCJoBQxyHYclMnCydQfUaB0QDMSs7rYM19d5mPxLp7iiMdWninseT1mZtCwxW6FW
         6wEeO0VPrmnHUYrhByVbSp1rWrpJJtA6X7k0do7kB9KpqupLheo4VqM8jQCZ4Q1l5aEp
         Tr9kfU3WLqGDkXGCjdsFEDZrVYJmlvqn85pc4xZLccCOyg7wnEy1QIcFaD/siijoC8KX
         pNz1bNoSepkRZVNAJHHKDst5jglpJ0Pd68q7PpolCFqzCCkshjYWqTamcMEaB+17N4H3
         odLw==
X-Gm-Message-State: AO0yUKWp5zVrEqlNuHxWkzCulAPeMimHyoeqjQlUmUjhN6PnwAYCXV6B
        UJ68ofbxDRQ+FxwoAYLwHf0=
X-Google-Smtp-Source: AK7set/wLZfrdqTUNhf9cTdfSVO3G4OtEtcjnB9LvY4qu+iiWusAStIg7QSbHXLIuYEytCNjKrgtEw==
X-Received: by 2002:a5d:5588:0:b0:2bf:cfb4:2e2 with SMTP id i8-20020a5d5588000000b002bfcfb402e2mr15934086wrv.17.1675178415145;
        Tue, 31 Jan 2023 07:20:15 -0800 (PST)
Received: from localhost ([102.36.222.112])
        by smtp.gmail.com with ESMTPSA id a17-20020a5d53d1000000b0024cb961b6aesm14697616wrw.104.2023.01.31.07.20.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Jan 2023 07:20:14 -0800 (PST)
Date:   Tue, 31 Jan 2023 18:19:46 +0300
From:   Dan Carpenter <error27@gmail.com>
To:     Martin Kaiser <martin@kaiser.cx>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Larry Finger <Larry.Finger@lwfinger.net>,
        Phillip Potter <phil@philpotter.co.uk>,
        Michael Straube <straube.linux@gmail.com>,
        Pavel Skripkin <paskripkin@gmail.com>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] staging: r8188eu: fix NULL check for rcu pointer
Message-ID: <Y9kxkhmS+yEs85s1@kadam>
References: <20230131090057.241779-1-martin@kaiser.cx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230131090057.241779-1-martin@kaiser.cx>
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[ Resending because my email setup is crap and silently eats my out
  going mail. ]

On Tue, Jan 31, 2023 at 10:00:57AM +0100, Martin Kaiser wrote:
> Fix the NULL check for padapter->pnetdev->rx_handler_data.
> 
> The current code calls rcu_dereference while it holds the rcu read lock
> and checks the pointer after releasing the lock. An rcu pointer may only be
> used between calls to rcu_read_lock and rcu_read_unlock.
> 
> Replace the check with rcu_access_pointer. My understanding is that this
> function returns the value of the pointer and needs no locking. We can
> then check the pointer but we must not dereference it.
> 
> Signed-off-by: Martin Kaiser <martin@kaiser.cx>

This patch is fine but it's a clean up and not a fix.  The original code
doesn't dereference "br_port".  I guess the new code is faster and
especially if you have lockdep enabled, so maybe in that sense it is a
fix.

regards,
dan carpenter

