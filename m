Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6F461150B
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:47:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231362AbiJ1OrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231226AbiJ1Oq1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:46:27 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 109E91F5268
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:46:15 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id t25so13455483ejb.8
        for <linux-kernel@vger.kernel.org>; Fri, 28 Oct 2022 07:46:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KESgtxp98yTHUoZtlQU4tbNiD6fIKzl1fVdZR1xYpYg=;
        b=CREjyA8iKBGLrlScxh1MaZcu5JW1Eaclq9/mWkUrqcirUTHEuerOj6LJNS98dEH485
         x/3tJ4el/hzWs3zDY2z4494TbS/XS/As+ZsdFatVbc8o00L8yJsyVSvtcmF7opWM3efi
         btaOl5H6a9FRYYtHnbKODvAzL23JLPoKteUpYxpnTzccOgY6JQcBVlqYxMN1FF68P/Ju
         DQco4x47+9VnXGtp3e2ECngJOPkiW+AAKQOAmK5Y7KApvQ2TAbOGHSCEVGERS0mS+6Ru
         h/ycWT2PK3iLLXa2s09SwbRlVFXjdBcB3xO2Crsh7jpCKY1/J19Zcde6HBO+HOEhFbYv
         D4Yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KESgtxp98yTHUoZtlQU4tbNiD6fIKzl1fVdZR1xYpYg=;
        b=JFQIyD9tdmELW+PQ4+pYy6NTnnoghpMdoml8jP7QDFZQ+bMxZO2CMxNh+mNcy9rDTv
         gVG/mezCmXKeGtOPrifmGjiaUXZlRsGLNewagB9l1ZGyaZCD/xAdiI2dCzTUXeV3OU3h
         F2bDsvzSUeE5wUR/zc6ne/Oor6F2DTIIs607f8TEqgVMZEKvi/xKnvght1iL/5T9/a2v
         oTVPPJKVgNCojg47rEPCy8vc6drDdXxFdF1KYq4Nma3Qr6oZi0qj86FOXJ6RjL2OFbfg
         nNo7iL50wxDxrrXlyWdQNOE9H2kuP6YrU5o9uD9W3RuVL7TC8zDmZQbtQyapQMWb/A9c
         OnhQ==
X-Gm-Message-State: ACrzQf3EbqTaq7nl6E9EQd6UaZeyZbeOJsURs85dSvkbpjzb6Yyoh3Y0
        dc5/IKzgbgDwO6iA4XTnBDtFx8RTtThmR5FmjCyPAw==
X-Google-Smtp-Source: AMsMyM4c+jz9XP+w/jlcPjuQFKcHTiI57Ya7OGNFA+kO/tG8L0ZPHIf3166jtslk3EZHPl3mfQFm5XZRMutOpzCZzhc=
X-Received: by 2002:a17:907:2705:b0:7ad:8460:7d30 with SMTP id
 w5-20020a170907270500b007ad84607d30mr10658222ejk.693.1666968374179; Fri, 28
 Oct 2022 07:46:14 -0700 (PDT)
MIME-Version: 1.0
References: <20221028063055.2817-1-liubo03@inspur.com>
In-Reply-To: <20221028063055.2817-1-liubo03@inspur.com>
From:   Daniel Latypov <dlatypov@google.com>
Date:   Fri, 28 Oct 2022 07:46:02 -0700
Message-ID: <CAGS_qxrzd5MnPgu0wTNiLaPKx-w_5BK2f=i8fuUFXTQcMQi9wA@mail.gmail.com>
Subject: Re: [PATCH] kunit: Include missing header
To:     Bo Liu <liubo03@inspur.com>
Cc:     brendan.higgins@linux.dev, davidgow@google.com,
        linux-kselftest@vger.kernel.org, kunit-dev@googlegroups.com,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Oct 27, 2022 at 11:31 PM Bo Liu <liubo03@inspur.com> wrote:
>
> The file debugfs.c missed the header debugfs.h, which
> resulted on the following warning:
>
> lib/kunit/debugfs.c:28:6: warning: no previous prototype for 'kunit_debugfs_cleanup' [-Wmissing-prototypes]
>  void kunit_debugfs_cleanup(void)
>       ^~~~~~~~~~~~~~~~~~~~~
> lib/kunit/debugfs.c:33:6: warning: no previous prototype for 'kunit_debugfs_init' [-Wmissing-prototypes]
>  void kunit_debugfs_init(void)
>       ^~~~~~~~~~~~~~~~~~
> lib/kunit/debugfs.c:92:6: warning: no previous prototype for 'kunit_debugfs_create_suite' [-Wmissing-prototypes]
>  void kunit_debugfs_create_suite(struct kunit_suite *suite)
>       ^~~~~~~~~~~~~~~~~~~~~~~~~~
> lib/kunit/debugfs.c:108:6: warning: no previous prototype for 'kunit_debugfs_destroy_suite' [-Wmissing-prototypes]
>  void kunit_debugfs_destroy_suite(struct kunit_suite *suite)
>
> Signed-off-by: Bo Liu <liubo03@inspur.com>

Tested-by: Daniel Latypov <dlatypov@google.com>

Looks good to me, one minor nit below.
Brendan, can you take a look when you get a moment?

Question for context: is there a plan to enable this flag by default
or something like that?
I was a bit surprised that -Wall doesn't seem to enable this flag when
I was testing locally.

> ---
>  lib/kunit/debugfs.c | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/lib/kunit/debugfs.c b/lib/kunit/debugfs.c
> index 1048ef1b8d6e..83411075f614 100644
> --- a/lib/kunit/debugfs.c
> +++ b/lib/kunit/debugfs.c
> @@ -10,6 +10,7 @@
>  #include <kunit/test.h>
>
>  #include "string-stream.h"
> +#include "debugfs.h"

Very minor nit: could we swap the order of these?
#include "debugfs.h"
#include "string-stream.h"
