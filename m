Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25F2E5B6C6C
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:37:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231915AbiIMLhk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:37:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229782AbiIMLhh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:37:37 -0400
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B1B12EF24
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:37:35 -0700 (PDT)
Received: by mail-pg1-x536.google.com with SMTP id g4so11091421pgc.0
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=TjtzJA8TbY7YIwrLa9FdbYyvleadiqEs0UmHM7ohbZc=;
        b=BWxKLsa1XK1/cCmSeyx+EuA4PQGqKnMl5MczYCNgXxoITrRmIaNfaJgkT6vTWgKUm3
         //K4mS0KCIYwWpukBE8YlYwb1LVKcHBxLcT7LTDzcpWrGe/BqBQ7f7IIuyoq4QIFK/+t
         u9zm3jNUZppy5wlz+8gQTf8zE4ISXF1AAHU0M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=TjtzJA8TbY7YIwrLa9FdbYyvleadiqEs0UmHM7ohbZc=;
        b=oTppUlAWgkR+1dBJGxbSuu/irS0WQEKEoxB904tfRM0VdHm4ROT94sO++KrxorfVbO
         RJPLweb96DI69x0MnqWPyxRO2QYOZubykMrEJnuHC9BCDFdcxRpBUenVkoqmBKHKNCIU
         4isI0dTeqtT54e0PVhbedtr2JfAAvIzhoVha1h4CGJSKOWsXEEfowIFl4ul1oLxKHVqg
         Jifu1ERMb0X9CKbYBXF8dvUtguVNEiA+WVg45ykRd5JZ5tM1OhTZKkt3dshXeusvSMBp
         X2Nb9e2sMiVFqpdJmkY+yp7m3StE0pNNagB46NKQTvac6mlhA4lLbbVdnf5Rw8/SGKD/
         gWMg==
X-Gm-Message-State: ACgBeo3DAFkoBFdN6LX15s6SKB+Pc09fLCWttyhHYCFthpOgI+6inLgc
        0stFu0ni1fxpVu3cA+YtYQwAXw==
X-Google-Smtp-Source: AA6agR4f79z5in3SokyyTKik0/YG0LlAPBib+4YiUgNyGbueLKId6zSyyneA1SJVJH28LlqFjLjHfQ==
X-Received: by 2002:a63:d94a:0:b0:412:6986:326e with SMTP id e10-20020a63d94a000000b004126986326emr27906686pgj.56.1663069055120;
        Tue, 13 Sep 2022 04:37:35 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id u1-20020a170902714100b001780e4e1a0fsm8116219plm.125.2022.09.13.04.37.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 13 Sep 2022 04:37:34 -0700 (PDT)
Date:   Tue, 13 Sep 2022 04:37:33 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Andrei Vagin <avagin@google.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH 0/2] Revert "fs/exec: allow to unshare a time namespace
 on vfork+exec"
Message-ID: <202209130435.12231CE199@keescook>
References: <20220913102551.1121611-1-avagin@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220913102551.1121611-1-avagin@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 13, 2022 at 03:25:49AM -0700, Andrei Vagin wrote:
> This reverts commits:
> 133e2d3e81de ("fs/exec: allow to unshare a time namespace on vfork+exec")
> 6342140db660 ("selftests/timens: add a test for vfork+exit")
> 
> Alexey pointed out a few undesirable side effects of the reverted change.
> First, it doesn't take into account that CLONE_VFORK can be used with
> CLONE_THREAD. Second, a child process doesn't enter a target time name-space,
> if its parent dies before the child calls exec. It happens because the parent
> clears vfork_done.
> 
> Eric W. Biederman suggests installing a time namespace as a task gets a new mm.
> It includes all new processes cloned without CLONE_VM and all tasks that call
> exec(). This is an user API change, but we think there aren't users that depend
> on the old behavior.

Can we include that patch here as well?

> It is too late to make such changes in this release, so let's roll back
> this patch and introduce the right one in the next release.

Do you mean you'd like this revert to land for v6.0, and we should wait
for the new API for later?

-- 
Kees Cook
