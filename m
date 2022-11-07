Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE7B861E9DA
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:47:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230328AbiKGDr2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:47:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231255AbiKGDr0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:47:26 -0500
Received: from mail-pf1-x435.google.com (mail-pf1-x435.google.com [IPv6:2607:f8b0:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E02656B
        for <linux-kernel@vger.kernel.org>; Sun,  6 Nov 2022 19:47:25 -0800 (PST)
Received: by mail-pf1-x435.google.com with SMTP id y13so9457934pfp.7
        for <linux-kernel@vger.kernel.org>; Sun, 06 Nov 2022 19:47:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=LeRxcf3iiMtcahtf1wz2RRfWDJy8GlafUjCiGkQ4x/g=;
        b=PzJyPN1hzsY7irKE0LoT7cQEVWGAiKFWdjgmAwHCxhsvLs/qk+d5MnNyQNEBnXtsDj
         vEwqM+mVYo2nvsUPYocMhjvKK/1bLqXW8v0NTwcNzzS2LAWeLXq84ZZyOl1RYRwSnqqb
         YNCVytL/nFRpl+9eGn8eiWVrzdO8J92BLnGng=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LeRxcf3iiMtcahtf1wz2RRfWDJy8GlafUjCiGkQ4x/g=;
        b=BvaMWtDn66YVi3J5KcCOW2b15hdn32NzCzdY+uGQ+xehfN3nHkETtjYRJmcdYrkYzY
         k0KFDoPwJzqcWl8p37YiFxcrN3qm+/WYQSr+gKHnL24x8JZE3FneKywfmNiN2rPKZ83I
         qmgdG37HFTHKDaVj7b9MPpAjOVI4Lk9YWlcTjeJQj/ka7dNJZjdyp1Z/IE5QlASdBwg9
         N2CBtOsxTM2ntnvu1A+aEiIUYYRNZaBBewpOUpv/fJy3i0y7o5fJJgKAomIeGLK6p//P
         7kmrCHgoSRi0zpQ/vvaR42XuMBHi2hv2ngPOFxTJkcZ8uoux0kwZ25uVU9wYQYAhQjCy
         r1Pg==
X-Gm-Message-State: ACrzQf2P3bJYYeHhwqIalP7w0/slA/Yed23IxnYHr7HEY4wcC/3WveP7
        FbyeojbwKp75jyOx4i1EHtv1MAQXCZWWlA==
X-Google-Smtp-Source: AMsMyM4lJOcuHrqAzZ9ZN4HAH66GV5hGJY0bz9qbe1YVJMcixuWwXUynn901Nr/iPWehrFj026aFqw==
X-Received: by 2002:a05:6a00:98d:b0:56c:7c5c:da30 with SMTP id u13-20020a056a00098d00b0056c7c5cda30mr47644948pfg.22.1667792844914;
        Sun, 06 Nov 2022 19:47:24 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id pi2-20020a17090b1e4200b0020bfd6586c6sm3183278pjb.7.2022.11.06.19.47.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 06 Nov 2022 19:47:24 -0800 (PST)
Date:   Sun, 6 Nov 2022 19:47:23 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Greg KH <greg@kroah.com>, Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the tty tree
Message-ID: <202211061946.AC6355E1C@keescook>
References: <20221107143434.66f7be35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107143434.66f7be35@canb.auug.org.au>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 02:34:34PM +1100, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the tty tree, today's linux-next build (htmldocs) produced
> this warning:
> 
> drivers/tty/tty_io.c:2271: warning: cannot understand function prototype: 'bool tty_legacy_tiocsti __read_mostly = IS_ENABLED(CONFIG_LEGACY_TIOCSTI); '
> 
> Introduced by commit
> 
>   83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")

Whoops! Thank you for the report. I've sent a fix:
https://lore.kernel.org/lkml/20221107034631.never.637-kees@kernel.org

-Kees

-- 
Kees Cook
