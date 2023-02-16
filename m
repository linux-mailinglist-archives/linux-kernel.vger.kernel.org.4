Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19305699122
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 11:28:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbjBPK2F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 05:28:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229714AbjBPK2E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 05:28:04 -0500
Received: from mail-vs1-xe35.google.com (mail-vs1-xe35.google.com [IPv6:2607:f8b0:4864:20::e35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C4FF27D4A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:28:03 -0800 (PST)
Received: by mail-vs1-xe35.google.com with SMTP id g9so1410258vst.10
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 02:28:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=aC0UZCTaZwODqWa60Uyhp4WnMR7OWFiD7msBoAVkJA4=;
        b=htrWahqkdR7BI3F8kB0NkYMgKTrwmwm96JkeJku5UN773iiC76dr1Vuj3h+k3wxLuJ
         mlVpcoxw28S9V9xkApmJxmAkvQREJCSwGQYT37ZrSVK2YtqP2fiqSDkcD6iOkLcYHRl9
         oNWuBqSjy5fEClLHgaynPefkng2WmdqVsXmMo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aC0UZCTaZwODqWa60Uyhp4WnMR7OWFiD7msBoAVkJA4=;
        b=ct7eGAt2L+ed3wcds9GTo9GbpoJFeOr3INId3ZXenBH7aMFpiSQAL7CAclfzcRWJ7F
         P1bYsJkToshRmUBt1PmRnHg8dOuGfYfbtl6iE7rCC01KSjkOIcE9vKRoz3O+MH+6yxd6
         oVMn/MEbGn9MtiGr88Yv5nK1WxQVT5Fo9ZbOlr9jmy6+3nkkg0SIZqtSH2Z18yULbj4t
         8OacMeRqzZTq4Q9iBGfwPiyD+ZOyzPQ04sKZ33T7ovwCQflkr9/red7X8RqkZRtGJQAR
         Iz/P09QFD8kVIai/vUIqovwRwWq1KQ7Mmg5OavKBjU2EDdys8y/DDSr9rg4J8ha43sVu
         3UhQ==
X-Gm-Message-State: AO0yUKWohLEIY5s/keFJIylIRvfcd0aQFZKVTTWa3B8ZEK2N1l7UlWzm
        8Ge8EF0bdZSzFrm9RN4YVON77qOqsTW+ZrjjrRVxMg==
X-Google-Smtp-Source: AK7set9S1a9PnO5AlC0aIUcyuYB4GoqrIa5JQM3cAhXe6/vzdJZfyC8Ugb35qpq0pzDqN3S8b4loTS4XI5MfTKfgMT8=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1001620vso.60.1676543282237; Thu, 16 Feb
 2023 02:28:02 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-22-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-22-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 18:27:51 +0800
Message-ID: <CAGXv+5GqF=PN_ZTLAHtpbOQG7VhsGJmVu8x8zVMWSn5X7uQ93g@mail.gmail.com>
Subject: Re: [PATCH v2 21/47] clk: mediatek: Consistently use GATE_MTK() macro
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
> All the various MediaTek clock drivers are, in a way or another,
> redefining the GATE_MTK() macro with different names: while some
> are doing that by actually using GATE_MTK(), others are copying
> it entirely (hence, entirely redefining it).
>
> Change all clock drivers to always and consistently use this macro.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
