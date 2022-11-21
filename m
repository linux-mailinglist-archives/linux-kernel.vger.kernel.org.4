Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D146B631D23
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 10:46:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229758AbiKUJqE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 04:46:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230360AbiKUJpy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 04:45:54 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D31929734E;
        Mon, 21 Nov 2022 01:45:52 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id d7so7625274qkk.3;
        Mon, 21 Nov 2022 01:45:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=08ON0wDEuOA5N2KdfVDxrAXwMO1f5tiaJoMdWJHTTko=;
        b=Hd3p28TQnQEFkZjzNqGop+xyOmuMRv8kmC3PEb2luLtIudBaXLAHNCwBb0UA8k8aUF
         /zmKwk58GMXeRA4pDb/JQ5VIPf3wTDlhIOihM3mZaQBBeHO9ZuJfKX0hPY28yEeFduSR
         fVX6ieegUkvWSM/teiggUvnVxcguF/hpmU2t6fpRZv1I25tgeB3DNRtOOndjeQlferDR
         vWsRN4Gi5AnnsiaHbU4v7wX3PWMDlTRd4h2xOda8jdeVxs5WXLBFDLPvfDbKII/IJlth
         5k6TVVwyxN4Eng1v+FPDi/8JEPh9yAop7xghXgNaqjsRx/pi31gcMFb5bN38vgKwumk6
         E3CA==
X-Gm-Message-State: ANoB5pniXxQlWMVWnxaIVf+wTZOC1C0FWApOYNCvurkE09UYNiCmsG4r
        S8IH7TTGURc5WQ0Kbc5QpJnMLa3FPEimDg==
X-Google-Smtp-Source: AA0mqf68Kznng4ttyT/KgqO8AGTnNTTP3puLvmFseM7hfTJaiyly+oOjMvjGU/5b23iGeOoxL6mWTw==
X-Received: by 2002:a37:a806:0:b0:6fa:88d:521d with SMTP id r6-20020a37a806000000b006fa088d521dmr15157445qke.317.1669023951821;
        Mon, 21 Nov 2022 01:45:51 -0800 (PST)
Received: from mail-yw1-f176.google.com (mail-yw1-f176.google.com. [209.85.128.176])
        by smtp.gmail.com with ESMTPSA id m2-20020ac86882000000b00399ad646794sm6508159qtq.41.2022.11.21.01.45.50
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 01:45:50 -0800 (PST)
Received: by mail-yw1-f176.google.com with SMTP id 00721157ae682-39451671bdfso82848207b3.10;
        Mon, 21 Nov 2022 01:45:50 -0800 (PST)
X-Received: by 2002:a05:690c:b81:b0:37e:6806:a5f9 with SMTP id
 ck1-20020a05690c0b8100b0037e6806a5f9mr788842ywb.47.1669023949996; Mon, 21 Nov
 2022 01:45:49 -0800 (PST)
MIME-Version: 1.0
References: <20221118145512.509950-1-gsomlo@gmail.com> <20221118145512.509950-3-gsomlo@gmail.com>
In-Reply-To: <20221118145512.509950-3-gsomlo@gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 21 Nov 2022 10:45:38 +0100
X-Gmail-Original-Message-ID: <CAMuHMdV0PVmcoieeyO_DMR7Yiy-gq6=yQgqQ4AXWxtpJMH5X9Q@mail.gmail.com>
Message-ID: <CAMuHMdV0PVmcoieeyO_DMR7Yiy-gq6=yQgqQ4AXWxtpJMH5X9Q@mail.gmail.com>
Subject: Re: [PATCH v5 02/14] serial: liteuart: use bit number macros
To:     Gabriel Somlo <gsomlo@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-serial@vger.kernel.org,
        gregkh@linuxfoundation.org, jirislaby@kernel.org,
        kgugala@antmicro.com, mholenko@antmicro.com, joel@jms.id.au,
        david.abdurachmanov@gmail.com, florent@enjoy-digital.fr,
        ilpo.jarvinen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 18, 2022 at 3:55 PM Gabriel Somlo <gsomlo@gmail.com> wrote:
> Replace magic bit constants (e.g., 1, 2, 4) with BIT(x) expressions.
>
> Signed-off-by: Gabriel Somlo <gsomlo@gmail.com>

Reviewed-by: Geert Uytterhoeven <geert@linux-m68k.org>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
