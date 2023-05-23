Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED2E070E254
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237802AbjEWQsa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:48:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237806AbjEWQsY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:48:24 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0175F120
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:48:22 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id af79cd13be357-75764d20db3so6371385a.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684860502; x=1687452502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Xb114seolUoLD2d2CjUPyFP0YTke/ucO4/H0ScpgceI=;
        b=f4aGH+Csa1rBuRxhj5RYm64cmR9e8C8qCJUKxnWxu5nUwb+D1jJx29ffXm1k+072Dt
         AricUXLjD40f0PIaW/9dhS1Mil/HH/QZu4RwpCaAi8hT3x86bGL110zVC012mvEV7qRm
         1VVch23Z5YdZOdgAmPrnPWCuTmVK6uiuSj9l94EfBfBnLXhihJ3AbMTDHNQwUcxuunsL
         /VXNlDgBVMS6WtNWrQRbA/fCjpjk23b+gLNz4nBD84qxyDnoBNZ5Lvfw3tiRXC9QORVO
         tRCjcVJQqgetFNsPeKkKHpmUYtg9r389ldZ1ISiToFSvBk621ZxE3Vw6puAVSbijju2X
         b9QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860502; x=1687452502;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Xb114seolUoLD2d2CjUPyFP0YTke/ucO4/H0ScpgceI=;
        b=DZK/sU0iJE18CZz2XG8+BZTAEI4JUMWRjvEO+PBqJTHwAeehlDaE9jx//vogKMHlWD
         upWui9kvGD33n1ETWYQ8t6Ju9ZddgYaHGX6mIMte1Pe1/JftY7guGqw1IOM7BjFRlQDl
         XIDp9WGXKR2/SBJGtWjHDrHPt/QaO79pyss6UEsJgWNetP7jAP88Cebv8I4ZP65MuTxB
         buI62bo7Ae2YzuaHNFXYiBK3ecska7/eO4cCyFmcIKwAlmgVX+aFp5mwmZK0EkQK13qj
         ME/Lc3N/0htCo8kBjmznnsgyy6OKWbjazGsIih9ApbjmGtqDugK6hNTM2o/rzzqDoBoM
         YwJA==
X-Gm-Message-State: AC+VfDyydbHzmSNvoZC4OkX3ltHMQ09ZeVENTwWfGF4xC8nvMsuOX8xP
        DTzOcgPcTagdv7PrNQaCZW/CT/Wx6ylXCRth9ww=
X-Google-Smtp-Source: ACHHUZ5M8WhAbQb7U1iv+oD8d7fAKiFP8impEVhXDAkLek49q03l6iwZcXiHhy4Jef9pL8DesPVVN8d1mGts0ePu/pY=
X-Received: by 2002:a37:bcd:0:b0:75b:23a1:442 with SMTP id 196-20020a370bcd000000b0075b23a10442mr4566841qkl.8.1684860501365;
 Tue, 23 May 2023 09:48:21 -0700 (PDT)
MIME-Version: 1.0
References: <587f259fb8634daa268595f60fa52c3c4d9bbec2.1684854090.git.geert+renesas@glider.be>
 <96def590-4ffa-4201-a1b8-0ad2c8ec718e@sirena.org.uk>
In-Reply-To: <96def590-4ffa-4201-a1b8-0ad2c8ec718e@sirena.org.uk>
From:   Osama Muhammad <osmtendev@gmail.com>
Date:   Tue, 23 May 2023 21:48:10 +0500
Message-ID: <CAK6rUAOfNT6EovuBse+C8uvgNOybmjx=cu8o5mzvhYn=2ytHRQ@mail.gmail.com>
Subject: Re: [PATCH] regulator: core: Streamline debugfs operations
To:     Mark Brown <broonie@kernel.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Liam Girdwood <lgirdwood@gmail.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

The patch to Fix error checking for debugfs_create_dir has already
been submitted.
Here is the link to the patch :-
https://git.kernel.org/pub/scm/linux/kernel/git/broonie/regulator.git/commit/?id=2bf1c45be3b8f3a3f898d0756c1282f09719debd


On Tue, 23 May 2023 at 20:17, Mark Brown <broonie@kernel.org> wrote:
>
> On Tue, May 23, 2023 at 05:03:58PM +0200, Geert Uytterhoeven wrote:
>
> > Fix the error check on the return value of debugfs_create_dir() in
> > create_regulator(), which was missed before.
> >
> > Fixes: 2bf1c45be3b8f3a3 ("regulator: Fix error checking for debugfs_create_dir")
>
> Also: this should be a separate patch.
