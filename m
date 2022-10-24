Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BD0A60BB6D
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 23:00:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiJXU7s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 16:59:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235453AbiJXU7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 16:59:23 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A447159D71
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:05:33 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id j4so18357775lfk.0
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 12:05:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6jLzWTJgQOtlVe+72Zg3h4fi2g2V5ar4l63Y1PCLPjc=;
        b=Z42jI/gXhcXG5YxoueNeDtIC3JesqUpHJU8cD7xjqdpFe/r+2T9oqnaaDn/+VCsi8+
         7nv6qZR7KznLY2jF8bhwMHq7P2w5ZoLClauIm6K2swABZF28/nRRVphkYBlqNrI5p+hD
         B1qoWm8NR+r79EtsEM8ogTfNZhOQtQCK7lNx0axp6JDqRTeHm3Bvgd6DfkGHL0bOuqP1
         dICzUk7rly8w9FubrYQmbfogXHNIRrel9h/z6IF1n4sm1Sa0ecfWGuW1Nf5OuViMEKhA
         QApQJlHPCSbXoOyTMuLWi7ERjPCpf2ACGcJep+PvEl4m9Tp16dGSFEqNX36ivjvW0InD
         zklw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6jLzWTJgQOtlVe+72Zg3h4fi2g2V5ar4l63Y1PCLPjc=;
        b=pPebFaVWEiDl7wbdv+RLSq8Caqz202dTDyNPl0RdY4aTlhban1jaR+vDm/LpIAQgEC
         H1/oP/9sm/v20KMlCIFafhB/bQ1PEAxM0jicldhyISfI0h45mUhV+tfZzHwmW7mUwgqK
         myNWLIpg3iCkT89B4Qa/lmWmfs+vFjLcB4aQKtM7SIsODHMdZwhJ7ntOZowW4jZAB3IN
         cLjH+Vx4kZHJpufJdayOAaWNLqWYOUfuq27Ij9DmTB24HwwY6bNg8MEHjj79+TC3+V/w
         +csYqypdbTJ8qqyZLS1doMUxdxH95PlgOuOMTq66D6SC6ILrxoUxefbdko1BJJ9XafEf
         gcIA==
X-Gm-Message-State: ACrzQf2k/5XO4qOtAklxFtmIzaICmwSnAwsYPQcuXbfHfouR9NI3ONWF
        6tNwgDzZZSSE3vWO59fhLwBk6P9Owg6VhYgG3U+flB8oUBowZQ==
X-Google-Smtp-Source: AMsMyM7GEkmV9v4atHnaNyKsdWev7GfMxpVpWKrPHXn2WJtejlHSWRanZiQZYYiLQFAsWnFgfPu5INCphD8i9o7t760=
X-Received: by 2002:a19:c205:0:b0:4a4:60e5:5a25 with SMTP id
 l5-20020a19c205000000b004a460e55a25mr12642060lfc.139.1666617869321; Mon, 24
 Oct 2022 06:24:29 -0700 (PDT)
MIME-Version: 1.0
References: <20221020130957.25197-1-fchiby@baylibre.com> <20221020130957.25197-2-fchiby@baylibre.com>
 <aaf7d4a9-c767-6a63-691d-e3ae00b206fc@linaro.org>
In-Reply-To: <aaf7d4a9-c767-6a63-691d-e3ae00b206fc@linaro.org>
From:   Fadwa Chiby <fchiby@baylibre.com>
Date:   Mon, 24 Oct 2022 15:24:18 +0200
Message-ID: <CAL8gX1d53p3WQkmFrpxLZ6AUg+x_ZtBxUw08eNbkCBMRgj=jQw@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: soc: mediatek: pwrap: add MT8365 SoC bindings
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong.Tao" <zhiyong.tao@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Rob Herring <robh@kernel.org>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.3 required=5.0 tests=BAYES_00,DATE_IN_PAST_03_06,
        DKIM_SIGNED,DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeu. 20 oct. 2022 =C3=A0 18:19, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> a =C3=A9crit :
>
> On 20/10/2022 09:09, fchiby@baylibre.com wrote:
> > From: Fabien Parent <fparent@baylibre.com>
> >
> > Add pwrap binding documentation for
> >
> > Signed-off-by: Fabien Parent <fparent@baylibre.com>
> > Acked-by: Rob Herring <robh@kernel.org>
>
> This is not exactly v1 then. Please use patch versioning and add
> changelog (to cover letter or to individual patches).
>
> Best regards,
> Krzysztof
>

Hello,

Thanks for your feedback. Everything is fixed in a new series.

Regards,
Fadwa CHIBY
