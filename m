Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FE8D5E873D
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Sep 2022 04:05:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232888AbiIXCFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 22:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiIXCFL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 22:05:11 -0400
Received: from mail-qv1-f51.google.com (mail-qv1-f51.google.com [209.85.219.51])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40ECA93203;
        Fri, 23 Sep 2022 19:05:09 -0700 (PDT)
Received: by mail-qv1-f51.google.com with SMTP id l14so1049838qvq.8;
        Fri, 23 Sep 2022 19:05:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=sXBGrc4MnmHkD3uAIqXZ6M5DcHxR/0FObdegovSMaC8=;
        b=teTqk4wlaeaRWMmG88IlmvzUF5OZCNMB1OT14AHqClKZWTyC9ve0NmHylLVQG18Lua
         bUFbF8GhE+zRTntqdKQTayyTJRkbFrcHQoNtts02uRVjXG23y8j073fh9VBwRiMnaF7C
         U6GaXkL2ZsLefWTnrj2pYEc3V+FaCZE8RPs7CBCyT12RLRKFDuYEZ900RGa4cOvhVjrq
         s7JS+P4gsaFcmOToeLXJ8FoyWUfuwnhVNxpkuoqepfQn+AG5aacrey80HIICmxdU6t9C
         XFn6+AHRLd1CIWX/+TChm3xPgmRhbricU2PyI7kAH2YUKRkWLO/d2zrGATVM4MpaiHnG
         1bVA==
X-Gm-Message-State: ACrzQf1ajVxISd8zCncbz+7rUciNva1wYQozpG9MrZovrSiEzKvOl7v0
        U1IL+YvrfUCBXXNmHCK7jds=
X-Google-Smtp-Source: AMsMyM5cjvA1cLoZGgk5hNBnqxl3ygzQaJ7bd8f3ok/Yc5cNwOjsBeNz5V0CZyg203W/HLtrXVpngQ==
X-Received: by 2002:a05:6214:21a9:b0:4aa:b0e6:c6f5 with SMTP id t9-20020a05621421a900b004aab0e6c6f5mr9297812qvc.19.1663985108284;
        Fri, 23 Sep 2022 19:05:08 -0700 (PDT)
Received: from maniforge.dhcp.thefacebook.com ([2620:10d:c091:480::2c58])
        by smtp.gmail.com with ESMTPSA id q13-20020a37f70d000000b006b9c9b7db8bsm6904943qkj.82.2022.09.23.19.05.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Sep 2022 19:05:08 -0700 (PDT)
Date:   Fri, 23 Sep 2022 21:05:09 -0500
From:   David Vernet <void@manifault.com>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Kees Cook <keescook@chromium.org>,
        Jani Nikula <jani.nikula@linux.intel.com>
Subject: Re: [PATCH v2 2/7] docs: Rewrite the front page
Message-ID: <Yy5l1UT4FVuHU+yz@maniforge.dhcp.thefacebook.com>
References: <20220922204138.153146-1-corbet@lwn.net>
 <20220922204138.153146-3-corbet@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922204138.153146-3-corbet@lwn.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 02:41:33PM -0600, Jonathan Corbet wrote:
> The front page is the entry point to the documentation, especially for
> people who read it online.  It's a big mess of everything we could think to
> toss into it.  Rewrite the page with an eye toward simplicity and making it
> easy for readers to get going toward what they really want to find.
> 
> This is only a beginning, but it makes our docs more approachable than
> before.
> 
> Signed-off-by: Jonathan Corbet <corbet@lwn.net>

Reviewed-by: David Vernet <void@manifault.com>
