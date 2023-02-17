Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A6CE69A680
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 09:03:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjBQIDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 03:03:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjBQIDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 03:03:05 -0500
Received: from mail-vs1-xe29.google.com (mail-vs1-xe29.google.com [IPv6:2607:f8b0:4864:20::e29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09FC82C64A
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:02:55 -0800 (PST)
Received: by mail-vs1-xe29.google.com with SMTP id c7so176003vsu.11
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 00:02:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o7YPoLv0Mb3/P1pcQA1xTESl2Pe5exe78Q7w7mJljJM=;
        b=hgJNmWlVbmB3rBcCxz0t4TFcMPdLncKPxUCjG3Ocmx0L5xNI2mLxrbeK5+MK7Kgf4W
         g9guiiB5baKztUyzX1jH4+GFsl49g1XaotdqvNRvGDukIxdrgM/g5dUl3oYiQIL/5WX8
         t8WT2cUKIhvtz8AcDDw1oJH9sp5peg++x5au8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o7YPoLv0Mb3/P1pcQA1xTESl2Pe5exe78Q7w7mJljJM=;
        b=yIUi+0l2JtDU99HqD7zn5W/+/MyolYzvGDOY5aog7hPUyXzbMvoJsCYmuVtygdGEaF
         l30tQ7eWxbiX9YPVoHlva8w2Cpq3p+khH1umXXluVRb34iSGUlX8lRoP86nnruM/L4BR
         ONrzP6JWGwh3c+rbGBJ/JEpitqLGO3gc3twYi8qkwG8/bB0zPd4gkHXRIFPsqdFIEtAm
         MVYDf9oyOuV9y8Y0G+5oqqdW2xMqn+Jaui0KJW6U/Xvjun0j7Rw/F5RhiIfRZ95rSNOK
         ki4OCu8KvM83JkGFuFCrVQN35xTR2z805b3+1joFHOuGRecYsjDOsaVqTWXYQ3Og01+v
         9ozg==
X-Gm-Message-State: AO0yUKUGU6dwelHe1m0ewr4Z4K48xGSUZQdXX2Kv79EmK8mrkAdKcNKX
        kvX8zh87wUYG0n+PZBeXB4CNWBZGADf8smNmPoA2NQ==
X-Google-Smtp-Source: AK7set+guMlNO8y7qmiUXCH5/6LMKqnHADxixWgkynAREbqMIljK8xAseyTKFErWOaE0P4+CiupdVaRpkTOTx/3kut8=
X-Received: by 2002:a67:f749:0:b0:3fc:58d:f90f with SMTP id
 w9-20020a67f749000000b003fc058df90fmr1614352vso.60.1676620974178; Fri, 17 Feb
 2023 00:02:54 -0800 (PST)
MIME-Version: 1.0
References: <20230214134127.59273-1-angelogioacchino.delregno@collabora.com> <20230214134127.59273-47-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230214134127.59273-47-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Fri, 17 Feb 2023 16:02:43 +0800
Message-ID: <CAGXv+5EJLijrq2Mb=+HyOJmOvTPzJA_RQswOhE8DuLXUO5BeHA@mail.gmail.com>
Subject: Re: [PATCH v2 46/47] clk: mediatek: Kconfig: Allow module build for
 core mt8192 clocks
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
> Bootloaders must in a way setup the SoC to boot Linux: this means
> that it will be possible to decompress a ramdisk and eventually
> insert the core clock driver module from there.
> Allow module build for all MT8192 clocks by switching to tristate.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
