Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD98D6474C1
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 17:57:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230105AbiLHQ5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 11:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiLHQ5I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 11:57:08 -0500
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94B9970BA8
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 08:57:07 -0800 (PST)
Received: by mail-pf1-x42d.google.com with SMTP id 130so1745900pfu.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 08:57:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OmFBgIdY3+ZsToSNVZ83H5cigb34N6EZfntDPaQf8hk=;
        b=FiN+qWfun85MRGRbla0Hd5IF9R1oP0Ok62X5UXey32hWqh62O5oiAeNbMNpb1yufvN
         emXRvqgv7WcxvKBzTF6iw78c2Kv+DsRijDc9Y1vr8wogSlBdmcjCrM6sRj0Vp5MSci2U
         89YCiUPqMprMLYVVAGxd8J03m5ZKcikIm4CFe4mWkYj4/dIpTJ60Xjeb4d8Kjgm3yhCk
         P7nXXwU/zrVhT5Opnl7yFPtEusvfP0G+MiE1q0OyN3VWRq87FM5p2pP6nMf91MXw0QKb
         +dWmT+l3UEHSjxqn5kw7g2PwgTvhNdHNxaitPkEcu8guLuaq1TUEeyC12aoan34vlOi1
         JJvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OmFBgIdY3+ZsToSNVZ83H5cigb34N6EZfntDPaQf8hk=;
        b=c4wo7nU2nGS8OeozY91R88iX/cqlPcssISsngq8KerfvdGK7O8ExFiyyGXGpxXR6y+
         GIC8NU0rVT2oDWWKRIBYydQGUW/Geykr8qTzhY8M9pu89sVhNqYUNKMrljQri6GdEEDi
         a+2B8M0xH0GWmKlH6h9w56W6Z3kUhzDPI6VjY3/9/v62Q7ca1yBQZ8CcgwZRUtkq+V4t
         dlXlkIvwAPMU52g/ZkHmQLf3ExRqQu/KRONwfFIVzTrnRJbApLR605emXHbGN2ra8Evl
         orpq31ydboQDcrFRRAOoGzYRpXSXHH6FuuBIiJxyhpHeXYrDLpOGfMwmh7d3u4xO5xCZ
         MCqg==
X-Gm-Message-State: ANoB5pkNuvCdpBTyv52AZVEDJXTLf7oGWVx5JUevTO7DNySEq3oR+kxS
        UezAQokiexAp+iUNsNfPOBCJ7k+bH12Pq6vEpgo=
X-Google-Smtp-Source: AA0mqf5g8+fIKbnqosSWgIeNZXUQt+JdAYoq4tQGaeVBG16JyNQurqd8gKAWal9umnshn6Z60VUhdfTTAFr/vmpBzLM=
X-Received: by 2002:a63:cc15:0:b0:476:ccde:6694 with SMTP id
 x21-20020a63cc15000000b00476ccde6694mr65907005pgf.603.1670518627025; Thu, 08
 Dec 2022 08:57:07 -0800 (PST)
MIME-Version: 1.0
References: <20221208165404.1512014-1-dario.binacchi@amarulasolutions.com> <20221208165404.1512014-2-dario.binacchi@amarulasolutions.com>
In-Reply-To: <20221208165404.1512014-2-dario.binacchi@amarulasolutions.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Thu, 8 Dec 2022 13:56:51 -0300
Message-ID: <CAOMZO5AWQcgaK-VjgwqqmqyeD0pnuQcL7oGbAWQVL6gAnBNtGA@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] ARM: imx: add missing of_node_put()
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
Cc:     linux-kernel@vger.kernel.org,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Martin Kaiser <martin@kaiser.cx>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Russell King <linux@armlinux.org.uk>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
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

On Thu, Dec 8, 2022 at 1:54 PM Dario Binacchi
<dario.binacchi@amarulasolutions.com> wrote:
>
> Calling of_find_compatible_node() returns a node pointer with refcount
> incremented. Use of_node_put() on it when done.
> The patch fixes the same problem on different i.MX platforms.
>
> Fixes: 8b88f7ef31dde ("ARM: mx25: Retrieve IIM base from dt")
> Fixes: 94b2bec1b0e05 ("ARM: imx27: Retrieve the SYSCTRL base address from devicetree")
> Fixes: 3172225d45bd9 ("ARM: imx31: Retrieve the IIM base address from devicetree")
> Fixes: f68ea682d1da7 ("ARM: imx35: Retrieve the IIM base address from devicetree")
> Fixes: ee18a7154ee08 ("ARM: imx5: retrieve iim base from device tree")
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Fabio Estevam <festevam@gmail.com>
