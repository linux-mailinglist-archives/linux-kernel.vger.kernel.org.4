Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D51376FEB62
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236538AbjEKFsg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:48:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEKFse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:48:34 -0400
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69BF02726
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:48:33 -0700 (PDT)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-55d2e87048cso121187777b3.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:48:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google; t=1683784112; x=1686376112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEsW6ADQiyg8bgT+PjLa2gxrYjuabhXtDe3R3pceTJI=;
        b=WYZvFHSsRWZ6DhNBRi4/coBWURsX5dKxk6DutKlHzPFfCwoxXLv9gTFgvCvpEcGDNt
         /H937a3COi3QwCP54p9wfk/PZMSk3F+FI0G/JwUl1HI90H7vIaHt714KLOegn2o47NZu
         TKaaW0C2NSlVPj+6xxnnGRsYts2AzSOAVaW7I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683784112; x=1686376112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEsW6ADQiyg8bgT+PjLa2gxrYjuabhXtDe3R3pceTJI=;
        b=Y6KGibgXYxGG9O3GGn+8qy9HupgKWDGseMzTv6B+O+ExcEmiAXOo97jW+QwGQg6UIr
         a9DoNbw5FrSgTN+IBQWKXxxTrlLEK3Q7qr5cTU30jyFLCm+i98b1ou8Bw4jwzxbl27+D
         W/lLXWHqpx82HetXGdWiHWe7vo9H8GxpaPKnMtj7gU+WGPqHuDHoXqrQYXzpHH+6Lu63
         rg+fTYVHhcxpD0hwFkYWSb/NIyXEArq8BFs+hfb+xbhJHsLgU338y87kFTK28TlGTsBb
         EOrmD5KlbzSEGazEcha7PosRG2uE1BEdOxtBUe7Ky07+tWDnJOBHnyhxmd4N1L7Vc2H8
         9RXw==
X-Gm-Message-State: AC+VfDwxG2U0hOSUShQturBjRb4/aqBfISPFqqe2rbVrcWqeekvdHTut
        O0Vbl6vbja0WTAlJGzckExrYUjf15rYTDr9GoFEt5g==
X-Google-Smtp-Source: ACHHUZ4Xspohc10WjXI/ZLcJktrJMzqRKsksA6kipW1qIT4R6dm9RJyuI17RWW6RV0fawVxqfYdgRswhQGFGZ1C0uus=
X-Received: by 2002:a81:5e41:0:b0:55a:985f:848d with SMTP id
 s62-20020a815e41000000b0055a985f848dmr24178916ywb.39.1683784112614; Wed, 10
 May 2023 22:48:32 -0700 (PDT)
MIME-Version: 1.0
References: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
In-Reply-To: <7ffd4a5d-61e9-4b4c-a312-a85bcde08c39@paulmck-laptop>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Wed, 10 May 2023 22:48:21 -0700
Message-ID: <CAEXW_YTuDQPqsVYz8X-rCau1RSpUR9HBSmq+H8imHB0424Do6A@mail.gmail.com>
Subject: Re: [PATCH rcu 0/6] Torture-test updates for v6.5
To:     paulmck@kernel.org
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-team@meta.com, rostedt@goodmis.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 10:12=E2=80=AFAM Paul E. McKenney <paulmck@kernel.o=
rg> wrote:
>
> Hello!
>
> This series contains torture-test and torture-test-scripting updates
> for v6.5:
>
> 1.      Add long_hold to adjust lock-hold delays.
>
> 2.      Correct name of use_softirq module parameter.
>
> 3.      rcu/rcuscale: Move rcu_scale_*() after kfree_scale_cleanup(),
>         courtesy of Qiuxu Zhuo.
>
> 4.      rcu/rcuscale: Stop kfree_scale_thread thread(s) after unloading
>         rcuscale, courtesy of Qiuxu Zhuo.
>
> 5.      doc/rcutorture: Add description of rcutorture.stall_cpu_block,
>         courtesy of Zqiang.
>
> 6.      Remove duplicated argument -enable-kvm for ppc64, courtesy of
>         Zhouyi Zhou.

Other than the small nits I mentioned, this series LGTM. Feel free to add:

Reviewed-by: Joel Fernandes (Google) <joel@joelfernandes.org>

 - Joel


>
>                                                 Thanx, Paul
>
> ------------------------------------------------------------------------
>
>  b/Documentation/admin-guide/kernel-parameters.txt                  |   1=
2
>  b/kernel/locking/locktorture.c                                     |   5=
1 +-
>  b/kernel/rcu/rcuscale.c                                            |  19=
4 +++++-----
>  b/tools/testing/selftests/rcutorture/bin/functions.sh              |    =
2
>  b/tools/testing/selftests/rcutorture/configs/rcu/BUSTED-BOOST.boot |    =
2
>  b/tools/testing/selftests/rcutorture/configs/rcu/TREE03.boot       |    =
2
>  kernel/rcu/rcuscale.c                                              |    =
5
>  7 files changed, 137 insertions(+), 131 deletions(-)
