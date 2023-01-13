Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46507669390
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 10:58:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240048AbjAMJ6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 04:58:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235485AbjAMJ5o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 04:57:44 -0500
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFC0193C7;
        Fri, 13 Jan 2023 01:55:41 -0800 (PST)
Received: by mail-ej1-x644.google.com with SMTP id v6so8060604ejg.6;
        Fri, 13 Jan 2023 01:55:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FL1qa9NWBiFahqVS7uPrQLa9p2D4H1P5I2LTXryXQM8=;
        b=ARafNnBkvUpZuUgUhwTMtWmlUTxe8k9Awg7mDkBW4XE7fV4hgc+MMv3psybNjMwnOu
         2byufc4c6+I/xmjLTFvrk7Vhbc+Svp1cc/Kljo69cNNmoGJB14lKON0HMXp2M17E2WzB
         ZqH4GiltM5Oo1pIMjOe2+lTvBa0KCzEtZ/wSEcad/Zdocxxz2N+FrFGKwjfBQZwuiGiY
         WFmequgXUyblfncvW+B5XTOjJPGM1eFw1nfTvHKIQRaMiuPqfNmkKNL3wOwOM7smxPa1
         C+AJiE9feki1tk4Szl5ChqzYiJjg6gPShOzmv0xY8CLkIALli1cG/F+bHYdhmtNrUPR6
         IXAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=to:references:message-id:content-transfer-encoding:cc:date
         :in-reply-to:from:subject:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FL1qa9NWBiFahqVS7uPrQLa9p2D4H1P5I2LTXryXQM8=;
        b=xu6/pdsUdbyUDLLXNgi4mPLHw8amU2wtVo02QC1eUcO8CpsNndqHA6ZbtH4gWlqlTE
         3kEcTgdQ0q6RVtstbIS0Jz/CS/6ezK1I1An/0pZFvBmK3SzhouWPP2+pasf0vmivDiWj
         WdtriVBRKC5EY8b0cw0giEiev+/X8XaQ7p/IACy71WzchYtDhbYtGdwEENR3FYvADTD6
         OI0gZIhDih847vbWgnyywIa08K416m4TyPjc6tCU8TE4Uq129J8zVPOAYs/aWqN3L82N
         P1WdGfWPQqaTuHJMyzzzAivlS1weoPznGETIntYXIQQKifpQlTq5uus4/57InDQq4yRE
         8qEg==
X-Gm-Message-State: AFqh2kpn8AmEvn1eQEIG2kg2eh1gq1mOg3b7Brh1jaICncK8YRSO/u8r
        NHPSPcY30QayWPGF9Z6TZKQ=
X-Google-Smtp-Source: AMrXdXuj5XJOhPHsKzoACyEDJti0gCLosbzWmCdInDsoLH9B1rfLQX43QL0LXpu+6bLc+WyWRIRTUg==
X-Received: by 2002:a17:906:fd54:b0:859:5541:f3ff with SMTP id wi20-20020a170906fd5400b008595541f3ffmr9518651ejb.32.1673603739589;
        Fri, 13 Jan 2023 01:55:39 -0800 (PST)
Received: from smtpclient.apple (i130160.upc-i.chello.nl. [62.195.130.160])
        by smtp.gmail.com with ESMTPSA id 10-20020a170906218a00b0073d796a1043sm8224538eju.123.2023.01.13.01.55.38
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 13 Jan 2023 01:55:39 -0800 (PST)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 16.0 \(3731.300.101.1.3\))
Subject: Re: [PATCH] docs/scripts/gdb: add necessary make scripts_gdb step
From:   Jakob Koschel <jkl820.git@gmail.com>
In-Reply-To: <Y8EUeB8tbpNVcn71@debian.me>
Date:   Fri, 13 Jan 2023 10:55:27 +0100
Cc:     Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Transfer-Encoding: 7bit
Message-Id: <1D726098-4129-4E9E-ABA7-53B72389C70E@gmail.com>
References: <20230112-documentation-gdb-v1-1-09ab556e9124@gmail.com>
 <Y8EUeB8tbpNVcn71@debian.me>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
X-Mailer: Apple Mail (2.3731.300.101.1.3)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On 13. Jan 2023, at 09:21, Bagas Sanjaya <bagasdotme@gmail.com> wrote:
> 
> On Thu, Jan 12, 2023 at 05:09:25PM +0100, Jakob Koschel wrote:
>> In order to debug the kernel successfully with gdb you need to run
>> 'make scripts_gdb' nowadays.
>> 
>> This was changed with the following commit:
>> 
>> Commit 67274c083438340ad16c ("scripts/gdb: delay generation of gdb
>> constants.py")
>> 
>> In order to have a complete guide for beginners this remark
>> should be added to the offial documentation.
>> 
> 
> What about below?
> 
> ```
> Since commit <commit>, debugging kernel requires gdb scripts to be built
> with "make scripts_gdb" first. Reflect this requirement in the
> "Debugging kernel and modules via gdb" documentation.
> ```

I guess you are suggesting this as an alternative commit message?

I'm happy to change this in v2.

> 
> Thanks.
> 
> -- 
> An old man doll... just what I always wanted! - Clara

- jakob

