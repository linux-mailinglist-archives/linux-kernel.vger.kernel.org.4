Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65BC265CA4D
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:28:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234063AbjACX2D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:28:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbjACX2B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:28:01 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E9CB1007F
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:28:00 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-47fc4e98550so314888627b3.13
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:28:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L8l9QQnnx7pQWx8WivUZKbIX8ABABPh7UytyXM59oII=;
        b=HOfuuQJqksmRSu3EpPqLC6xDLLLVQdTihgvOvbvivCKtODqrx4jD6THiCNjc/3wMPx
         fyucRLzMc/O5q5bIBn0jBP5HFD9NarzHovHdfw3x5jT5bIeXsK24cKRv/rhKH9So+Hw+
         gjCkk2/mgVhXlZEJ5A7nEZD+MzDSOZZ1OIHAY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L8l9QQnnx7pQWx8WivUZKbIX8ABABPh7UytyXM59oII=;
        b=zJ0eqhdnXQU0wmyvxlxNLbjC4ePd8GUOz9dexx3dKK50SvZ3mwFPvKVyRLYEpiO1RP
         X1iaVvGbL1kRz+hL6dSwYOGagO07ZFyBTMQUrDTyjcJ7C7v62YLKhCxlVDtN2AEIn31o
         WLzAPYx2xqzH6r/fpgfvWCQR795CMweK8zf8YL2pNtlQFR9FCeai5KRCQisO6tyr/FEm
         Eq/XmoCJrvAqiygRjf7D7n5uyM8PNJSz3yMYTYGvLZ7BxGM6JKG/h83Wn11l/LWq6591
         esAAg3Bu+b5+7bIbS2qO8hBypMGaGqNy0r1Var013nVH/75m/8TWQV0stgAVOBR4ej1G
         zIIQ==
X-Gm-Message-State: AFqh2koSWCxPSf9jUHneQT4jjdu+O2t+3C4wsokT7kjamNTfJEqZd2/s
        WMCPowphbOSgMLgHlASseIsmjTrv0v8W2arZsrbbcQ==
X-Google-Smtp-Source: AMrXdXs7CO9UoGvmqSlN1Oc57sVUqBz0Y+Bqcr+xyEbJFqNg8gHRYBydcqrnb/KlfGZI8R1k5DBypNWgu+R+wAjv/AQ=
X-Received: by 2002:a81:c30e:0:b0:4b2:72:d8ee with SMTP id r14-20020a81c30e000000b004b20072d8eemr412253ywk.272.1672788479482;
 Tue, 03 Jan 2023 15:27:59 -0800 (PST)
MIME-Version: 1.0
References: <20221221185540.2265771-1-robbarnes@google.com>
 <CACeCKafZu=46NE--r9W-wtJWAhj8=s46yCBO4N4u5nt4COqYAQ@mail.gmail.com>
 <CA+Dqm30XF=wDVcdUabbHySp-fwf+zFNqXpdYDW3bDTOwRbkiZw@mail.gmail.com>
 <CACeCKafGg5=1MQQdCtXDm-3LE2VsixHPsUDngRwQXUvAwQ=u=Q@mail.gmail.com> <CA+Dqm33CAjWv=DFhp0+iee2-EugJzjWOYcyfieaULq2H9egheA@mail.gmail.com>
In-Reply-To: <CA+Dqm33CAjWv=DFhp0+iee2-EugJzjWOYcyfieaULq2H9egheA@mail.gmail.com>
From:   Prashant Malani <pmalani@chromium.org>
Date:   Tue, 3 Jan 2023 15:27:48 -0800
Message-ID: <CACeCKad+cdVLi8Qq1R2j+jkRkyF6Mktu_64oq4Ewi0TWXSKJ-g@mail.gmail.com>
Subject: Re: [PATCH] drivers/cros_ec: Handle CrOS EC panics
To:     Rob Barnes <robbarnes@google.com>
Cc:     Guenter Roeck <groeck@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        dtor@chromium.org, Benson Leung <bleung@chromium.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 3, 2023 at 3:15 PM Rob Barnes <robbarnes@google.com> wrote:
>
> On Wed, Dec 21, 2022 at 5:38 PM Prashant Malani <pmalani@chromium.org> wr=
ote:
> >
> > On Wed, Dec 21, 2022 at 3:55 PM Rob Barnes <robbarnes@google.com> wrote=
:
> > >
> > > On Wed, Dec 21, 2022 at 12:23 PM Prashant Malani <pmalani@chromium.or=
g> wrote:
> > > >
>
> >
> > It's just I find having a notifier for a single use case overkill(even
> > 2 would be fine); one could get away with exposing a method
> > in cros_typec_debugfs via a local .h file (it can compile to a stub if
> > cros_typec_debugfs is not compiled to the kernel);
> > the LPC code can then just call that method instead of invoking a notif=
ier.
>
> My first implementation did make a direct call to cros_ec_debugfs.c,
> but an internal reviewer recommended using an event notifier instead.
> So I'm histent to go back to a direct call.
>
> There may be other sub drivers that want to handle EC panics. So I
> think keeping this as a separate notifier makes sense given the
> constraints.

The issue with that reasoning vis-=C3=A0-vis your implementation is that
the panic notifier is tied to cros_ec_debugfs. What if another
(sub)-driver wants to use the
panic notifier to do something, but that system doesn't have CONFIG_DEBUGFS
enabled?

Having a direct/explicit dependency avoids that issue; LPC depends on
debugfs being compiled
to have the log printed out (a stub is used when debugfs is not
enabled), but nothing else
relies on debugfs for a panic notifier.

BR,

-Prashant
