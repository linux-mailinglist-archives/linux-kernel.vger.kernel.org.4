Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA04F72FBDD
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 13:02:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235066AbjFNLCq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 07:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233170AbjFNLCm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 07:02:42 -0400
Received: from mail-oi1-x22f.google.com (mail-oi1-x22f.google.com [IPv6:2607:f8b0:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93B611BC6
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:02:40 -0700 (PDT)
Received: by mail-oi1-x22f.google.com with SMTP id 5614622812f47-39a3f165ac5so3843256b6e.3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 04:02:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686740560; x=1689332560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B7n28fOV0ec1Tw2+qWmFSFZwMwZ5UkpPV/M6nrRgIrY=;
        b=O9WNazqTO3lUTcjFKo+mMX+lO0KaH4Aqp7PfLKjDds3HB/ihZVzbxLLVm2FzxtQLuZ
         m2xMT/YfYgoCbkOWJsn/C7kyrrqbveOnMXPRv3kAevimACTJiFUvqdRQ5VVYvBLff+pB
         TepOU554ykwGt3AeiFAczf0bctpG/p+qPDulZgMTdc6Kqko3T100yrT2YYFHlBvL451y
         e0Xw//XQPT+xQa5mubCNROIHsU83LmYAxVKB9iNUZS2SFbg0Qcbc3mUoXmkEDKD9YAbv
         laPt/AUt/FWBIoOvOUH1T1mbHCHVw5xMDnontfdwuw2PoCPi/mrGVWuHLA+TlwYlxXGu
         A1rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686740560; x=1689332560;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=B7n28fOV0ec1Tw2+qWmFSFZwMwZ5UkpPV/M6nrRgIrY=;
        b=M+G9DBEbivfjoFG4kvoB7isM0vEz5owDkma+n4uBS2yT9d1UCLrHPSZmQmKb3lssm0
         wcEZwLY0QUmWn9ow9tvjJm4ZUiDIT2gIxJadX3NhhwFXCQqAhZ7HvzGNCjDjUaPLTD6s
         WUIPW7HpNb9pecUwb3EdxKHYWaZIwZjaAkXw75eYaMmVJiEpuCIiI6EuAHrTTm46cnPT
         WIpcLVLQe9f1yVVEs/5BsCOfvDJBFBDfRj76jVpRW3BtYNMVDtCmWNLy8kz/IDOMTUJ4
         v6INb3fLp5+7OmYnyA/nGHoCWNyjC4EHDxmjqjC48Av1Lgjbm++iyEyZJL/DMls/apc5
         qjyg==
X-Gm-Message-State: AC+VfDwo4E6CPg4WtIyB6Wh06wwjXNufgRfOGd2nfkhHlJjFaVa+wG7C
        FhtUfzsi0kJc1eWvIgFxjruPn2TJnenDWODFa7rAGQ==
X-Google-Smtp-Source: ACHHUZ4mY8nx43hAFWe4CQB5v7vGWAlyy4P6dhWyMk8YiOo/gBQVm0YzK2YgRY0RdDIQ76ozPyVPQPVUCxL6RL2PR/M=
X-Received: by 2002:a05:6808:284:b0:397:f82f:90a4 with SMTP id
 z4-20020a056808028400b00397f82f90a4mr9759150oic.3.1686740558467; Wed, 14 Jun
 2023 04:02:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230609063615.758676-1-yangcong5@huaqin.corp-partner.google.com>
 <20230609063615.758676-2-yangcong5@huaqin.corp-partner.google.com> <949a2d21-eb14-3ef8-a7be-9c12152cd15a@linaro.org>
In-Reply-To: <949a2d21-eb14-3ef8-a7be-9c12152cd15a@linaro.org>
From:   cong yang <yangcong5@huaqin.corp-partner.google.com>
Date:   Wed, 14 Jun 2023 19:02:27 +0800
Message-ID: <CAHwB_NKQuxBBCHrHs24CZ=r2HS9U=4BYu9gJQnkqLRYQGu1uzQ@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] dt-bindings: HID: i2c-hid: ilitek: Introduce
 bindings for Ilitek ili9882t
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Krzysztof

On Sat, Jun 10, 2023 at 12:01=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 09/06/2023 08:36, Cong Yang wrote:
> > The ili9882t touch screen chip same as Elan eKTH6915 controller
> > has a reset gpio. The difference is that ili9882t needs to use
> > vccio-supply instead of vcc33-supply. Doug's series[1] allows panels
> > and touchscreens to power on/off together, let's add a phandle for this=
.
> >
> > [1]: https://lore.kernel.org/r/20230607215224.2067679-1-dianders@chromi=
um.org
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
>
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> If there is going to be new version, then:
> A nit, subject: drop second/last, redundant "bindings for". The
> "dt-bindings" prefix is already stating that these are bindings.

As Doug  said,makes sense to land if the panel follower patch series [1] la=
nds.
If  Doug's series[1] land,  i will update this and commit message link in V=
6.

Thank you.
>
>
> ---
>
> This is an automated instruction, just in case, because many review tags
> are being ignored. If you do not know the process, here is a short
> explanation:
>
> Please add Acked-by/Reviewed-by/Tested-by tags when posting new
> versions, under or above your Signed-off-by tag. Tools like b4 can help
> here. However, there's no need to repost patches *only* to add the tags.
> The upstream maintainer will do that for acks received on the version
> they apply.
>
> https://elixir.bootlin.com/linux/v5.17/source/Documentation/process/submi=
tting-patches.rst#L540
>
> Best regards,
> Krzysztof
>
