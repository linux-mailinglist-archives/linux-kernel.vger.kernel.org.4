Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DCA269A60D
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 08:26:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229652AbjBQH0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 02:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229637AbjBQH03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 02:26:29 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A31A5D3C6
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:28 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id o136so511519vkc.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 23:26:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Oid+aqBdw4K3Kog+gaRMquz6ngOAq47AZPlR5mwS954=;
        b=Wpiq1msOSALxHslmO5r4oAi5zGjFqDjan08pBLo60zasY1WA4ImnzmVgS32qHyY4LO
         FPqD22dSQlVp3GZnwcZx7aN5DffRJAYFAubMxsYv9B9vQYi+EC4vY9QfF8uomzhVj5I6
         Np6kJyIIsRiDL/deUDh45nl6oRFARfEIdEHpQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Oid+aqBdw4K3Kog+gaRMquz6ngOAq47AZPlR5mwS954=;
        b=ZjSgnbcUaQlwcxEJoJlkoMgblTxk2pmYLEVDvi/RQndGCRmb7jAXNdLmKDja/wQrWl
         AF5prBZM0MZKBAQ9rzPtOxfYyfN7p2jgFBtqMEuzRbfAa2ntSdHend7gI8IUpAK9rK2N
         LeS4tnXbyFc6ZfCBMdc2ptttp+tci2zaTnYxJKCNC361NkWpu2fdi/oFctapZiDgFmMn
         KIVNXcDXNWa5RBlbg7pypoywEQCbDCWy9cI90GnVRWa30fuBoI0Wi5NmQJZeWOk9F+aR
         Cfy4Kd0rUW3UG4NkhibjbgkKMVMD1LYS1jpAiGZAzyx06Eq/JDbpFzG90hmmy9DNEZw7
         3kcg==
X-Gm-Message-State: AO0yUKXlbCtyIF4cJ615uXr/w72X337tYwuHGA4gwfiR5o9mitnSJGan
        6Apz2qnk12ZW+pNaIsXtL7xMqVIo0wAhXw0HoE/rQg==
X-Google-Smtp-Source: AK7set/dFOe+XmErTLWHyjvHjFKkrqaDezsomGj7d6EevRFgpJETrmfHwbshsqCN3BM9nIRDuhKixQ94pBVr0vBQtmo=
X-Received: by 2002:a1f:a447:0:b0:3e8:66ce:a639 with SMTP id
 n68-20020a1fa447000000b003e866cea639mr1392918vke.2.1676618787321; Thu, 16 Feb
 2023 23:26:27 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-43-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-43-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 15:26:16 +0800
Message-ID: <CAGXv+5Eh_4RXN+uvG0Cwq+GkJ7mYdhtGz04MMNDnXVU13BRdMg@mail.gmail.com>
Subject: Re: [PATCH v2 42/47] clk: mediatek: Allow building most MT6765 clock
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
> Most of the MT6765 clock drivers can be built as modules: change them
> to tristate to allow that.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
