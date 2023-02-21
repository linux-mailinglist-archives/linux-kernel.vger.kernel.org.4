Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B668569DB08
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 08:16:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233538AbjBUHQG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 02:16:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50584 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233504AbjBUHQE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 02:16:04 -0500
Received: from mail-vs1-xe2e.google.com (mail-vs1-xe2e.google.com [IPv6:2607:f8b0:4864:20::e2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED3A84204
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:16:02 -0800 (PST)
Received: by mail-vs1-xe2e.google.com with SMTP id f31so3271217vsv.1
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 23:16:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1676963762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vbc5+PWjBMqqOs23vNflMUj0LpSmaqSkZSK7MLtQNdY=;
        b=cxs+VrB7WJHMk4oly9w7lBF4j83z/RT7TkHrzECW44Cfe1Cslqmlk4fnc9EG7a77pj
         jznKiD/o4QH3YFSTyke1HM7vXxIEYGu4VWWMxXbovTuQRAswbR/l7+fj+E8leXh9cpHI
         mvFKY7KDxf8CpIMp41TaVBMxSfo5Amkrmzpfs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1676963762;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vbc5+PWjBMqqOs23vNflMUj0LpSmaqSkZSK7MLtQNdY=;
        b=ukL2ajxDQm+l4aGEPFxczcOUqeRpthdrW1ntSpqULIEIEl7u1IcC7qoJFjG/oCWHkh
         hb7imsI/ej2YXSKJ1QkPio7db4co64krKw0i6Ndv2kpN9db3uq8L6RsRqGBgngGMBm11
         gV3Be7a5ok0ephuL9MxfWBtZtDienVwFyWhD1xy6+ACWEdgyvAvAcC1xqWI4DL8obEqu
         PlVwfYjhXG7+782qYQWw8Ibzs1l5kLcZ2O3jrwqPL8b2RFDQQjAI34HSInlPJfi9nMom
         tEgyUImwADz34s7mm6KkpNUFgTwGMQbA/rLx4P2TTADrhJL0eZNS2wd7Bn0OESRZnYr1
         LcEg==
X-Gm-Message-State: AO0yUKVmbhNmzX/a0YiixzJQIQJewqqMMCI+Tre4gqSvXInZfdhvQNZt
        +ZWV6dU5ZUnqNK/hPpFYB3YfvMj4Vq9al7viXkJjDQ==
X-Google-Smtp-Source: AK7set+4HmFRKdGZ8coYddQ0NEYgKqbmpjRUwDPjqAc30x8eIbR6ErTneTgm+HFMA4NKabjwWOVQ3MN4rQeplEurWXA=
X-Received: by 2002:a67:f6c1:0:b0:411:a14d:6bac with SMTP id
 v1-20020a67f6c1000000b00411a14d6bacmr909353vso.44.1676963762165; Mon, 20 Feb
 2023 23:16:02 -0800 (PST)
MIME-Version: 1.0
References: <20230216130021.64875-1-angelogioacchino.delregno@collabora.com> <20230216130021.64875-10-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230216130021.64875-10-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 21 Feb 2023 15:15:51 +0800
Message-ID: <CAGXv+5ErU3yZgDbcSZuwnPbkwD1NzhqwEvLThCeOLO2xRaV8CQ@mail.gmail.com>
Subject: Re: [PATCH v1 9/9] soc: mediatek: Cleanup ifdefs for IS_REACHABLE(CONFIG_MTK_CMDQ)
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

On Thu, Feb 16, 2023 at 9:03 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Now that the mtk-cmdq.h header contains inline functions for cases
> in which the driver is not enabled (either module or built-in), we
> can safely go on with cleaning up ifdefs for CMDQ handling.
>
> This also shows in a clearer manner that writing through CMDQ HW is
> optional and used only for performance purposes when/where wanted,
> needed and/or required.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
