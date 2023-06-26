Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A70B973E660
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 19:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbjFZRZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 13:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjFZRYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 13:24:46 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21789B5;
        Mon, 26 Jun 2023 10:24:45 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id a1e0cc1a2514c-7943105effbso605494241.1;
        Mon, 26 Jun 2023 10:24:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687800284; x=1690392284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dujPk+6duNP2d1uQS/BC+afoRfdG4+lHXiKhSULvjm4=;
        b=qULknWVGqlfHHFE6RKEofS3iqzTgUK1xS362rivCouyzRDp0EpzPCCTp5qra30NsHh
         R2DfV0fErw+8uM8c0M4MvgGCHTcj4UP4gm5WgJPJSio442Gui8KSfpSwydB7oRK1Bvzo
         ybH1gQjnamNO3685GnrDaDfds3R50w6y7sCAzj/+q/+yt5KyHhCW2If9hc91DKd4mfl/
         TezrTiSKAJVGN+Th9660Qlin5VaYyNvOVyDxlakamCPiSealD0oSxgBkWJg2JltyzcvO
         Ga0V4gAFh0MJuNahgW8IqmB+XuGvkqLEjtiMQOY1Wee1S314kWPFOaRFdlVRXrQGXbDp
         I74g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687800284; x=1690392284;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dujPk+6duNP2d1uQS/BC+afoRfdG4+lHXiKhSULvjm4=;
        b=jnkdTuGy83O1fSAU1G+YEx8LqYe9G687XMYGdaiqAC7PQSOkLb9QZU3jtcyaIp/XG/
         nUfB8Q/2PV8z0KGX4sqkeU6UBlDhMqAQTBdJkDW853TlL2Qe2qMFJ7y6FpM9hhLJk6f+
         +izclWNDsAcalf7lQ1tAFy12GdoZ5RexW5p+hoNwyMbHBEYghSs4LVyvG5ZDEZn4SNDZ
         w1aOOMcm0BeKAQJ9Uv75JjIjQZcn0UxeZkHm/mnY4/kwszXKhFubqGg8g5hi/LP7xlxZ
         bAC9poNWFbuUoFUyjaH+tBb6nrP5AHr5LdO0v2ewz5NM3pYa7/+lG1lwipWDYQkQln95
         4BCA==
X-Gm-Message-State: AC+VfDwrg/c+NXXCzuy5kkRwy7+/Zzs/2AlVxqLPRhwxHM5Poe3cdlNa
        FEB2+OiYVYmSRn4/YgrlZkjJoCmlM2b+HOoBgOU=
X-Google-Smtp-Source: ACHHUZ4CguV7XgsKSOUJIQqgdZwYCRCvfxWYx7/7i2VzgRfv4+5VoGDlRRxb8amVE4sJFFWZFXdjJHQGzOm9h5BErfY=
X-Received: by 2002:a05:6102:458f:b0:440:a8a6:333e with SMTP id
 dx15-20020a056102458f00b00440a8a6333emr7201338vsb.9.1687800284081; Mon, 26
 Jun 2023 10:24:44 -0700 (PDT)
MIME-Version: 1.0
References: <CAA85sZukiFq4A+b9+en_G85eVDNXMQsnGc4o-4NZ9SfWKqaULA@mail.gmail.com>
 <CAA85sZvm1dL3oGO85k4R+TaqBiJsggUTpZmGpH1+dqdC+U_s1w@mail.gmail.com>
 <e7e49ed5-09e2-da48-002d-c7eccc9f9451@intel.com> <CAA85sZtyM+X_oHcpOBNSgF=kmB6k32bpB8FCJN5cVE14YCba+A@mail.gmail.com>
 <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
In-Reply-To: <22aad588-47d6-6441-45b2-0e685ed84c8d@intel.com>
From:   Ian Kumlien <ian.kumlien@gmail.com>
Date:   Mon, 26 Jun 2023 19:24:32 +0200
Message-ID: <CAA85sZti1=ET=Tc3MoqCX0FqthHLf6MSxGNAhJUNiMms1TfoKA@mail.gmail.com>
Subject: Re: [Intel-wired-lan] bug with rx-udp-gro-forwarding offloading?
To:     Alexander Lobakin <aleksander.lobakin@intel.com>
Cc:     intel-wired-lan <intel-wired-lan@lists.osuosl.org>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
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

On Mon, Jun 26, 2023 at 7:15=E2=80=AFPM Alexander Lobakin
<aleksander.lobakin@intel.com> wrote:
>
> From: Ian Kumlien <ian.kumlien@gmail.com>
> Date: Mon, 26 Jun 2023 16:25:24 +0200
>
> > On Mon, Jun 26, 2023 at 4:18=E2=80=AFPM Alexander Lobakin
> > <aleksander.lobakin@intel.com> wrote:
> >>
> >> From: Ian Kumlien <ian.kumlien@gmail.com>
> >> Date: Sun, 25 Jun 2023 12:59:54 +0200
> >>
> >>> It could actually be that it's related to: rx-gro-list but
> >>> rx-udp-gro-forwarding makes it trigger quicker...  I have yet to
> >>> trigger it on igb
> >>
> >> Hi, the rx-udp-gro-forwarding author here.
> >>
> >> (good thing this appeared on IWL, which I read time to time, but pleas=
e
> >>  Cc netdev next time)
> >> (thus +Cc Jakub, Eric, and netdev)
> >
> > Well, two things, it seems like rx-udp-gro-forwarding accelerates it
> > but the issue is actually in: rx-gro-list
>
> Do you enable them simultaneously? I remember, when I was adding
> gro-fwd, it was working (and working good) as follows:
>
> 1. gro-fwd on, gro-list off: gro-fwd
> 2. gro-fwd off, gro-list on: gro-list
> 3. gro-fwd on, gro-list on: gro-list
>
> Note that their receive paths are independent[0]: skb_gro_receive_list()
> vs skb_gro_receive(), thus I'm still not really sure how gro-fwd can
> trigger gro-list's bug.

Neither am I... I have enabled sol via ipmitool now, will try to get a
better capture

> > And since i've only been able to trigger it in ixgbe i thought it
> > might be a driver issue =3D)
>
> Your screenshot says "__udp_gso_segment", which means that the
> problematic UDP GRO packet hits the Tx path. Rx is in general
> driver-independent. Tx has separate netdev feature ("tx-gso-list"), but
> it's not supported by any driver, just software stack. It might be that
> your traffic goes through a bridge or tunnel or anything else that
> triggers GSO and software segmentation then booms for some reason.
> BTW, __udp_gso_segment() is one-liner when the passed skb was
> gro-listed[1], so having it in the bug splat could mean the skb didn't
> take that route. But hard to say with no full stacktrace.

I do have a UDP tunnel, in wireguard, will disable it.

Beyond that some bridges and veth interfaces, but lets wait for a full trac=
e

> [...]
>
> >>>> But correlating that with the source is beyond me, it could be gener=
ic
> >>>> but i thought i'd send it you first since it's part of the redhat
> >>>> guide to speeding up udp traffic
> >> [0]
> >> https://lore.kernel.org/netdev/f83d79d6-f8d7-a229-941a-7d7427975160@nv=
idia.com
> >>
> >> Thanks,
> >> Olek
>
> [0]
> https://elixir.bootlin.com/linux/latest/source/net/ipv4/udp_offload.c#L51=
8
> [1]
> https://elixir.bootlin.com/linux/latest/source/net/ipv4/udp_offload.c#L27=
7
>
> Thanks,
> Olek
