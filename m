Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42C5869A4E4
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 05:32:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229557AbjBQEcC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 23:32:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbjBQEb6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 23:31:58 -0500
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 476124FCB5
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:31:56 -0800 (PST)
Received: by mail-vk1-xa31.google.com with SMTP id f17so2474808vkm.2
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 20:31:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4SdDgKb/8CZXVcKHrb27WnrCNDKmHhMmCt+ahSI3BnQ=;
        b=FMljJubHsaElsWtwyMPXulZVx0IzoKTmNdVRohhh7riEQHGrlvGIBoR3sB0Mu/nIFm
         A9y0Ki7HGc48I3sBUHZ7bLd3wMFIGTw11+I2NmLAGHq7AJq7ueVSGe9M7K2Ju1j/JfXX
         l09jZwu6wpq959VEoDXibwYYLzczlamKVQ+g0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4SdDgKb/8CZXVcKHrb27WnrCNDKmHhMmCt+ahSI3BnQ=;
        b=oIkUfev77Dx5d4ZnEfZd4k7ziwnRDUZeTjjjRwZ15AAdvNBJ8Vns5aH8QHhc1ax4by
         yyQbrTVIfhebbgAZNmxlEiX19Sywn8hVzdoyMr4f85HY2PiAVqIgwy3sRkPbUA4Dsdq7
         VqwYtZ5NBQONzf2ePcbKZsc7VXctpeJLfzopzlR5YPxfMz3s/GAF2crkqIORnrHSAfKy
         veiPw2bpSYJSABllWdAxjdMZfI2vf4LRrOZJRp+Yd8vduFIW83Oz47vzmg+gOP/ERAMQ
         SdVOsI3CCmGMQhygr6aKw+hggJWbiooapqWBdTsMmgCqLtc8J+tIbiwl3l6DhLFk6Yt+
         h1aw==
X-Gm-Message-State: AO0yUKVPnGVN1guQcOY3+Y0ZIYYI898Bgh4A+OX8Jad5EsevkX52aZdv
        Sv0GZ+5sFLrC/yPwvuYk/MP+jq+0/cWsuB9BOlP4pg==
X-Google-Smtp-Source: AK7set/LyxXRr+sumZROeJO4s16ExGKjzu7tn66ff/AESIRiG79BXtzTjOtZ6FIsoLoMABtdoYQCkZ3lJRoMNXtGZkk=
X-Received: by 2002:a1f:a447:0:b0:3e8:66ce:a639 with SMTP id
 n68-20020a1fa447000000b003e866cea639mr1327876vke.2.1676608315967; Thu, 16 Feb
 2023 20:31:55 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-39-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-39-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 12:31:44 +0800
Message-ID: <CAGXv+5GVzk6ZXfhgCRkK7HbjQq0K6geFjw7Fhno02cdNtKCF1Q@mail.gmail.com>
Subject: Re: [PATCH v2 38/47] clk: mediatek: Allow building MT8192
 non-critical clocks as modules
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
> Allow building non boot critical clocks for MT8192 SoC as modules by
> changing them to tristate.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
