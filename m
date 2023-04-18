Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7492C6E6CE4
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 21:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231646AbjDRTWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 15:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232431AbjDRTW1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 15:22:27 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCDDB1721;
        Tue, 18 Apr 2023 12:22:25 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id fw30so23188114ejc.5;
        Tue, 18 Apr 2023 12:22:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681845744; x=1684437744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MVAYFkU4mZduYsk7XhlvO4PjGSkxPXxfIXo1XXy+AEs=;
        b=VHSLJh7a0+mKe8SJNR4lwJZ0ByLipyZYp6jzwW0N879wOMzn9Tn0xL/cbZMxu+DSV5
         4ZF/OeV7jpVoTkqQNSRHhdQYDDswnLXGcgX7/vqMsTosqbF6RETV7WUjoq8M5LbsZKm+
         ChbTa16747d2uH6di9ad2XsnFy87gzxUEHQ4wDWQHbx3bssEPWh+W2LPRfY+jpnn6NXz
         rtnw62vhRqFklBkDZ6JS34otGmzZn/zJ7Rva0SWp/79WuCPEYWI7ZD9Wqv9UPwgadeoO
         Mklj2jOVUkshn1TX4W1mYOgdM6ZR0ra5MR7nkISGaJlwU7CW9YNYNtyu37tZahbdM6Ir
         gJEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681845744; x=1684437744;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=MVAYFkU4mZduYsk7XhlvO4PjGSkxPXxfIXo1XXy+AEs=;
        b=ixRnIVnGrlhWrz2kXPoznvqM6MLlZm1/ov8MQo8D/Dl8Av8s4cnoGJmeogpo7gM6NV
         PhGWCgNGS0z+kJYdnlKybhsow5bsrn9b4cClYrgBASTphVXCYLf7pqKz6K3QE2VDWnBk
         6uZo6D7CHCXWZmxtw0lVBhbfZIWBDgocRaXezGPaBkH5k3/lb86oqqrUaoYCrMVG8y0z
         Qvhb9pAfrvwARMtyiwSNBguBCjHdF5toodqAJkuXdXn18y3e/3wmFiaxs37AX43/Mlpk
         /U/yUj6UGvSI8Hj9Vf/OOvRmK58MY6L7TmoR01e5uvzzJ8WNMIP9S5PvpgrJtnfBWzsW
         x4/g==
X-Gm-Message-State: AAQBX9cV5hmfCBakEX1+Etc/c/vtkBwzmYBnbd57R8y250VfM91jIWLV
        mmSfwOA1MHGbWxLJq1+1ve9Rl23FXeaB/PM7AUFlSePHcPI=
X-Google-Smtp-Source: AKy350YAbd1xtzBLNooSy7Q7R7XUCCs+WEyWb5S82P/Ez2u3mb+sD7/nEsuSWPBB2lXyd28OFJ8kCMKGff7hYfa98LY=
X-Received: by 2002:a17:906:4a82:b0:94f:cee:56f2 with SMTP id
 x2-20020a1709064a8200b0094f0cee56f2mr11285413eju.4.1681845744201; Tue, 18 Apr
 2023 12:22:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230310144710.1543139-1-robh@kernel.org> <20230418162500.GC1764573-robh@kernel.org>
 <CABb+yY3Y8oZYG1y8zfTCC8g7=T0HQp3G3N_iECudo1gduYpy-A@mail.gmail.com> <CAL_Jsq+Oxj4ZDMyS_jOXiZEL2p=mYGr4MOGxiLen1ThRVE5cMw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+Oxj4ZDMyS_jOXiZEL2p=mYGr4MOGxiLen1ThRVE5cMw@mail.gmail.com>
From:   Jassi Brar <jassisinghbrar@gmail.com>
Date:   Tue, 18 Apr 2023 14:22:12 -0500
Message-ID: <CABb+yY2owfFY_6UucBeGfP66jBMrSBPKRBzenMHgoGm25Jw2fg@mail.gmail.com>
Subject: Re: [PATCH] mailbox: Use of_property_read_bool() for boolean properties
To:     Rob Herring <robh@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 18, 2023 at 2:06=E2=80=AFPM Rob Herring <robh@kernel.org> wrote=
:
>
> On Tue, Apr 18, 2023 at 11:36=E2=80=AFAM Jassi Brar <jassisinghbrar@gmail=
.com> wrote:
> >
> > On Tue, Apr 18, 2023 at 11:25=E2=80=AFAM Rob Herring <robh@kernel.org> =
wrote:
> > >
> > > On Fri, Mar 10, 2023 at 08:47:10AM -0600, Rob Herring wrote:
> > > > It is preferred to use typed property access functions (i.e.
> > > > of_property_read_<type> functions) rather than low-level
> > > > of_get_property/of_find_property functions for reading properties.
> > > > Convert reading boolean properties to to of_property_read_bool().
> > > >
> > > > Signed-off-by: Rob Herring <robh@kernel.org>
> > > > ---
> > > >  drivers/mailbox/hi6220-mailbox.c | 5 +----
> > > >  drivers/mailbox/omap-mailbox.c   | 3 +--
> > > >  2 files changed, 2 insertions(+), 6 deletions(-)
> > >
> > > Ping!
> > >
> > Pong :)
> >
> > I don't usually reply back that it looks good and will pick for the
> > merge window. I just do that. So yes, it is not overlooked.
>
> Okay. No reply nor applying it in over a month is not a great
> experience for submitters.
>
I sense that. I may be wrong, but I feel any form of ack from a
maintainer demotivates others from looking critically at the
submission. I have seen revisions asked after many weeks of
submission. So my idea is to let a patch roast in public glare.  Maybe
I should reply after 2-3weeks.

-j
