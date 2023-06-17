Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC8E773413A
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Jun 2023 15:32:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234543AbjFQNcH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 17 Jun 2023 09:32:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229635AbjFQNcF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 17 Jun 2023 09:32:05 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 724DA19A1;
        Sat, 17 Jun 2023 06:32:01 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-55ab0f777afso1302967eaf.1;
        Sat, 17 Jun 2023 06:32:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687008721; x=1689600721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CUMiTZ5iGfC0qJ9KfHtJIyZWfHPRwn7POyp9hU5HJvo=;
        b=pOuS/z7vpdvkNpnuXnY9p6x4DFTBZeh9TgoMO3DmbGN4wNKdzlfGwKI8KRET6lTAfS
         VqsbWDw6GOermLkOxNLLG0esZL1Zuv3fswbHh/JYPXLl9q6v9krbT3+lDtVoXM4tyVaJ
         9giypgVTYMstYbpQ0Vei6IMHNXmEDB4yv5VgEDEl7846FbGD0SDz+q+4JbmVGWcsuq6a
         uuDFzu1acXG+ynZFPBnah1NYKwp3Dn2PoMfIKrZsVfmo2H7B1yDDL4rCLh+CFs09eR6u
         zwFYK/2TqPTb9sZEfEtdfNP1M+KkOagfJT+Az0tYoOgfNG0zqKs05ijqTkAOiTZpGdBN
         6jBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687008721; x=1689600721;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CUMiTZ5iGfC0qJ9KfHtJIyZWfHPRwn7POyp9hU5HJvo=;
        b=lm28DkLjRzGiIQH/DtaSa4JnTvt18oR2HUJNjACiKjBn5YV3yvpmXqPiJPObfMSnBX
         uPqNp6/1Xsdhb5SVMrbyuMR9FsAgqPpnKENUhxxqrJ/LILmnC8bpVa7zDgzT+5GNLDGq
         NVdqC7TjWf8qgyitH1M78Whm7Ep4txxduGhM2PphvpPmJ5BBWpJ98QApoOYGHuopXLpY
         KVjh4bZOwmclNFtiowckD0Hoey/FHs1m1VjEQAfjZ5/7LjsRB3l0u8mbPd3MG6p/CzNt
         JjhCICxYY2ZbZ7M+OO5oQH43d2rkwbTbwzbnFemqH7DuP2nmRHJ51DRN8Z9ZfylvZOXg
         fhBw==
X-Gm-Message-State: AC+VfDwcGuwGUGcGQw+pbLm+0jVsNxZVyee0TCBSodOWAgsw+nYop9Lo
        dV6mhzkZXY/QvZ1SExUfGhwDhwwYBAt8BdWZf7I=
X-Google-Smtp-Source: ACHHUZ47Ctt7aAwffbarYc289j756pVlY15S+gI2Ob6gmNYOT7cJ09I8OY3JJAuw0s+EyQy6+UEy8N1xPrqbGEeYQ2w=
X-Received: by 2002:a05:6808:d52:b0:398:5d75:c0ac with SMTP id
 w18-20020a0568080d5200b003985d75c0acmr7341292oik.14.1687008720726; Sat, 17
 Jun 2023 06:32:00 -0700 (PDT)
MIME-Version: 1.0
References: <20230617052435.359177-3-sergio.paracuellos@gmail.com>
 <TYAP286MB0315AB8274CDD341D49809A2BC59A@TYAP286MB0315.JPNP286.PROD.OUTLOOK.COM>
 <e0f74bdc-3a4b-596a-5ec7-83054377813e@linaro.org>
In-Reply-To: <e0f74bdc-3a4b-596a-5ec7-83054377813e@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Sat, 17 Jun 2023 15:31:49 +0200
Message-ID: <CAMhs-H9M_c8+AkqUTpYeS2q7_+wBA-jhhiXj-QVXNUDmuERcOA@mail.gmail.com>
Subject: Re: [PATCH v3 2/9] clk: ralink: add clock and reset driver for MTMIPS SoCs
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Shiji Yang <yangshiji66@outlook.com>, arinc.unal@arinc9.com,
        devicetree@vger.kernel.org, john@phrozen.org,
        krzysztof.kozlowski+dt@linaro.org, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org,
        matthias.bgg@gmail.com, mturquette@baylibre.com,
        p.zabel@pengutronix.de, robh+dt@kernel.org, sboyd@kernel.org,
        tsbogend@alpha.franken.de
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

Hi Krzysztof,

On Sat, Jun 17, 2023 at 3:07=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 17/06/2023 14:54, Shiji Yang wrote:
> >> void __init plat_time_init(void)
> >> {
> >> +    struct of_phandle_args clkspec;
> >>      struct clk *clk;
> >> +    int cpu_clk_idx;
> >>
> >>      ralink_of_remap();
> >>
> >> -    ralink_clk_init();
> >> -    clk =3D clk_get_sys("cpu", NULL);
> >> +    cpu_clk_idx =3D clk_cpu_index();
> >> +    if (cpu_clk_idx =3D=3D -1)
> >> +            panic("unable to get CPU clock index");
> >> +
> >> +    of_clk_init(NULL);
> >> +    clkspec.np =3D of_find_node_by_name(NULL, "sysc");
> >
> > The node name should be "syscon" as the example node name in the
> > dt-bindings document is "syscon".
>
> NAK for both.
>
> Node names must not be an ABI, unless you talk about child of some
> device node. I don't think this is the case here. Look by phandle (for a
> device context) or by compatible (looks the case here).

We need to get the cpu clock to set the initial cpu clock here. Search
by 'sysc' is the only  shared in all the dtsi files since it is the
clock provider node. Why is this not correct? I don't understand what
you mean with look by phandle for a device context. The case of
searching for compatible is a mess since as you can see in the
bindings there are tons of compatibles to search for, then (this code
is common to all ralink platforms).

Thanks in advance for clarification.

Best regards,
    Sergio Paracuellos
>
>
>
> Best regards,
> Krzysztof
>
