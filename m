Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E8DE62C981
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 21:05:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbiKPUE7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 15:04:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36372 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234297AbiKPUEi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 15:04:38 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A463663C2
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:04:34 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id b131so21630697yba.11
        for <linux-kernel@vger.kernel.org>; Wed, 16 Nov 2022 12:04:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PSKQyCay4BBogRpmQsUSaoxdrcqQ8CI1eEM5yI2MZYA=;
        b=TGxi2qoKU+O5Kf8x39Y0vpnERSqdiODPn3n6IblXD89ESRoR88nKxACFftILuVafLV
         a1eWlSBVq9ZhGn2oD/QIYWoyoc5zEEacySXCCpNdmXP5eHxVJVia1N5B16hAxmULDWYF
         WVUOuIHfN5dPoQy9iIT/DAfrC7xKFg3wZ6iFpwiK9CQA0ArBOGAjt3ur4lCrU4BQFnA8
         Uu1APb8vFUvV/kHr3VaYp+znz9zTrqVXEKwIrdFFZfxeDwFND+WBLX/cWOxXkzcHVQ7I
         n9skPNGueq70oONSIUCSxtwUDsKQyvD4wEr2xGKm99xy2Oc/BpzGlG9SLVhC800rzmiG
         QWNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PSKQyCay4BBogRpmQsUSaoxdrcqQ8CI1eEM5yI2MZYA=;
        b=pi+dho/S5AqIaE/wcGyPcIy7H8U2W91eYpGaSflw/WvU8OzVM982fvArXkFgRsY52K
         RwufnBU+Csg2kEhFAO1JitNfZ8ucFwFzSZw1ndmPKHn17BNBRE6qSPlUv0TjFIFFhU+i
         a8t0DmzY+A8NHqDGoFLiDLXSHWR/4+ZtEn2P1R6AIARGAg1AO1lSQLODGLTlHBo1Co0Y
         h9ZARKz4Zl3YlLfUl/mON8kUaNY6ZRG2CCGXKR3lDunlQ5OgK8D9HzBumxAUsobJevFd
         Ei9taBM9CKjmsZAsd4HN0J7c93v65Vi2XxLleyje8eqJgk+hHXUGcIgckIfsB2elk6BN
         +uvw==
X-Gm-Message-State: ANoB5pnrkZTfrZAHiwNUqPE21+q6yVlxMYncxnIxDN4h7u0+q9gcPSJQ
        fY2D0ebupp+LX6yLPMrrWXRSiZoRlxJ3RiYJZEA=
X-Google-Smtp-Source: AA0mqf7JMZj7Yoq1mO618KFhnfeVpb2kxVsYpbT1hNk+/yO5E4ZsiWjSqlBd5dVJaJYO01tPmpPIfGF50QysE5UhIx8=
X-Received: by 2002:a25:d60e:0:b0:6cb:16d0:1ae1 with SMTP id
 n14-20020a25d60e000000b006cb16d01ae1mr22524009ybg.581.1668629073696; Wed, 16
 Nov 2022 12:04:33 -0800 (PST)
MIME-Version: 1.0
References: <20221115212546.7154-1-cyan@0x00a1e9.dev>
In-Reply-To: <20221115212546.7154-1-cyan@0x00a1e9.dev>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 16 Nov 2022 21:04:22 +0100
Message-ID: <CANiq72nJ8OutiA48zzXkZUvfGFjEWazPOgzXtqV2-J5HnDWx=w@mail.gmail.com>
Subject: Re: [PATCH v2] scripts/kallsyms.c Make the comment up-to-date with
 current implementation
To:     Yuma Ueda <cyan@0x00a1e9.dev>
Cc:     linux-kernel@vger.kernel.org, keescook@chromium.org,
        gregkh@linuxfoundation.org, ojeda@kernel.org, boqun.feng@gmail.com,
        masahiroy@kernel.org, samitolvanen@google.com, ytcoode@gmail.com
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

On Tue, Nov 15, 2022 at 10:26 PM Yuma Ueda <cyan@0x00a1e9.dev> wrote:
>
> The comment in scripts/kallsyms.c describing the usage of
> scripts/kallsyms does not reflect the latest implementation.
> Fix the comment to be up-to-date with the current implementation.

It may be a good idea to say in the commit message that this is now
equivalent to what the `usage()` function prints (and possibly change
`scripts/kallsyms` to just `kallsyms` to make it exactly equal). In
fact, we could replace the comment with "See usage() function" to
avoid further desyncs... But that is a different patch :)

Also, I am not sure we want to use tabs on the comment -- the rest of
it uses spaces.

Cheers,
Miguel
