Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 802AE632DD2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 21:19:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230390AbiKUUTj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 15:19:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231892AbiKUUTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 15:19:24 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACA3DD06FF;
        Mon, 21 Nov 2022 12:19:23 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-39451671bdfso99140377b3.10;
        Mon, 21 Nov 2022 12:19:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Rd4Jm/e508B9fRuPdgkDC5Sv2y4ES1AktySKiiGtLNQ=;
        b=mjSWppemaP+ZUrOhua9ikIl8SbShMxfOacSlLD9r6VvORUQFrnN2AfMvvIrXhw3U+L
         sqVsIvhpFAMLO/4BCD4r7o5Sy6hA329l1SmfT4jHPY5GztDosVcQewb3otoDsELXzCgE
         /NQSVnnvoyvp9Gd6dToBjghzSfysw/SzOwWThFfgymKVTGxlmxp1tgpAYb7Uv/s+F7ve
         uRTNsp5BIktWAqSnV5ngQPzj/UClEAsHVC+wFDn21CLo7gRT9c1IW/VnJ6meyu84Ve4I
         RsXDKGsgNYyrZF05nupeMiRMRNaXdd/JxdHVt50XDA3quBfBXo0oHeBoTz0nKLINHZpf
         OAnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Rd4Jm/e508B9fRuPdgkDC5Sv2y4ES1AktySKiiGtLNQ=;
        b=s7iFKCtUOmKPFNJ2QV9ooTj9Q/65BN4YtTzna88Z3JRS5qLQYwKDqfmNyByOU4AZXa
         i7lLjQRaMnCeOFfVNIuk81HCKPMST1FJZ2XCjSQ3Fr4zYhcDtjbADk4buDWZQgB46lHe
         OTt4eJCmv9wPjz3WtThcVEIX6S2nTpszh/GD5KfaVy+ql3aKjWfSNQIWfnN0CQikJ46x
         O1S0iUv3oDHCtQlNB4WbkKuakpph12ph6br7C4wjjXfEcjlyMxmHD63DhqK0FQCsUt0s
         D66trGbpX4VarrDLdN5Bd40+2Ka9ux9qAmo8SczW7eBdFYVrfRWyGr7F0lWg1vBctbJ2
         NEaA==
X-Gm-Message-State: ANoB5pkRaA1hX/TLWJk9WsZX5/7XVAs9jPg3YSMzPP4Gj2Gy49PuGGPQ
        1jICyg4cn0NV2EXU77DNdgeiV7K/d2qFphbWuKc=
X-Google-Smtp-Source: AA0mqf4qL2P/BkGy1mGCx0oK7tFKngK8cE6O46xq5tRfhvN/kIAkcaUreI9S4mKF+1DY4AizY6WDorp9VIDPmtwha1Y=
X-Received: by 2002:a81:7cd6:0:b0:385:136f:6e0b with SMTP id
 x205-20020a817cd6000000b00385136f6e0bmr761466ywc.256.1669061962908; Mon, 21
 Nov 2022 12:19:22 -0800 (PST)
MIME-Version: 1.0
References: <20221121181626.149558-1-carlos.bilbao@amd.com> <20221121181626.149558-3-carlos.bilbao@amd.com>
In-Reply-To: <20221121181626.149558-3-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 21 Nov 2022 21:19:12 +0100
Message-ID: <CANiq72kuCc_fbyvoe+DKeiot69=Y_JvTMctYWYUO5x=dHbqe4Q@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] docs/sp_SP: Add process kernel-docs translation
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, ojeda@kernel.org,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, jm@goyeneche.es
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 7:17 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> +escrito por Juan-Mariano de Goyenche

Same typo here too.

Cheers,
Miguel
