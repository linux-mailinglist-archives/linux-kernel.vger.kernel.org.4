Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 915796414CE
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 08:42:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230315AbiLCHmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 02:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230273AbiLCHmP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 02:42:15 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0336492FCB;
        Fri,  2 Dec 2022 23:42:14 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id jn7so6594377plb.13;
        Fri, 02 Dec 2022 23:42:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gH9cG3m73A9rV9MZfPNttg4nX7xR1Ly06iaUkGeAWaE=;
        b=BjEoCOk0Mi8JwFAPYjcp4hOyW1in4GNAJvOYyKW39P0zDbZTiua/edx9o3TSSbVYe3
         zYiALcSHI73G6rRxBPs89yM5HGDtGNlOK7DL6BpEOMIkDH+rmye+yZVloe0pS9Yxe+wN
         BZEJ4anhyF2IWBKeHNHdqfYpJP2ZDFkCq3f1WyLDQgoNwy55RdexX2DJBpJthhL1xo3t
         +kWNT6aK+3/emic+U3j7kDs6p1QeK2onMH8L8271kXKx7oBzQkdAYPqiEggu5gIAv2Hn
         VijGzNEgELzDkzdTL3MYcsvXYl51jQreS/kniuO+VmE3CuKfOhAnPbHU+PEpU0NKuyJS
         Edkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=gH9cG3m73A9rV9MZfPNttg4nX7xR1Ly06iaUkGeAWaE=;
        b=0Bix2t4n1yIze7X4MjIQzxmslX8Mb5Thls5gX/5kbxgqkoVx+aM8b6cfbBaf+h3K37
         9KoiAE0uOrGNmjeS/83tkTshBCAyqV45vEU1BzIfAa3gfkD1p4XQa1CTq7i4yXxIBMen
         lx0zNETAziBWJ36BbWbswOswlL9z8heFh2cUlfy2hpfYDtN8C8pRMkcdPTs9JqWsO3H+
         gp8ZvSOzrF89KH6TbAO18ZG9S3ffXQ+b7rC9zvuQgvm0fiwiOVKwx2+g9L0EjPW8Yjxd
         TCUsd3y//Ifxnp/t+CfFuS1QCQdPxJeWZIUi+GuXHLBM/bjlh6OXb32NomQAVuKOv/9S
         WjKA==
X-Gm-Message-State: ANoB5plQ6lrGrcoCjYQ9Smuu1pdCuAT4/d+08TMFK4FmqWrtpf79fScP
        luxj29pvBIFDASj/P3RTYrxRMGuOOBjz7sV4
X-Google-Smtp-Source: AA0mqf7HCmeQOuORdIZHN2SySkLEgwMy9Vv1ckxO++kZA1b/tjFP1z5LAG/egxKe5ViqubCHMcJ9Ww==
X-Received: by 2002:a17:90a:5295:b0:219:a43b:1006 with SMTP id w21-20020a17090a529500b00219a43b1006mr2559795pjh.195.1670053333376;
        Fri, 02 Dec 2022 23:42:13 -0800 (PST)
Received: from dell-void.taile5200.ts.net (c-71-202-83-242.hsd1.ca.comcast.net. [71.202.83.242])
        by smtp.gmail.com with ESMTPSA id c10-20020a63ea0a000000b0047048c201e3sm5104664pgi.33.2022.12.02.23.42.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Dec 2022 23:42:13 -0800 (PST)
Date:   Fri, 2 Dec 2022 23:42:06 -0800
From:   Eirin Nya <nyanpasu256@gmail.com>
To:     "phoenix" <phoenix@emc.com.tw>
Cc:     "'Dmitry Torokhov'" <dmitry.torokhov@gmail.com>,
        <linux-input@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "'Josh.Chen'" <josh.chen@emc.com.tw>
Subject: Re: [PATCH V2 3/3] Input: elantech - Fix incorrectly halved
 touchpad range on ELAN v3 touchpads
Message-ID: <20221202234206.6527835a.nyanpasu256@gmail.com>
In-Reply-To: <003201d904ae$05d38870$117a9950$@emc.com.tw>
References: <20221014111533.908-1-nyanpasu256@gmail.com>
        <20221014111533.908-4-nyanpasu256@gmail.com>
        <Y4T2nygbxkhAQRvM@google.com>
        <Y4T21vl0mJocdpdV@google.com>
        <003201d904ae$05d38870$117a9950$@emc.com.tw>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-unknown-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> If the setting is indeed double resolution, can we simply multiply 
> x_max and y_max by 2 instead of re-querying it?

Perhaps in some laptops, x_max or y_max is odd when resolution is
doubled, and rounded up or down in half-resolution mode, so multiplying
the half-resolution size by 2 results in a slightly incorrect full
size. I don't know if that's the case in other touchpads, but my
laptop's touchpad has even size in full-resolution (doubled) mode,
meaning it doesn't round its size in half-resolution mode (so
multiplying both values by 2 would work on my machine).

On Wed, 30 Nov 2022 19:22:25 +0800
"phoenix" <phoenix@emc.com.tw> wrote:

> Consulted with FW team, we suggest re-querying x/y resolution after
> setting absolute mode.

My current patch re-queries x/y resolution after setting absolute mode.
If this is the process that Elan's FW team recommends, should the patch
be kept as-is?
