Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C0E968CFE3
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 07:58:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229949AbjBGG6w (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 01:58:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229500AbjBGG6u (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 01:58:50 -0500
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F1B4F23C47
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 22:58:49 -0800 (PST)
Received: by mail-ua1-x92e.google.com with SMTP id ch22so344782uab.9
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 22:58:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=R5I8DVYK4b9McA/r3M/11XMbXDM1r/KOU7F9x3+nTK8=;
        b=i4IRGldyz7bsyO1yl+IwS+9uwH6TMyV3ZceFsE+hkKuyuOx0ipHR+mGOTj/7GGhHqg
         JEWMJKhl/Y0LbmgZVsPIr1PB5uzwtSDsxCwqa9Ay+JfcnsJnD4o7x8oQ/0RZZVdj7NGe
         /l4QjrMriXwrW86obfM26x68oowkuCTXt5VYs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=R5I8DVYK4b9McA/r3M/11XMbXDM1r/KOU7F9x3+nTK8=;
        b=1O2nuwRQ6YUNm6BImIcbk9rCtC3Bbypd94uK1DEXbuwDY/3hv9FqgBIlZ2xMZclipG
         kTZx8eDWayIPo/+PrUEcdaIH7MZ2odvHcgYsPiAlgM+O75ICcUObstYuTGri0miSHFYv
         egK+Fpf7uw2FYRT8gVZbt7MFujo0P1mFl0dLBQ9jWby3A8QwSJPcM9ky4O+DUCvrdc2b
         5HLW3ObAfXyqspTKMYH7cIuPEtsPFhgXbKwqZJXLGSb8mu9v2DCon1gApwhO/fpc8H3E
         06jvThBBhXgdIHsX1yUKG33sTbnBil5GcY4a5TBSS71HVUsRSI3f6tX0iBp78FnrFj1J
         ud5w==
X-Gm-Message-State: AO0yUKU3d21wUBanpxqJVffi3ESoHZcm4QYZiuBedJr3qX9hFXsf7nyt
        g2o5CYoB95lcYMR+GbBXmuhaN/+KM1epSVtqdQxf+g==
X-Google-Smtp-Source: AK7set+78b7Dxso6dKCLZowVq0wZELWdMYO62DUcepaqgTDKO3R5fnsrULG8pV1lDnlXoMYJn3L42i8V4EcTZgbjRSw=
X-Received: by 2002:ab0:2bd5:0:b0:5e6:3536:22e4 with SMTP id
 s21-20020ab02bd5000000b005e6353622e4mr378300uar.55.1675753129141; Mon, 06 Feb
 2023 22:58:49 -0800 (PST)
MIME-Version: 1.0
References: <20230206152928.918562-1-angelogioacchino.delregno@collabora.com> <20230206152928.918562-7-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206152928.918562-7-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Feb 2023 14:58:38 +0800
Message-ID: <CAGXv+5HiWU6MxSCqW8a_7xKA=-HKQSnC9EvT5eCtbpAqguq7tQ@mail.gmail.com>
Subject: Re: [PATCH v1 06/45] clk: mediatek: mt2712: Compress clock arrays
 entries to 90 columns
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

On Mon, Feb 6, 2023 at 11:29 PM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> Compress the clock arrays entries to allow a maximum of 90 columns:
> this greatly increases readability and also generously reduces the
> amount of lines.
> While at it, also fix some indentation here and there.
>
> This is a cosmetic change. No functional changes.

wdiff agrees.

> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
