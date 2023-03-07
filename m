Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20C2E6AD697
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 05:53:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230295AbjCGExm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 23:53:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230267AbjCGExk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 23:53:40 -0500
Received: from mail-vs1-xe32.google.com (mail-vs1-xe32.google.com [IPv6:2607:f8b0:4864:20::e32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 396382FCE9
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 20:53:38 -0800 (PST)
Received: by mail-vs1-xe32.google.com with SMTP id s1so11299620vsk.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 20:53:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1678164817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tcE3GqJXQUb3n8r8Cf9DeCZohIcMVrjYDJopDIgXigE=;
        b=Vzrk9J5moRnykRY4cC9oel+ani17/mQT1hS7fW5bTqtqAd7jAs6j9dMN+vet4QAbiR
         wLn/UcC5dzKOaSIlo8lpjPkkrFOXTgdUN74fa4OM2opvZio84DqY/cRDreHz/DoYvVWg
         0qsmUVy/K8rXM1y8XCrhGaMupA3V/0nQMDoC0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678164817;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tcE3GqJXQUb3n8r8Cf9DeCZohIcMVrjYDJopDIgXigE=;
        b=wgZsG26T1WWiH+h5Df3kNudyBdz/ASwgytjlH2u+dO5VXeklleBkCEEGlgDDZToctX
         u03OBfW8F+MMKPrm3mjt2cBtj8AndLy1cgeuMjR5+ArMuUK0gI3gFOmJ4dfTTrEI1coc
         T91R21uqWwdo8lTgOe/0Lr9q+5fTAMnOlC6ObeedKYMXbF+S7B+18FPXrgvvQ7z4Tr6G
         d4mNoOMHWK9v8yOYRbkEWibks7MwfuRiWkrWRu0eH/japvRAwWnzD8W0c7jVag4LoGrn
         uVjZ/HqpRSeSjjhmHvoHCkiXLp8YP9IPkDp/q16x1r7UO8GQW2Rfpa7c10GVzkca3+rI
         z01A==
X-Gm-Message-State: AO0yUKW1CAM1RNQV+KgdT5q1c18g0ImHKbBvYyzxQWmy0n/2qiKJC13j
        qwxHJSotMBZFzY24sGBaKYr/lx6pr3mSkq1/IJONrQ==
X-Google-Smtp-Source: AK7set/aeUCT0y/ttIIfAOxj05+op6eB8+wnmmD5urpBf0dNju9inYFodFHO4EvDUnuOZnaNy9rangMDYNzBR51J9rg=
X-Received: by 2002:a67:db97:0:b0:412:2ed6:d79b with SMTP id
 f23-20020a67db97000000b004122ed6d79bmr8785312vsk.3.1678164817397; Mon, 06 Mar
 2023 20:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20230206100105.861720-1-angelogioacchino.delregno@collabora.com> <20230206100105.861720-3-angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230206100105.861720-3-angelogioacchino.delregno@collabora.com>
From:   Chen-Yu Tsai <wenst@chromium.org>
Date:   Tue, 7 Mar 2023 12:53:26 +0800
Message-ID: <CAGXv+5EFtex3YCqkD91XbXura+e1gOWL6uerX5YMw-1=akW7Ew@mail.gmail.com>
Subject: Re: [PATCH v3 2/7] clk: mediatek: clk-pllfh: Export
 register/unregister/parse functions
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     sboyd@kernel.org, mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        miles.chen@mediatek.com, chun-jie.chen@mediatek.com,
        rex-bc.chen@mediatek.com, jose.exposito89@gmail.com,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 6, 2023 at 6:01=E2=80=AFPM AngeloGioacchino Del Regno
<angelogioacchino.delregno@collabora.com> wrote:
>
> These functions are used by the various MediaTek apmixed clock drivers
> that may be built as modules: export the common functions used to parse
> related devicetree properties, register and unregister the PLLFH clocks.
>
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>

Reviewed-by: Chen-Yu Tsai <wenst@chromium.org>
