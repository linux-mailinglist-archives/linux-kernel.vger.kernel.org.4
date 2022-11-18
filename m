Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8AC62FC07
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 18:52:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242246AbiKRRw4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 12:52:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242265AbiKRRwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 12:52:54 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E63764544;
        Fri, 18 Nov 2022 09:52:53 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id k84so6497575ybk.3;
        Fri, 18 Nov 2022 09:52:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DZc60G77tnBeDaIJDUGaSbXuJtHL1CgQTVBXHXPY7LY=;
        b=pbnVZiWl9+jQaSexHLexcAK7kR4Sl8V4f8W8Z5R6KkM+WUHVW+pkK6W0Z96tgLmaO1
         knY0qQcQLUb86THyByi+LIGwnjx8aVyg/P41Bp7smbxx6wFD6pFzegIdZWxbfT+vaWWO
         EFBzLzt2kw+7iClbfRguBG81YOnIYYaNM0Gn8FgEnr+SGxAyB9PHa62S3J9MV1/Incmn
         QrUScfYQ+7kh1zVH5rNjqinIvzX7RE0ihkUJYwh6I2/rswSqgGGpkNAU2zz6DBMMd025
         97XSQcta5PgdCkDult/4YnLsw44I64GBdlT+zmh5l31lwVGtavdOu61g5F5Mcn0F4jnz
         kAyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DZc60G77tnBeDaIJDUGaSbXuJtHL1CgQTVBXHXPY7LY=;
        b=NuRIrJTPhaeILbBNLQfatJ4SALb4h2t3yOxKfy36nRDdqITzHYcQXfhrLbeLzRK7Wl
         3D+7xC6Nawf38wL9LXBWg2ISOucnkuC4isvb/RHbVXcuPV0tVMe/LVfU7ezUqnxzj3YD
         reGyLeRpAMeMjMqYwLCExyhVBNOuSA5YypdQi1bjskXKzdsHq6YkaEHjdRBsapRr5RXZ
         tj+truG0h4+JH2pF3Bn4dAHUIpL6mL7PwvDFJptlsKc+pL9TYzkCQHR3hBsRZIw1dXVN
         V9aE6ppOEE8/TtOxiq+oCd1PamaUVGGc8LzvCfrmxD0orBF/qxyCqE4aheKytUFLmX4z
         xeBA==
X-Gm-Message-State: ANoB5pmhLgT47jyDna7Jdi95R/FbWBzOy+T+BZ874EkZ/32KomtgqOU3
        wnPFRYxS0kk1BqHUkAX3bpcsGPV2Pf6VBuuxbJU=
X-Google-Smtp-Source: AA0mqf6S8QgG0JBWchUvXPogxa6bRykbS9qW5lbGJTtm4oxWVETgVwzwhTfJ4O0Lg10peBOsVY+1hHTwSXYOdCqog9A=
X-Received: by 2002:a25:44c5:0:b0:6cb:16d0:1ae1 with SMTP id
 r188-20020a2544c5000000b006cb16d01ae1mr7218008yba.581.1668793972536; Fri, 18
 Nov 2022 09:52:52 -0800 (PST)
MIME-Version: 1.0
References: <20221118170942.2588412-1-carlos.bilbao@amd.com> <20221118170942.2588412-2-carlos.bilbao@amd.com>
In-Reply-To: <20221118170942.2588412-2-carlos.bilbao@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 18 Nov 2022 18:52:41 +0100
Message-ID: <CANiq72nN7i4yXjnLftdKZ7zo8Qw8c=aM6L+D2SvzH47PVALJYQ@mail.gmail.com>
Subject: Re: [PATCH 1/2] docs: Update maintainer of kernel-docs.rst
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, lukas.bulwahn@gmail.com, Dhaval.Giani@amd.com,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org,
        bilbao@vt.edu, ojeda@kernel.org
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

On Fri, Nov 18, 2022 at 6:09 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
>  Index of Further Kernel Documentation
>  =====================================
>
> +Current Maintainer: Carlos Bilbao <carlos.bilbao@amd.com>
> +
>  Initial Author: Juan-Mariano de Goyeneche (<jmseyas@dit.upm.es>;
>  email address is defunct now.)

Shouldn't this be covered via `MAINTAINERS`?

Cheers,
Miguel
