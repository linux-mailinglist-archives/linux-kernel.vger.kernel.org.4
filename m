Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C0FD63D44F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 12:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234908AbiK3LUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 06:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234566AbiK3LTz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 06:19:55 -0500
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDB22FA41
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:19:18 -0800 (PST)
Received: by mail-pf1-x430.google.com with SMTP id w79so16534262pfc.2
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 03:19:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BATu+UcqlwtwfiH4MTWO+KZsAE1c6RkNGAfFiYngKsc=;
        b=MWUGFgJ3pPP+HjfH6nVLwvKypRF6J+Sr9LNGi4Tezu8OkPBBJC/D4s+9zBJX9IhKk9
         LHv2LkBJfJabLZ00leMhDqXsvyi/rCK3AIOrXcGF3p+VY3TKh9m3okvgUAEJMUnBpevF
         7seCtYq7oQbml4ZQOO0QIqUZoK5fbAg7nQsCQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BATu+UcqlwtwfiH4MTWO+KZsAE1c6RkNGAfFiYngKsc=;
        b=o2TIOs7eTCWX7eWHnC2DpbRaTxd5LF9JLQ/v8qkXof73koZ1et+KDQCnTSMJOcppVJ
         NyWGMYZ55oypOIGGuzB76Gap0EFpq5MpiflPZ1+yZlGHBl2Ku4omFYs5yWXvhUmsWDtJ
         kjN+gasxX87RAVSsbfXqRC1/pW5FVYu4W7DB4tJG9jimgJpsdidXvjvwdDhs5dhrFiuq
         txzJDghNfUlx/pR2QDNFxsrZZW3JKeOXyyY0QmjHVVmtXOk0jy5UA+1b80UC3oDOVdPn
         gLS3qUM7d+Aprw59u9FjBwTYtEMh+2/GkyAJU5GwHMvK6j8XkB8jbHT4yR9+TRumHTFh
         n8Ug==
X-Gm-Message-State: ANoB5pkVj65cPjwWmq0HGBkjSMUIMBUFDNAbyqJOUQFhmXt7489gfx4r
        jm+NRv++ua48PjAd998MXKRTyUxP10uX6a8/K4aM5XlmdvaoQw==
X-Google-Smtp-Source: AA0mqf5jySgZgQzui4HtwIX1shh1/LW1UBionDIXDLn/xObKoTzJveFzh3gM2+BL/Q8jj8n2pkBDQVBIeobfFvYc6Gw=
X-Received: by 2002:a05:6a00:1812:b0:575:19b6:dfe9 with SMTP id
 y18-20020a056a00181200b0057519b6dfe9mr16659744pfa.16.1669807158350; Wed, 30
 Nov 2022 03:19:18 -0800 (PST)
MIME-Version: 1.0
References: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
In-Reply-To: <20221130101021.1868764-1-benjamin.tissoires@redhat.com>
From:   Florent Revest <revest@chromium.org>
Date:   Wed, 30 Nov 2022 12:19:07 +0100
Message-ID: <CABRcYmK3x0+1kCe-yJSjKS57t1aLJxRiZRt+tSzzQ0aeuoMvMw@mail.gmail.com>
Subject: Re: [PATCH 0/2] HID-BPF: Kconfig fix
To:     Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Jiri Kosina <jikos@kernel.org>, Jon Hunter <jonathanh@nvidia.com>,
        linux-input@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 30, 2022 at 11:10 AM Benjamin Tissoires
<benjamin.tissoires@redhat.com> wrote:
>
> Hi,
>
> As discussed in [1], we need to add some more dependencies to HID-BPF in
> the Kconfig. This way, when fmod_ret will be available on arm64, HID-BPF
> will get enabled automatically.
>
> Jon, would you mind giving a shot at that patch on your test system and
> confirm the error disappeard?
>
> Cheers,
> Benjamin
>
>
>
> [1] https://lore.kernel.org/r/CABRcYmKyRchQhabi1Vd9RcMQFCcb=EtWyEbFDFRTc-L-U8WhgA@mail.gmail.com
>
> Benjamin Tissoires (2):
>   HID: bpf: enforce HID_BPF dependencies
>   selftests: hid: ensures we have the proper requirements in config
>
>  drivers/hid/bpf/Kconfig            | 4 +++-
>  tools/testing/selftests/hid/config | 2 ++
>  2 files changed, 5 insertions(+), 1 deletion(-)
>
> --
> 2.38.1

Reviewed-by: Florent Revest <revest@chromium.org>
