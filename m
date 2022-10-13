Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A0465FD36F
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 05:07:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229511AbiJMDHm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Oct 2022 23:07:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229594AbiJMDHi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Oct 2022 23:07:38 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E928111E47B
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:07:36 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id r22so751962ljn.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Oct 2022 20:07:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=teT7jLlxzN4i1te1sVTA7XA7K2s0Bo1np+U79OkEZds=;
        b=a3jtqMpOOhZuTY4QC3PGfEN5pY3L8lvp+y4QJXVoPWwdAg8nWFqubN5gCcMHFj+U7u
         /U4/C7JlWhypXP/uFWVDxoGFkLis1AlnRMQNo5p+C+O4QKiHfuFsVyXl53WoeMk3CGhF
         uCpfIFnlJVrOOjBQR0ivHRe/u0a7GAzHhoKjGgNytEaApQ/A8hY5onwOQzz/UtRpbFXz
         0FmMLTIfxjXfvrXRb8h5L3UGqyFrcybPMzsZh89h1xW+/21xBctI88STKhaxCXvRMsiK
         x9N6lWATu3oWk7M3YRoTlw+BQ7bpOx8gzprxBSCVuno6agoDAoyG5IiyXH5Ag4tXUVX9
         /CMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=teT7jLlxzN4i1te1sVTA7XA7K2s0Bo1np+U79OkEZds=;
        b=3MkngF9NUZ9x4OXnEu8FlO9P5VzAK4Lj24ZwkbEstOrhr3BXe0Kpi6/wchSSTZfe6e
         uD1dfgNagSRx9RUtp912L0V+jggQUF0iLmuxXETwOJjh0kamXXZrqOhOCJ3VxhV0gnh1
         Sio3vXf4lDRsRaJHbsZkhBZLTL2mH+7eZflEIC6manJy2UGsdiMNjA2iJEYPblseA083
         i0MfNBlwPUGXrv5+O4FFt36MvYBi3pNRgbG5vpA1TSx7dJeMTGNsOl8MY/cCLDUfsr12
         B64kIzFPYcwOSXexcOF9cW5HLaIXgTTKaP2U58KA/2Z9l9ctI4nO1hrBrFoChsuSpcjI
         AG0g==
X-Gm-Message-State: ACrzQf332RhREfQJ///6sseUoDU0w+9ABVf3TjuN7DviSRepq6rb9T+6
        UiMq3EWmMh2louXR+jzQ6tTEqb6hCpHAm+G+1kv8gqfEeA==
X-Google-Smtp-Source: AMsMyM7s0RTDvuj/pVbsqF6Qfr5bg4a5tCwlZtc9rgBRuqFwjYDX/FMk9gCwQg3cQJyt4Yzkaw/Mfm9BdH75puFTuQY=
X-Received: by 2002:a2e:9e50:0:b0:261:e3fd:cdc5 with SMTP id
 g16-20020a2e9e50000000b00261e3fdcdc5mr11728293ljk.56.1665630455163; Wed, 12
 Oct 2022 20:07:35 -0700 (PDT)
MIME-Version: 1.0
References: <CAJD7tkZkY9nfaVDmjzhDG4zzezNn7bXnGrK+kpn0zQFwPhdorw@mail.gmail.com>
 <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com>
In-Reply-To: <CANDhNCrrM58vmWCos5kd7_V=+NimW-5sU7UFtjxX0C+=mqW2KQ@mail.gmail.com>
From:   John Stultz <jstultz@google.com>
Date:   Wed, 12 Oct 2022 20:07:23 -0700
Message-ID: <CANDhNCojzuCW2Udx_CssLvnY9DunEqVBSxnC5D6Rz0oX-r2-7g@mail.gmail.com>
Subject: Re: Question about ktime_get_mono_fast_ns() non-monotonic behavior
To:     Yosry Ahmed <yosryahmed@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Stephen Boyd <sboyd@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        bpf <bpf@vger.kernel.org>, Hao Luo <haoluo@google.com>,
        Stanislav Fomichev <sdf@google.com>
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

On Wed, Oct 12, 2022 at 8:02 PM John Stultz <jstultz@google.com> wrote:
> On Mon, Sep 26, 2022 at 2:18 PM Yosry Ahmed <yosryahmed@google.com> wrote:
> So I think it reasonable to say its bounded by approximately  2 *
> NSEC_PER_SEC/HZ +/- 11%.

Sorry, this should be 2*NSEC_PER_SEC/HZ * 0.11

thanks
-john
