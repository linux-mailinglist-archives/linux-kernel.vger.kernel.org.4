Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4378B640AC6
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 17:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234174AbiLBQ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 11:28:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234158AbiLBQ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 11:28:06 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AFF696156;
        Fri,  2 Dec 2022 08:27:36 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id v206so6606995ybv.7;
        Fri, 02 Dec 2022 08:27:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=2GxtvfHCkncjnTNpJW4An3z4TxFNjBybQDia+IbsvAI=;
        b=AXHkzHOUOB30rgVsOy7suQUPZicLTrqxJk3pFPRFKy9yXV9WDO6ppfKW/okGciqoTV
         QTR2FidLs3Zqzq0KfXmfdN7umbRjPJzgy369QroyGajw223Em7YI1p7JSJitJeS2/RV9
         AtAaPfvGfahcbcGadr6p6PUtfhx0KvFYmmea7iDtJCoaRVwc5az1Gq6NVuPUo30+vYXY
         k860SoFeqz6EQXC9LXalTkmPaX+btA9gwhl/XaP+qZG32I3SR5bxEKvzYVaZr75n76+Y
         o+hXugqFzoH/2B1ragC/B4rrgwByqUR32ZZgEnf2xtSmUuIkcpg0IuvxRfxSQLYoqgXX
         nYDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2GxtvfHCkncjnTNpJW4An3z4TxFNjBybQDia+IbsvAI=;
        b=iVz6kM7s2FHwYbt+ZlMCzKkyhfTBqf9SPB+Qk6f2i5LsGHGnq3A5ce3RUXXK0MZShI
         WxbbBZ2U2da1bGLmzxXK6oqtVbXlRPc7zQOq08mIIRiYkjNdH9Yun/IvCZQuaybwyCKL
         JlkSRD0IblOqEE+CogoClCls2X1ID100YSZ9byLH5D9nthtddVq42BanF1jCrQtjP0Zt
         dcx2bx8m/bF0D05zkinn4nMNBkMLbHjxMJ86gBzwc8yT7dZL2HYdzsXqB8XoqiUMHiGk
         kdIHFiteK32ZoSwwAiLRtRJLYS2b71by7b6iKqJqO0wQ1nGZa+SAsdWXGVF4/iSP8j0n
         fPCw==
X-Gm-Message-State: ANoB5pk9ItQxmoNQ+vMRUzD2TxCZg/c26iHMPuedOM9QDQf98Glwb8gy
        QIa1pXNvoOHBOe3PyTJSXbDJWkyPVd5oXE4K4ys=
X-Google-Smtp-Source: AA0mqf7m7pxhWnL1A3FKm5m8WgIh9QG7XLbayOVVXnVFxagacUUAg+TdH567KwyTXyh51iOPeLjMskMvWKff3c8V/gU=
X-Received: by 2002:a25:44c5:0:b0:6cb:16d0:1ae1 with SMTP id
 r188-20020a2544c5000000b006cb16d01ae1mr48488932yba.581.1669998455690; Fri, 02
 Dec 2022 08:27:35 -0800 (PST)
MIME-Version: 1.0
References: <20221130220825.1545758-1-carlos.bilbao@amd.com>
 <CANiq72nMY5f85tJJFg7AFsh4YRrKObhurhT8TVawYqoZU+J-Fg@mail.gmail.com> <15942593-5ec7-77a6-8637-61ca495d7528@amd.com>
In-Reply-To: <15942593-5ec7-77a6-8637-61ca495d7528@amd.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 2 Dec 2022 17:27:24 +0100
Message-ID: <CANiq72kkkbhYn44Mxn=55SLNHgqoAyiEadOAkprNpQOMaNAHUg@mail.gmail.com>
Subject: Re: [PATCH] docs: Integrate rustdoc into Rust documentation
To:     Carlos Bilbao <carlos.bilbao@amd.com>
Cc:     corbet@lwn.net, ojeda@kernel.org, bilbao@vt.edu,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        konstantin@linuxfoundation.org, Akira Yokosawa <akiyks@gmail.com>
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

On Thu, Dec 1, 2022 at 9:40 PM Carlos Bilbao <carlos.bilbao@amd.com> wrote:
>
> I don't understand config sync. Perhaps that, e.g. Documentation/Makefile
> checks for broken docs, for CONFIG_WARN_MISSING_DOCUMENTS, but we don't
> do that for rust/Makefile? I'm not sure, but it does sound orthogonal, yes.

Config sync is what needs to happen to make a bunch of files in
`include/` up to date with respect to the `.config`. It runs
automatically for some targets, but not always. For instance, the
`*docs` targets do not trigger it. So if you enable e.g.
`CONFIG_WARN_MISSING_DOCUMENTS`, and immediately afterwards run
`htmldocs`, it will not take it into account.

But don't worry about it: that part of my comment was directed at
others (e.g. Jon, Akira...) that may know the historical context or
the reason behind it -- no need to fix it here. I mentioned it here
since it affects `CONFIG_RUST` if we use it there (in the same way as
the other `CONFIG_*` used there).

Cheers,
Miguel
