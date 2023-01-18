Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB6E672B56
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:32:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229830AbjARWcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:32:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbjARWc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:32:29 -0500
Received: from mail-yw1-x1130.google.com (mail-yw1-x1130.google.com [IPv6:2607:f8b0:4864:20::1130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFF9B5CFC1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:32:28 -0800 (PST)
Received: by mail-yw1-x1130.google.com with SMTP id 00721157ae682-4e4a6af2d99so1768317b3.4
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:32:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=iR2rhrTSMYK9PDj2icFRUKFemo5k3GYEy4vYgABVWBA=;
        b=mixoZB3XxmmwB+248ZOx2zNjqNP3syHPWQOlCKWGblxckFWMjSkBVb8eywGZvwRUBH
         2cwxPpzrbeiHAIZfMqIXhTAdpWS0sYi+8waOYFI+zh2X6q6AqS8hKxWPE5lO17MoE2bx
         u93UNmBAkcQAsb5eRWo2mt0ca4/WXqAUfgOQiHeWj1VqyyIctf5GrACBkukpyVikFrNr
         qFVgR7FFMN2D+FFf+aDQ/I58WFeHnaYgPN+xgfKgxSDuiYDMhBBXSCxILdPU5vPbQN7K
         KxGwEaWV1/Fs0wPKjPnVXFvsK+KXS7oRs1S2ibwZ5/zcr/2rqij2f+S0plYKkBo7VCop
         7H6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=iR2rhrTSMYK9PDj2icFRUKFemo5k3GYEy4vYgABVWBA=;
        b=dvVG7fYJurlRrmoYQfO1mKLBg6tcrTy2ejlmcwT977tGXqaPcQnIHaqhBNNpXvhKOB
         6rAX/T+PuqkC5Jq7/exexYKyRCS2JAyhN9OnEkgvXG2TZBXhz9aGZW37zE54OnRWIa63
         P6kooq0EaxP1am2GAXHvnF3zUdmtrS4c8w6jB6H5AIZOZrYKuSyyrekY1fxP8h3K8VEB
         dXZBQhsQ/dG37GiIr9Un9HVQ/Bag2iH98I0Ui3djO3pLJycDWtGc3t11RAOpZSgW1LzE
         38xUohBYxlaAXZG9zVQhFi0VBtllomyZcy2H9nYJTKKm1xBGi9BzdDE+Iy570tN3PVVI
         OAbA==
X-Gm-Message-State: AFqh2kpSKFmz2QOgf8hGOmkRUeE5D09Xmux95AaCVflSDe1/osh3i96H
        QuNM2icjfIKT5X49oo9azHDI3uPpwCArGHUs4D7gpg==
X-Google-Smtp-Source: AMrXdXthNU+N2HysXSnoWkZV1WoH8vtXfPtXO05j8luFV1F0xquuRFfbj1CWJAKa2gVJWtkVD+77IuheHg/Ii70YLyw=
X-Received: by 2002:a0d:ce43:0:b0:474:b3f2:8df1 with SMTP id
 q64-20020a0dce43000000b00474b3f28df1mr999564ywd.434.1674081148032; Wed, 18
 Jan 2023 14:32:28 -0800 (PST)
MIME-Version: 1.0
References: <20230118161110.521504-1-arnd@kernel.org> <20230118161110.521504-3-arnd@kernel.org>
In-Reply-To: <20230118161110.521504-3-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 23:32:14 +0100
Message-ID: <CACRpkdbO9-GioRumc8tOZ_NjUQUQ2JN2R2sJpRou4kbucmEWaQ@mail.gmail.com>
Subject: Re: [PATCH 3/5] ASoC: ux500: remove platform_data support
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 18, 2023 at 5:17 PM Arnd Bergmann <arnd@kernel.org> wrote:

> From: Arnd Bergmann <arnd@arndb.de>
>
> The platform data definition for ux500 sound devices was removed
> six years ago after the DT conversion was completed, see commit
> 4b483ed0be8b ("ARM: ux500: cut some platform data").
>
> Remove some leftover bits in the ASoC driver and just assume that
> it always gets probed using DT.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
