Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C725E9A2D
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 09:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233981AbiIZHJV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 03:09:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233926AbiIZHIv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 03:08:51 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41C2B2A726
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:07:41 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id bj12so11971980ejb.13
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 00:07:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=11G5wZe93PJcN4JPjI5GurXGIszeTe2Izd0qLhIMjI4=;
        b=VQjC7cLYYYcFa55Oh12+okpceJgr3GoMc/hc+3LlMkfQNrwFafuuNcGoQOcncBpS4M
         fVz/hBy92bmiRXB/J5/+8rXsz3DQrePRddqGPLr7uIdhJFccYgikCVNkdZntfEPjOMNe
         jBGUu6fBx2RA1dy/xubugdWFxtHt5Pe36MNrc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=11G5wZe93PJcN4JPjI5GurXGIszeTe2Izd0qLhIMjI4=;
        b=xQFGcbHgyqpjV4tr3t6gNuvM9c9NwrvaY3GkVkDwbeT2vzwWA40ENDQu/8aWg+HeiR
         EWR09AlpFYHge2cn/Z4C+NjbVvryPJKMTLFxWwQbl/eAmUmWRyote3AX1bpaE4/z66Hk
         NUVQSQRZlzrhAq2EkF7RflKqeOtfdMUWhL8RbEecfnPpFxU32Vg+K+hWbpLEMb4+VUmn
         Oc/LmBpJCP01+NRsQqgov0MedNMt0oxM5tc6ETeKQtigFaf33Fq8txc2HqOh4kN/hMGO
         EjaO3P1jiL614CdGB125bz2dW2kZqFKkbTgmGbLT/Q1PqE8l5yJLn25AmZiZCWia1Onf
         wNLg==
X-Gm-Message-State: ACrzQf2HUbKvFC9BvSABQz/at0hllCBaprG1HcvTNOwQnxeBngJKY5Hl
        1sViQ7Pp9At2QwQkl13c115QETBjmd+MvTU2n7w+5w==
X-Google-Smtp-Source: AMsMyM747L8SdOtTBm0A1vuOwUIlVvdgf67xu2aLQMPPNr7+JeF3ZNc2Rh6l6SziBDn5+0MBtn+Sp0uZ+FtdD1hcNHE=
X-Received: by 2002:a17:906:770d:b0:73c:a08f:593c with SMTP id
 q13-20020a170906770d00b0073ca08f593cmr17590088ejm.182.1664176059865; Mon, 26
 Sep 2022 00:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20220813083249.45427-1-y.oudjana@protonmail.com> <20220815121957.hmdjsznp4zj2ijmh@blmsp>
In-Reply-To: <20220815121957.hmdjsznp4zj2ijmh@blmsp>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Mon, 26 Sep 2022 15:07:28 +0800
Message-ID: <CAGXv+5Gzd7qA8_4-kZLw=iyhvVVWK1CEKaG5tLYUtDzaQ7-1DA@mail.gmail.com>
Subject: Re: [PATCH v2] clk: mediatek: gate: Export mtk_clk_register_gates_with_dev
To:     Markus Schneider-Pargmann <msp@baylibre.com>
Cc:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Michael Turquette <mturquette@baylibre.com>,
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 15, 2022 at 8:19 PM Markus Schneider-Pargmann
<msp@baylibre.com> wrote:
>
> Hi Yassine,
>
> On Sat, Aug 13, 2022 at 09:32:49AM +0100, Yassine Oudjana wrote:
> > From: Yassine Oudjana <y.oudjana@protonmail.com>
> >
> > This allows it to be used in drivers built as modules.
> >
> > Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> > Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
> > Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>
> This change overlaps with my patch [1], I added export symbol for more
> functions as it was necessary to build the mt8365 clock driver as a
> module. I will rebase after this one was applied.
>
> You already have two reviewed-bys, but if you need one more, here you go
> ;)
>
> Reviewed-by: Markus Schneider-Pargmann <msp@baylibre.com>

I've queued this patch up here [1] and will send a pull request to
the clock maintainer later this week.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/wens/linux.git/log/?h=clk-mtk-for-6.1
