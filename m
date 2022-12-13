Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B62D64AD4F
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 02:43:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234334AbiLMBnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 20:43:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234327AbiLMBni (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 20:43:38 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58C7A6171;
        Mon, 12 Dec 2022 17:43:37 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id C5CE5CE1346;
        Tue, 13 Dec 2022 01:43:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7793C433EF;
        Tue, 13 Dec 2022 01:43:33 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="N/aQMkz7"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1670895812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qBABwiEsFw7XNv3PYFYqMmbh0RZ3nujH6VSw2HFWxM8=;
        b=N/aQMkz7LJi254x6VyIGHRiqCun6quu726T+BFriSxH6rdLMyMxowqf3I+KJLFPvjX+lQg
        qrUopAPWk/036VAgHNXSykQZJtjVzQZxvHFPvIE4XdHI6q+zAxuQqH9qrAt8QapnCk01ZC
        4C4YkRha/bW/Mb0fZsd9b+HtEma1hNw=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 4250d992 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Tue, 13 Dec 2022 01:43:32 +0000 (UTC)
Received: by mail-yw1-f178.google.com with SMTP id 00721157ae682-3bfd998fa53so172841547b3.5;
        Mon, 12 Dec 2022 17:43:31 -0800 (PST)
X-Gm-Message-State: ANoB5pnXrLdi7D0f0H8K6C2QQ1FI9GMGGeTIv7P/Nh1WG6yYn5C9ZJ14
        XKdlUIudMSKBtCjYxLyaDz2t9HZB1UnmOIxrsyc=
X-Google-Smtp-Source: AA0mqf7x5QNPNbUQq5lkThmsxCjzL1qiwduM7oTFA/eIkkQ3myNlQ3rks14OdIWZ27lc/FQoMTBACRuPPJfLlJWkZVE=
X-Received: by 2002:a05:690c:843:b0:3b5:ea43:e343 with SMTP id
 bz3-20020a05690c084300b003b5ea43e343mr1151574ywb.259.1670895811416; Mon, 12
 Dec 2022 17:43:31 -0800 (PST)
MIME-Version: 1.0
References: <20221213115125.51bb83ae@canb.auug.org.au>
In-Reply-To: <20221213115125.51bb83ae@canb.auug.org.au>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Mon, 12 Dec 2022 18:43:20 -0700
X-Gmail-Original-Message-ID: <CAHmME9oT+g2oSRK_1s4+dUmBOW9LTVGuT8pYByp=k2YzAc9cpQ@mail.gmail.com>
Message-ID: <CAHmME9oT+g2oSRK_1s4+dUmBOW9LTVGuT8pYByp=k2YzAc9cpQ@mail.gmail.com>
Subject: Re: linux-next: failed to fetch the unsigned-char tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
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

Hey Stephen,

Was going to write you this evening. Yes, the tree is done (merged to
Linus'), and so you can remove it.

Jason
