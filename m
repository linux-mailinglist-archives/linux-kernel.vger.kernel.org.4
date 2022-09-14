Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3475B876A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 13:43:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229938AbiINLnk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 07:43:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229941AbiINLn0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 07:43:26 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3B407C1F9
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:43:24 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-1225219ee46so40179863fac.2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 04:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore-com.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=sOxHaoTJOjG90MRKGtH8xvRMhqWLDRTQda56XXmNdy8=;
        b=y8pxtjJNRTqsadlORjvQJVCQTL15Da9B3B4XK2cnOSKgXSz4dvHCVGs9GWBK1g11Te
         zLb907AFMy6DLmzbSzLELy7Wg3pmtdZ24bdHRiibV8V55ANh8wSOLq9T/ODJi1/m9hMK
         QYvMxHoTNNqBdGxuKG7W8YFFjZ8+HO3noGv4eSis4ADs0tNc8xwpjIZt+hn5c4O4XpIw
         PSh3B1pv8FZF3YGjEL7R34B1aHnhg4pEfCqs+BlWE5ndjB0awYt2hN87gsXQnqQcWdU4
         tpqXvSygnCNYxLSoOk+fHVEwybuIuwmKi2XiUJ9x2ZEceXZD+splDVJev18DTbZo2xTr
         5glw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=sOxHaoTJOjG90MRKGtH8xvRMhqWLDRTQda56XXmNdy8=;
        b=nzl3DHPxoew3gOcovY+/Ws5pEgsX2NskxvGdtd6dY3JDcLl8vqoOuXGv8rS/CDMeQK
         pD9Gn+hC7Ye1h/aox81X2afI6Q8rHg365rBKAI2VTL1xwoVgOpEbLw9Vt067kL6FyqPl
         u5p5m5ZC9o+nttB2UyJ2HJ3DMnHh6WUatWwcqUXhMnMjzw3sPh8SrLF6k20YkbZlcomM
         KGORUg5Y4yhnWN0YOkv7zud8hZX8u3Zxiqpuelz8bMD2oJkQHv4CUOtUyZnnBtFUHHiT
         1qiW2Qr4bHQ2hdAiNYDCs91jq+Sg6lqiJ022r25gXg0lTMXZ094ulIc8ziWdIRlN8lfB
         sVjA==
X-Gm-Message-State: ACgBeo2xw0DqUK6lIAmsi0lDX9ct0giyDgWUqUcSbbUgC2vgAzTbIM1e
        WiuCUwRvBYtA5mDKrC9XwhA3ZoyGXnTzKv3vBXQW0KdFmoOy
X-Google-Smtp-Source: AA6agR7y4dqEBaNmcp8pcuElIApVSoE1q6orBTPvGb4kFLPeQXKUJsJtIm/kt/5+Jok6lir6cKMkAL7UHd1ZT43cDos=
X-Received: by 2002:a05:6870:178b:b0:12b:c621:b7a9 with SMTP id
 r11-20020a056870178b00b0012bc621b7a9mr2106429oae.41.1663155804184; Wed, 14
 Sep 2022 04:43:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220908220222.267255-1-nathanl@linux.ibm.com> <CAHC9VhSWmgRxH_5yVfg=ujni_qpWd33NkXS9wKa+1n4fNMtZwA@mail.gmail.com>
In-Reply-To: <CAHC9VhSWmgRxH_5yVfg=ujni_qpWd33NkXS9wKa+1n4fNMtZwA@mail.gmail.com>
From:   Paul Moore <paul@paul-moore.com>
Date:   Wed, 14 Sep 2022 07:43:13 -0400
Message-ID: <CAHC9VhSq_PNPHZkTiPr0L7gz9R3QM14e_W6FnYr=Y3eozzVnWg@mail.gmail.com>
Subject: Re: [PATCH] lockdown: ratelimit denial messages
To:     Nathan Lynch <nathanl@linux.ibm.com>
Cc:     linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, jmorris@namei.org, serge@hallyn.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 9, 2022 at 10:05 AM Paul Moore <paul@paul-moore.com> wrote:
> On Thu, Sep 8, 2022 at 6:02 PM Nathan Lynch <nathanl@linux.ibm.com> wrote:
> >
> > User space can flood the log with lockdown denial messages:
> >
> > [  662.555584] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.563237] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.571134] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.578668] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.586021] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> > [  662.593398] Lockdown: bash: debugfs access is restricted; see man kernel_lockdown.7
> >
> > Ratelimiting these shouldn't meaningfully degrade the quality of the
> > information logged.
> >
> > Signed-off-by: Nathan Lynch <nathanl@linux.ibm.com>
> > ---
> >  security/lockdown/lockdown.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
>
> This seems reasonable.  While the last visible lockdown message to the
> console might be incorrect/old, I think it would give the user a good
> indication that lockdown is being hit and hopefully preserve the start
> of the denial storm.  It is also worth noting that this does introduce
> a spinlock to this code path, but since it is only an issue on error I
> doubt it will have any significant impact.
>
> I'll leave this until next week to give people a chance to
> comment/object, but if there are no further comments I'll plan on
> merging this into lsm/next.

Now merged into lsm/next, thanks!

-- 
paul-moore.com
