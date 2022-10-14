Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 237B85FF231
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 18:21:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJNQVh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 12:21:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229688AbiJNQVg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 12:21:36 -0400
Received: from mail-io1-xd34.google.com (mail-io1-xd34.google.com [IPv6:2607:f8b0:4864:20::d34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D016F1D299E;
        Fri, 14 Oct 2022 09:21:35 -0700 (PDT)
Received: by mail-io1-xd34.google.com with SMTP id 137so4266521iou.9;
        Fri, 14 Oct 2022 09:21:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=45Qc6kmJfXhoQUyX3B+fNLOQoMuf3VclzIIGEEGFt1A=;
        b=mUptDl/lHGm3yOKs3cqewPAT6HdcyKTxz5h3mSX37Dlf1Wu+XKyQF5QlBOd0YlDrEe
         OMY1Drfzlr/2SE6Fgglns0csn8MGGwgvjJFLIv6jDenEPE6rsPsBUmlSSQXfHzPkDEdt
         5ReiV7AhfWZuVxLoQmxS/+BZQeQ2a5j/RIaBviVTyiDMlADRljALv46B6qx2oJPsaYcd
         mGkB6JIAgn+tkAdxFfINkZjG2p6qQJT4FdLlH39RtA4PZtUMwAaIYCxe04DNjvsUUvuD
         4NI+zJklU6l2IHbGODhh8mbWbwN0/w4r2qKAZ5mLh8R26jrZu8XLL/L0nVD2PC5GfZXi
         Pijg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=45Qc6kmJfXhoQUyX3B+fNLOQoMuf3VclzIIGEEGFt1A=;
        b=htxcVO0sFHWFLe8maVd5vBe06fddyZwNylVbJhIXLhSbXuJ9nKr1BRRHEadPyMk9TL
         TnClf4pPSXRO1NMu66b5pmLJmObL7ebpA5XRsD4ht8YGKhyPdrcg0hmZSKKYOAIYqNq7
         +hoLduklWJnzXh5Gtdh9wQGVZNN5YfbiCqc1janoCFkzwEgsj7ramUQx5dtVPKBCGzx5
         MxEReMUSuQy0w1AUD6Nb5i0xrVDVXW1df305TT1jkuQJqnNDskA/8sF3L3x+IKzGWBEv
         9T9CfWrom03feBhJ5E9ZAu9vx8+F4lXj+u0TvqblDM6Pk3n0Tfrc9xXSXYFNEbvZEOZH
         esYQ==
X-Gm-Message-State: ACrzQf2k6VIBBtlUowffyBashuvm0IFY2TEQowO9fHvakeY98OEHu7u3
        GwV/p6T+Rith8eQ1sOBkmsjXLZLdPCgtsCUX0cE=
X-Google-Smtp-Source: AMsMyM4dnJTOcQS8q+8pDdCGeXUsJD1aKXpt0AU6KUaOu/cXO06Bsv6eEfaYrt8aZJT8BvRHc5tcDDHoabpZKxdPzk8=
X-Received: by 2002:a02:cc6f:0:b0:363:98f2:347d with SMTP id
 j15-20020a02cc6f000000b0036398f2347dmr3320450jaq.199.1665764495244; Fri, 14
 Oct 2022 09:21:35 -0700 (PDT)
MIME-Version: 1.0
References: <20221004184625.10076-1-olof@lixom.net>
In-Reply-To: <20221004184625.10076-1-olof@lixom.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 14 Oct 2022 18:21:23 +0200
Message-ID: <CANiq72mFGoDySLHNyakOnJMDpRVmvCRUAAuiKw1B2KrMhFteCA@mail.gmail.com>
Subject: Re: [PATCH] scripts: rust_is_available.sh: Provide hints on how to
 fix missing pieces
To:     Olof Johansson <olof@lixom.net>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
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

On Tue, Oct 4, 2022 at 8:47 PM Olof Johansson <olof@lixom.net> wrote:
>
> This might be a bit bikesheddy, but it saves a few roundtrips to the
> documentation when getting the `make LLVM=1 rustavailable` run to pass.

It is faster for someone that already knows how things work, but it
may make newcomers skip the docs and it duplicates the information
there. In addition, for the non-error case, it makes it more verbose
which may not be appreciated. So maybe we should point to the docs
instead? What do you think?

Also, the patch doesn't add instructions for all the cases, so
somebody that may have hit one of the documented ones + not have read
the docs may wonder where to find them the solution or why they are
missing.

Thanks!

Cheers,
Miguel
