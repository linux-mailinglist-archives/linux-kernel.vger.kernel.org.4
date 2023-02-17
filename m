Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E290869A684
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:04:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229765AbjBQIEv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:04:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjBQIEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:04:35 -0500
Received: from mail-vs1-xe2f.google.com (mail-vs1-xe2f.google.com [IPv6:2607:f8b0:4864:20::e2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4D895EC8B
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:04:19 -0800 (PST)
Received: by mail-vs1-xe2f.google.com with SMTP id k6so4776696vsk.1
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:04:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CpxtOTmVR2iXHq4ntS7OV0jJ3byBq2V6cwWSHKeYass=;
        b=E/vIuU9ySLKJMhuGEau90zQBSG8SlHXkZF8yV3yS2kyxvZ4J6navODNrBOLVYMXgRs
         Ox62VC5OKcy1I/E3Uxu67J+4p3RLdNmXa4/5RjPnQtGjv8Ji7+fkzUpbvaec1bXgGk41
         t81KFoQ4wjoT8c4wmiBMfHEvM4VzhaNMRxm2U=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CpxtOTmVR2iXHq4ntS7OV0jJ3byBq2V6cwWSHKeYass=;
        b=xX6Q57h9JwFHzO/DzlJ7GcEgIHVs7zzXzSeFGwD/JKNfoW3BD3nnR9BMVsHewh6wEP
         xUJtg5nDAE4CEzDkBIZBaSMyjslrPh+wtdFSUs0vOfb0HXl4bzB1Eo0rFY+XEustL/h2
         MuMYzw1WiTxYHD8BIHtHHzWpyK0Lg7n3hhbUV9UdnsTALRQKal5wARriKkEEoaKBSZvi
         40hpJ0fnPqu46e7W7G/limc9Njo54tQ+br1kdLaYwVuw9Hkt7FZtB16ZlUc+TegikJ/P
         Q+ASMeLTgWWXLVhIMrt+8JI+mIBiUMO2oae+epR+eb9yw1Ne0zqnUnxTqEDuDZbc2twj
         F2WA==
X-Gm-Message-State: AO0yUKV9Q9KB3zGupToPM2gv6+/PAc3qGJIm0A0akOHFL65np9papTvA
        mXYTyvK7cPtJHng54kydTigFJyVP9RrEvLDzobrLjw==
X-Google-Smtp-Source: AK7set+3G1On2xvJPdWW5BJlN2FbGevzUL/1abRBSCTHO4z51cXzRqmejg/kYU+jflz2dX+3jtTcJOE5uEtw71QLDKg=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1615105vso.60.1676621059003; Fri, 17 Feb
 2023 00:04:19 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-48-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-48-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 16:04:08 +0800
Message-ID: <CAGXv+5Ffsf8bO2HemdOhmEwHtYwm9B+pRKMr0URc6bkY9Btr5Q@mail.gmail.com>
Subject: Re: [PATCH v2 47/47] clk: mediatek: Add MODULE_DEVICE_TABLE() where appropriate
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     mturquette@baylibre.com, sboyd@kernel.org, matthias.bgg@gmail.com,
        johnson.wang@mediatek.com, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, daniel@makrotopia.org,
        fparent@baylibre.com, msp@baylibre.com, nfraprado@collabora.com,
        rex-bc.chen@mediatek.com, zhaojh329@gmail.com,
        sam.shih@mediatek.com, edward-jw.yang@mediatek.com,
        yangyingliang@huawei.com, granquet@baylibre.com,
        pablo.sun@mediatek.com, sean.wang@mediatek.com,
        chen.zhong@mediatek.com, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Add a MODULE_DEVICE_TABLE() on all clocks that can be built as modules
> to allow auto-load at boot.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Looks like every file applicable is covered.

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
