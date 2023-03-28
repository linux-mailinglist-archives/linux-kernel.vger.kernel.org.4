Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 950926CBC4F
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232277AbjC1KOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229654AbjC1KOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:14:37 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AFAB9F
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:14:36 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id bt19so7621876pfb.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:14:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679998476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bI+U+ehMV2RvQbwwRI06yiYeDzyczR8dE8YMosw2Qms=;
        b=SAfF/Gkc1U8nfkCYo0+4vWHXLooj8t0GdvqsadZ7Li3uWjZcWB6EhmOlHzueIq66We
         N8YTdy99Zi8XstviZtESzDC51odxg+qHQhBlG7/XgooTES7eMKpL7bsQk/Vll8YjuQvH
         g8xMLn0XlxErtncnM2wB2ndQIku1xIAAPxleYSnXpegg1HzVE9uBd2rmw7EdJ+46BMgw
         +3QqsInNOLUfl2MTIac1ykKpZ43xlA3cXyHaY8KxaeZ2ReaEou3dTnXJKjCz63N3LgLt
         EFkZzYsLjvmqPN/GkLjoYSSM5UW59xp0JAA3Vu3ylhvcew7CxYmlg6Dd5aofOZuAvsFG
         ytCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679998476;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bI+U+ehMV2RvQbwwRI06yiYeDzyczR8dE8YMosw2Qms=;
        b=UqafkUkgSym2TW7zjybxGs8CTIQvsoiCOS8h8cdiiRByAY0HSBRs+FO3yOIl/KbN+b
         iF9pWmSN+GklIJmsQbhpuF58U5LObLQx6efipZ9W7NdKqASzw3c6M82wPXy5fBgc1AwI
         1yrfPc5ddbKlvip+4w4k8dS4a0Q4v1iwgrenjjEGTo36ltVhPfRibSdlXWHgNuXfT9bk
         ul4f3dcFVHylqlj5lEDN3EjWEFa8BzcEu4A+l4IHiK2cUq0+NUal/tVrVWEdj5Cq80EX
         T8YZDQkjS4Wolc2YGZD0iIHbpQpxy2ZGRyy1de7xDwWWDK2VfwtE/4o9Pe85ZpXzCiMk
         p3wg==
X-Gm-Message-State: AAQBX9fVyJrh8GoqPRch2NkDBWhDfIt9XUVKRvmVd/fwfTwN94f8avoI
        4jUZ2tVB1g6gQUGPb9Ht33uk1zdnkKLHW5NUYY8=
X-Google-Smtp-Source: AKy350ZUZBqKKUiNoPhDywIt+GDtRl06iL706Fqtds6uxbxpvkyM0mW+3yr+9dcBEHSb4zI4Oeb5sldbwDwyHoB9Opw=
X-Received: by 2002:a63:ef0c:0:b0:50f:aafa:6bc9 with SMTP id
 u12-20020a63ef0c000000b0050faafa6bc9mr3885956pgh.6.1679998475847; Tue, 28 Mar
 2023 03:14:35 -0700 (PDT)
MIME-Version: 1.0
References: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
In-Reply-To: <20230328100531.879485-1-u.kleine-koenig@pengutronix.de>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Tue, 28 Mar 2023 07:14:24 -0300
Message-ID: <CAOMZO5AHrXrJZJ2NY3GN56zf=meA5r3rWpD7GVuszBL7zcye5Q@mail.gmail.com>
Subject: Re: [PATCH 1/3] clocksource/drivers/imx-gpt: Drop unused function mxc_timer_init()
To:     =?UTF-8?Q?Uwe_Kleine=2DK=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Uwe,

On Tue, Mar 28, 2023 at 7:06=E2=80=AFAM Uwe Kleine-K=C3=B6nig
<u.kleine-koenig@pengutronix.de> wrote:
>
> The last caller is gone since v5.10-rc1~28.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>

I have already submitted this change:
https://lore.kernel.org/linux-arm-kernel/20230307124313.708255-1-festevam@d=
enx.de/
