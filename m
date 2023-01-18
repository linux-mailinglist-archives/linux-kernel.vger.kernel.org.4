Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D936D672B5D
	for <lists+linux-kernel@lfdr.de>; Wed, 18 Jan 2023 23:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230061AbjARWen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 Jan 2023 17:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230043AbjARWek (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Jan 2023 17:34:40 -0500
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FF535D113
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:34:38 -0800 (PST)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-4d0f843c417so1657847b3.7
        for <linux-kernel@vger.kernel.org>; Wed, 18 Jan 2023 14:34:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xJvYbw6U+K+0k8BLB+5FqLiyzX7FBCNqG4euLaaJvIg=;
        b=Gw0omF3rTcAXmt61uekjPSMgv7ju/jQkT+NRYfg9clCCKkBTEB23Evj839n2n8qoNx
         s8Y59LwroPq/lApwG59kNIt6F9v38rKdQRdeYCn4EcLgR2xAE1WUahiFZDjTbGuOsbYL
         yMDJWS0gyHaya9j7vNwSWnJbixaqTqy5xWGZRHjYJhefVMUHoMZ8bsX4pAL93frFHWpL
         YH8kcGWtkNgRG2/YmoUITscmA1Fnpqd7WmdrZkRCYyrazIKac/BIIbegNk7SX6Pb0bNj
         XBsP3S87RV2/SWpTohHkG+rxSMn5w9hGVhnGPDF+4CigzvO0xieBdBkTS0AogF02dkPb
         jJ9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xJvYbw6U+K+0k8BLB+5FqLiyzX7FBCNqG4euLaaJvIg=;
        b=TZUiHkzQK4ysQ/Ibxsu2VTXPl39HqwB8l+assQr6okh5jy9icJRXQhjzf/R8Rl2WrZ
         Wt8FW6yBqfl3l6ekXWqymjp+/Y+Z56LXjHccJHiOF8iv7mhGI0fMZK8W032s+6nA0jXv
         LoVBJRggPqn55df/0xXaemFk4mctaUcchckwUnkACdhIXQo+zCrIS8WRi4+RSzNoWwMq
         sHRTtzSP50tb+/9z+MS8GFDzlwrFPBRodhJ5wymr3Fyndpc2wdQiZcCU8gmVNyoV0xQ9
         xhDmfDt7LKRy8UMkKDZjckndg6K0ATPhkPy9xQdiVUmrupjc0RKCaUMXI9kOWuJjs8EL
         op4Q==
X-Gm-Message-State: AFqh2krQPIECr1uQQsyKXhwCwiXxI3OmovuRLRrTMjD1m14mbIAV5CfT
        SUrq40A9/xDFbaiuSBaqx2RFGnyww4ywjyMy3ZxpNlEuQKPVSg==
X-Google-Smtp-Source: AMrXdXsYvs9R4DumEh82QT8w/5J+EBP6tPUYo8vsrjxDEkR74vY+cmlmPYMXXZqlqcHX/KZpOQ1sN4+YM2TWY7PVyvM=
X-Received: by 2002:a81:4e54:0:b0:4e1:a40a:af7a with SMTP id
 c81-20020a814e54000000b004e1a40aaf7amr1150249ywb.273.1674081277745; Wed, 18
 Jan 2023 14:34:37 -0800 (PST)
MIME-Version: 1.0
References: <20230118161110.521504-1-arnd@kernel.org> <20230118161110.521504-4-arnd@kernel.org>
In-Reply-To: <20230118161110.521504-4-arnd@kernel.org>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 18 Jan 2023 23:34:26 +0100
Message-ID: <CACRpkdZhyL4tTP+=uDB9CfYKRgoKvqp-T+SUzg0YZi4r0Hxy0g@mail.gmail.com>
Subject: Re: [PATCH 4/5] ASoC: ux500: remove stedma40 references
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
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
> ux500_pcm_request_chan() is never called because the dma channels
> are already set up from DT. Remove this, along with the
> ux500_msp_dma_params structure.
>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Now I will try to continue my work on refreshing the Ux500
audio support on top of these patches!

Yours,
Linus Walleij
