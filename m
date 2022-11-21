Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 208626320C5
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 12:36:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231294AbiKULg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 06:36:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231350AbiKULgB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 06:36:01 -0500
Received: from smtp-relay-internal-0.canonical.com (smtp-relay-internal-0.canonical.com [185.125.188.122])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 19F8615A3A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:32:42 -0800 (PST)
Received: from mail-yb1-f200.google.com (mail-yb1-f200.google.com [209.85.219.200])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-0.canonical.com (Postfix) with ESMTPS id 47B243F078
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 11:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1669030361;
        bh=Wdu8vQakfdIXWZI6cloLPICZaVlSsHqCpUijZ/K0Ym4=;
        h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
         To:Cc:Content-Type;
        b=nHy/naF46E8HlCo+XkxyJ0Zt9BNNBqXFSJnhUcGPqX65Y9ZRzXEe/MfyGXL/RSa9w
         uREfg0yxZRGqXgdoDsNrP4Vl9zgZPAGEIqLcQ2Ice1eTst/tZl7tOaM+18GYg4hpN3
         m1NTJm46d3dUP8i78PCwvWIyqQGbhIZNVErX4Zih8CmTriSad6Do1GUH7YWMj/zcZX
         1zbUHfJtOZ6rD1mYEbwC59liq3CnRgt3QaN3lveJjmbCkhhbzlv7SlkOzduhdup2uA
         VRE1jW6Fix0v017M0XBFi4HXJQYS2d95xLVbKraP/28FzDh3hwTN33+MwYe0K2qQzo
         XvD0hEFHBn/tA==
Received: by mail-yb1-f200.google.com with SMTP id v189-20020a252fc6000000b006e7396ee2c3so10537357ybv.9
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 03:32:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Wdu8vQakfdIXWZI6cloLPICZaVlSsHqCpUijZ/K0Ym4=;
        b=KCbUx5fhMX03FMT5z+A3qsVBEDHaOCsQJStIGwfCavVODXyrp+oHshesa6qBwCsW5z
         KN+YkOsMjeKzLGNia0LF72N6YVj/40BZHXWWBqUdbRSvPQ7Dg0MZsOHLwoZ8v7xAZ9P3
         TwkM0Z/LW8yGB81Qc2r/F6WDPL4GUoRp9ueHxh1ZlyLF5jrLYsrtsNZR5rmG5wcqrj0z
         p8eFUSLxtnMOs3wUTbKvES2RU1YW2c8WWIvRlmbN7vsqJ+lUMpbAjUdTRqXXXeKpvwYE
         pz22fCKUhBDGyZ8+hXl22Wa73pfirImeaL0zDzBsR8u/EqJjsa4B6v0tdhowFtTO+iFY
         ZHig==
X-Gm-Message-State: ANoB5pk1KcYoE453SqBOkUnAHNrL0z4TcKWNXaltx7+FgB+1s9HGjIXA
        VTOVz69Hv6ODBw2sfobH6eJaH4Ei3LQJGjT+ywP08plmE0IlLASfuCKQ57aRkvDLQbQnqVDVspO
        BTVUFgliKkZ7me8iofHFgnTxAM0DW269FVpB3wkfrtAyEXBaJ4rXxp7K4Lw==
X-Received: by 2002:a05:690c:582:b0:391:fccf:db48 with SMTP id bo2-20020a05690c058200b00391fccfdb48mr16027163ywb.257.1669030360333;
        Mon, 21 Nov 2022 03:32:40 -0800 (PST)
X-Google-Smtp-Source: AA0mqf7N94HxBZ+Phe4pBPmAyuYlGRxUDO4LFZpUy/j94PlMnqUevStF7XkySMLq/crkVuRUqW5EdlT7wLqM6xkcUyE=
X-Received: by 2002:a05:690c:582:b0:391:fccf:db48 with SMTP id
 bo2-20020a05690c058200b00391fccfdb48mr16027152ywb.257.1669030360150; Mon, 21
 Nov 2022 03:32:40 -0800 (PST)
MIME-Version: 1.0
References: <20221118010627.70576-1-hal.feng@starfivetech.com>
 <20221118010627.70576-3-hal.feng@starfivetech.com> <CAJM55Z-Zftr29oGzeBFzOKuGixABSJEzPF-R2c0U9Pg5qDcRCQ@mail.gmail.com>
 <13578755-ab98-7567-258d-bc6c4164ee6c@starfivetech.com>
In-Reply-To: <13578755-ab98-7567-258d-bc6c4164ee6c@starfivetech.com>
From:   Emil Renner Berthing <emil.renner.berthing@canonical.com>
Date:   Mon, 21 Nov 2022 12:32:24 +0100
Message-ID: <CAJM55Z-a1Pg2q7ZyvhwU2sp9YpsJZmE8y161UM-Ap7egCdgYVw@mail.gmail.com>
Subject: Re: [PATCH v2 02/14] clk: starfive: Rename "jh7100" to "jh71x0" for
 the common code
To:     Hal Feng <hal.feng@starfivetech.com>
Cc:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-clk@vger.kernel.org" <linux-clk@vger.kernel.org>,
        Conor Dooley <conor@kernel.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 at 08:16, Hal Feng <hal.feng@starfivetech.com> wrote:
>
> On Sat, 19 Nov 2022 00:26:27 +0800, Emil Renner Berthing wrote:
> > On Fri, 18 Nov 2022 at 02:06, Hal Feng <hal.feng@starfivetech.com> wrote:
> > >
> > > Rename "clk-starfive-jh7100.h" to "clk-starfive-jh71x0.h" and rename
> > > some variables from "jh7100" or "JH7100" to "jh71x0" or "JH71X0".
> > >
> > > Co-developed-by: Emil Renner Berthing <kernel@esmil.dk>
> >
> > The patch is fine, but I'm a little unsure about this Co-developed-by.
> > This patch is taken directly from my jh7110 branch so does Hal sending
> > it count as co-developed-by?
>
> Your original patch merged patch 1 and patch 2. Suggested by Stephen, I
> split the patch into two patches, and I need to add a new commit. My
> previous thinking was that the Co-developed-by tag should not be added
> to the commit author, so I added it to you.

Even if you didn't just copy it[1] I still don't think splitting
patches counts as "developed by". You can set the author of new
commits or copy them from a previous commit with git commit -c.

[1]: https://github.com/esmil/linux/commit/df4bcbc307e97cb6a0e7b8ed5ecc66487395176d

> Best regards,
> Hal
>
> >
> > > Signed-off-by: Emil Renner Berthing <kernel@esmil.dk>
> > > Signed-off-by: Hal Feng <hal.feng@starfivetech.com>
>
