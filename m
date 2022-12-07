Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF642645D54
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Dec 2022 16:11:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbiLGPLo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 10:11:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiLGPLl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 10:11:41 -0500
Received: from mail-qk1-f179.google.com (mail-qk1-f179.google.com [209.85.222.179])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AABB55C0C3;
        Wed,  7 Dec 2022 07:11:40 -0800 (PST)
Received: by mail-qk1-f179.google.com with SMTP id s10so8620438qkg.8;
        Wed, 07 Dec 2022 07:11:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=V8+mpXZFNkFWvHuLStCRLZZRDcBgfMva+nRq8c4oh74=;
        b=PelouB+kMv1YpiEwerN3PCzW6UT84WIthprWlEWlqsOrvTb8ebpugqkS4+VLeuD7M8
         s3jfhCts2TW/iIPfI2U11BYVZn4epiNGcY81QLx6UensNrnaEK1jy/1/oSHrqyFlXdLy
         zkDVM9N1QEp7RLnRW5RNcufkza2jX0TX5fDskUgwAdBJ88IN6pG3kaFUilZ6CeS2HZz6
         HUQYzFW/zaBvo8Aqp+JoHmqRFV6TxUYJraX+v8r/R3UCPUn+kYw9MpNf8A6KkxFvwZ2Y
         QcMcujKuFXRFXVAMPB9S/4ntYq0LSQaE33Zf3f6pjLWxu3UsRW7z4Q93PeSDUTqeNHkg
         bJiQ==
X-Gm-Message-State: ANoB5pnD8DhHf6q4jR82P11Se+l1eYajeX+XYWP9yEMnrPJelS4elczL
        HUwQ5Tq5jl4PuEXhpinA65mx5lYkhdw2cw==
X-Google-Smtp-Source: AA0mqf5i2tkZHXFouVjesGx7eZLiCdZTfs1bbfeRHXYdCv2Gl7g48YroyZx1l2RoaYSVUxByDO7oNw==
X-Received: by 2002:a37:711:0:b0:6fe:c86a:c1c4 with SMTP id 17-20020a370711000000b006fec86ac1c4mr8829552qkh.518.1670425899593;
        Wed, 07 Dec 2022 07:11:39 -0800 (PST)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id do50-20020a05620a2b3200b006fa32a26433sm9099195qkb.38.2022.12.07.07.11.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 07:11:39 -0800 (PST)
Received: by mail-yb1-f171.google.com with SMTP id d128so23038879ybf.10;
        Wed, 07 Dec 2022 07:11:39 -0800 (PST)
X-Received: by 2002:a25:9:0:b0:6f9:29ef:a5ee with SMTP id 9-20020a250009000000b006f929efa5eemr33961528yba.380.1670425899011;
 Wed, 07 Dec 2022 07:11:39 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgyXu4D44b8wQU9dpTYUft6WhZ0wr3nV1fziy6k0GwCCw@mail.gmail.com>
 <20221206085158.349363-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2212060957480.648028@ramsan.of.borg>
 <87cz8vmfh4.fsf@kernel.org>
In-Reply-To: <87cz8vmfh4.fsf@kernel.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 7 Dec 2022 16:11:28 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVxgfgbtdaFVzUWEmiJw13nQFkFG5SO_m4ixjYd=rsJow@mail.gmail.com>
Message-ID: <CAMuHMdVxgfgbtdaFVzUWEmiJw13nQFkFG5SO_m4ixjYd=rsJow@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.1-rc8
To:     Kalle Valo <kvalo@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Kalle,

On Wed, Dec 7, 2022 at 3:54 PM Kalle Valo <kvalo@kernel.org> wrote:
> Geert Uytterhoeven <geert@linux-m68k.org> writes:
> > On Tue, 6 Dec 2022, Geert Uytterhoeven wrote:
> >> JFYI, when comparing v6.1-rc8[1] to v6.1-rc7[3], the summaries are:
> >>  - build errors: +1/-3
> >
> >   + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6152:45
> >
> > sh4-gcc11/sh-allmodconfig
> >
> > Looks like a real issue, albeit not new (but never seen before?).
>
> Weird, I can't find any recent change which would affect this function.
> So you have seen this warning only on v6.1-rc8?

The gcc11 build for sh4/allmodconfig was introduced quite recently on
kisskb, and it's still buggy (ICEs), so it's possible previous builds for that
target never went that far before...

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
