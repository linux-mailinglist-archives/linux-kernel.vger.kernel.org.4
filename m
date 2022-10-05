Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 868425F5B43
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 22:56:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbiJEU41 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 16:56:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbiJEU4X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 16:56:23 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9298A7757D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 13:56:22 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a26so350564ejc.4
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 13:56:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zfpsNBbNVPzFpz+lF6+ppNQCYSIyAPrPwcUGS4C/qTM=;
        b=Mf5nuCylf6oEdgUt9A74oPuzITr0D9YIrAijaWEUBhdHOQdttCTl3kdPf9/gN34UMB
         f4Jw9sNgDqmkiYuAhKBRAUfRw7ovit1aoS6tSbYi/u3KEansVUfvs4aXg9XfyDiDciY+
         CcUFjq2W3UizHMc58TANb7W4Q0Wb/p7HErqSAACaWlBUQ323wnoYvOybrWNFnYc3CfsR
         SKoIwLYQpn7qVcryF0xDwkM8AEop/LvohQRx3Du26pCKcUWLzjG4dvwxqBOuctYVUKVP
         KdzkDEsE8vBW5zwYaMkxXYlgQ0PPW03+8qad68O2P6wl9o0H6C3Xr/+w834WkeITicHM
         KxUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zfpsNBbNVPzFpz+lF6+ppNQCYSIyAPrPwcUGS4C/qTM=;
        b=J4NSZAEy+fFHGWFtWIiY3hZF9CsU/pZChaMm0GP4uhCU+9UZmjca8AsS9EZrcAd3g/
         nD1YOYYE0h+y1ZtV7MvS0lvOPqt38GvbdBPlk75WP6qGV3J9gL2GzyqgGzlBDR5l8Wgj
         xdZa+SDJleamZNwGKDEIMP4uoc4kmBmkggTSfXooWJziwrrn3TR2V2anInlHSqop2J0q
         AC+G07ER64pPGTPmGGl4mNkMQC9sV/LvCokb7LwVGx9sa0duxKOWBDW8YeN7LWYPu/7z
         SRDgCQDUwSvHO+dEryiradiJ/4/slQT18p4MWxOwdxwl5UKey7Wb3SuCbWQ+g9ppxO98
         QPSw==
X-Gm-Message-State: ACrzQf0VfugNte0+fjgUIsyqbz3hZtm+A/oMPzOgQ07bopOb00yDXZSY
        QASt/5h84oQDpaC21A/fk8Z1cl61I2V6Wtktx2noYZYs
X-Google-Smtp-Source: AMsMyM7arMg3njnjE8r31COnUuj7GFoDNNv8j63P6WC0F1Sdxn2Pw7vfjj13LeCE8eIzls9P4+NNy7g/B19QBlnm4cs=
X-Received: by 2002:a17:906:9756:b0:78b:8c9b:3b1d with SMTP id
 o22-20020a170906975600b0078b8c9b3b1dmr1181520ejy.256.1665003380999; Wed, 05
 Oct 2022 13:56:20 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
 <CAHk-=wgJmLVs7MYd=uF4+b32Fwmvgc0MLr4TEUSBEPf5U6=W5g@mail.gmail.com>
In-Reply-To: <CAHk-=wgJmLVs7MYd=uF4+b32Fwmvgc0MLr4TEUSBEPf5U6=W5g@mail.gmail.com>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 6 Oct 2022 06:56:08 +1000
Message-ID: <CAPM=9tx+qa5aucS7Sa4Lg4SAD7PamCYsPwSupgd1xix1Y9HEkg@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 6 Oct 2022 at 04:38, Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Tue, Oct 4, 2022 at 8:42 PM Dave Airlie <airlied@gmail.com> wrote:
> >
> > This is very conflict heavy, mostly the correct answer is picking
> > the version from drm-next.
>
> Ugh, yes, that was a bit annoying.
>
> I get the same end result as you did, but I do wonder if the drm
> people should try to keep some kind of separate "fixes" branches for
> things that go both into the development tree and then get sent to me
> for fixes pulls?
>
> Hopefully this "lots of pointless noise" was a one-off, but it might
> be due to how you guys work..

In this case I think it was a late set of fixes backported for new AMD
hardware, that had to be redone to fit into the current kernel that
caused most of it. I haven't seen it this bad in a long while. We also
maintain a rerere tree ourselves to avoid continuously seeing it.

The problem is a lot of developers don't have the insight that the
maintainers do into the current state of the tree/pipeline.

Stuff goes into next because that is where the patch it fixes
originally went, and it goes through CI there. Then at some point
someone else realises the change needs to be in fixes and it gets
backported.

The volume of patches and company signoff processes doesn't make it
trivial to upfront decide what needs to go in -next or -fixes
unfortunately.

Dave.
