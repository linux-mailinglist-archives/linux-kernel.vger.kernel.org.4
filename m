Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 015816D201A
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 14:23:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232098AbjCaMXS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 08:23:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjCaMXN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 08:23:13 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB3E61F7BF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:22:46 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-536af432ee5so412234527b3.0
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 05:22:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680265365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=2owAB3QIh/fJmsl2/RdqrmdgMBNDGNEWdkKSHrJDCNo=;
        b=AHL3dXDDbBLaLWU/gvqB57G6n+zZ5P0WuNtY7UVz7hYQg1Dyt4lEIR9ezSGfR3YgH2
         l7gRTIFuVsxhmhcvoK6nuBb4rcjcEaz70KC485Awzk6urblUULbmP1V6FCuxXJw2c9NM
         IaFa7XSp3NK7BuzOpxGYBfO8pHG+eqFODg0R9nNLi7KTASWGm68SB7iiirBlFHfhCOI1
         P4l+FiMUs026/Rq/pFvBBm3mEx6ylsqBOdbUQyiJjM+yEz0uVNRm9QRR1q/d6SMciH/A
         Wy7QL4OddVTtYV1qa58u4QSOGYDQKpBA6j2XX7q+beXqVTX6XCRnnUI03BU5cG1EhBaB
         Tu9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680265365;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2owAB3QIh/fJmsl2/RdqrmdgMBNDGNEWdkKSHrJDCNo=;
        b=hqhBJ0gw2J87HkWPnfa3fmM9W7167W8stjfH7VgOXv0dlQyZSGUn0JWE68OTLKC/bv
         oS9/jL3pky1XD/SPIq0lqsgcutBOESNul983hlbTUELRYXhHctRUvy9rnKGSm9ogKfE7
         qLcWBOR9z3lxzdlN2DSLnp69MPPyLk4Ote3XuEo+cj9TNFbbA6Li8URqm4s/NDZIJ1iS
         3I977zLPisWK8sxaCPpSnbqwIWqyqU/uaNo2Ncb5VADG2wuYn12CmjcbwWKZVDcX4uW6
         A16Z6+OUdZdNvJmmpPFF8Z3QJlqxumk9tkBXNxAbVjWSD2C6iWE6IDkMui5wAXQCk0wc
         06Zg==
X-Gm-Message-State: AAQBX9fadCzJVyGyw8072304WA8yQLpMDRJ/P5IyHaiCGDNrIPmNbjN8
        9JEGrvsZiuDsw/z0O9GnbuN6vWvFhZtxT51dzXt7Lw==
X-Google-Smtp-Source: AKy350Y75Hrriomm/pGgLwtjhceJ4FaC1JCezQW32b0yP9veCHMLvw9+T4Ah1HaSl9byrDxUB04ZhK9nb9gkqXcBrsI=
X-Received: by 2002:a81:4426:0:b0:53d:2772:65d with SMTP id
 r38-20020a814426000000b0053d2772065dmr13513308ywa.9.1680265365023; Fri, 31
 Mar 2023 05:22:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 31 Mar 2023 14:22:33 +0200
Message-ID: <CACRpkdbx_4CqMokdKf8Zs0BrBz6iEZrwL_8c7nrP7yqxM46A1g@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: gpio: fsl-imx-gpio: update gpio-ranges
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, stefan@agner.ch, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 7:24=E2=80=AFAM Peng Fan (OSS) <peng.fan@oss.nxp.co=
m> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> one is not enough for i.MX8, so enlarge it.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>

Makes sense.
Reviewed-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
