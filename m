Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99F136C3C0A
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 21:40:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbjCUUkd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 16:40:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59138 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCUUk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 16:40:29 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88F613B0F1;
        Tue, 21 Mar 2023 13:40:24 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id l16so9231068ybe.6;
        Tue, 21 Mar 2023 13:40:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679431223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rnJYCIHb3YOLk6h7F2Xo1WPCj6zYYjtkpvkZ8wpoQJs=;
        b=jLlwwP11Eqd3QcuN1GuSMsYw65pUik7rYOLx5A1BPNTMKYJnucTWfSjnqUytJNHQXy
         GlAFJL6HyR3XP707iPGwPLT9NY80fMZ/hCISBwSyJBwHfz7eX+lK3CL2OIHoNHXO5Kyz
         no+vIz2/4ucVrHHNXkTOmblHIkWNlzdaISIxpB3ZjQRTD5u2I/FgqtMhRgiy9YzTWTcX
         waavRaNlKiFGoog+iFNJImDr8t2BuR/0PLfTa74EW/SK1wMrTJ1l2qBB/fA5N5Y/t28Q
         /rPFIaJLKvcae0dQ9PRxX/RisjwpluW3tmFgSdLMjx7xzAexmNpGqZa2XA5/3IwG7ffU
         1+CQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679431223;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rnJYCIHb3YOLk6h7F2Xo1WPCj6zYYjtkpvkZ8wpoQJs=;
        b=UDw/pTjDpVPB3R2MB4IPyDpBqxjevfkOFn/twFloF0zj3tK4+pMOQU5bA9nIIeV59O
         foklRmlFan8ILt8HSg74rX8YcJ2ohP2aCfbcFGBDqymqWQWowvjERA3Nf9vLXFMGf2Fi
         k9kgyC6AxVvYhpPGCx0sgUETfFZz+EMDn4f0BG1cLHlBQjXmfqWOr6NYIUIFBpGjZdF3
         am75TALB6OX3K48NmIYjQsID9nuPZITxVqd08Brw1VqCV6lW+JlBirYqVVUvxejnwD9n
         PKeTv8jinTyZzc7Z2udEKhxP4u4BFGC7KvSCgtueh/VS1HanONDreTwZkIlyAQDNwVJQ
         fLOw==
X-Gm-Message-State: AAQBX9dwVEOWOmKSA7Oq+2OO3KdryIdcU8p7qUb9nbYYoPvMEpOJMdPX
        cgi/H6xDkC+ui3nAGKxmZAa5fZ8ItQx1b5RRufE=
X-Google-Smtp-Source: AKy350Yr0lFcvlrRV/aUYAmitKBlF/YIDHoHGNgfQJQ9fN+jGmA0gMeojAbcNNdTi/SlMNF7cHZPfM6jxoOO65XX8gM=
X-Received: by 2002:a05:6902:6:b0:b5c:f48:3083 with SMTP id
 l6-20020a056902000600b00b5c0f483083mr2322649ybh.11.1679431223686; Tue, 21 Mar
 2023 13:40:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230320233823.2919475-1-robh@kernel.org>
In-Reply-To: <20230320233823.2919475-1-robh@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 21 Mar 2023 21:40:12 +0100
Message-ID: <CANiq72m+cNuGiU_J9xU9QKmQK-ncD=1Y5imskrFNFSezzmjq8A@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: display: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>
Cc:     Robin van der Gracht <robin@protonic.nl>,
        Miguel Ojeda <ojeda@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Laurentiu Palcu <laurentiu.palcu@oss.nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        Tomi Valkeinen <tomba@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-arm-msm@vger.kernel.org,
        freedreno@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 12:38=E2=80=AFAM Rob Herring <robh@kernel.org> wrot=
e:
>
>  .../bindings/auxdisplay/holtek,ht16k33.yaml   |  2 +-

Acked-by: Miguel Ojeda <ojeda@kernel.org>

Cheers,
Miguel
