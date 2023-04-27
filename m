Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E5A6F0272
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 10:20:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243042AbjD0IT6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 04:19:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243077AbjD0ITx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 04:19:53 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FABE3A9A;
        Thu, 27 Apr 2023 01:19:52 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id ffacd0b85a97d-2fa36231b1cso5048438f8f.2;
        Thu, 27 Apr 2023 01:19:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682583591; x=1685175591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=gzFxCmCViEMHXU5pJcqB4vl+bQBH8MRNorgL7voOk4s=;
        b=LWvz2ZPnfvG2hf+HjF8rsGqkWnAStW32Cgrx9nJgmk+Ur3BQBcsBcHS0t3XIGc0n4a
         OdBdVB08Y9NS8yXu82+FqsIfptZceNRaQ2bsBl83aNJVqxN6EAx6ucZGdzJdvm/qiaSR
         eQ/OLKYc8j3RoiBEf73MG1LzUGD6yqHRFDrcZAvzlYh2VEKQExB3pW4UJ+QPcEef4eT3
         8KAc7d+kLG7LI/2VV1fUubxLaceVm1HNdL9xXxR0e2LJ7aEixMOJNtfbaPL8xmBrw4bv
         rldWwA+HFyIIFW/WyT1fCK8fY8igQ9IfANwxGDgqTp2eZlkR+CXuBFw+LeWtGuzztiOR
         ol3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682583591; x=1685175591;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=gzFxCmCViEMHXU5pJcqB4vl+bQBH8MRNorgL7voOk4s=;
        b=gFpjMzs2QOjadocMfpEnKYyRp4LvwdcsA58PWFOVc0S3WQkT/Ekb8Yc+b9SIQATWtt
         RFbYS8cURUax8uAQA2UeSa+uMUY3jOYQuP1ZZw8Jw7ckcIOxFqgvKBF0jPBBYYOck0ta
         J/n84Cqxtx5hxAQzOrbHNWAMsSnDdX7Hii8QfF+OTh5v2YCSg6XAbKlZ8B5DeA/kCde/
         uLSuIEsEvotNuc60PFfMAHXtZDzQ7nivB3XDPumB2Kmap2oYn6bIfvhcm67acnJ739DP
         lmxcsoZZrHR6b9vBcm6E2gX1UDLY0cG4t3q7D/GM0EDGXUj7gYcc+CV+4eYBEHyqB9EU
         EEZg==
X-Gm-Message-State: AC+VfDxc3QdsHc07DmCcmD56yI64Okw135fkPf5pUnT+DWkG3iPqWvsa
        NsKljRWklQqOrjp2eEzTwas2JOguHzd2EU8uaw==
X-Google-Smtp-Source: ACHHUZ4oLyd8EpikyeMDBjp/0mXOBX8YzZrSOILK/qEv30qbv0kjhzl8WY2s3xULUcVM5j5atJvCMPFRNljPp3w9DT0=
X-Received: by 2002:adf:da47:0:b0:2f4:4e1a:bea2 with SMTP id
 r7-20020adfda47000000b002f44e1abea2mr583218wrl.59.1682583590838; Thu, 27 Apr
 2023 01:19:50 -0700 (PDT)
MIME-Version: 1.0
References: <20230425130054.591007-1-tomas.mudrunka@gmail.com>
 <ZEf0RYdD5jhE9JEk@nixie71> <ZEmwsViIjUVPZ4Cd@google.com> <ZEnBZs9VYxriT1Or@nixie71>
In-Reply-To: <ZEnBZs9VYxriT1Or@nixie71>
From:   =?UTF-8?B?VG9tw6HFoSBNdWRydcWIa2E=?= <tomas.mudrunka@gmail.com>
Date:   Thu, 27 Apr 2023 10:19:38 +0200
Message-ID: <CAH2-hcJa_vL9iWTARUAD+adrvQAjzr1N4bQ=cN+8kbE0arVwZw@mail.gmail.com>
Subject: Re: [PATCH] Fix freeze in lm8333 i2c keyboard driver
To:     Jeff LaBundy <jeff@labundy.com>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Yes that's correct; what I mean to say is that depending on the nature of
> the read-to-clear mechanism in the part, there is a chance that the IRQ
> has not been deasserted by the time the threaded handler returns. On some
> devices for example, the IRQ is not deasserted until some time after the
> read's stop condition.
>
> For these cases, I consider it best practice to measure the I2C and IRQ
> lines on a scope and if necessary, add a small delay before the interrupt
> handler returns. This is especially true for open-drain interrupts that
> may need a few hundred extra us for the pin to rise.

Well before posting the patch i did some testing.
I was watching the /proc/interrupts and checked that IRQ counter for
lm8333 matches number of keypresses.
Which i've only tested for like 20-30 times, but haven't seem any glitch.

But i still recognize the fact that the gpio line getting stuck for
some reason (short circuit on PCB?) might cause troubles by
unnecessarily loading the CPU, while with edge trigger it's more
likely to affect only the function of keyboard itself rather than
bringing down whole system. But i am not sure if this case is supposed
to be expected and handled in SW.
