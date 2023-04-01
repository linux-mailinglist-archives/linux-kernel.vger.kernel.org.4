Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A83806D2E0E
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 06:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233389AbjDAEJc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 00:09:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233316AbjDAEJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 00:09:27 -0400
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 436B41A96F;
        Fri, 31 Mar 2023 21:09:26 -0700 (PDT)
Received: by mail-ot1-x336.google.com with SMTP id r17-20020a05683002f100b006a131458abfso10372371ote.2;
        Fri, 31 Mar 2023 21:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680322165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=moEsiQdrfjLTLT3nbE6SFehFZ+ghxOA2nR0m6JbX7oE=;
        b=owoca4/xxxCpxUnPskej2OfFzSZ+QgFYS8PMBqACaciirf0/uXhRAsDtzATxPIwuIi
         wYFxilvKFOFtdGR3cBuUqp1xxIDRxZ1FovKeU/boks2aOu/c1lHDg0NbL6D4sCOH2TiX
         9of7XreuAL9BT78l0RqD/NR0WZgnu5h1qm91HYeY4lL47WbRhoUyOrAlwwqZJbjgiSUm
         9XspqyPN4GjfGMJZAPYbfA0G9RJXEAXhfMu69lYBH0LPUh4QBufHNrzMmsCIVtLb/Srb
         DYo1lzfwh98U1iJuMRDmLFHRgjmgkNGBCoJwfzO6LHBFafgCSZRwezJyxze3WjJTdD+V
         kNqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680322165;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=moEsiQdrfjLTLT3nbE6SFehFZ+ghxOA2nR0m6JbX7oE=;
        b=3WKkcpQL3xCLs+bHf/O7UPqtXcPZ6f2BRBpzH9PU9ZASGLrQuDwMv0pODE1k6R/yN5
         0TqT81de5W5z84zcCuFrxpqOJFq7FXrZwnJKCBV452Zyee6LW1cJcu1gYbRJV3Go146q
         ItqLSZSW/Xwm6SoS4IKBLkWvfD0QU490jAw17aSBf1yqdEpf2b7aQdw/ijJH9HQwEIB0
         Rl+KI6cklZdc6kZtqKsVZK4TYnmHyl73WULUGXZQevhsgrK0wNUcAniZLH/nhIZMgb2G
         PvIaYPwwK9CHbkd6dj3BnHbk2muoq8itxeHbAWfn4+ZmxecT5oCaHLvCfJvfJ6B9pYVo
         ezXg==
X-Gm-Message-State: AAQBX9dH9Pn74cZVeIE6MfEC3Zas+QizeNim+S6TX9Tzcz4ZfajfSUDd
        aGMzjCyvqCIJ+QCRh5Oh+bs=
X-Google-Smtp-Source: AKy350YPpw/47LxP/TbYnDDi+5bob2BOGEHyUIPT8ivzRxx8I7o+S3VHPvhznlOhi2kvvAKBj5TpkQ==
X-Received: by 2002:a9d:734c:0:b0:6a2:f3e2:d5b with SMTP id l12-20020a9d734c000000b006a2f3e20d5bmr1437349otk.9.1680322165442;
        Fri, 31 Mar 2023 21:09:25 -0700 (PDT)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id w3-20020a9d6383000000b006a11c15a097sm1921168otk.4.2023.03.31.21.09.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 21:09:25 -0700 (PDT)
Date:   Sat, 1 Apr 2023 01:09:18 -0300
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Gary Guo <gary@garyguo.net>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: Re: [PATCH 10/13] rust: introduce `Task::current`
Message-ID: <ZCeubhgETf84thv9@wedsonaf-dev>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-10-wedsonaf@gmail.com>
 <20230331034701.0657d5f2.gary@garyguo.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230331034701.0657d5f2.gary@garyguo.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Gary, thanks for reviewing!

On Fri, Mar 31, 2023 at 03:47:01AM +0100, Gary Guo wrote:
> 
> I don't think this API is sound, as you can do `&*Task::current()` and
> get a `&'static Task`, which is very problematic.

One thing that isn't clear to me is: how do you get a 'static lifetime in the
example above?

Altough `TaskRef` does have an arbitrary lifetime param, that's not the lifetime
that the returned `Task` reference gets. For illustration, I've explicitly added
a lifetime 'a in the impl below:

impl Deref for TaskRef<'_> {
    type Target = Task;
    fn deref(&'a self) -> &'a Self::Target {
        self.task
    }
}

Which means that the borrow of the `TaskRef` you use to call `deref` must
outlive the returned `Task`.

So how do you get a `TaskRef` with a static lifetime to begin with? Or is there
another trick to get the `&'static Task` that I can't see?

Thanks,
-Wedson
