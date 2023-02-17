Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82EBB69B470
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 22:13:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229770AbjBQVNP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 16:13:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbjBQVNN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 16:13:13 -0500
Received: from smtp1-g21.free.fr (smtp1-g21.free.fr [IPv6:2a01:e0c:1:1599::10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5D20D3;
        Fri, 17 Feb 2023 13:13:11 -0800 (PST)
Received: from SOPL295.local (unknown [IPv6:2a01:e0a:a6a:5f90:38fe:9937:c1ef:e044])
        (Authenticated sender: robert.jarzmik@free.fr)
        by smtp1-g21.free.fr (Postfix) with ESMTPSA id 068E2B0055E;
        Fri, 17 Feb 2023 22:13:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=free.fr;
        s=smtp-20201208; t=1676668389;
        bh=o4n9TV7P8lOWD4f+6mSZVv0GFtJZ5luwHrSpvYZHeT4=;
        h=References:From:To:Cc:Subject:Date:In-reply-to:From;
        b=YbR3L1enVLq5ZaRfsEnSqSPMDplJyVixP/skM+hJ3ek1fRySocXdxtGG6klgx44QT
         pIURdqj5OArK93keVZnZeeJI53v3hnsI+txoQ/qM8UplvfJ1aofRM0onAc3grmOhDA
         veBXTtKBSkwkq6elouRVtM6xRAzcxMjJd7N5CW675lCx78UWjhUBmnLvuW/vzBeU6J
         QBwR42KkNAU4NPj5BblXwPwK0Ylou/LS5F+sN4x3r0wq1/U2IUcoTzetF9Keg+1uy9
         uEEFx8OkTI0+kBaM9+zJVgUr4dpK76XtFf4QrhzsR+BTJoP1IYcfLijS+KLdfKC/mv
         ERpuLamhA8hAQ==
References: <20230214090728.1737140-1-arnd@kernel.org>
User-agent: mu4e 1.8.11; emacs 28.1
From:   Robert Jarzmik <robert.jarzmik@free.fr>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Robert Jarzmik <robert.jarzmik@free.fr>,
        Arnd Bergmann <arnd@arndb.de>, Mark Brown <broonie@kernel.org>,
        alsa-devel@alsa-project.org, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Input: mainstone: fix pxa2xx_ac97 dependency
Date:   Fri, 17 Feb 2023 22:12:16 +0100
In-reply-to: <20230214090728.1737140-1-arnd@kernel.org>
Message-ID: <m2r0uoj8rm.fsf@free.fr>
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
... zip ...
>
> Fixes: e217b085a1ac ("Input: touchscreen: use wrapper for pxa2xx 
> ac97 registers")
> Fixes: b401d1fd8053 ("ASoC: pxa: remove unused board support")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
Acked-by: Robert Jarzmik <robert.jarzmik@free.fr>

Cheers.

--
Robert
