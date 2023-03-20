Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 777D66C1A15
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 16:46:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231807AbjCTPp6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 11:45:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232983AbjCTPpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 11:45:40 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A67FB37B6F;
        Mon, 20 Mar 2023 08:36:03 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id y4so48444156edo.2;
        Mon, 20 Mar 2023 08:36:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112; t=1679326562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L7O9sQEBEyADAKShtHU/SV4p9FNZJbLKQq8Lw4CGcFY=;
        b=BE6GpoyPw/AtySquV40eHJgpL6SWYMenmYeYMtclwKiXWHVXC9JA+1/Gxrb3tRXE2e
         mNLG6v+SbrTxH0SjFNiidBlc1dG2gIEVMRLo/QATdLrNyk2/m2UtzyEEJ2aO1mSnLiEK
         xlqlAs6KgNI6qc2pV8iZjzUCSmjDp5ebWTXKQh800VGtbci9onYhEVblyftUBDkPDWnh
         ntskMDf5QBsqXI3wfTi/2cdsoO2xnjuQyUHy4N4Qrgv2ZXCo3tnEBiQOwNVeAEYzIAk1
         7tlXARNcqsM/VOOFigg4VX+5tQVJOS0eWYlyerqoWLNXzWJCy+qbt7KPu4ut4NNevIs+
         QN2g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679326562;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=L7O9sQEBEyADAKShtHU/SV4p9FNZJbLKQq8Lw4CGcFY=;
        b=nz+GZvCS64Ifgc0P77dAct0j4uFOSDITKN8qmq9BZGEi4T7u0wBPfEoF/1nuSlcjzr
         TE1bL3Mo8RQY5b6W/MDq2qHqVjc83fD2+Ph+LLhlp6Nem7+YY8WWe8nKeOLSWDw9Reyj
         xC3flT5x91gxbMDa9QT8DBhnfZYHeJqxOvxrLyppqvzAMPukLNalVt9KkmPwcbySC9fp
         CweE/ln1mAkNkXTs3ZCOW6Dk1N+9BRFqffj2KP/TzaDcKZgGMPlN6IyyYIVYYdldK1du
         WdE1WCziM2c54O9dgk6jWixibFgSn7eEj1UMsda6CE9FlBvj7GZKNh15Y9zGNBj6B3In
         zoQw==
X-Gm-Message-State: AO0yUKU1wtgHgorqJs1eK8OwiwzoVEvCcwT/JVUe3lGwByTZo6zElDYI
        O1XvbbMOknYB2w0r9WJ68wh/oT0Id4Qi9Efxrm0=
X-Google-Smtp-Source: AK7set+uH28cMFUpa6epWEpBR3ODSq1DYQPiF68MjOnhPNWsv1RcqqFuNC7TRJTOxtvfIB6B1/dwSy8yOuTgBc4MgO4=
X-Received: by 2002:a17:906:3e1a:b0:930:90ce:a1a6 with SMTP id
 k26-20020a1709063e1a00b0093090cea1a6mr3861875eji.6.1679326561903; Mon, 20 Mar
 2023 08:36:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230320113445.17260-1-yu.tu@amlogic.com>
In-Reply-To: <20230320113445.17260-1-yu.tu@amlogic.com>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 20 Mar 2023 16:35:50 +0100
Message-ID: <CAFBinCAE-ihq9oeXc=GqUEHVKUYM+n_e+2_5+gDMTGQcEEhRtg@mail.gmail.com>
Subject: Re: [PATCH V2] clk: meson: vid-pll-div: added meson_vid_pll_div_ops support
To:     Yu Tu <yu.tu@amlogic.com>
Cc:     linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, kelvin.zhang@amlogic.com,
        qi.duan@amlogic.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yu Tu,

On Mon, Mar 20, 2023 at 12:35=E2=80=AFPM Yu Tu <yu.tu@amlogic.com> wrote:
>
> Since the previous code only provides "ro_ops" for the vid_pll_div
> clock. In fact, the clock can be set. So add "ops" that can set the
> clock, especially for later chips like S4 SOC and so on.
>
> Signed-off-by: Yu Tu <yu.tu@amlogic.com>
> ---
please describe the changes you did compared to the previous version(s)

[...]
> diff --git a/drivers/clk/meson/vid-pll-div.h b/drivers/clk/meson/vid-pll-=
div.h
> index c0128e33ccf9..bbccab340910 100644
> --- a/drivers/clk/meson/vid-pll-div.h
> +++ b/drivers/clk/meson/vid-pll-div.h
> @@ -10,11 +10,14 @@
>  #include <linux/clk-provider.h>
>  #include "parm.h"
>
> +#define VID_PLL_DIV_TABLE_SIZE         14
In v1 you used ARRAY_SIZE(vid_pll_div_table) wherever this new macro
is used instead.
I think using ARRAY_SIZE is the better approach because it means the
references will update automatically if an entry is added/removed from
vid_pll_div_table

Also I think there's a different understanding about what Jerome
previously wrote:
> It would be nice to actually describe how this vid pll work so we can
> stop using precompute "magic" values and actually use the IP to its full
> capacity.
From what I understand is that you interpreted this as "let's change
ARRAY_SIZE(vid_pll_div_table) to a new macro called
VID_PLL_DIV_TABLE_SIZE".
But I think what Jerome meant is: "let's get rid of vid_pll_div_table
and implement how to actually calculate the clock rate - without
hard-coding 14 possible clock settings in vid_pll_div_table". Look at
clk-mpll.c and/or clk-pll.c which allow calculating arbitrary rates
without any hard-coded tables.


Best regards,
Martin
