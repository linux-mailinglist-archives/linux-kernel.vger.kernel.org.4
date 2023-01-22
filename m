Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 600A667721D
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 20:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230123AbjAVTtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 14:49:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229795AbjAVTtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 14:49:31 -0500
Received: from smtp.smtpout.orange.fr (smtp-19.smtpout.orange.fr [80.12.242.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84AD21E1FE
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 11:49:29 -0800 (PST)
Received: from [192.168.1.18] ([86.243.2.178])
        by smtp.orange.fr with ESMTPA
        id JgLFpiKJCzLACJgLFpAgK4; Sun, 22 Jan 2023 20:49:27 +0100
X-ME-Helo: [192.168.1.18]
X-ME-Auth: Y2hyaXN0b3BoZS5qYWlsbGV0QHdhbmFkb28uZnI=
X-ME-Date: Sun, 22 Jan 2023 20:49:27 +0100
X-ME-IP: 86.243.2.178
Message-ID: <bd2df24b-e19e-2ba4-c3e8-0d555f69b453@wanadoo.fr>
Date:   Sun, 22 Jan 2023 20:49:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH] agp/amd64: Fix full name of the GPL
Content-Language: fr, en-US
To:     Diederik de Haas <didi.debian@cknow.org>,
        David Airlie <airlied@redhat.com>,
        "open list:AGPGART DRIVER" <dri-devel@lists.freedesktop.org>,
        open list <linux-kernel@vger.kernel.org>
References: <20230122181632.54267-1-didi.debian@cknow.org>
From:   Christophe JAILLET <christophe.jaillet@wanadoo.fr>
In-Reply-To: <20230122181632.54267-1-didi.debian@cknow.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le 22/01/2023 à 19:16, Diederik de Haas a écrit :
> Signed-off-by: Diederik de Haas <didi.debian@cknow.org>
> ---
>   drivers/char/agp/amd64-agp.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/char/agp/amd64-agp.c b/drivers/char/agp/amd64-agp.c
> index ce8651436609..3020fd92fd00 100644
> --- a/drivers/char/agp/amd64-agp.c
> +++ b/drivers/char/agp/amd64-agp.c
> @@ -1,7 +1,7 @@
>   // SPDX-License-Identifier: GPL-2.0-only
>   /*
>    * Copyright 2001-2003 SuSE Labs.
> - * Distributed under the GNU public license, v2.
> + * Distributed under the GNU General Public License, v2.
>    *
>    * This is a GART driver for the AMD Opteron/Athlon64 on-CPU northbridge.
>    * It also includes support for the AMD 8151 AGP bridge,

Hi,

maybe the line can just be removed.
There is already a SPDX-License-Identifier above.

CJ
