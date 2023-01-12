Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3376666F4A
	for <lists+linux-kernel@lfdr.de>; Thu, 12 Jan 2023 11:16:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239716AbjALKO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 Jan 2023 05:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237845AbjALKNV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Jan 2023 05:13:21 -0500
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 914E5395;
        Thu, 12 Jan 2023 02:11:54 -0800 (PST)
Received: by mail-ot1-x32c.google.com with SMTP id f5-20020a9d5f05000000b00684c0c2eb3fso1248405oti.10;
        Thu, 12 Jan 2023 02:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GdaiFhugD6+oPaJhwaL4Kajgsb7fLINSYFgd7bDk4J8=;
        b=D6929yU096JD5AfK5EnzixHXiNvJbcDjIam7feV518ZFPQ6LVTQh5wQIhG+OgWPiRw
         KvLXMi97RsaXG8bTb3+V56xQKO4wlgzrhRd64S8cS9kQnyLAlgmhOikgWH1PtOGq3TlG
         lIvP5HqZfj4l08Ki6geXDihjhmOt5p1udP93sv5SKL8q5N1HEaJSDwHAMEd10sQStEeR
         QYyLm8JAvEX+LhUQgRu3nEQGJtb2ehJYr3DSgH0qofHyay7TvmGejEX5GjcGOt0XfgSt
         NFZbmf4PlO8vZ/H98VLaBUhuDiLeFCq3lIT3juTqm2DutAJtg8mz26hz780GefQO9mYs
         nEVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GdaiFhugD6+oPaJhwaL4Kajgsb7fLINSYFgd7bDk4J8=;
        b=0JyKCHHxTtZMEjPOXQ6Jt6BrEU5CISEo2BvCmr+dOgFvOrc0/lVVmfv8ut+VPoQmP1
         Db3cBxuv3xeZzBAZf8F4pligR2Uegn8iQRYRSF0xLtv4IJ2HIZvokZEieSm46x+5ZrNY
         PbAoUUr/4ZH3S4XJqqskxt0DdeaJ3H2jbInjsmqu99xB1PHd12WZUdiw5VxouMC8iB3R
         N7IB7c7oOxcwc7/W0vaDxEULexjo6AN1eI9i0M9LHrw+nQn6NRlMkw1oFc/nbk9VQBqp
         uBPdG2v6ifLyG8ARBqJ9QBFexstxkF3VPffB6+DrS/9Z5D4Wf3OS3j9nU9CaMTFj0P9p
         mwYQ==
X-Gm-Message-State: AFqh2kq030eCCQQPrNxuatz+U0fHvfE6PaxcdWtpKLKaf6484dEvpBCS
        ucDWNdvMkZx3kvtUnt1X5PpzcS024on9G9kvA6M=
X-Google-Smtp-Source: AMrXdXu4i8RZ9oUXZZSSmOvejAHMluXivRyO1ot2lck+WOreatEKCm4GQt8+55NYUd7PhqhGQaNxDyqmW1WQ2gYseuU=
X-Received: by 2002:a9d:75d5:0:b0:675:4bf4:dba2 with SMTP id
 c21-20020a9d75d5000000b006754bf4dba2mr6017172otl.304.1673518314006; Thu, 12
 Jan 2023 02:11:54 -0800 (PST)
MIME-Version: 1.0
References: <20221231160849.40544-1-arinc.unal@arinc9.com>
In-Reply-To: <20221231160849.40544-1-arinc.unal@arinc9.com>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Thu, 12 Jan 2023 11:11:42 +0100
Message-ID: <CAMhs-H848zZRtnGjaEty4+0DmD69rN11FHUfrd7xQcaastfH3w@mail.gmail.com>
Subject: Re: [PATCH v3 0/6] Enhance Ralink pinctrl documentation
To:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org, erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 31, 2022 at 5:09 PM Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc=
9.com> wrote:
>
> Ho ho ho,
>
> This series mainly enhances the Ralink pinctrl documentation, and make a
> small variable name change on the subdrivers.
>
> I've compile-tested all the subdrivers.
> I've tested the dt-binding changes with:
> make dt_binding_check DT_SCHEMA_FILES=3Dpinctrl/ralink
>
> v3:
> - Changes on v2 were put on the last patch. Fix that.

For the whole series:

Acked-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>

Thanks,
    Sergio Paracuellos
