Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51E9A677FCB
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 16:31:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232260AbjAWPbP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 10:31:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232213AbjAWPbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 10:31:12 -0500
Received: from smtp5-g21.free.fr (smtp5-g21.free.fr [IPv6:2a01:e0c:1:1599::14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2668F2659B;
        Mon, 23 Jan 2023 07:31:09 -0800 (PST)
Received: from SOPL295.local (unknown [IPv6:2a01:e0a:a6a:5f90:f8ca:19b4:6313:bc3])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp5-g21.free.fr (Postfix) with ESMTPSA id A3A4E5FF93;
        Mon, 23 Jan 2023 16:30:52 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1674487867;
        bh=0mLGiFxXL934+MnA0bzTBcB0yjt9RF2xQOgM+iaYjPY=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=oPO+odbfKIZ6vir9Tfwk80gwYeCsjrxxt/HC4veBDAcxRTbn32Hs1FVVwspQw+XTx
         TEwEjOTHoHRFYjk/FTqepQNXfG6fe4LvGbcIp7GMCqGyXTgk0xAgiA6rNg8fFtKIT7
         kGiJm1PSp6I0o0IUUkpqbj/3jYcNTQxD+B4ZLAiPvPpph0SfQSyMi1y9/BDJoopR5v
         P+it0gg99oexQHK4cI2hFcHGdFrFglUrt1YbdIsg/ou6JC9P6tbkwgMeT2LPC1/QDN
         HdZDTYqFs8WdawsswDBQzFFeKNtwwgZ+wpWS7JPeT/l+dTZobZjsGw7dB2UjMFf0HX
         sV8iwf0BLXhig==
References: <20230109161636.512203-1-arnd@kernel.org>
 <20230109161636.512203-2-arnd@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Aaro Koskinen <aaro.koskinen@iki.fi>,
        Janusz Krzysztofik <jmkrzyszt@gmail.com>,
        Tony Lindgren <tony@atomide.com>, linux-omap@vger.kernel.org,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>
Subject: Re: [PATCH 1/3] ARM: pxa: enable PXA310/PXA320 for DT-only build
Date:   Mon, 23 Jan 2023 16:30:17 +0100
In-reply-to: <20230109161636.512203-2-arnd@kernel.org>
Message-ID: <m2bkmpgteb.fsf@free.fr>
MIME-Version: 1.0
Content-Type: text/plain; format=flowed
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Arnd Bergmann <arnd@kernel.org> writes:

> From: Arnd Bergmann <arnd@arndb.de>
>
> After commit b5aaaa666a85 ("ARM: pxa: add Kconfig dependencies 
> for
> ATAGS based boards"), the default PXA build no longer includes 
> support
> for the board files that are considered unused.
>
> As a side-effect of this, the PXA310 and PXA320 support is not 
> built
> into the kernel any more, even though it should work in 
> principle as
> long as the symbols are enabled. As Robert points out, there are 
> dts
> files for zylonite and cm-x300, though those have not made it 
> into the
> mainline kernel.
>
> Link: 
> https://lore.kernel.org/linux-arm-kernel/m2sfglh02h.fsf@free.fr/
> Reported-by: Robert Jarzmik <robert.jarzmik@free.fr>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
