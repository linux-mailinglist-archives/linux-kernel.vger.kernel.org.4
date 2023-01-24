Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 717C06792E7
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 09:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232226AbjAXIUd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 03:20:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229930AbjAXIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 03:20:32 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CADF30EF;
        Tue, 24 Jan 2023 00:20:26 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id y25so22133449lfa.9;
        Tue, 24 Jan 2023 00:20:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CD3O6ZdZYXrRnyE2BcOXHsWifO2eKM+2LTfm0D+lNes=;
        b=RX0REkNXMjJqvrX8e8Jxnyu0bfCFWuQ/DfcVbiUBxqr7Rvt+QFOhGvbHG9LBROKGz6
         jKUGZJCF9RqifPgO1OszvbCn9/OHVeVguUaKpF9BhbcU4NOA1nQWCnvOdU69alYmqfRo
         xkibnz0Qruj2GqyQ5N44+I6wcujxKpslmIGLC7VJDX/iiYXE0v5pYhbs1kWurSDhSJ/C
         D0AhqEd0DZyTTv93Dsu7Rgvf61/Ib0pEgDIGDsuT1FJfAXHmGq1h2Wzq7Udk+3Yz1fx0
         dlvdi9U/Ru+8VzYm50Bju2xfHpJUBLdHL5blrZGLoIiDq45HlbYN9bTi+P+N+vSy85sE
         gB+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:content-language:in-reply-to:mime-version
         :user-agent:date:message-id:from:references:cc:to:subject
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CD3O6ZdZYXrRnyE2BcOXHsWifO2eKM+2LTfm0D+lNes=;
        b=GFPk+Mf5yafkNYeOhVikH4qzZESndOJkmPdDeOrKLsFLtUN5V5pO2SqaCrcDjhrxke
         Xgy1DCcquI/jTvnIxPo0FH4t3KHQn278Q6jsO0g6x6gohFYMieyX2f9nbxI+Up3/3mBT
         i70fD820ZLkAZe05q+LGs2R3zPuhtTR/hZApM7UAZ7I6n6DyB2t0k1FH3ds3VQlzlfyS
         VAYsBdZ7kw0VyEB2Y8L/dJsGV7c484MLwsutK0OW3merrW4vzxRUeNzw21a0HDm5HnIZ
         LXisVnZPXD5onAUCAc4/POyl8XgP9rmfvA34TtN0Mvngm93jftJlZHE9bV4HW3B3MJre
         N2sg==
X-Gm-Message-State: AFqh2kpIY8VteiI/8+hn6H0/BwJ7a8ReT7kVWEAhN6FvQ6kqJRRPyUvo
        hNRM71MGc59qyzootKRj6X9bRzO4BcM=
X-Google-Smtp-Source: AMrXdXtDe6vyw3xGLe6Il6gO3Z0UzOGstPIMHTdkln93Fa1RiPZhKLiUN+FsB5188fuo8Olw25Fu4w==
X-Received: by 2002:a05:6512:1196:b0:4b6:a6e4:ab7a with SMTP id g22-20020a056512119600b004b6a6e4ab7amr8005217lfr.8.1674548424219;
        Tue, 24 Jan 2023 00:20:24 -0800 (PST)
Received: from [192.168.1.103] ([31.173.82.218])
        by smtp.gmail.com with ESMTPSA id t2-20020a19ad02000000b0048a8c907fe9sm129837lfc.167.2023.01.24.00.20.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 00:20:23 -0800 (PST)
Subject: Re: [PATCH 2/2] arm64: dts: renesas: white-hawk: Add CAN-FD support
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>
Cc:     Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Ulrich Hecht <uli+renesas@fpond.eu>,
        linux-renesas-soc@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1674500205.git.geert+renesas@glider.be>
 <a19d0a70aacaf4c3517a226bf32ea49db3542da4.1674500205.git.geert+renesas@glider.be>
From:   Sergei Shtylyov <sergei.shtylyov@gmail.com>
Message-ID: <c3816a2f-65c5-e201-35ea-0c6f5c3c3dd0@gmail.com>
Date:   Tue, 24 Jan 2023 11:20:22 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <a19d0a70aacaf4c3517a226bf32ea49db3542da4.1674500205.git.geert+renesas@glider.be>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 1/23/23 10:06 PM, Geert Uytterhoeven wrote:

> Enable confirmed-working CAN-FD channels 0 and 1 on the White-Hawk
> development board:
>   - Channel 0 uses an NXP TJR1443AT CAN transceiver, which is be enabled

   Is be enabled? :-)

>     through a GPIO,
>   - Channels 1-7 use Microchip MCP2558FD-H/SN CAN transceivers (not
>     mounted for channels 4-7), which do not need explicit description,
>     but channels 2-3 do not seem to work.
> 
> Inspired by a patch in the BSP by Kazuya Mizuguch.
> 
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
[...]

MBR, Sergey
