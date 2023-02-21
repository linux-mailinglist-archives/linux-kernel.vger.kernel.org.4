Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEED569DAFC
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:13:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjBUHNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232622AbjBUHNO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:13:14 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4CF9824104
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:12:59 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id 6so3458530vsv.7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:12:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676963578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HdJzFq7jufeOqCgSl9+xQrgy1RmhMxPxNMg0cBhlhbs=;
        b=QTtP++qdraIvmGcDg/G0yedBnkO5aUr696nf4kJjEqynqHqqP1t1I/p6IiZYtEH0iP
         VEp0HA85edRMoW1PVhjW9VC9yXpFVoON2oi71egsP3qCJFyVBnQXc0U2LfolYtbmKL+D
         kqRBypDclfnAfqZYidJkUoJrXGOFeBpLaxeC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676963578;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HdJzFq7jufeOqCgSl9+xQrgy1RmhMxPxNMg0cBhlhbs=;
        b=d90n0Ry2i4XJceA+tk/7BSWnPRP+PmT+j+LO3hKkJGF6GceRaBzVx7tQIwK7w96TyF
         Evs2StnKx++honKBsOdzc7VKyshebCIfQG08WSxhY261hs2Dnm94oGN6h92C/nTnC2Bx
         wN6JCo35DUaHv2TXQuE2yPu4TPFPeM93iyIn/ARwxx3zsPcMaRmMy0T7CeXCewqzDIzN
         fXv32PnpOODzwdgFIg7pwBqU3zUE4kq4t5CKU/61Xn9Sc+Q/qLRXltxEGszblAG/16Yw
         HrcwXcReWlOdrMWge3xixwDovzEX+WlVajO7DzAbOLeIeY2BryYb8Z2ZuCWq3CxPrA5p
         yGoA==
X-Gm-Message-State: AO0yUKXODux4ErCcRf+zDt0MLhu8/cidCsJ4sirCgoAYzajP4IGdy/3V
        rnA+muVT3zGy7huxz4lNHm7T4W85LERSgMMmNvqRtQ==
X-Google-Smtp-Source: AK7set9LDiQDEkH3XQ+jZqO1icouR/ex+tykAQ7KVNOAzfsDipi4GTynjIqgeAiSU3oARM6Z7LKriycFiF6nuUE0L+4=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr907948vso.44.1676963578806; Mon, 20 Feb
 2023 23:12:58 -0800 (PST)
MIME-Version: 1.0
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com> <20230216130021.64875-8-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230216130021.64875-8-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 15:12:47 +0800
Message-ID: <CAGXv+5ELyqF+p1Z-m52CkV92nQ26Y_-uvBx_BetiFU4X4oyt_A@mail.gmail.com>
Subject: Re: [PATCH v1 7/9] soc: mediatek: mtk-mutex: Use module_platform_driver()
 macro
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     matthias.bgg@gmail.com, jason-jh.lin@mediatek.com,
        chunkuang.hu@kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 9:02 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Replace open-coded init/exit calls with the module_platform_driver()
> macro being equivalent.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
