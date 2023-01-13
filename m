Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9527668A88
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 05:07:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232777AbjAMEHw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 23:07:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231169AbjAMEHb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 23:07:31 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5AAC63D27
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:07:30 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id v23so17336436plo.1
        for <linux-kernel@vger.kernel.org>; Thu, 12 Jan 2023 20:07:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DYI5pjk8+oki3WxDxm15UVmcJ7O/apoFc5w+Rdk9kRM=;
        b=I/wdvXlxrKnCFaV7HqW1wESORYWZzMW73q3/XsX/J+NCac8+1X6R0kIdbjovHyQ8KD
         AOsJoUnWeNGW8eyhEUB8f1zZDtqpeNqTJ7xYbbo32wj5tICJmmHTCR+Mw6khXbTM5ymj
         xrX6p3HvCq1lHVMk9YA4b9Iq2pKgIi5a2Y07b8O6yRkIbKrJ0LWghXXs98riB4hWhBpr
         mWYkuCZwLrWwSYXF/2HXDWepbF8k0no+quJuhO7i1m0hd188DSZbcK4a8wNMK/+pcka5
         oJiHkHB+96Gqzsp1BvbcTJ+3eXqSWDSf7RmDIiAPx1ejRZpFRz6JjcQOHqjH4XZAvYDV
         oabQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=user-agent:in-reply-to:content-disposition:mime-version:references
         :message-id:subject:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DYI5pjk8+oki3WxDxm15UVmcJ7O/apoFc5w+Rdk9kRM=;
        b=K5+xlSVbcuK/B9zfSmJZ7KidZpGAtLGpY7QoQVj4r9MHEN1u52CtSJ6js5Yw1ZXBCs
         rYwjJ4zfgDbN7ktOik9dMMvjQ77MQVN0Gc0IR7t8FHL++Byx/tMv3/pKCtspRbmxCbSI
         XfRMpzjz/YC5ynIZIS8vIwRYGda6Qw2cj9UyJoME6nB8Db/GLzqo7H7xe2Qm+6PWJU8n
         7JOnuppKffuDq82ImS5PKsZvVrGEvpCEjJJkynvmnBcuYdIj2kDUIcz5qZa9XY+X7EV7
         HR5CQu5+5SqpXJ6CyAbGq71q2T5ZsqPW0DnM5Fv3Uv/1u04ga2fgU/UgMiUaS0uyami1
         0bIA==
X-Gm-Message-State: AFqh2kp0+oBbV4s+pcNv+63E2oM50D7o+IHXWFh7b/GJcrUILJnekmNb
        g+HxAVpAivUT7aO1Q1XsEy4I2OQisCs=
X-Google-Smtp-Source: AMrXdXt5BbBVxth7GVajOSkTUfDVNOx7mN4hFgf4F3YZ5tGCdyHdegavN7MlF6HqveqTeLjMB+gTVQ==
X-Received: by 2002:a17:902:c205:b0:194:6e8d:89ac with SMTP id 5-20020a170902c20500b001946e8d89acmr1263076pll.24.1673582849855;
        Thu, 12 Jan 2023 20:07:29 -0800 (PST)
Received: from thinkstation.cmpxchg8b.net ([76.133.164.192])
        by smtp.gmail.com with ESMTPSA id q8-20020a170902a3c800b0017f74cab9eesm8322993plb.128.2023.01.12.20.07.29
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 12 Jan 2023 20:07:29 -0800 (PST)
Date:   Thu, 12 Jan 2023 20:07:28 -0800
From:   Tavis Ormandy <taviso@gmail.com>
To:     linux-kernel@vger.kernel.org
Subject: Re: x86: XSAVE flags mystery
Message-ID: <Y8DZAOY4O5ftbsjP@thinkstation.cmpxchg8b.net>
References: <Y8BDveL74VlBFZpw@thinkstation.cmpxchg8b.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y8BDveL74VlBFZpw@thinkstation.cmpxchg8b.net>
User-Agent: Mutt/2.2.7 (2022-08-07)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 12, 2023 at 09:30:37AM -0800, Tavis Ormandy wrote:
> Hello, I have a mystery and wonder if it might be a kernel bug.
> 

It seems like other people have noticed the same issue:

https://robert.ocallahan.org/2017/06/another-case-of-obscure-cpu.html

I guess it is just an unexplained CPU quirk, not a kernel bug.

Weird.

Thanks,
Tavis.


-- 
 _o)            $ lynx lock.cmpxchg8b.com
 /\\  _o)  _o)  $ finger taviso@sdf.org
_\_V _( ) _( )  @taviso
