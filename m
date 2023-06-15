Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 617E5732037
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 20:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230230AbjFOSwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 14:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230012AbjFOSv6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 14:51:58 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429AE1FF9
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:51:56 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bc4651e3838so2093151276.2
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 11:51:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686855115; x=1689447115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oys6po3xV1zflUTK5Q7rHSTxvD+daqTUwms8w9Gkeig=;
        b=TZhkEOVM+6kSP3s5XIj7Ew/F2o0nsoTRE4JNLY0qV8p3htIK+2Ja/WTZsyu+9D9+xV
         R194akxrpQUzn/5KomHtspD+WL7yzirv7m6CrYCpfgMLyk1xYpMjgMt5Rp6VBh+TyEnT
         WFBCKtzWarwwuRgVdhyYdDRR7RFF8M7JOEWsNRLullUntoYJ0xVVsB9eUIilmnpS6PD3
         RZTOxzGP2mmiqCEtKkhYfdT5EVK5/2l0huHhyAnCS47j2BWUUKFzoAfZ7P/B9yiW+oda
         IYwLwOrYuiih0pZqKFC5OudEhmMh+ceJtpvU7nt0RcFWkiHWS/zuzjmvNwouOojEdFAM
         NJ2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686855115; x=1689447115;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oys6po3xV1zflUTK5Q7rHSTxvD+daqTUwms8w9Gkeig=;
        b=JSpr9Kk2FPE5Tw40HbGGLI1YiZD47WITwpPorl6dPzjGXoqqC8u8cohfpKomV9qy7G
         nNmzo6E9JxffT50MDZvK7Zacwcyv3VHId7Iwu633Gd7YWkfheCFHMnSN4bVswS5wcQgv
         00aRN735oPGSJbCDe7kp07jmJ1YCFT+AQCx6nE1PTDe39FGMYFZ8p95vAEAkHY7vpr4X
         f76Hz6FV3GkCfEODwK/TZXXbA89bav2a+/yJoqpjdKrkukncfBCgY/hvQolyFc7eov2q
         OaF7w7PIU0WOoa1rEPDYZW/ox4JqCHwL4QoaizRMEduhX3WxODNIBHqcy7M2HUbiR3ML
         tDJw==
X-Gm-Message-State: AC+VfDyC+D6YkmR5YYwQlZM1opeqKVyWKmbTDrgq0KYVX6Kp8azTFrRN
        OCJi5D2M8R4iQICKM50nQv86D4+wimffpGi0Y2UxJA==
X-Google-Smtp-Source: ACHHUZ5MGUqqRHv95slcbK18Ur8RugPXouW0J3O984wR6h8VWSwkh4mWLExlNWIjg1eG8cz9Gob1bzBzu5dXlscM0yI=
X-Received: by 2002:a25:424b:0:b0:ba8:972d:e37e with SMTP id
 p72-20020a25424b000000b00ba8972de37emr5179293yba.14.1686855114258; Thu, 15
 Jun 2023 11:51:54 -0700 (PDT)
MIME-Version: 1.0
References: <20230615092001.1213132-1-yann.gautier@foss.st.com>
 <20230615092001.1213132-2-yann.gautier@foss.st.com> <CAPDyKFqJsqmNzeRg8hj55yUEMSycOWsmKVKsMWk4Qu7Y8_dNzg@mail.gmail.com>
 <3b6781cb-8f59-e70a-bcf8-9fb48fa47cbf@foss.st.com> <266de9f5-826a-c1bf-be8d-11f5e27c87dc@foss.st.com>
In-Reply-To: <266de9f5-826a-c1bf-be8d-11f5e27c87dc@foss.st.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 15 Jun 2023 20:51:42 +0200
Message-ID: <CACRpkdZLtCwPQsPw_Lp3Ppw2ed6gOo+-82_y2WPVJ_oZUHbLoQ@mail.gmail.com>
Subject: Re: [PATCH 1/6] dt-bindings: mmc: mmci: Add st,stm32mp25-sdmmc2 compatible
To:     Yann Gautier <yann.gautier@foss.st.com>
Cc:     Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-mmc@vger.kernel.org, devicetree@vger.kernel.org,
        Conor Dooley <conor+dt@kernel.org>,
        Russell King <linux@armlinux.org.uk>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Christophe Kerello <christophe.kerello@foss.st.com>,
        linux-kernel@vger.kernel.org, Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Xiang wangx <wangxiang@cdjrlc.com>,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 5:19=E2=80=AFPM Yann Gautier <yann.gautier@foss.st.=
com> wrote:

> >        - description: Entry for STMicroelectronics variant of PL18x.
> >            This dedicated compatible is used by bootloaders.
(...)
> >        - description: Entry for STMicroelectronics variant of PL18x for
> >            STM32MP25. This dedicated compatible is used by bootloaders.
(...)
> > Should I remove (or adapt) both descriptions?
> >
> >
>
> At the time the patch was done it was really just used by bootloaders.
> But as it is now used in the driver for delay block, I should remove the
> second sentence.

Remove both.

After "This dedicated compatible is used by bootloaders" there is
an implicit "in the SDK provided by ST Microelectronics", and that
is of no concern for DT bindings, which are (well, in theory) used by
e.g. BSD or other operating systems and who knows what they will
use and not, we don't put Linux specifics in there, neither Boot
loader specifics nor ST SDK specifics.

At least that is the little bureaucratic ambition we have.

Yours,
Linus Walleij
