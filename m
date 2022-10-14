Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B6A35FF211
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:12:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbiJNQM3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:12:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229924AbiJNQM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:12:26 -0400
Received: from mail-io1-xd31.google.com (mail-io1-xd31.google.com [IPv6:2607:f8b0:4864:20::d31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B61E653004;
        Fri, 14 Oct 2022 09:12:24 -0700 (PDT)
Received: by mail-io1-xd31.google.com with SMTP id y80so4256897iof.3;
        Fri, 14 Oct 2022 09:12:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=YzF8nM01hZWzZm+9umHDPuILoGvVnKs20DXJk0y8/UQ=;
        b=jkG1bmDpPJAVggc//wtm//iVdHLa/J9FI3Dh2zf71HxR+nAjnPJtltxkjYh/WwOB6j
         yZTsWVbokIn22w0+SWQGZRpR25fvBvkCD/CPIT3TSgDt7O1/VWoWtZysaCN6zBskuB4z
         fmZOx6Y50vSfSn703yA16a9wYebueL2ohsOY9xWFDeYJOBMM/INNHBk4kFnJ+n/4kTBc
         bpJsvZyKYxnyuamOjZxMScA0UfzF4NIXK1+5ub2OlGKbZMeHCdn7qFoQ+OirN0HESJol
         FwGvBIxZM6BXwb3XBJYoD+NWClt6SyJI9XxG6qubfzG+0i19EJKX03EQw3RMxwEqzFlO
         DylA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=YzF8nM01hZWzZm+9umHDPuILoGvVnKs20DXJk0y8/UQ=;
        b=wET2ttTDPzF39ZWM2b59k/FxXb7IZcwQpY7G070Ue7XpGSUtICLnQZH0Lxu+dLtGuv
         m1Zoil72t8wElZ6HauVAYnajaStNXyYYcvOLmnrAvxqAdcA1kS3tZ8j4zuG01cSPJc61
         RyX1Czjj9GKAbZM4rbKU5uAuMPq05SS2dLeOX35DvK4BWpcu60Zg82UOuddGHMr0qrTq
         nXAbWVrO7xGB4gbRIiOhFTn9CLOj8FoKNW2NiKgTyzf7OjoWYycsQxBYMM5anHL+MIQR
         po4UJTJ3ZZ/dBOhW/URtzMwAJvogfw+5I2fIDpVf//QydrwMMg4FV39a2vOET4VwdPsU
         3CWQ==
X-Gm-Message-State: ACrzQf1baLH8fiW3vX5ory0q/YADakQ2oDwAV5+ijP8YkAC7eSzfqGMX
        GWHfOGZF39oGXM5+WeTKYpx1Ulkf46Yxlv+0STLou63rS30=
X-Google-Smtp-Source: AMsMyM7lmU0uBYNCu+Wl0FZTBGN1BhmiRVJrhq43DsY+IPe9OGRViUb09zzkFFdky6XTngI7a8PEMRE+M8q5FnhhJ+c=
X-Received: by 2002:a02:cc6f:0:b0:363:98f2:347d with SMTP id
 j15-20020a02cc6f000000b0036398f2347dmr3297442jaq.199.1665763942638; Fri, 14
 Oct 2022 09:12:22 -0700 (PDT)
MIME-Version: 1.0
References: <20221004184625.10076-1-olof@lixom.net> <20221005072743.vfanu2mgj56wbdmh@gpm.stappers.nl>
 <20221013170105.kqmdxiuvi3ltnddd@gpm.stappers.nl>
In-Reply-To: <20221013170105.kqmdxiuvi3ltnddd@gpm.stappers.nl>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Oct 2022 18:12:11 +0200
Message-ID: <CANiq72nJSaR-_89Epe2gZc=5_N-xhUBV0W4rV0NAb2-OsQc51A@mail.gmail.com>
Subject: Re: [PATCH] scripts: rust_is_available.sh: Provide hints on how to
 fix missing pieces
To:     Geert Stappers <stappers@stappers.nl>
Cc:     Olof Johansson <olof@lixom.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Geert,

On Thu, Oct 13, 2022 at 7:01 PM Geert Stappers <stappers@stappers.nl> wrote:
>
> How to prevent that the patch gets lost in the mail?

Do not worry, it is not lost :)

> And how to avoid that reminders like this get contra-productive?
> (When to send the next "Please approve or reject the patch"?)

The author of the patch would normally send a ping. If you are
curious, please see Documentation/process/submitting-patches.rst for
some guidelines.

In short, the authors would wait at least a week, and they would apply
their best judgment (e.g. whether the merge window is going on,
whether it is a new feature or a critical fix, whether
feedback/comments/tags are still coming, etc.).

Cheers,
Miguel
