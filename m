Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF186ABFAD
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 13:37:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbjCFMh3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 07:37:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjCFMh0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 07:37:26 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E465D2B61A
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 04:37:24 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-536be69eadfso181553727b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 04:37:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678106244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B1fqN+Osai6CCo/4uAM/DIM6+3uZVeAU3x7P6Nh+AL4=;
        b=kgXWRALfBwicLyIj2AHvNJ5gg1ibq5RRNApO/nCtrsRirMEDwTI5eh0fJAvmB/ndck
         HwNhtV3anhcNQD7++OC5LilGZx5ixD8Glg2v8x99OigvY9zxcftolFR22ghvZSq51nXP
         AnAJms+vpoaILeIY9Va4Bz8ba0ZgAKj8lkgtfdbX+3hcp6kJbXeR6LJlulkzZ+qj8xnT
         TvI52p1HkQ0EmO3dncEs0eR6HsvnOLN0qLgRZeBzztmea9TImX1bef/+VidIUmCxcGgZ
         2cFej9kS7yRFYwSC2/Pa4B/KJAszeeav8VcqOKl7UcF7ZQto/dlPsfU+tRrHrNB6Jmt7
         R1mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678106244;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B1fqN+Osai6CCo/4uAM/DIM6+3uZVeAU3x7P6Nh+AL4=;
        b=w/uTvEOu77OBjRKjACAXzOU4qFnq7eGMTkjEShYoo+WndjZ7ElIpOpzMA/DFWQOllN
         HmwtoeTEhL/mlNfvIpR8JtUKf3ECMsLb7XWZOqxS7nQIMdq1507heOJiNPF8l446pePn
         lZW6lv32ipZ9W2nTjesoYNptbNiv+8uAj16gHpGGy94MXmKrUWUZzb0eKF6jlm0EpqTq
         NtZJ1TyDNMVOw/bBl8ojZAguc5mT2KC0W6L7JrHsGROt8zgjzwyTLv4Q2P6lxEI9FRGB
         tiTtPFIYoMTnFCv2BO7o5Q0EShodEmP3DhB/JCkFG28Jf6I0dh5Fzzr94jlLQ8JpBY8v
         qTDA==
X-Gm-Message-State: AO0yUKXpTKpZ4oXthXzJiZt7fQ6mflGDTdSumMOCD+B19FUCdCul5piZ
        UvaLOKu2hcUQ4VcLNA///F4m1EbA9YYGuRhdJlx/hw==
X-Google-Smtp-Source: AK7set9JqmeLzn+ZpNjBjlBik7FoHGXFdpiI5Z4ulz0J2fN04dJzku/RxjI5AxZT8fYCWSsV9AXnTrQu1Y6OPL7lPX0=
X-Received: by 2002:a81:ad24:0:b0:52e:bb2d:2841 with SMTP id
 l36-20020a81ad24000000b0052ebb2d2841mr6245708ywh.10.1678106243865; Mon, 06
 Mar 2023 04:37:23 -0800 (PST)
MIME-Version: 1.0
References: <20230127181244.160887-1-sebastian.reichel@collabora.com>
 <20230127181244.160887-10-sebastian.reichel@collabora.com>
 <CACRpkdbQfaCX=ZbFQh3p_T3biWEex-QZofXTrbVKd5hYOzMAug@mail.gmail.com> <ZADNS9dqqbBE9Ohb@google.com>
In-Reply-To: <ZADNS9dqqbBE9Ohb@google.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 13:37:12 +0100
Message-ID: <CACRpkdbPHnzLBsg6RkFi7AA3ZfHMergXkdPhvx1DQKWRBJ1GUA@mail.gmail.com>
Subject: Re: [PATCHv6 09/11] pinctrl: rk805: add rk806 pinctrl support
To:     Lee Jones <lee@kernel.org>
Cc:     Sebastian Reichel <sebastian.reichel@collabora.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        shengfei Xu <xsf@rock-chips.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 2, 2023 at 5:22 PM Lee Jones <lee@kernel.org> wrote:
> On Mon, 30 Jan 2023, Linus Walleij wrote:
> > On Fri, Jan 27, 2023 at 7:13 PM Sebastian Reichel
> > <sebastian.reichel@collabora.com> wrote:
> >
> > > Add support for rk806 dvs pinctrl to the existing rk805
> > > driver.
> > >
> > > This has been implemented using shengfei Xu's rk806
> > > specific driver from the vendor tree as reference.
> > >
> > > Co-Developed-by: shengfei Xu <xsf@rock-chips.com>
> > > Signed-off-by: shengfei Xu <xsf@rock-chips.com>
> > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> >
> > Is this something I can just apply? I haven't had Heiko's review
> > on it but it looks innocent enough.
>
> Ack please. :)

Acked-by: Linus Walleij <linus.walleij@linaro.org>

Yours,
Linus Walleij
