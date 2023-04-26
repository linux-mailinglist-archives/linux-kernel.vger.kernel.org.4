Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4CDD6EF844
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 18:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239597AbjDZQTB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 12:19:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239749AbjDZQSy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 12:18:54 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8149BEA;
        Wed, 26 Apr 2023 09:18:47 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b8f557b241fso5698412276.0;
        Wed, 26 Apr 2023 09:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682525926; x=1685117926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wSh9sgIRcl+VyffTOcjg6rBcF1wwJvh9yVaf8FbL/QU=;
        b=jlRIL2PONUJqNfyCIn/+R0cgo2l/he5gu/7d3S4i1FYjx5B+X51Ufj9ibWNX+xu3dl
         6pGnaxNVsbHq6R/Dv1vK4BadPlP7PfaAjzMjOQuEo21fPm2dIZHpoGwY3iAVgq0jLsd4
         7JaEjR1YHiohJXEKP13zOV7qjaBEp0EuHCljPfAz7BbDh0bsFFExFeO7xWQPYbMZrlcM
         /M0PGr1Dwh0e/EErzd3izCvPLe9VIWkdrlgCaRC/+6750kvc17QXi0j6s0UzBD/hWtaf
         8i6UvK9EVLPemv5gkI+7DbZY7X/BWJFkYYa3wDXrRpd6M84tDynUEjXU1/6WsY8XkFO3
         z7BA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682525926; x=1685117926;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wSh9sgIRcl+VyffTOcjg6rBcF1wwJvh9yVaf8FbL/QU=;
        b=Acp2WL2URL1ncZuMYcnOWIfN+jDm1iUrNvcJYFApZjLwtLfOtDRM8M7mUNBAa6CfvB
         8L6IQMgx7U4eRp3CgYO55s+KFTIN8DPo+qmpEbE2VEMrJsDSeiTnPRQYH+O8EZs2ywAG
         IO44717h8SKU3KEsmQIgnr41gcub15UI28vyCj1r25u3IBOZqIr/tI5U1UPENXYWkIx9
         XwsjoiYM6yS8lP/kukqwOq6MJUSFrxJKMLBA4uaSO2eiaOfpVPCWsvXIEvxYedhyXaKA
         URlEVzkSAtn2I4Qre+TDJRd7z7N0dMMow8pJx3WMiTKVIxlPEk4fwO6GPowbt/4OnDZz
         qOsA==
X-Gm-Message-State: AAQBX9eIjwTS+heW6ep4vhTJqp3DJmWWZs2vcJHeUJsctQPxpSX43Er6
        eLVRrrb+aacmk9D8hbeDJp6uwmy9fNtU/YlRriU=
X-Google-Smtp-Source: AKy350aTRGtpV10EC+AaG5mU6fHFJVobalSpMqKbLpWFHqBKoMkmRVJT/7cNdLLrBXcSryh8h6uMNiRupjyBKVB6iVg=
X-Received: by 2002:a25:502:0:b0:b92:4a11:e4e1 with SMTP id
 2-20020a250502000000b00b924a11e4e1mr13517692ybf.25.1682525926680; Wed, 26 Apr
 2023 09:18:46 -0700 (PDT)
MIME-Version: 1.0
References: <20230406215615.122099-1-daniel.almeida@collabora.com>
 <136035a4-26df-1c14-e51e-406b4ee5fe33@xs4all.nl> <CANiq72kzgopREcNcAnjCBk2u9b9cJ4f_jPix6LWYSkcOV5kubw@mail.gmail.com>
 <20230426003210.GA31260@pendragon.ideasonboard.com>
In-Reply-To: <20230426003210.GA31260@pendragon.ideasonboard.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 26 Apr 2023 18:18:35 +0200
Message-ID: <CANiq72nLtpOn2HcOneoQ6v_TcYAEj_W8z2HCQvF4HmB4+OoSZA@mail.gmail.com>
Subject: Re: [PATCH 0/6] Initial Rust V4L2 support
To:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>,
        Daniel Almeida <daniel.almeida@collabora.com>,
        wedsonaf@gmail.com, ojeda@kernel.org, mchehab@kernel.org,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-media@vger.kernel.org, kernel@collabora.com
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

On Wed, Apr 26, 2023 at 2:32=E2=80=AFAM Laurent Pinchart
<laurent.pinchart@ideasonboard.com> wrote:
>
> Now, I hope that mentioning "lifetime management problems" will be
> enough to nerd-snipe a rust enthusiast or two to help fix the C code in
> order to implement proper rust bindings on top ;-)

Good idea ;)

I think it is definitely a good opportunity to consider how Rust could
fit the new design, and perhaps borrow some ideas from Rust for the
new design, even. If you feel like a quick meeting could help on that,
please let us know.

> That would certainly be a required step, but I don't think it would be
> enough. On good days I see the media subsystem as barely able to cope
> with the current load, on bad days it feels it's completely collapsing.
>
> We have homework to do when it comes to maintenance for the media
> subsystem, we're doing *really* badly at the moment regarding community
> management and attracting (and retaining) new core contributors. This is
> a topic I really want to discuss face to face during the media workshop
> in Prague (and I know that many people are looking forward to that
> discussion).

I am sorry to hear that. One idea would be offsetting the extra work
by having the Rust person also take care of some of the C parts too.
That way you can also potentially get them to be a full maintainer at
some point, even if the Rust experiment does not pan out.

Of course, easier said than done, and managing more people always
takes extra time, but getting more people seems to be part of the
solution anyway, from what you say.

In any case, thanks a lot for at least considering it :)

Cheers,
Miguel
