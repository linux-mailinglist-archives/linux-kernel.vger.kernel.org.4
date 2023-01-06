Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3A6C6602F4
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 16:19:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234950AbjAFPTC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 10:19:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234496AbjAFPSl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 10:18:41 -0500
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E12C8B743;
        Fri,  6 Jan 2023 07:18:40 -0800 (PST)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-476e643d1d5so26868567b3.1;
        Fri, 06 Jan 2023 07:18:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oLTT10Q08SvcCsbZuYubvWn2TjFc+1wP3y0ZN/T09Wc=;
        b=RKjEKEBjR7zbv+AXsvsl9YLEazD1LOHUJYucqol512xauguktXOj6/HU+n6iqsxWm0
         hjj6YJ2gflxjwQtUAVqiUvnjJ6dz3UmzFB1UpxebYVqfLG/hnR3PONteMaMKP+WsNVNl
         tuPBpxUsbXrdua/Wn5nRw858KOO1LRwrApKEwduv1kyFmeeInnH9+UW5foP9wBaMKGzs
         h8dPxv82OrFNm4uHt6Z5qxcDmcjFD2mCBC8DuBeTNkugCympWU7RnJAubyI1OQhTacHa
         EXq8utlSznSD11aMA+ORTa3k3sGhE7XqfIRs2k/zS2U/xwf5aqcfbjMUNF+9fldkoEAm
         m+fg==
X-Gm-Message-State: AFqh2koPd6GE8ygV7C9oydj/3zbObaU/TREB4s+QR+TaZW7eVKXyzzs+
        VR6Wf5bdnaiFfa71ZJM+nWIpE46lON9pug==
X-Google-Smtp-Source: AMrXdXubmLBSxEeWEOTXkzNQNH1yY4T0RdkGs7dNm/m+L3Vkn40L98eh7w/lB8z1bzTKRDFEzHxEog==
X-Received: by 2002:a81:4e89:0:b0:487:b6b9:ff5d with SMTP id c131-20020a814e89000000b00487b6b9ff5dmr29500339ywb.45.1673018319407;
        Fri, 06 Jan 2023 07:18:39 -0800 (PST)
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com. [209.85.128.174])
        by smtp.gmail.com with ESMTPSA id j19-20020a05620a411300b00704c1f4e756sm656168qko.14.2023.01.06.07.18.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 07:18:39 -0800 (PST)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-482363a1232so26741327b3.3;
        Fri, 06 Jan 2023 07:18:38 -0800 (PST)
X-Received: by 2002:a81:17ca:0:b0:46f:bd6:957d with SMTP id
 193-20020a8117ca000000b0046f0bd6957dmr4281773ywx.383.1673018318622; Fri, 06
 Jan 2023 07:18:38 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgf929uGOVpiWALPyC7pv_9KbwB2EAvQ3C4woshZZ5zqQ@mail.gmail.com>
 <20221227082932.798359-1-geert@linux-m68k.org> <alpine.DEB.2.22.394.2212270933530.311423@ramsan.of.borg>
 <c05bee5d-0d69-289b-fe4b-98f4cd31a4f5@physik.fu-berlin.de> <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
In-Reply-To: <CAMuHMdXNJveXHeS=g-aHbnxtyACxq1wCeaTg8LbpYqJTCqk86g@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 6 Jan 2023 16:18:27 +0100
X-Gmail-Original-Message-ID: <CAMuHMdU8AKSdujbr=nwaBUy4q4z_R=MERnb5CBPPv=A63BVFXA@mail.gmail.com>
Message-ID: <CAMuHMdU8AKSdujbr=nwaBUy4q4z_R=MERnb5CBPPv=A63BVFXA@mail.gmail.com>
Subject: Re: Build regressions/improvements in v6.2-rc1
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-wireless@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-sh@vger.kernel.org, linux-f2fs-devel@lists.sourceforge.net,
        linuxppc-dev@lists.ozlabs.org, kasan-dev@googlegroups.com,
        linux-xtensa@linux-xtensa.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,SUSPICIOUS_RECIPS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 6, 2023 at 4:17 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi John,

Bummer, "Hi Adrian", ofc ;-)

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
