Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5354698E34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 09:00:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229709AbjBPIAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 03:00:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229704AbjBPIAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 03:00:21 -0500
Received: from mail-ua1-x930.google.com (mail-ua1-x930.google.com [IPv6:2607:f8b0:4864:20::930])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B60AE6183
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:00:17 -0800 (PST)
Received: by mail-ua1-x930.google.com with SMTP id 30so246655uab.8
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 00:00:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=HwDQyziQcnL3/qYobk2rERtbLb6UKPgXAiYWHCJ3ci0=;
        b=nIRE8j59PqoJX7PnFaxwLXJvnpib/xw1mMdiCqZXNqoyJ4kCmBlKo72Y8fDay0MHP6
         /dPlbBTBI7i9OTV+q26ngG0OlG2vv0nTzUQJ5c55Xob85LG9DRKP/pgLdeZPYzrP34LJ
         1GT1+Tuy6HtrXbhUi5nN3KhOapekzucC/V988=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HwDQyziQcnL3/qYobk2rERtbLb6UKPgXAiYWHCJ3ci0=;
        b=ORFXzqSRFESy6qDI37cIuemiHnq48Cpj38mm0zuEBUxpbIJq//z/vRGr/le86O1gu0
         D3OAHYr5wDg7lyGjtJsJzy9JWjuF9DZiAjKMj+JrqJpLaB7LmbPiE1WfXEsstYxnsbMr
         iNkH80vrJdo9XZNyC4W6UQBEOgilMXzPP1+tTnMgdXnE1hknbdugc3s9UZUf3ImLiZky
         Dwkw5z4BBMSSAnk4wpTJRTOnYdE6YBLjgeLyWQzz9DacLqad7pJWb/b1EUOi/7RTcE+6
         Ntk8WD+LSLW2p8KwH8Y59N9bzNM3fcK1ZAKsswUzDC1vjYB4KPqDtmV2xVpav7PReN3f
         R2kg==
X-Gm-Message-State: AO0yUKWRXJFmnElCWZxj8fP/kdtc82WZH22dMVTk0tK2gNv3Oz/gUH5+
        9u8ZKpWaC0DniovwnqD8AhK/ZrMB0jS7WFxejmdmyg==
X-Google-Smtp-Source: AK7set/WvM64Q5fol97RcKyUBZadppjKf6uZsIOu4uAc5MszrxY6orAb3miq/PyxHEIgF7hbx7+7gJfDgZu4bM62Fio=
X-Received: by 2002:ab0:1045:0:b0:68b:728c:cf35 with SMTP id
 g5-20020ab01045000000b0068b728ccf35mr144924uab.1.1676534416768; Thu, 16 Feb
 2023 00:00:16 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-17-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-17-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Thu, 16 Feb 2023 16:00:05 +0800
Message-ID: <CAGXv+5F+v=Sh+NaqKKcrzABS96fRqc97gq2YVWabjH7Amo0AVA@mail.gmail.com>
Subject: Re: [PATCH v2 16/47] clk: mediatek: mt8167: Remove __initconst
 annotation from arrays
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
> In preparation for converting the MT8167 clock drivers to be proper
> platform_driver(s), drop the __initconst annotation from all of the
> clock arrays since they will be used not only during init but also
> during runtime.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
