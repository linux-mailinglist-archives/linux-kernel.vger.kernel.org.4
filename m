Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 61B3A5E874E
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:14:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232955AbiIXCOx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:14:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230113AbiIXCOt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:14:49 -0400
Received: from mail-qt1-f179.google.com (mail-qt1-f179.google.com [209.85.160.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D796424BCC;
        Fri, 23 Sep 2022 19:14:43 -0700 (PDT)
Received: by mail-qt1-f179.google.com with SMTP id w2so1131598qtv.9;
        Fri, 23 Sep 2022 19:14:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=XYpb3jMoE2sW/1DrEQcCXaAdtZuC9Ljzelzta3hGVvo=;
        b=o9nfKEAKIdcVeBJDdILQUXSgafLPD/K+S5hhxFJHZmTJio725itvWOxKu4CZppuf15
         dzEPzijQALu/09UlWiu75YXdV9/M2bB6LrQybt5W5KYaylem6JFSL7eFjdBXNCeE9yTC
         QJ4Z+dcqTZ++Jr5dxu1gqUn0VrxUET4cIP32pKc9n8CI8zCERTtmY+UAF94TWznJ1Bz0
         fd9av4z5luxOXazgG/5gLU1kWgsZ2ZeJkBHVgX9pqMuCDTYh9URrpJpy8g424c3IAasX
         fnLniPQEeswoEbXxBufNw1KAX0OlR7yCsqKDXoerJ+/F0dWsWl5n/ED0tIzrp+eED2yU
         rMzw==
X-Gm-Message-State: ACrzQf0LCjxvBs1cwxZUBjoo6BiyZxnqcVf8dO9NodhgMmJvfTU2kmTA
        nDhmKA5kBbspSbgh3dV7szZ93JtKaIuF/g==
X-Google-Smtp-Source: AMsMyM4MUwRUUY75JOpTav8YqgKmv6hRd8op8lfYeqXipzXPq34sefaIil43ZGPOU5xtC1HYtnW2gA==
X-Received: by 2002:a05:622a:1904:b0:35c:c657:14e4 with SMTP id w4-20020a05622a190400b0035cc65714e4mr9772665qtc.65.1663985682878;
        Fri, 23 Sep 2022 19:14:42 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2c58])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a444c00b006af1f0af045sm7447796qkp.107.2022.09.23.19.14.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 19:14:42 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:14:44 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 4/7] docs: remove some index.rst cruft
Message-ID: <Yy5oFE41pCDeN6LS@maniforge.dhcp.thefacebook.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-5-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922204138.153146-5-corbet@lwn.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:41:35PM -0600, Jonathan Corbet wrote:
> There is some useless boilerplate text that was added by sphinx when this
> file was first created; take it out.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: David Vernet <void@manifault.com>
