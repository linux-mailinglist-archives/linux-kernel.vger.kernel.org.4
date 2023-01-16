Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 929ED66BD98
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 13:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230212AbjAPMRN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 07:17:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229906AbjAPMRF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 07:17:05 -0500
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B40DF1CF5B
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:17:04 -0800 (PST)
Received: by mail-pj1-x1034.google.com with SMTP id v23so28943244pju.3
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 04:17:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WiDjPImFP/3NhlWJraNf85+Pcm+wTN124g/r+QcZ5QA=;
        b=m5ctym40YljO2q9b/kEqp8bBP56026lZc8mcVQzHmSAH5BCUvTgHAx1MmVLiieHNCY
         /PvOIgJlb3MnK7ic/jCOW3pzDByBJ6QSWi+NL0OchA2uqsugnst7O/rhqhyOy1orpkKY
         1vjowTMawfVwMB9hbFymPKaVNWnPCRJhdEU64IunqfyT0UoViTvBM7A/f2yHX78Kvywk
         BBHfxMBB/qpkHu1u8HefAX8UQK2d62HmrVlPUL6bTxsKI3dX0bXyTiyOgo1FSzlvgIZs
         JMrvt4185slG4raykDVdr6Bm8WpCye1nknE2R6Lf2H+ubGka4hQMU72blN3WTUcH2BFG
         MjnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WiDjPImFP/3NhlWJraNf85+Pcm+wTN124g/r+QcZ5QA=;
        b=KdJ4s0JT9kq0DMkLQntA9b0rhDvlSQuNJrlx7B//3MHOY8rntI3JmBIMq/krMuphQq
         3cFeSsbA4cGnzdgY/jzrEOfmKsA1F/najAvOq1Xc4Fqt0UhD5ex2rT+LIsXhbUtHhx2J
         Fr3HBuJaOa2DyIfAkzeqj+7qoC7RdPZiyMzXcbh8RxkKA+m//mU9A5eIQ+E/CX4NtYuI
         QBAiVQxOfoUSdUQyvkIVlH9tKcl1IvxlIX7p+QOEkDk8zn6RG/V0YKfT32qIIyFvMVmo
         kOiYyBSs4h79fAp3PRRK3kBsavcedSdMtvdstul8C0PuDyrGo+QYdKMSPOD7d3aLyR5z
         HVxg==
X-Gm-Message-State: AFqh2kphmeGfVy3LJZ30NaHISdztw9dCPGn1H+UezgC7Gq3VtHghiI0c
        cbsJgzNQ3/QDMllfuaUcP3UBpOEodTnPWbHL4s6/7w==
X-Google-Smtp-Source: AMrXdXv+v7rh2S4hgSP52Ss1lcKL8Es8wj8wKgX4qenrftmbItiz/1omsR0u0yN0zU8hS0mlxhlA/XBcLDCiXFas5X4=
X-Received: by 2002:a17:903:2cf:b0:192:9d79:d3db with SMTP id
 s15-20020a17090302cf00b001929d79d3dbmr883572plk.129.1673871424232; Mon, 16
 Jan 2023 04:17:04 -0800 (PST)
MIME-Version: 1.0
References: <a650c8b930a30f5902f4fcfe23877314d098abde.1672763862.git.geert+renesas@glider.be>
In-Reply-To: <a650c8b930a30f5902f4fcfe23877314d098abde.1672763862.git.geert+renesas@glider.be>
From:   Ulf Hansson <ulf.hansson@linaro.org>
Date:   Mon, 16 Jan 2023 13:16:28 +0100
Message-ID: <CAPDyKFpVfgv_31tMF3JMzK9qXO1OiN5LRxxym=ajGVefygoVYw@mail.gmail.com>
Subject: Re: [PATCH trivial] mmc: sdio: Spelling s/compement/complement/
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     linux-mmc@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 3 Jan 2023 at 17:38, Geert Uytterhoeven <geert+renesas@glider.be> wrote:
>
> Fix a misspelling of "complement".
>
> Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>

Applied for next, thanks!

Kind regards
Uffe


> ---
>  drivers/mmc/core/sdio_io.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>
> diff --git a/drivers/mmc/core/sdio_io.c b/drivers/mmc/core/sdio_io.c
> index 79dbf90216b599c7..b774bf51981d05a4 100644
> --- a/drivers/mmc/core/sdio_io.c
> +++ b/drivers/mmc/core/sdio_io.c
> @@ -766,7 +766,7 @@ EXPORT_SYMBOL_GPL(sdio_retune_crc_disable);
>   *     sdio_retune_crc_enable - re-enable retuning on CRC errors
>   *     @func: SDIO function attached to host
>   *
> - *     This is the compement to sdio_retune_crc_disable().
> + *     This is the complement to sdio_retune_crc_disable().
>   */
>  void sdio_retune_crc_enable(struct sdio_func *func)
>  {
> --
> 2.25.1
>
