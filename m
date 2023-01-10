Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D213A663A3B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 08:55:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231243AbjAJHy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 02:54:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234906AbjAJHy0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 02:54:26 -0500
Received: from mail-yb1-xb32.google.com (mail-yb1-xb32.google.com [IPv6:2607:f8b0:4864:20::b32])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 019281C921
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 23:54:24 -0800 (PST)
Received: by mail-yb1-xb32.google.com with SMTP id c124so10950944ybb.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Jan 2023 23:54:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=M1HA+cUB8IN88uId3+2+zul+0QRsM4IYV5HaTxUg2o8=;
        b=ilvUVPx25OH3XNmE6VPoLRn6bqaJSPeWJn8Ir8cd9MgUZOAHsJycQV4sOLqd1+6DY4
         XAKhTVYNnLhSfK7NHNKM5MN7E7yEqTCioo6nbACSo3q80Si3AbmkAudS7SW6ZgswnsWk
         iW2E92oUtIv39FYjN79fSzAH+m58CCOmkR4i1kFWe7+1cdRaAfcBhlKw8zMCDGYPcIrh
         V6YlLvcehJNFbQpDjOJ0tjTWaTRL1GfbgFy+z2fwOLjQpeyyiPPpcwurTK6Dicw8mIyx
         ed3YFANM9iSdkO0SYBYEd+Oi6xmhfnendwnhLo886z3aeNWJfnQPqIOcrijwjLK+1vVM
         jCsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=M1HA+cUB8IN88uId3+2+zul+0QRsM4IYV5HaTxUg2o8=;
        b=143Bgv6+aYZFdirGqh+HtvNCs064GYjpNrQKSOQj+Hlyzis8GAXDo6GTXRLHlxEiDQ
         FEZSsTHf3+4udgDaQXurezpom8dhIepaBZD2kFTCX+qRMEvfIoN382PuW8+lZpZX3VcP
         28+1C+oPhqwMbd2HDFskFII3emTrYbV1SneZ5pEHBOQFJUhZ1LulafCAYIfzN3SMe3wl
         FRarWq4TWuSJPXqJjqlEo+47dUGzloQLIs4+mCuBO1wIi2AAGJVOEAQVb+8pEr9+1VxO
         uf6yaELpH01Z+GYwyk85E9T+v++d+KDTGKtgeq0tNGPtJvFnERDNyrCC1h4NGqdMcV+u
         lhpA==
X-Gm-Message-State: AFqh2kq3E7MQx9emeLkMYULYwmGFSK5jdpaa+67fg04YQDVWUg++eJkJ
        oY4rW6v/xso83b06nhqdN7R1ZDI41FD8m0EwGRGDOA==
X-Google-Smtp-Source: AMrXdXuxq1hU1ANfE7x69zRH+at5knWFVgWEGqMr5dBQpesWF7B6/CJi/6pfxL4Ad9TNAlTVy08sM+TyJ/s2Y3KsRPI=
X-Received: by 2002:a05:6902:1817:b0:723:be61:1a2c with SMTP id
 cf23-20020a056902181700b00723be611a2cmr7642350ybb.130.1673337264115; Mon, 09
 Jan 2023 23:54:24 -0800 (PST)
MIME-Version: 1.0
References: <20230104021430.3503497-1-peng.fan@oss.nxp.com>
In-Reply-To: <20230104021430.3503497-1-peng.fan@oss.nxp.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Tue, 10 Jan 2023 08:54:12 +0100
Message-ID: <CACRpkdaBAc78_Z0-rVBdqNF0ejt4Gnk+i2SG04LL0YYM9Kb5TQ@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: pinctrl: imx8m: Integrate duplicated i.MX
 8M schemas
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     aisheng.dong@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, ping.bai@nxp.com,
        linux-gpio@vger.kernel.org, kernel@pengutronix.de,
        festevam@gmail.com, linux-imx@nxp.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 4, 2023 at 3:13 AM Peng Fan (OSS) <peng.fan@oss.nxp.com> wrote:

> From: Peng Fan <peng.fan@nxp.com>
>
> The i.MX8MM/N/P/Q IOMUXC schemas are basically the same, it does not to
> have four schemas for almost the same binding.
>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> Acked-by: Rob Herring <robh@kernel.org>

Patch applied!

Yours,
Linus Walleij
