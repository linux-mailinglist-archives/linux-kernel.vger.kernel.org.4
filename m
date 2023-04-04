Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D35A6D66AC
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:03:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233169AbjDDPDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231661AbjDDPDL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:03:11 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D04DB26A3
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:03:08 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bj20so24419644oib.3
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:03:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680620588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xvMCqRQRf/gGIv7OESh2ryqIvc636JRA//u6AB/lZ4A=;
        b=THjN01mLcxpN6nEW6PKJXdgOD1D4GaYChzH3W5H6niJWUCXWhI7RaAngZIFev3s8Gp
         oHOsZbBavP8a8/hECytyMn551H51eOcqTtRsmO89S0TzyppAHiyoHvtE2eLcRQNWQS+8
         wHitkjaufmYDX+Q7o24Oelk6ywfk9LapLfgWEhzr/FHTieviZolxgEnau83VtmiazUyf
         Zeh18rzvW87PHZy9cqMXBac7CiiFI3oYSdSEQD9WdB3PN8yQSBoFHNOLsZaDD3Y18uEO
         snrCVBXOdZKK0xBp/SHd/mpnsQ6yqCOVhlFdQLPdIyaHUpx69aLHYHC6O0Ki6XvEGkO8
         EVQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680620588;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xvMCqRQRf/gGIv7OESh2ryqIvc636JRA//u6AB/lZ4A=;
        b=rWjXFwcAfWyMgnx/GrwZfV4WPHYXMktDfl3mMl4lBkyLTd+as2CCf4pKxUQ2Y2N/1c
         mcPPzWbPFE8hkJNhQv8OvZ0lvFkfbww0xLEnTmbBI5QHlswkq9dloPzg31UbWGHAUzK3
         5O6QECB7DaBQs1CpP4BmrD2T5pYAeZlXNSkYx3IV47u8kQJWe6LI3S4X4o2ub75UWfmy
         7cVwYWV8ggffLccQBALgYIYiS8e2XziprNGJayHlYkN4U1rmsfzOF6c9qDeV1HL93t8V
         230yVld6obrU1fXQvnrsG7vKZXEcy7lUL/YXub4r+jcyI6M1OtljkckGRr13awFiYBYB
         aIIA==
X-Gm-Message-State: AAQBX9fBVSydTKy+5KJol8y+A14QQ9VrYl2K59LdqqXjA9BHPGXWsFGP
        mCfrhNYL3U9zGyT6YpwwzPAQ78R7T+02nhwya3sX/xOd
X-Google-Smtp-Source: AKy350YujKRNGsMRUoIBrj18JGfp8lOKGzmP0vrL73jovQXuRFBnIqFrFxusFkVvnVKSVyi/K382RHA1Ks4k7VxPTtw=
X-Received: by 2002:aca:120e:0:b0:387:7fe1:a5 with SMTP id 14-20020aca120e000000b003877fe100a5mr1057927ois.6.1680620588073;
 Tue, 04 Apr 2023 08:03:08 -0700 (PDT)
MIME-Version: 1.0
References: <20200424222740.16259-1-afd@ti.com> <CAL_Jsq+4mf6QHX27knoHTXA4vnsC3swuvAH7zK1DpyaV-p_qbw@mail.gmail.com>
 <f46c097a-b2a6-6368-a8a4-e30995a54d17@ti.com> <CAH9NwWeZnDEkundm98=KL6xB9bVO3nOkk48xMF-eQnztP4DD4g@mail.gmail.com>
 <99f1da4f-810e-986d-388a-af136ade745e@ti.com>
In-Reply-To: <99f1da4f-810e-986d-388a-af136ade745e@ti.com>
From:   Christian Gmeiner <christian.gmeiner@gmail.com>
Date:   Tue, 4 Apr 2023 17:02:56 +0200
Message-ID: <CAH9NwWcafkmcZd=5WN_hoJmfkwUJJrewaPnSmCK-izrC3hwKnA@mail.gmail.com>
Subject: Re: [PATCH] misc: sram: Add dma-heap-export reserved SRAM area type
To:     Andrew Davis <afd@ti.com>
Cc:     Rob Herring <robh+dt@kernel.org>, Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linaro-mm-sig@lists.linaro.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Hi Andrew
> >
> >>
> >>
> >> Okay, will split for v2.
> >>
> >>
> >
> > Was there a follow-up v2 of this patchset? AFAICT this series did not
> > make it into the mainline kernel.
> > Do you have any plans to work on it? If not I would like to help out
> > as we have a use case where we want to
> > use a dma-buf sram exporter.
> >
> >
>
> Sure, I've been keeping it alive in our evil vendor tree, but if
> there is interest upstream now I'll post a v2 and CC you.

That would be great!

-- 
greets
--
Christian Gmeiner, MSc

https://christian-gmeiner.info/privacypolicy
