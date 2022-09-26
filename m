Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31E665E9A2F
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:09:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234014AbiIZHJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:09:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234004AbiIZHJE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:09:04 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E3A936418
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:07:55 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id y8so7670635edc.10
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:07:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=JSGq+UJdZHZI7m7+R4s5lT3YI7bcQs6FVi/cIp+srik=;
        b=hC8eV+FOx3YJcNNqaY+XiFeY+2Nqsm9G4oDCO/a+cex2r8/iNo8V94MyR+IcMynnfX
         Kl5WUO8utF3U3B4raqaM6u/9W9STCcBj2oGetI6QL7LwGTNwDYIpSf+/KaT/aCrtkFSN
         B29U+6SmA/saBUhyv552ASfMNEBcAX2n/OOz4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=JSGq+UJdZHZI7m7+R4s5lT3YI7bcQs6FVi/cIp+srik=;
        b=EMjREjWa2S8EPTTZLusqMtppJp1y/tbFGZdgrJs1ErXNTK/XGF+A3giX6x7PhpDRIm
         hmK9NnWdQaXSdYnz0gq8Zzi+22jNs7CBSFn7r/lNlPhBFTRO/GQX+/kosJbTT8Y6OXOl
         r5UTavGk61ZOzoHBGehIImP0u2DU+NwCQtwqtsZitdy8Pa8pOzz+1etpbwLUjtZfTaRc
         7vXTaxYdaWgPplxCQugYK3ALOUI1xzxEfvfLEhcA/EL/FhpDADZa5933xxBZm7NoMfYq
         J02p7DCf5UXYrxAap101MwcYB9ydxrzQD5p1wBersK+OQYt1i+YhkFwZqt46TjudSXob
         UZxw==
X-Gm-Message-State: ACrzQf1ioPqWeEt3GSvWQd6Mgy9Kewvdu1FPCjXBDciH8xN89ST8MdJT
        /X/jOKkg3pcPSC+bY55AE6ClZL08HroU7Cj7mHHojw==
X-Google-Smtp-Source: AMsMyM6jkTKiLKSqDZxJdnx4sI0Vk0Ohi0/4NFzL4mGK7QELlD/W4obOucDIKNq/Qv9RKu/hH0qBuRIpgRfNcgKh1sA=
X-Received: by 2002:a05:6402:90e:b0:443:ec4b:2b03 with SMTP id
 g14-20020a056402090e00b00443ec4b2b03mr20572019edz.71.1664176073670; Mon, 26
 Sep 2022 00:07:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220813083319.45455-1-y.oudjana@protonmail.com>
In-Reply-To: <20220813083319.45455-1-y.oudjana@protonmail.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 15:07:42 +0800
Message-ID: <CAGXv+5FZ2YKccJQQmALvu53y+z1X7REwY0MHm-WZ=A=gTCQ8CQ@mail.gmail.com>
Subject: Re: [PATCH v2] clk: mediatek: Use mtk_clk_register_gates_with_dev in
 simple probe
To:     Yassine Oudjana <yassine.oudjana@gmail.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Rex-BC Chen <rex-bc.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Aug 13, 2022 at 4:34 PM Yassine Oudjana
<yassine.oudjana@gmail.com> wrote:
>
> From: Yassine Oudjana <y.oudjana@protonmail.com>
>
> Register gates with dev in mtk_clk_simple_probe.
>
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

I've queued this patch up here [1] and will send a pull request to
the clock maintainer later this week.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/log/?h=clk-mtk-for-6.1
