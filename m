Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54BEF5F59F6
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 20:39:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231952AbiJESjv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 14:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231904AbiJESjZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 14:39:25 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0B9580F5A
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 11:38:53 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id d64so18565253oia.9
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=uWGfOQNoiUR5+ft56H+DZe0QVsHI27BeyjlrNzwymwA=;
        b=b/2ws6naoA1zK5Fni/IVTuECUTXhcVShJRsUWlc+utLejWBsJw6drZ34b3LMOQG56V
         0jLCzKHgreodGZ1ODUAIfUVwSFNuEppcozm8XReuA3qXDCdx5Ve0bmNJbZyFEOETdhN/
         SXjfLlbNmEPscfdR5L1sz+Yog5/KhDqKzDYwo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uWGfOQNoiUR5+ft56H+DZe0QVsHI27BeyjlrNzwymwA=;
        b=pQJGK+pfeJR/VH+//GayirWprVm52CQ6gjLPZzDQ1qI8gRUtxFQiypMmQ/XzFVtv+7
         2IcYqfC2/FAGCcEC9enAJTCvCQm6Sp6N4QVzTeIF1SbeZLLZdItgvr2merFjwiEM9U9d
         ph0m/OtLJ67cr8tawdmph2CpbJNC/AxaSIR6Qm1GfjWtcTnQKvsiEdoRM3hIl9GfXGz9
         3PUaQVxjosIaSMrPpzNaCp5CxdAdWImIjv/Bd1M7JBL7YJ2L6SlaaIozG+grwdBIxvj+
         cDlWnNd9nNTPZI9EbL4nuM3wMuT/ISFPi0E48HbsfyBPCi1/dW1MrWKFxk5UY+bIVmq9
         +TXg==
X-Gm-Message-State: ACrzQf06iPxP79zMTlptLZbEMUCpV/TvMnqVNbcmf+/mUaCu58yjLz/N
        gOsy33GpbyjQ3CCIhFn5X+iTHmfnEfsqrw==
X-Google-Smtp-Source: AMsMyM79tnZwn+Fdn9UIzXHxmQe37nHljE9LMuzX8oeZS2y/wpTV6qDum3MU6uC+mBK2sADaXnVkmQ==
X-Received: by 2002:a05:6808:1648:b0:347:b631:cc80 with SMTP id az8-20020a056808164800b00347b631cc80mr576009oib.238.1664995132481;
        Wed, 05 Oct 2022 11:38:52 -0700 (PDT)
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com. [209.85.167.178])
        by smtp.gmail.com with ESMTPSA id y12-20020a056870428c00b0013191b00f72sm5471057oah.17.2022.10.05.11.38.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 11:38:51 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id n83so18555356oif.11
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 11:38:51 -0700 (PDT)
X-Received: by 2002:a05:6808:2012:b0:34f:ca73:ee55 with SMTP id
 q18-20020a056808201200b0034fca73ee55mr591338oiw.229.1664995131487; Wed, 05
 Oct 2022 11:38:51 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
In-Reply-To: <CAPM=9tzs4n8dDQ_XVVPS_5jrBgsNkhDQvf-B_XmUg+EG_M2i4Q@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 5 Oct 2022 11:38:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgJmLVs7MYd=uF4+b32Fwmvgc0MLr4TEUSBEPf5U6=W5g@mail.gmail.com>
Message-ID: <CAHk-=wgJmLVs7MYd=uF4+b32Fwmvgc0MLr4TEUSBEPf5U6=W5g@mail.gmail.com>
Subject: Re: [git pull] drm for 6.1-rc1
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 4, 2022 at 8:42 PM Dave Airlie <airlied@gmail.com> wrote:
>
> This is very conflict heavy, mostly the correct answer is picking
> the version from drm-next.

Ugh, yes, that was a bit annoying.

I get the same end result as you did, but I do wonder if the drm
people should try to keep some kind of separate "fixes" branches for
things that go both into the development tree and then get sent to me
for fixes pulls?

Hopefully this "lots of pointless noise" was a one-off, but it might
be due to how you guys work..

                      Linus
