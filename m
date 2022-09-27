Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 935BE5EBDEF
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 11:01:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230378AbiI0JBD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 05:01:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231401AbiI0JAm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 05:00:42 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE3F397B3A
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:00:41 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id l65so9102879pfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 27 Sep 2022 02:00:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date;
        bh=FoWxL7OPF5Vt7GG7PGeiRRE+3SfmYsfHI6XYr9SmeEo=;
        b=g58BAz3lJ7SA0EDVHpTmY6Ubk/YayOVdFDT7CqDjA5USIPw2pvaOfSVlU6iRsnuyuH
         /z6LdV+A60Z9+UVUyqBvbqmBHpgLj/EZhDFnRyR9Jt7MAL953z3E4JNB5SkDApgV9HLx
         b5JGpeSUucYff5i9roKkpZjcth92Qn3TUoYeJAsgyQzodstEbFiWkDCg3vZA5K2ObK25
         hX6OqLlOZ95F5ezbjJJfA432wiJAXE44YSKKgl/ukIP+3AP4vSVV1iUyx3eBUlAw5JUB
         J8oe4V1mf3tj803y0VfSj6bXQniY8zs26xv9DbwJwD13yMMkytA9HG9ASPO90nTY9TOa
         nR6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date;
        bh=FoWxL7OPF5Vt7GG7PGeiRRE+3SfmYsfHI6XYr9SmeEo=;
        b=19CDQfGeVlsDOMOj3lt+vzkQTYIbrkv6DTF+A01ScsfQ0zLcL9kKOO14/0muYcKQ1O
         ZmkWFNygCjsIaR+HtpDj1eWe/EXG/iiN6/6eMZwBpf4pJaZKHgwo6cYKO5N1WuagXnyQ
         A1XnQImnAAr7t+WvH7Zwag/SNkqDNU4DbSgajUDQd8LzjBvg8S6QIiQFW3t9B6sgD4VX
         clnS/ZhUhw1q0CMKFifvIuirztTPrc0e7i5iWLNYuElMWtjw80ro/ZFArlxU+q+UNZ/u
         k9VxCCqfWIYWEnt/s4qhP9/P5rXQlA0sqzOwfHJn4s4FvcsElMupFogr0LlKk+trfx48
         46Yw==
X-Gm-Message-State: ACrzQf17oM9sj32FlblMm8nzu/NVfz3IWwZ6Kaq2B6OERKOJ0pqH7Frw
        vd704nIQuD++R0vjQUSgfaThqp2aGpo=
X-Google-Smtp-Source: AMsMyM4KHQVLxG6sNP6ySsjx+1ZLTwimQzqB0i4wiGvtNmhqYM6NfCsVjvFxefO3zWeNOF8BXzW+5w==
X-Received: by 2002:a63:6a85:0:b0:43b:dac2:ff0b with SMTP id f127-20020a636a85000000b0043bdac2ff0bmr24406872pgc.234.1664269241408;
        Tue, 27 Sep 2022 02:00:41 -0700 (PDT)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id f13-20020a170902ce8d00b001786b712bf7sm948900plg.151.2022.09.27.02.00.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Tue, 27 Sep 2022 02:00:41 -0700 (PDT)
Date:   Tue, 27 Sep 2022 17:03:29 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] erofs: clean up unnecessary code and comments
Message-ID: <20220927170329.000013b1.zbestahu@gmail.com>
In-Reply-To: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
References: <20220927063607.54832-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Sep 2022 14:36:06 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> Some conditional macros and comments are useless.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>

> ---
>  fs/erofs/internal.h |  2 --
>  fs/erofs/namei.c    | 11 +----------
>  fs/erofs/xattr.h    |  2 --
>  fs/erofs/zmap.c     |  3 +--
>  4 files changed, 2 insertions(+), 16 deletions(-)
>

