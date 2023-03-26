Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EE6F6C9735
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Mar 2023 19:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231771AbjCZRfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Mar 2023 13:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbjCZRf2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Mar 2023 13:35:28 -0400
Received: from mail-il1-x12d.google.com (mail-il1-x12d.google.com [IPv6:2607:f8b0:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9822972B1
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:35:27 -0700 (PDT)
Received: by mail-il1-x12d.google.com with SMTP id n1so2788842ili.10
        for <linux-kernel@vger.kernel.org>; Sun, 26 Mar 2023 10:35:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679852127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=eZf4Q1Tx6L+B1KzWs59sfdK76WmqOF9UglHcQK60Ewo=;
        b=Jwy+JVvhRuLgLuCfY6CQw+fTLE+tY6ltHEUlD3QiASg8te6DytHym0PZmc5ig+PnbS
         NNhtOtov9yRmf9b6SDyrgNkeHybtXFzfu9D81NF6gx2xlMZQ4ai9QkZkuVQBE+Gvym+8
         3KTsHzRc9l3iUFFYm2n0qAm+wtpuht8FoTYaBDb2VqLrJxFVoJAmMYCCJeLb3+ZueR1B
         O0TjiLYi9f9t2+4L2QZslbxUm3SG9lQicIOalQb+59kYWnyMHLWTOXc5NVxpVSHCBhBR
         HVVUBWO7b4kxJganBEKL1GutJsZEoM/eO5QZjrmpp/ReXknvUhQ8eYyUwX5+8pFz2Hek
         exEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679852127;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eZf4Q1Tx6L+B1KzWs59sfdK76WmqOF9UglHcQK60Ewo=;
        b=XbsbVEG02Rzb15YI9A9GKAuxwMGjjQon4XmDXOy/k/ZZCY6UyEgwEzDkd3JW5GgYIc
         pJojmdAHHDzDO30+Ix9DWFusLcTkbeBmNapN7kjand38ydhUJIAgpwtpGqo8BreAk1hX
         AlA2BYoI7XXzOPvYuOVCF7QO6dLk3fQusBxA6zTAVmbTrjDVk6NsCMz3mJEoYU9wFJMB
         gMDKVLZtTESamHefnqDG+5y9WkOuG/qQOf+F1iJZDq6aIbnXrG0dNLNmLFydE8AVuwjB
         JwUS1csw6lU+jTfj1rkEjQWtZxXRVFlngx0nEWBwIUUH4HX7r8tTjLvQJFHN8tjKIKTP
         yL5Q==
X-Gm-Message-State: AO0yUKWsvBaYMpwk12k9uAkxpE6SskfrKcotmjJClU6VWtUmxgloaqpd
        QwRjvUN8qgr/titKBPIMy2YLFHzV7eZ9ogyUdsxbEQ==
X-Google-Smtp-Source: AK7set/g3lz+4sKnlvKOVASmqn1QDk4/tVGy0Tw94Y+J4BJKvCsWijpStJlru7XpQne4Hd5S+NkHX+NPCmrxGYn86IA=
X-Received: by 2002:a05:6e02:2207:b0:323:ecc:daf1 with SMTP id
 j7-20020a056e02220700b003230eccdaf1mr8501949ilf.2.1679852126729; Sun, 26 Mar
 2023 10:35:26 -0700 (PDT)
MIME-Version: 1.0
References: <20230325152417.5403-1-kerneljasonxing@gmail.com>
 <CANn89iJaVrObJNDC9TrnSUC3XQeo-zfmUXLVrNVcsbRDPuSNtA@mail.gmail.com>
 <CAL+tcoDVCywXXt0Whnx+o0PcULmdms0osJf0qUb0HKvVwuE6oQ@mail.gmail.com>
 <CAL+tcoCeyqMif1SDUq4MwfV0bBasgQ4LeYuQjPJYDKYLyof=Rw@mail.gmail.com> <CAL+tcoCFPKpDF+JBN1f74BxDJj9q=9ppoPntnCoT0gT6C0r=PA@mail.gmail.com>
In-Reply-To: <CAL+tcoCFPKpDF+JBN1f74BxDJj9q=9ppoPntnCoT0gT6C0r=PA@mail.gmail.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Sun, 26 Mar 2023 10:35:13 -0700
Message-ID: <CANn89iJLdce57j6fPbLpexp=tzTtw9yDwV7wjT5FbNF6fPkk+g@mail.gmail.com>
Subject: Re: [PATCH net] net: fix raising a softirq on the current cpu with
 rps enabled
To:     Jason Xing <kerneljasonxing@gmail.com>
Cc:     davem@davemloft.net, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Jason Xing <kernelxing@tencent.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-15.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,ENV_AND_HDR_SPF_MATCH,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> Forgive me. Really I need some coffee. I made a mistake. This line
> above should be:
>
> +               if (!test_bit(NAPI_STATE_SCHED, &mysd->backlog.state))
>
> But the whole thing doesn't feel right. I need a few days to dig into
> this part until Eric can help me with more of it.
>

I am still traveling, and this is weekend time :/

It should not be too hard to read net/core/dev.c and remember that not
_all_ drivers (or some core networking functions) use the NAPI model.

eg look at netif_rx() and ask yourself why your patch is buggy.

Just look at callers of enqueue_to_backlog() and ask yourself if all
of them are called from net_rx_action()

[The answer is no, just in case you wonder]

In order to add your optimization, more work is needed, like adding
new parameters so that we do not miss critical
__raise_softirq_irqoff(NET_RX_SOFTIRQ) when _needed_.

We keep going circles around softirq deficiencies, I feel you are
trying to fix a second-order 'issue'.

Real cause is elsewhere, look at recent patches from Jakub.

Thanks.
