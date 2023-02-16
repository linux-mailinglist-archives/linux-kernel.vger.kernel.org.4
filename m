Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BB6B699299
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:01:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229597AbjBPLBf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:01:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229828AbjBPLBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:01:31 -0500
Received: from mail-vs1-xe2a.google.com (mail-vs1-xe2a.google.com [IPv6:2607:f8b0:4864:20::e2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CCA2125B3
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:01:30 -0800 (PST)
Received: by mail-vs1-xe2a.google.com with SMTP id v16so379334vss.5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:01:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=BdECL0nWuOhxxQUzq/mcwRUPnRSLFDs596FGLIMR9pc=;
        b=Y2oOU8cyEJwEh700yB/7z2QJu2Bcxy3bkWsnI1OtkkcuKXE0+3Uil6KfV+8akOLw8y
         to9XpIffITAWrGVJ0oUrBWYHYBUFRD37sLkmgWZFGT56TJjoSmMYDTrAvaFvPeh1o22S
         BUny0HCn9pdX8tD1l1xOcUydoBcifTNPBDp8s=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=BdECL0nWuOhxxQUzq/mcwRUPnRSLFDs596FGLIMR9pc=;
        b=I8m3jWcsrkIUX48i1qTdO13YPp7snmazcnaL+Nd/rbybMDBBw/X5j18ndYnxfPeCc+
         Upwokdf8pJSN8qGVpKp4hZHb+OhYRdw+gI47BDN3q++9avjhZd6NJDILvh6GPh7Yi2bY
         Ngw293wIdDsanKnuT89NwU3ALVIMxdOMy90PLqDVI8vEXsPhzQ08WIXb728eG14PPRWz
         kh/KemrEw1X653572FxNfHdFhlJIcubyswfBmHwv6TQAJX1wCXNw5Ll0o4kC4QfUB7SI
         qFzkmtSLOxWo8FvI1IwDgQEagKAy5OpLMlSmHbKykolIL3CZ/flqH/Njn1kHkyM51l8s
         fa+g==
X-Gm-Message-State: AO0yUKX1uvyW6da3E1QqbXuE6zleT2tRLw/yuTrJ690faOnLP2n9JyU0
        QEs4J9fqOwSjPqO6m35ZJbHzPQvLWvJwk87tfqB+yg==
X-Google-Smtp-Source: AK7set/IA9hmi0kwDAgoklZpazoBjsCfVSxcouOI1lZeu5WRYfZai2E2MPhF1VyHs6yD9YxZM6pQqZxHx1mPiUZlaKw=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1015471vso.60.1676545289161; Thu, 16 Feb
 2023 03:01:29 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-29-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-29-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 19:01:18 +0800
Message-ID: <CAGXv+5EhnDu-=hnyDZoYMBgQhLPpyP+TYgt+hsXVHz49P61KFg@mail.gmail.com>
Subject: Re: [PATCH v2 28/47] clk: mediatek: mt8516: Allow building clock
 drivers as modules
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
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 14, 2023 at 9:42 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Now that all MT8516 drivers have been converted to platform driver,
> change the configuration options to tristate.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
