Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1B5663A3BE
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 09:57:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230236AbiK1I5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 03:57:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230248AbiK1I5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 03:57:01 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34AD317AB2
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:56:59 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id n20so24105411ejh.0
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 00:56:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UlT6JqjPReHXe7EcP6Bm9RZ1YVa4h6RI/hRicIEgKs4=;
        b=62u2Rfj+8hqBycQ942lIdMJxOmRUxzLFS88338/bWaX64SRCze08nOErchZZjD79e9
         jxBkgmmaQb3aktcKJuwqGmxQRHDn0HXvZJXpscXmgRAEUMeHLbrHyPMYJW/j82zk0XYp
         6gsJAbx5GUzNoNIIq6D0uaEI3LTbltrvXUIxmJkV5yRRZ5FbMm3Poiyu/RsHYa1lRF0T
         zAL7YK9GDAm5n9zem/EG7R7+zkUqLeAThB0+xci9RvHt6jIf1rQnf3D7tTwsSt7O+pCo
         3ZZJhl8mYjGanyUk4utkZbvWtSfrwXeyNwbLSF+ofpay5bEraiGSMglDjxaUVeB5Bns4
         WJVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UlT6JqjPReHXe7EcP6Bm9RZ1YVa4h6RI/hRicIEgKs4=;
        b=ky4x56IoRenWasmLW4wyqfvWge9W0I7OjzMds8SCVMSIqk4Tq6LlI7B635+tofCsbX
         kJbShq3yJAQ/59n+iB5Ru7y0l5L+clf+6R4vVgdrhg/5HujA03e15/D8h2kNo3voVYrx
         +1a06JI/Gfyr2Z+MdyGMqHUC45CWTixni9uXoH0IrYU27Wx4M/IbXFS2VIUI3VxHEiAg
         g5a0iK+DEojpaPw2CfYWGfugouj6eKkma9bAZJ7yQfGZzitHkN/4xxMKTi9+1dw1kDFu
         EhbVax8e00Gq3Ufle2/CTqjHajwOIl2IE7C2w8qp2bfjCc94lBrr05t9PAcbS1YlzIrN
         qT+Q==
X-Gm-Message-State: ANoB5pmyABk/rvxXXsZqsH508zze7BvnO3iwJtQ7krsJAuz08uOlbah9
        8CPMCMPq830TH69K1wajwITblu0Y5L0KXBABasWo1w==
X-Google-Smtp-Source: AA0mqf7iybltDA7hXJL9yAT+SXbkybtSOfTzeliT8SvsSM8emlSdXZtrfN5+duEiN2skEXcM7mCKyxD7tFoNefo+WI0=
X-Received: by 2002:a17:906:7f05:b0:7be:26f2:909f with SMTP id
 d5-20020a1709067f0500b007be26f2909fmr7248255ejr.86.1669625817752; Mon, 28 Nov
 2022 00:56:57 -0800 (PST)
MIME-Version: 1.0
References: <20221005-mt6357-support-v6-0-4f589756befa@baylibre.com>
 <20221005-mt6357-support-v6-2-4f589756befa@baylibre.com> <f7f0753c-f0bc-b87c-b99a-8b1bc3ef40b2@linaro.org>
In-Reply-To: <f7f0753c-f0bc-b87c-b99a-8b1bc3ef40b2@linaro.org>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Mon, 28 Nov 2022 09:56:46 +0100
Message-ID: <CAFGrd9rK184_mqpPmHsSRXyE=Y3OxaWe_RaYBh5P1F-aOhPGvg@mail.gmail.com>
Subject: Re: [PATCH v6 02/10] dt-bindings: rtc: mediatek: convert MT6397 rtc documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sean Wang <sean.wang@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>,
        Fabien Parent <fabien.parent@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Mark Brown <broonie@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Flora Fu <flora.fu@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>,
        Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Mattijs Korpershoek <mkorpershoek@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Fabien Parent <fparent@baylibre.com>,
        linux-input@vger.kernel.org, devicetree@vger.kernel.org,
        linux-leds@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le dim. 27 nov. 2022 =C3=A0 13:59, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> a =C3=A9crit :
>
> Regardless of it, Rob suggested squashing it into MFD device schema and
> I think his proposal is still valid - you have here only two properties..=
.
>

Ok, I thought the conversion was worth it with the latest changes. I
will remove this patch and write RTC properties directly in the MFD
schema.

Alex
