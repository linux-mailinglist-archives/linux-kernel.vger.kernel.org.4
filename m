Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4ACF96A2242
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 20:19:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229509AbjBXTTK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 14:19:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjBXTTJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 14:19:09 -0500
Received: from mail-vs1-xe2d.google.com (mail-vs1-xe2d.google.com [IPv6:2607:f8b0:4864:20::e2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39F1C1FF3
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:19:08 -0800 (PST)
Received: by mail-vs1-xe2d.google.com with SMTP id d7so999061vsj.2
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 11:19:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=uci-edu.20210112.gappssmtp.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=beKhMtsCTaM5oM3Mze5dnKYHOlzx1cDOTU11CiVmTd8=;
        b=H3SEpbzsD7PRyycSfaIJTHQITmlJgkO7Io7xHoUfh6iiCZVz9xOrTv1LV5ScXsGbej
         M3JGKkz9ieE3+sdM+rX5Y49Yz5gd+cYX/v0ssXiXxWX4jF+LyGDKdjYOZyoHyZ7M6Hj8
         Fjanq3xvT7H3csTgbOkTU6NCKQRA91J8J+5gTpS/aCv/4DTD22moW91JBqYzHOOB2pzm
         Ebke5bzH9WteMh+0aqP+q3oNr61B5MppI/LEvWcOeI2AvTZuq9P5IQTQW0boFKrEbLB7
         7GVXbJurw3Hpq1Pu0Rii7SqEW3ZxpAErRkHGUYlomFpzjepes0z6uzV2TVE5ux+ASXT0
         roaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=beKhMtsCTaM5oM3Mze5dnKYHOlzx1cDOTU11CiVmTd8=;
        b=S5o9UYa389cVM0mC8unOgvEwxxSTY2pz8vTntTB1o0OfTfuPeCCj8biAytlsfVvx3R
         pjuuooirqBy+5FeIcbAF3RFWxrBY0ydXLQ9ZltfdwGRiWuuR/W7YwtF++Orzrvlf16Np
         OrnMkJZm3TkVezXuDDRUseslQYuH+Jw9v2gDOKc+7mM6CNbUTLt8yDeRi/ywQbX/4kKg
         2slD3ZE6Y+41Ev4riKBvHlsQOWj5YaWablJPeoLZTHVW8j2zTLS6PAdedQL0NtawcVhr
         Y88Lx4gO5W9xc3Yr3R4frkIgerJSMWOC8hSlpcAJQXbzp2ptDY0KBizLTjt38NDJHGG/
         BRAQ==
X-Gm-Message-State: AO0yUKWwaQoL9KRSXJfhK0bsiqwupcvAKjZ+FhusbYzgnsaWU/SfJPMJ
        j/ya4HWCeDVx6wy9Epk08gSoVsAYVOnRmaQyp5V24g==
X-Google-Smtp-Source: AK7set8lCRfbdrWNN0pLqcJuTWrdGmQzu4KmlBszfB3kfSMl8UPsYGuSJPDt8W5Ix1Vhgy16L8mKJ8WCEEKd5v8PayQ=
X-Received: by 2002:a67:db0a:0:b0:414:2344:c353 with SMTP id
 z10-20020a67db0a000000b004142344c353mr3075359vsj.5.1677266347284; Fri, 24 Feb
 2023 11:19:07 -0800 (PST)
MIME-Version: 1.0
References: <CABcoxUayum5oOqFMMqAeWuS8+EzojquSOSyDA3J_2omY=2EeAg@mail.gmail.com>
 <87a614h62a.fsf@cloudflare.com> <CABcoxUYiRUBkhzsbvsux8=zjgs7KKWYUobjoKrM+JYpeyfNw8g@mail.gmail.com>
In-Reply-To: <CABcoxUYiRUBkhzsbvsux8=zjgs7KKWYUobjoKrM+JYpeyfNw8g@mail.gmail.com>
From:   Hsin-Wei Hung <hsinweih@uci.edu>
Date:   Fri, 24 Feb 2023 13:18:31 -0600
Message-ID: <CABcoxUY=k8_aM0YE3_e_FaMTLiBmo-Yc4UMyBVuRNggj4ivA-Q@mail.gmail.com>
Subject: Re: A potential deadlock in sockhash map
To:     Jakub Sitnicki <jakub@cloudflare.com>
Cc:     John Fastabend <john.fastabend@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Just a quick update. I can still trigger the lockdep warning on bpf
tree (5b7c4cabbb65).

Thanks,
Hsin-Wei

On Fri, Feb 24, 2023 at 9:58 AM Hsin-Wei Hung <hsinweih@uci.edu> wrote:
>
> Hi Jakub,
>
> Thanks for following up. Sorry that I did not receive the previous reply.
>
> The latest version I tested is 5.19 (3d7cb6b04c3f) and we can reproduce the
> issue with the BPF PoC included. Since we modified Syzkaller, we do not
> have a Syzkaller reproducer.
>
> I will follow John's suggestion to test the latest kernel and bpf
> tree. I will follow
> up if the issue still reproduces.
>
> Thanks,
> Hsin-Wei
>
>
>
>
> On Fri, Feb 24, 2023 at 8:51 AM Jakub Sitnicki <jakub@cloudflare.com> wrote:
> >
> > Hi,
> >
> > On Mon, Feb 20, 2023 at 07:39 AM -06, Hsin-Wei Hung wrote:
> > > I think my previous report got blocked since it contained HTML
> > > subparts so I am sending it again. Our bpf runtime fuzzer (a
> > > customized syzkaller) triggered a lockdep warning in the bpf subsystem
> > > indicating a potential deadlock. We are able to trigger this bug on
> > > v5.15.25 and v5.19. The following code is a BPF PoC, and the lockdep
> > > warning is attached at the end.
> >
> > Not sure if you've seen John's reply to the previous report:
> >
> > https://urldefense.com/v3/__https://lore.kernel.org/all/63dddcc92fc31_6bb15208e9@john.notmuch/__;!!CzAuKJ42GuquVTTmVmPViYEvSg!PU-LFxMnx4b-GmTXGI0hYjBiq8vkwrFrlf_b0N5uzy8do5kPFiNcuZJbby-19TtOH2rJoY9UwOvzFArd$
> >
> > Are you also fuzzing any newer kernel versions? Or was v5.19 the latest?
> >
> > Did syzkaller find a reproducer?
> >
> > Thanks,
> > Jakub
