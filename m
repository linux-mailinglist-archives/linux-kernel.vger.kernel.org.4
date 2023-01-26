Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9422067CCDE
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 14:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjAZNy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 08:54:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjAZNyJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 08:54:09 -0500
Received: from mail-yb1-xb36.google.com (mail-yb1-xb36.google.com [IPv6:2607:f8b0:4864:20::b36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF2F6166C4
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:53:42 -0800 (PST)
Received: by mail-yb1-xb36.google.com with SMTP id x4so2038691ybp.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 05:53:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=bpuj4csXn4X99vb3I/8s21NoXDHeQ/0SUOopiJHmpcA=;
        b=T1OCixkhNVvyqIZG02I05yLXMmu0eRtoy7a1SbHSvmaUaNSxhw1D3/LIvUbLquayXB
         yV+BtLGzuQfszCSBlQ9R2P2LmFDhBpW5QHj6vNoet2lRvFj8mHM/2tGpoJwDJnX6vfGq
         9aG1wkd9GjOd0Qo5EMgr5y9lhqsZraSPNFYsOSMgJ90jdp8NZdl4VDBVh7+UXOdvYoUv
         aLPu8JIpl49wnMfa+jFlLrcWSoWGWtDdAWA31H+OqdURvRn2fO1wKsC98OoirxOfs102
         psM27Q4jO2ZFe+Mw/uTheQ0YXYL6e1JXsDMIYsioyjJA6+a0xudWPVol+9wiSlfZMCqZ
         1Ykw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bpuj4csXn4X99vb3I/8s21NoXDHeQ/0SUOopiJHmpcA=;
        b=Wv5x5UakNepZEmLoCM385TbFXDQvBwZDpaQp//2pSMPyTjZgY3cmSuxz7COKYLCR8r
         FeXfnXigvWNsGr4aYrBSaPKUl6qWI3dHh2gOvhPBGqSi+JijEXii4RpqV8xdkLUzX5y1
         N5kx98441A3Cvj41RsOw1QkG6oyOrPjn/njgX5XlzxkT7PU/NsyI+ZvY5GqSlBCCOybx
         qQNCfMeW8w2Y1b8w6ASITG+IHxqlEXu/AgrzQqWtSj7JIG8MoCA5PJN37a42wvopBWbW
         lw04lc/TIBWWAWUAgf3HZBMYjpr6T8WwVclzFyPNPgbmoAd2bB4FO/Sy2/uxnh+clbGc
         UaZg==
X-Gm-Message-State: AO0yUKW7mIEfjquljDQlkGBGEMwr4K44QqaUQYzhMGXJWvA1IGKSprm+
        2KuyNwIm90qnu13BrAmTKqlnlOb6bwq2sPeeryp6Ww==
X-Google-Smtp-Source: AK7set9K8VEvJWIIsQbzLpHPBdIj6YRdDIIsA2XTX+4WAVIQ5O4wlEhz7CX7+BOEhoz7cif/nbeZ9U+rSHTl2iHnGDQ=
X-Received: by 2002:a25:f81b:0:b0:80b:821f:b621 with SMTP id
 u27-20020a25f81b000000b0080b821fb621mr752679ybd.24.1674741217835; Thu, 26 Jan
 2023 05:53:37 -0800 (PST)
MIME-Version: 1.0
References: <20230125143503.1015424-1-bero@baylibre.com> <20230125143503.1015424-5-bero@baylibre.com>
In-Reply-To: <20230125143503.1015424-5-bero@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 26 Jan 2023 14:53:26 +0100
Message-ID: <CACRpkdYMif0--zeKe-tccUJvjiQAkbzBq2nCYMS8qU_imZmCmg@mail.gmail.com>
Subject: Re: [PATCH v9 4/9] dt-bindings: pinctrl: add bindings for Mediatek
 MT8365 SoC
To:     =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        linux-usb@vger.kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, tglx@linutronix.de,
        maz@kernel.org, lee@kernel.org, matthias.bgg@gmail.com,
        gregkh@linuxfoundation.org, daniel.lezcano@linaro.org,
        chunfeng.yun@mediatek.com, angelogioacchino.delregno@collabora.com,
        nfraprado@collabora.com, allen-kh.cheng@mediatek.com,
        sean.wang@mediatek.com, zhiyong.tao@mediatek.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 3:35 PM Bernhard Rosenkr=C3=A4nzer <bero@baylibre.c=
om> wrote:

> Add devicetree bindings for Mediatek MT8365 pinctrl driver.
>
> Signed-off-by: Bernhard Rosenkr=C3=A4nzer <bero@baylibre.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

This patch applied to the pinctrl tree, decreasing the depth of your
patch stack by 1!

Yours,
Linus Walleij
