Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77C8C6AA117
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231697AbjCCVYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231615AbjCCVYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:24:38 -0500
Received: from mail-pg1-x534.google.com (mail-pg1-x534.google.com [IPv6:2607:f8b0:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 290D66153E
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 13:24:37 -0800 (PST)
Received: by mail-pg1-x534.google.com with SMTP id s18so2305276pgq.1
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 13:24:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1677878676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1mdoExm51Pf5mwwZ4Mi9krVz9vq+ZuMYZbUHrj+6+MY=;
        b=VsZLaCA1o7PfS/2uqkfBMQhBxAqtr9smxIr3yTAhLFKnRjgIbkVVKQyYH4eI+QISau
         SMlTDUfaqmuVN8fJuzP0XkURXKBvYZN6GhPxbn1LVAbUgwR9wdRdBGgn75IGF8zYcTPu
         cCKXh/ycFb9Hm7/Va2frtYvkwF+TEP05vTvas0DWtdDPJloTFYt5TCF/F4yzxd+EjJwl
         A0Ogahl6bKYqAmt55kOn8k+m7W9vCuFRlet6cNYuZpHtH/TBv4/+gnEo66vgqqww+XM+
         E/mZRIMGDWr1JhLSNEnmCAJRVl2Cy2TvwmZZtnSmWagcQOBQKA4iZfdn+ut8f6vEMtr9
         tNQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677878676;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1mdoExm51Pf5mwwZ4Mi9krVz9vq+ZuMYZbUHrj+6+MY=;
        b=VBBcJFkspp10Mrz2TaFcDn3eTLg33v1f88lVWOroD/uoXYSwxGunuTrBD8W1kNHvVZ
         D+UexSZh98meDNdc1N8hQgcPMuRRfMfqBCNlzkMgJilt6SziCTrMCYJZJ87zlmQJKcPA
         zb2jDyQeu0Utj3t4euzcNELGUx6plOyRe54hLfxaKNcpbyY9bpJtjrcV1bmlXAF0DfwA
         9E2X/4SiWVxVJhlSHMxHS35foz7N8vpnxovFc78uji8AGpnGXrW+MouiDDLmEggGi2bj
         au5ZarY4vf6S4TcSmCs68j4HgfiuSslk5lT3eSrsq4+KIvNXdEpMeX3lmwl1i1AwHL6N
         oJ9A==
X-Gm-Message-State: AO0yUKUtzLUrlbHLDttepohkBfk8CPIGxcdyDXxP1+tUqRNDwq9rOaKk
        WWbBpJLJ7wxY5Is0ZAwTha2/HOvbfK0fc/KlA0Xfnw==
X-Google-Smtp-Source: AK7set+MVxx0iNuzwlpdMu16Mkge9Tq/RihIUOuYeBOSH7pw7kgWv7dpM3a776BxyD0/Qm6OkWL4oT3m673kmPWOHpU=
X-Received: by 2002:a62:cdc8:0:b0:5a8:dc92:109f with SMTP id
 o191-20020a62cdc8000000b005a8dc92109fmr1477278pfg.3.1677878676371; Fri, 03
 Mar 2023 13:24:36 -0800 (PST)
MIME-Version: 1.0
References: <20230302014639.297514-1-saravanak@google.com> <CACRpkdacG4yxtZqwG5hKRY_8nY9qWeNPb-ZttMCnFH7ojZ3kCA@mail.gmail.com>
In-Reply-To: <CACRpkdacG4yxtZqwG5hKRY_8nY9qWeNPb-ZttMCnFH7ojZ3kCA@mail.gmail.com>
From:   Saravana Kannan <saravanak@google.com>
Date:   Fri, 3 Mar 2023 13:24:00 -0800
Message-ID: <CAGETcx-W3o=rQoVLnKkvk=oTAMiwEcqAZ_trcMPBuune-7Hoiw@mail.gmail.com>
Subject: Re: [PATCH v2] clk: Mark a fwnode as initialized when using
 CLK_OF_DECLARE() macro
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        kernel-team@android.com, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Mar 2, 2023 at 5:14=E2=80=AFAM Linus Walleij <linus.walleij@linaro.=
org> wrote:
>
> On Thu, Mar 2, 2023 at 2:46 AM Saravana Kannan <saravanak@google.com> wro=
te:
>
> > We already mark fwnodes as initialized when they are registered as cloc=
k
> > providers. We do this so that fw_devlink can tell when a clock driver
> > doesn't use the driver core framework to probe/initialize its device.
> > This ensures fw_devlink doesn't block the consumers of such a clock
> > provider indefinitely.
> >
> > However, some users of CLK_OF_DECLARE() macros don't use the same node
> > that matches the macro as the node for the clock provider, but they
> > initialize the entire node. To cover these cases, also mark the nodes
> > that match the macros as initialized when the init callback function is
> > called.
> >
> > An example of this is "stericsson,u8500-clks" that's handled using
> > CLK_OF_DECLARE() and looks something like this:
> >
> > clocks {
> >         compatible =3D "stericsson,u8500-clks";
> >
> >         prcmu_clk: prcmu-clock {
> >                 #clock-cells =3D <1>;
> >         };
> >
> >         prcc_pclk: prcc-periph-clock {
> >                 #clock-cells =3D <2>;
> >         };
> >
> >         prcc_kclk: prcc-kernel-clock {
> >                 #clock-cells =3D <2>;
> >         };
> >
> >         prcc_reset: prcc-reset-controller {
> >                 #reset-cells =3D <2>;
> >         };
> >         ...
> >         ...
> > };
> >
> > This patch makes sure that "clocks" is marked as initialized so that
> > fw_devlink knows that all nodes under it have been initialized.
> >
> > If the driver creates struct devices for some of the subnodes,
> > fw_devlink is smart enough to know to wait for those devices to probe.
> > So, no special handling is required for those cases.
> >
> > Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Reported-by: Linus Walleij <linus.walleij@linaro.org>
> > Link: https://lore.kernel.org/lkml/CACRpkdamxDX6EBVjKX5=3DD3rkHp17f5pwG=
dBVhzFU90-0MHY6dQ@mail.gmail.com/
> > Fixes: 4a032827daa8 ("of: property: Simplify of_link_to_phandle()")
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
>
> Works like a charm on U8500!
> Tested-by: Linus Walleij <linus.walleij@linaro.org>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Stephen, Does this look good? Can we have Greg pull this in?

-Saravana
