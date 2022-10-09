Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287845F8DE4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 22:42:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiJIUl7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 16:41:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229607AbiJIUl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 16:41:57 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C8391C126
        for <linux-kernel@vger.kernel.org>; Sun,  9 Oct 2022 13:41:55 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1322fa1cf6fso10683432fac.6
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 13:41:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=tvaot2L15NY1QUpSajE/jgPmRugZzKKTWuvwSu4wnMI=;
        b=bK7HmiQjmO4dSo5b7wHYga7E610PKTFoUB3bEyEy/8+nbyN9WwPP9DeVd16OFiMjU8
         ufgzyQWLqpAjSYrnbK4kP6bQgYxG9wmcAORtTCQaKpV18LAbrL9J6kJ0lzJAyX1Svf+W
         dK1S7BadL1d2E4QpzliZr2T4WE44tC1oePd20=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=tvaot2L15NY1QUpSajE/jgPmRugZzKKTWuvwSu4wnMI=;
        b=CDx4V8XdV14FP+AEmy0kObcoNY+oS5M+My9J3k9aqNxBM2Iv3VOyeFAFWeobw5CfNz
         +SoPvB4NE2iQO6vtUvK7+RemwJyNvN2pb8+c2WSfNgoUFVJe+4b/ptx4BjC5B1a+Sc6e
         SDdlRMt5c0hYL4/FwrHNmK5dCQDu6Y/ViErxE0oFz9nrQ1nesZWDDV5c9KNtAx7x7fd3
         ZmSH+/+nvbxm6iM8WXgvKiulQ/NHMJStPIYMWEqrfxSKsCQxFQi8dTrMZuj+nRwjbGdq
         /4Wj2euYmkTPnLn6v9fOcQG3ZWTtyRw6ufPEdfBsAP1jzs8KSfe7XsOWnMCJMughXFIs
         XTFw==
X-Gm-Message-State: ACrzQf3+YDZgNTOyjjjuzXywfTGjlu7JokXP76DoSMZT1HNaJs4z539r
        Q2w49GNdRWIhHwJnguD5lu+nzlm9ydzA/Q==
X-Google-Smtp-Source: AMsMyM7+eQW+sXDymfySWy17zZrdntU0O6L6amGqY0/MmilZSrWBHV6Tc6PuvPJ50Up7eEhibSc08g==
X-Received: by 2002:a05:6870:f2a6:b0:136:8a4d:f183 with SMTP id u38-20020a056870f2a600b001368a4df183mr1245440oap.193.1665348114312;
        Sun, 09 Oct 2022 13:41:54 -0700 (PDT)
Received: from mail-oa1-f47.google.com (mail-oa1-f47.google.com. [209.85.160.47])
        by smtp.gmail.com with ESMTPSA id z3-20020a056808064300b0034fbbce2932sm3567546oih.42.2022.10.09.13.41.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Oct 2022 13:41:52 -0700 (PDT)
Received: by mail-oa1-f47.google.com with SMTP id 586e51a60fabf-12c8312131fso10699952fac.4
        for <linux-kernel@vger.kernel.org>; Sun, 09 Oct 2022 13:41:51 -0700 (PDT)
X-Received: by 2002:a05:6870:c0c9:b0:127:c4df:5b50 with SMTP id
 e9-20020a056870c0c900b00127c4df5b50mr7800531oad.126.1665348111500; Sun, 09
 Oct 2022 13:41:51 -0700 (PDT)
MIME-Version: 1.0
References: <20221003203129.GA2767725-robh@kernel.org> <CAL_JsqLR=9czyHPngjKczSxK8icw1=vBFHKgiRNz2AdvVRKC2A@mail.gmail.com>
In-Reply-To: <CAL_JsqLR=9czyHPngjKczSxK8icw1=vBFHKgiRNz2AdvVRKC2A@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 9 Oct 2022 13:41:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjNaJWvvUKTk43H-OtdP+wnM31tw8v4oz5t1TzfO4x+TQ@mail.gmail.com>
Message-ID: <CAHk-=wjNaJWvvUKTk43H-OtdP+wnM31tw8v4oz5t1TzfO4x+TQ@mail.gmail.com>
Subject: Re: [GIT PULL] Devicetree updates for v6.1
To:     Rob Herring <robh@kernel.org>
Cc:     Frank Rowand <frowand.list@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
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

On Sun, Oct 9, 2022 at 11:32 AM Rob Herring <robh@kernel.org> wrote:
>
> Linus, Did you miss this?

No, it's still in my queue.

Right now I'm doing merges (very slowly) on my laptop, while waiting
for new ECC memory DIMMs to arrive.

I have had some instability on my main desktop the last couple of
days, with random memory corruption in user space resulting in my
allmodconfig builds randomly failing with internal compiler errors
etc.

When that happens during the merge window, it's obviously a new kernel
bug causing problems, which is never a great thing.

Except this time it wasn't - it was literally a DIMM going bad in my
machine randomly after 2.5 years of it being perfectly stable. Go
figure. Verified first by booting an old kernel, and then with
memtest86+ overnight.

My new memory is "out for delivery", so hopefully I'll be back up to
full speed by this evening, but I'll probably leave memtest86+ for
another overnight with the new DIMMs just because this wasn't the
greatest experience ever. A fair amount of wasted time blaming all the
wrong things, because _obviously_ it wasn't my hardware suddenly going
bad.

              Linus

PS. And yes, my system is all set up for ECC - except I built it
during the early days of COVID when there wasn't any ECC memory
available at any sane prices. And then I never got around to fixing
it, until I had to detect errors the hard wat. I absolutely *detest*
the crazy industry politics and bad vendors that have made ECC memory
so "special".
