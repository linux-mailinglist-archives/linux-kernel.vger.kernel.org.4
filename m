Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04BD25B8928
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 15:28:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229630AbiINN22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 09:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229491AbiINN2X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 09:28:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0566A4B4;
        Wed, 14 Sep 2022 06:28:22 -0700 (PDT)
Received: from [IPv6:2a00:23c6:c311:3401:435d:1590:4ce7:da62] (unknown [IPv6:2a00:23c6:c311:3401:435d:1590:4ce7:da62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: martyn)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 03F226601F88;
        Wed, 14 Sep 2022 14:28:20 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663162101;
        bh=8gAdOKSbEb1lIvZUbCLlNMdTh2S9J6j+Bys/GGRrHE0=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=lA5uoGr90t3Lu3MvAc3ctlHEyzFla+TeCrmD5IggaLHAqKcR9iNG84KSIYJbhW2r8
         B69Is0PMBUe4ZOMgincMtTxRONsSnK7A6/3CPHs8yWDf1fnjll+LM3IeRFCphBjT9J
         /JuWoeco7zpZRaWEyVZOlq5rN/Cw0gM47GdzctK74FNQ1fBpzP/x0FcJxgiBZ82IQB
         GJofroLuWo2d9SlmPZeITl7UDxmb3fyEhzhD43gYsJV3rbHiiwhRidwDada5uMU7eQ
         QeXFPDRf72yudptANW++6JImRB+A8SmeRY0bV/5XTpOC/8Mt1QTf5Q7L3fYH1tpzut
         eFpGrND3ycQ4w==
Message-ID: <fe67869043408328e6cb91a64781f30ed7b71e5b.camel@collabora.com>
Subject: Re: [PATCH v4 2/5] dt-bindings: gpio: pca95xx: add entry for
 pcal6534 and PI4IOE5V6534Q
From:   Martyn Welch <martyn.welch@collabora.com>
To:     Bartosz Golaszewski <brgl@bgdev.pl>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Date:   Wed, 14 Sep 2022 14:28:18 +0100
In-Reply-To: <CAMRc=MdSsLfQDGHD0w5GwvYQMZWteY_vwbLB6Y=urVpzNhQJGA@mail.gmail.com>
References: <20220913155348.38716-1-martyn.welch@collabora.co.uk>
         <20220913155348.38716-2-martyn.welch@collabora.co.uk>
         <CAMRc=MdSsLfQDGHD0w5GwvYQMZWteY_vwbLB6Y=urVpzNhQJGA@mail.gmail.com>
Organization: Collabora Ltd.
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.45.3-2 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2022-09-14 at 14:43 +0200, Bartosz Golaszewski wrote:
> On Tue, Sep 13, 2022 at 5:54 PM Martyn Welch
> <martyn.welch@collabora.co.uk> wrote:
> >=20
> > From: Martyn Welch <martyn.welch@collabora.com>
> >=20
> > The NXP PCAL6534 is a 34-bit I2C I/O expander similar to the
> > PCAL6524. The
> > Diodes PI4IOE5V6534Q is a functionally identical chip provided by
> > Diodes
> > Inc.
> >=20
> > Signed-off-by: Martyn Welch <martyn.welch@collabora.com>
> > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > ---
> >=20
>=20
> Can you rebase this on top of my for-next branch[1]? We've had some
> new models added and the patch no longer applies.

Sure, no worries,

Martyn

>=20
> Bart
>=20
> [1] git://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git

