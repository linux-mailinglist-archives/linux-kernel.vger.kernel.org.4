Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0084E5B4313
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 01:37:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbiIIXhQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 19:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229437AbiIIXhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 19:37:14 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F662A9C0C
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 16:37:12 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id d2so5547195wrn.1
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 16:37:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=fBPq46hbTrG9wM+9Xgdxn8MYgKzYnidZfX0P256umeo=;
        b=SQ945tzLOESrAn6MCcAfpU8UvnQNZDehkgDWimKz/e0SMAZHIhYykS1WIzr5Ah0Pq3
         4iQqbCokBB5g1/WNkIksgD+dmatPfU732ow1vUr9gNNnvgc5iTagKxsOZL6yrCfhtYoP
         FOc1b9DBkjSbcEdY8ba6w5a7lLgwFQ0+s9pKU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=fBPq46hbTrG9wM+9Xgdxn8MYgKzYnidZfX0P256umeo=;
        b=ktb6itI4BiCPhldmN+fey0hRvi1Hz+BQcdASQH86FFX46Bf2DiVdVp7iYXr2dLlSdY
         lNI5v9+vVQynxK1pUzmrVeGOJfVLOreVc40DJB25EJAR3MqkTUcE8+5xg1KCeeJ8vBFy
         kEvOtXXvu5TbEiCtYQvlVqQXrHTiuhySEkbDH+wjSO+KubcRUeDY5ANWGSlxmlRYNyod
         DSSpdNGooqkZmAH2or77sL0Ik2SM8rdnEHr94+JgyvKNptiIoIj+enSgf/nLBkQqi2Rt
         tvwaRWXpnYBzB+qlkaGg2LRyiMb3/Fz/uEUefdWPPZ1MvkLqy/gNUZrKW9yCXcdC+wHQ
         zHqg==
X-Gm-Message-State: ACgBeo2cujqBG8ZloJpXcT+Kom8Cjk3gU0cZpNp3mx16HLCV0TRJm4gZ
        Mjom84zLXGSyO7JCSTOZRbV9iCOwxjQ7Awedi2abSUjazlM=
X-Google-Smtp-Source: AA6agR730qL3+cmf+ujhr0yPF2q6wjEh0qnguHFe5oEVHS+4TPUxBs921Rh+wwYMOcGiZm0mOOj1bBtrd21MMH+tQQc=
X-Received: by 2002:adf:e306:0:b0:225:618e:1711 with SMTP id
 b6-20020adfe306000000b00225618e1711mr9189511wrj.407.1662766630506; Fri, 09
 Sep 2022 16:37:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220831013359.1807905-1-jwerner@chromium.org>
 <20220831013359.1807905-5-jwerner@chromium.org> <63c350a0-2393-208b-4fab-94db050407c2@linaro.org>
 <CAODwPW-9njhmjf1jEYsm68-StqciovgXo8VFBYksrdmqDJGC7g@mail.gmail.com> <4abfb333-fd68-d752-a140-d15828be2148@linaro.org>
In-Reply-To: <4abfb333-fd68-d752-a140-d15828be2148@linaro.org>
From:   Julius Werner <jwerner@chromium.org>
Date:   Fri, 9 Sep 2022 16:36:59 -0700
Message-ID: <CAODwPW9bn65uPbY7vP4S1BDdKEaaZVJwh3NJqQWS2NFYw=1M7w@mail.gmail.com>
Subject: Re: [PATCH 4/4] dt-bindings: memory: Add jedec,lpddrX-channel binding
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Julius Werner <jwerner@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Doug Anderson <dianders@chromium.org>,
        Jian-Jia Su <jjsu@google.com>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > Well, stacking in parallel just means you have more of them? In the
> > original example, you have a single LPDDR chip with two ranks, one
> > 4Gbit rank and one 2Gbit rank. That chip is directly hooked up to the
> > LPDDR controller and that's the only chip you have, so you have 4+2 =
> > 6Gbit total memory in the system.
> >
> > In your next example, the LPDDR controller has a 64 bit wide channel,
> > but you're still using that same 6Gbit LPDDR chip that only has 32 DQ
> > pins. The only way to fill out that 64 bit channel with this kind of
> > chip is to have two of them in parallel (one connected to DQ[0:31] and
> > one connected to DQ[32:63]). So we infer from the mismatch in io-width
> > that we have two chips. Each chip still has 6Gbit of memory, so the
> > total system would have 12Gbit.
>
> Two chips so more device nodes? Since there are no DTSes with it, please
> provide an additional example in the bindings.

No, there isn't a separate node for each chip in this case. There's
still only one node (per rank), but if the io-width of the rank node
is smaller than the io-width of the channel node, that implicitly
indicates that there are in fact multiple chips of the same type wired
in parallel on that channel. I tried to explain this in the
description for the channel's io-width property.

I chose to model it this way because having separate nodes for each
chip would be redundant since all their properties have to be equal
anyway, and because it more closely resembles the way this looks to
the firmware and the DDR controller. The DDR controller doesn't
actually "see" that there are multiple separate chips and cannot
enumerate them as individual entities, because only the DQ pins are
split among the different chips -- all other pins like chip select and
column address are shorted together between all the parallel chips,
and mode register values are only returned through the lowest DQ pins
(DQ[7:0]). So it's impossible for the DDR controller to read mode
register values from the other chips, it can only read them from the
first chip and it must trust that all the other chips are the exact
same part number, because that's the only valid way to wire this (and
when the controller writes timing configuration to the mode registers,
the same value is written out to all chips at once via the shorted
column address pins).

My example does contain this case already, in lpddr-channel0, rank@0:
there's only one rank node with density 8Gbits, but since that node
has io-width 16 and the channel has io-width 32, it is implied that
there are actually two single-rank chips wired in parallel on this
channel, and since each of them have 8Gbits of memory the channel has
16Gbits in total.
