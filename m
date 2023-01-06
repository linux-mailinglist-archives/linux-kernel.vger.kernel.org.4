Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0E7F65FAB6
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 05:24:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231344AbjAFEYX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 23:24:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbjAFEYR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 23:24:17 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30BED193E5
        for <linux-kernel@vger.kernel.org>; Thu,  5 Jan 2023 20:23:54 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id t15so277957wro.9
        for <linux-kernel@vger.kernel.org>; Thu, 05 Jan 2023 20:23:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZMx8hqsmDH7uwUr+MaFAPSJQbUQHznQbqDI9RPeo9/w=;
        b=tY5Cei/ARcdvRIV226os/xQMBhiUFhOUbUldkBLjEH/cB3CJk3qWlxPwNoCHcRMAcb
         veRcagafhCc4Pgdsk1sxjAEvHWYZKwYBAtu739ZWTarO1zgshzNWEYxoQkWihFq+omh8
         IxhLIHUtwRUChCEZ9kzmZAY6ly3M9vVUqYtpzgBfYdAewAvqUpSL0XkGKVFEgDVlM4hJ
         DkjqzsCD0iQEy0sW283GW5xWKC7sGJMtiUE4zBwqehalS5M7o2G9RPgBc/LUmA0/TjIH
         +gRJTRqJ24IzjpLbgSzsPm174UhO1aVefLZGRh2FAUcqXAi9SxzWFkjwxEIUsErVLHOB
         4AAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZMx8hqsmDH7uwUr+MaFAPSJQbUQHznQbqDI9RPeo9/w=;
        b=KxK0C6hreBQl2IrxSrJmRYrDXRXTLI2gGDfEnzG8c2gwN4HpyltOtEILUxOiGTFc/Y
         c8eqgwdq0LrCeLyVbpWEuv+/mhQPf3AB+RQkik2Gjmhg8347zv4ei9iiI64QP8xSY/iC
         o9kE7HCxWj2i9SGJzV75Jz2jy94toBLGrmVGug6egpGK13QiFxv/olYOunMyiiIBqwT/
         5qgq4bH/1zoHSQ7ChRUzhgdXMUHii7PjAwSugEjSgo7e7otz+MRoJ7SLCmMTtPX5Vxkl
         FtPEpK82JtYOqMtJCMSaj7xlpQTw+zt3xUzETuHGBo5O3PtewtZBR8MnCN/y4mnsqBRB
         SBJw==
X-Gm-Message-State: AFqh2kpNuda+0htu4Oe47YUkdM3U4xo+jWlixzFDCBEqRTudPSAFm/K3
        6e4damqiW58PS+iEJzFs65i5pMPncAs2MRZ5DXmiaA==
X-Google-Smtp-Source: AMrXdXvrO8sE1PFjTeUZYd/6TK8WlhAjWv9cOx0c0sdQc5AhAJSoOx9JjHVY9LNUnE5jhSonK+bjaF/f7oYBCbpQDDI=
X-Received: by 2002:a5d:624f:0:b0:24c:208:ae87 with SMTP id
 m15-20020a5d624f000000b0024c0208ae87mr1250834wrv.523.1672979032832; Thu, 05
 Jan 2023 20:23:52 -0800 (PST)
MIME-Version: 1.0
References: <20230105100014.1935-1-cuiyunhui@bytedance.com>
 <20230105090807.51213cea@gandalf.local.home> <CAEEQ3wmnUpuZxLbrMwPCk+pnbC27fo4bi-nN-848o6QGO6Xt+Q@mail.gmail.com>
 <20230105230737.426abfdd@gandalf.local.home>
In-Reply-To: <20230105230737.426abfdd@gandalf.local.home>
From:   =?UTF-8?B?6L+Q6L6J5bSU?= <cuiyunhui@bytedance.com>
Date:   Fri, 6 Jan 2023 12:23:41 +0800
Message-ID: <CAEEQ3wmhAiguPm6K2=q26QRUurcoG+voJrDaDX8rd1KRf_SAgA@mail.gmail.com>
Subject: Re: [External] Re: [PATCH v2] sock: add tracepoint for send recv length
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     mhiramat@kernel.org, davem@davemloft.net, edumazet@google.com,
        kuba@kernel.org, pabeni@redhat.com, duanxiongchun@bytedance.com,
        kuniyu@amazon.com, linux-kernel@vger.kernel.org,
        linux-trace-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 12:07 PM Steven Rostedt <rostedt@goodmis.org> wrote:
>
> On Fri, 6 Jan 2023 11:24:18 +0800
> =E8=BF=90=E8=BE=89=E5=B4=94 <cuiyunhui@bytedance.com> wrote:
>
> > Regardless of whether the MSG_PEEK flag is set or not, it is possible
> > to return -errno,
> > but based on your suggestion, I plan to modify it like this:
> >
> > trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
> >                           sock->sk->sk_protocol,
> >                           !(flags & MSG_PEEK) ? ret : (ret < 0 ? ret : =
0),
> >
> > what do you think?
>
> Sure.

Ok, Thank you.

>
> But note, from your original patch:
>
> > +     trace_sock_recvmsg_length(sock->sk, sock->sk->sk_family,
> > +                               sock->sk->sk_protocol,
> > +                               (ret > 0 && !(flags & MSG_PEEK)) ?
> > +                               ret : 0,
> > +                               (ret > 0 && !(flags & MSG_PEEK)) ? 0 : =
ret,
> > +                               flags);
>
> If flags MSG_PEEK is set, you return ret in error regardless, so error
> would be ret even if it was positive.
>
> So I'm guessing that this change actually fixed a bug. ;-)
>
> -- Steve

Ha-ha, seems like it=EF=BC=8CI will modify these and post v3.

Thanks,
Yunhui
