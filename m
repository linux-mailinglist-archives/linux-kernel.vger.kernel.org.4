Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC76A6D66EB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 17:13:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234451AbjDDPNa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 11:13:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235478AbjDDPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 11:13:23 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC4DC4686
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 08:13:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id h8so132051915ede.8
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680621200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=1O026JM7eSnBPLdKfSjDDMSv0KRDXdafHprAvA88P84=;
        b=a7XqBTQ0njpuHJTWVmYyEC0Lv+fIrzGPXujd5UcPSChN6qIDSY9Jqt4zRb8rev/rXC
         Xez0vM/KcaUGauqdeEAFCAr96+GdSTuEPVqUTCE8fm7RElbd1umLDEIipv1bvHHxcX1L
         w44Gumgw2WN+z9tIa926gMWQhN1bLpqXeNcME5O+dZpeC9RvsDL4O+Vb7jP3uSBjhQsS
         7CCERz6rXrnuLEp+krtmYlzeNA2oOidFFmqf38BK6e2FKyWuyKwzHXJNQ3C56iZzptbq
         XfIEv5ZzhrnS4UtBLJTsvYMe+2jzyUROAuq7W6QRJXZ8Ga5aAwYb7RToh7l9FRRbzhkY
         mJTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680621200;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1O026JM7eSnBPLdKfSjDDMSv0KRDXdafHprAvA88P84=;
        b=3bwoX9YEVBBnLcipOjuilcz4ycCOU+4n1m8eU2P/9GzGjctOe2yhiP8zOdOQZEpYzN
         +QAXW1A6cCQszqHKipxRV5Zjs21Idbj6AON0W3Yul9TJF6/1FxUd/p3Z5bU6xisoNBfL
         fQQ2ZJRus13UXX+m+LjfF8+3nQPwNdY/5eB+d9kt0yZHzUBmVQivIJmJSjeGIJGb6Krn
         n+UVJiY+b1xq/oGbcz87VGkI155kcttdf46X5VQq7XRJnG3nYQlY8vFJRdRk70O7DjvG
         RGnd1XbycCjH2RyjzHQ5dJ4iP/GkC11C0G8wa/0wZCiLjxsoTHeNBXGD4NbPP8B0Vtnd
         y2/Q==
X-Gm-Message-State: AAQBX9eVBrV+ClQGhVKXefquQbVtJIajVgn8d5Fi0s9/Ap7zXIfXJkc1
        6wE7urbjwoXeJFE4Qr2SsNcCyqbmUChFsgO+2PM8fg==
X-Google-Smtp-Source: AKy350Z9lA8DgGqhAjKhVYJznsekz+CaWqLxDEEDb8hlazRI26y2fGS7u7PE8AETVfvb5fn8k4nKYSUUTLHi9KvEap4=
X-Received: by 2002:a17:906:a5a:b0:946:a095:b314 with SMTP id
 x26-20020a1709060a5a00b00946a095b314mr1387289ejf.2.1680621200196; Tue, 04 Apr
 2023 08:13:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230307154524.118541-1-bchihi@baylibre.com> <20230307154524.118541-3-bchihi@baylibre.com>
 <0a86d734-000e-560b-8f47-1c0a113c01ee@linaro.org>
In-Reply-To: <0a86d734-000e-560b-8f47-1c0a113c01ee@linaro.org>
From:   Balsam CHIHI <bchihi@baylibre.com>
Date:   Tue, 4 Apr 2023 17:12:44 +0200
Message-ID: <CAGuA+ooYbHn-4BYzaTkdagc2FimkenE0z2Zt4AqDbXQ++GThvQ@mail.gmail.com>
Subject: Re: [PATCH 2/4] thermal/drivers/mediatek/lvts_thermal: Add AP domain
 for mt8195
To:     Daniel Lezcano <daniel.lezcano@linaro.org>
Cc:     angelogioacchino.delregno@collabora.com, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Apr 1, 2023 at 10:51=E2=80=AFPM Daniel Lezcano
<daniel.lezcano@linaro.org> wrote:
>
> On 07/03/2023 16:45, bchihi@baylibre.com wrote:
> > From: Balsam CHIHI <bchihi@baylibre.com>
> >
> > Add MT8195 AP Domain support to LVTS Driver.
> >
> > Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>
> > ---
>
> Applied, thanks
>
> Changed the commit log to reflect the comments change

Thank you Daniel!

>
> --
> <http://www.linaro.org/> Linaro.org =E2=94=82 Open source software for AR=
M SoCs
>
> Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
> <http://twitter.com/#!/linaroorg> Twitter |
> <http://www.linaro.org/linaro-blog/> Blog
>
