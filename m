Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 308E3621AA7
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 18:31:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234517AbiKHRb2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 12:31:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234125AbiKHRbX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 12:31:23 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20D031DDDD;
        Tue,  8 Nov 2022 09:31:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ACB8C616EF;
        Tue,  8 Nov 2022 17:31:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 795BBC433B5;
        Tue,  8 Nov 2022 17:31:21 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="X8TWEhxg"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1667928678;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=WFchwpYWTZe1uP8NzfYiIHuE3VUM7GlNjwOOVlNkivY=;
        b=X8TWEhxgMqUY3ABKegdYHjdTULR1ZAEQzm/G3BRcJHsT3IMdcLhB/GXyxlyHExuWSMEb+L
        wzLJtg1bPIWtG9zqERGIRh7/8hr1aN3VjKE+y0AE/zjRg+gcSNy5I6AONviXfni+IH363+
        QQRKnVbPdHfwtKnwknSH1V9RCICTNsc=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 277c757f (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 8 Nov 2022 17:31:18 +0000 (UTC)
Received: by mail-vs1-f52.google.com with SMTP id z189so14321125vsb.4;
        Tue, 08 Nov 2022 09:31:17 -0800 (PST)
X-Gm-Message-State: ACrzQf2VaSLNfefNdPDdBntwxPARsvsGkRJWzXtWUlLW/G/v5hbaLTHP
        VaATmjWqePZdD60rE+yzJhNkGm8RDIsYciiqwwo=
X-Google-Smtp-Source: AMsMyM6OVmzlIf5XCDhf4Ss4zAoklzwJ63nR7aCZ5EFvtrKLrKq8Vw6R5xzFM1Hpl8GzbqEh3JVzJKqkRY2Xv5kJjVI=
X-Received: by 2002:a05:6102:f9a:b0:3aa:1a11:2702 with SMTP id
 e26-20020a0561020f9a00b003aa1a112702mr29981791vsv.73.1667928676884; Tue, 08
 Nov 2022 09:31:16 -0800 (PST)
MIME-Version: 1.0
References: <202211080929.F5B344C9F@keescook>
In-Reply-To: <202211080929.F5B344C9F@keescook>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Tue, 8 Nov 2022 18:31:05 +0100
X-Gmail-Original-Message-ID: <CAHmME9o_vJL6YstAGutZNzQ30EmWQ5vcYqbeFYoSvPm3CYeXzg@mail.gmail.com>
Message-ID: <CAHmME9o_vJL6YstAGutZNzQ30EmWQ5vcYqbeFYoSvPm3CYeXzg@mail.gmail.com>
Subject: Re: Coverity: add_early_randomness(): Integer handling issues
To:     coverity-bot <keescook@chromium.org>
Cc:     linux-kernel@vger.kernel.org, "Theodore Ts'o" <tytso@mit.edu>,
        Dominik Brodowski <linux@dominikbrodowski.net>,
        Olivia Mackall <olivia@selenic.com>,
        linux-crypto@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        linux-next@vger.kernel.org, linux-hardening@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"If "bytes_read * 8 * rng->quality / 1024" is greater than 0x7FFFFFFF,
the upper bits of the result will all be 1."

Except "bytes_read" is an int. So false positive.

Jason
