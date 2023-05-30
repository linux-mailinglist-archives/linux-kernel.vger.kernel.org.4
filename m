Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1A05716DAB
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 21:36:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbjE3Tgd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 15:36:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230219AbjE3Tgb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 15:36:31 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45341137;
        Tue, 30 May 2023 12:36:22 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id 2adb3069b0e04-4f3baf04f0cso5520560e87.1;
        Tue, 30 May 2023 12:36:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1685475380; x=1688067380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QEE5HR8KnTXDzE7qIjWjCheMHM5HqAaaQn2y8Q+rxV8=;
        b=IVNYUCmhiNFu0EgZ0lRI69pOYybAw0Roa8Zps1B2zd6CwZ7FdSroL2EOxDfml0hl2k
         qo04Uq1vSu9zxk3gbbRpCUq+kbB4EYsM4sMt9kIpzRVLpuenwvbcptbkDrlFjz12s+jq
         Scm6s+4dseL2zUnMkuF3CYBxGsMySIe2Fb7A5mFYMwNE68P9YxV/Fl9CbWB02Ef8mvKK
         ZitD/QzB1WKggCor0rhynySgN8NAXQQ+YISaEfdcnHBcfTYnBfKh+elXdbA0muZjv4WC
         WhNKhfsMy0lBtIqF9wiFwHe13B4CIBjJ2815jAkuozg8QmHhGJJdZtGzvf2u7K6N7b3l
         /Etw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685475380; x=1688067380;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QEE5HR8KnTXDzE7qIjWjCheMHM5HqAaaQn2y8Q+rxV8=;
        b=PvJ+2RPX+aXc1nQsd76lfSZUU7kg1vIPFlj35IjwFznnK3wySeli5oBBQp9QF1j31w
         wCwQ+2DyF71mUalN40hxgFCZCRYjlC8s/TkKIPTC3o/UMX68190pSC2tWNbiw3tngWkG
         OfNu2bexDgHrKfZuRkL7HhCJZE/5dtAmc1jsG8C+v1zOHQ5VsbQTvBcA262taiHBWg7X
         XJbA3f7SVsZY203h4gxvB971HC9aD/uFY4Ln9tJiHUmN+WPhsOKw+FgV+qHXLnZ7shrA
         FU3AT6iNvUvszlgxxJNemkkvolYkpXyuPDMowPOrkMC97dvTvZv0ko2F9W2eYv2fQN9v
         4vaQ==
X-Gm-Message-State: AC+VfDyxIsGz5+up22DzMcWdXLQs0w6qAIiVNmIw8wrYRuaClsaPfgoY
        nAGVdzRqqvVW1QIDZtWvO692GbfqjssxzEeGdj0=
X-Google-Smtp-Source: ACHHUZ5gc/hxHeYex2Y8Okc8JH1HtS8SizLAVO7CtDJbdkVMJw6syU7DTQmP8/PMv1wx+1QnYFOncA22xyJ5j/x0vzw=
X-Received: by 2002:ac2:4c13:0:b0:4f3:8258:5894 with SMTP id
 t19-20020ac24c13000000b004f382585894mr1358968lfq.27.1685475380186; Tue, 30
 May 2023 12:36:20 -0700 (PDT)
MIME-Version: 1.0
References: <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-0-56eb7a4d5b8e@linaro.org>
 <20230512-amlogic-v6-4-upstream-dsi-ccf-vim3-v5-5-56eb7a4d5b8e@linaro.org>
 <1jv8ga445j.fsf@starbuckisacylon.baylibre.com> <c24502f9-f717-6ff9-211c-1d129ef02f24@linaro.org>
In-Reply-To: <c24502f9-f717-6ff9-211c-1d129ef02f24@linaro.org>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Tue, 30 May 2023 21:36:09 +0200
Message-ID: <CAFBinCD4nZPp4JKpGARBkWL5pKVHJ0GSLTvy3S_q9mF=1d37Kg@mail.gmail.com>
Subject: Re: [PATCH v5 05/17] clk: meson: g12a: make VCLK2 and ENCL clock path
 configurable by CCF
To:     neil.armstrong@linaro.org
Cc:     Jerome Brunet <jbrunet@baylibre.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Sam Ravnborg <sam@ravnborg.org>,
        "Lukas F. Hartmann" <lukas@mntre.com>,
        Nicolas Belin <nbelin@baylibre.com>,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-phy@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Neil,

On Tue, May 30, 2023 at 5:57=E2=80=AFPM Neil Armstrong
<neil.armstrong@linaro.org> wrote:
[...]
> >> The mipi_dsi_pxclk_div is set as RO in order to use the same GP0
> >> for mipi_dsi_pxclk and vclk2_input.
> >
> > I don't think notifiers is the appropriate approach here.
> > Whenever there is clock change the motifiers would trigger an off/on of
> > the clock, regardless of the clock usage or state.
> > If you have several consummers on this vclk2, this would
> > cause glitches and maybe this is not desirable.
> >
> > I think it would be better to handle the enable and reset with a
> > specific gate driver, in prepare() or enable(), and the give the clock
> > CLK_SET_RATE_GATE flag.
> >
> > This would require the clock to be properly turn off before changing th=
e
> > rate.
>
> Sure, will see how to switch to that, seem Martin did than on Meson8.
You can start here: [0]
It may not be the nicest logic but so far it works (for me).

Please note that I don't mix between CCF and direct register IO clock handl=
ing:
For the old SoCs I'm relying only on CCF to manage the clocks.


Best regards,
Martin


[0] https://github.com/xdarklight/linux/blob/meson-mx-integration-6.3-20230=
410/drivers/gpu/drm/meson/meson_vclk.c#L1177-L1179
