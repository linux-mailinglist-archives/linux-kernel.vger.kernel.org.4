Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3220D6AC0B9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 14:23:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjCFNXu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 08:23:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjCFNXs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 08:23:48 -0500
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E105727480
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 05:23:46 -0800 (PST)
Received: by mail-yb1-xb33.google.com with SMTP id c80so1074965ybf.5
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 05:23:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678109026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=xvyn9YaeJ86q8W8Lig51PjsTK8zYrWmGcOa1PW4eicM=;
        b=fx9JPxs8+fzKQ6JqYbK+ifFmBjQ8eiYWeu+QMPOh5aQDwncSjoIKNL+6iwAOjYGL09
         3Faqia2eMlfEynDpLbJsBSy18Shb+rKJvTtBtUgqrHGWJsxEBFUk5jymRW2ciTwgAkBj
         Po/2KOc34FC5F1VTHjYFGz/7k77mF4aZk6Xu1s8tuGev7TIh09D/mEHWsAaiA7Wq09Ff
         tvi4rLXv5h/JsFMe/neIUqta45IBBHusMEqepEMZjXSFb1OGWAJOTjlL6QCtSiCbozNh
         D//3aNiuN/Ed5uiK2252qkssT63iyt6DfhlB2t6qIaaMPbKb7TJO/3+omybR4yL88MJ/
         g/Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678109026;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xvyn9YaeJ86q8W8Lig51PjsTK8zYrWmGcOa1PW4eicM=;
        b=uXZSky23/8gj4krSxItvwJbByAxM8aKNFJaM8YrbIMqh4i9LV8YcyxMJ6j6BWo7s8M
         Z8ecYMV33F2sabii+a+yJWuN5ndxWsR74+wh82hhDORhlbSE2g/NBQZuIrkx48/4Yy1b
         6m/13vApG/gdzL/mnDTqhcCDZLSj6v4Y21p3bVWmXx21f+SHaLv0HqOuJQn86LCt5SfY
         kzZFnx6cO/K00IB8NUyQp9AlkfqbvmDLxVCPur8jiXaH2X01AW21b/wH4L8QyxmUUjdp
         /+gbgxizWSN6UqVtvSP8mvSxWBiTsxelyMNb59bMqoa1z02ll7qTEFH5IHw/WFyP35Q5
         Ac6w==
X-Gm-Message-State: AO0yUKUINajbGT6mbSQc7Zhr4Aj2wLO+7sJ1OF2+RFP+yQnbrr9kn+Pc
        tt/ahxD29xHc9HKRKxwaKtldI8ad1b+Vpcpa5k2HzQ==
X-Google-Smtp-Source: AK7set9u5szpr+wnH4nFcOvWFTNqyAYPnIW16Yn+p0DCJfxCmYIAe+HSI0DHLu7vDQphHfezI+/du5AHMakyD/+qNYI=
X-Received: by 2002:a05:6902:4c2:b0:ab8:1ed9:cfd6 with SMTP id
 v2-20020a05690204c200b00ab81ed9cfd6mr6273934ybs.5.1678109026098; Mon, 06 Mar
 2023 05:23:46 -0800 (PST)
MIME-Version: 1.0
References: <20230218065108.8958-1-arinc.unal@arinc9.com> <20230218065108.8958-2-arinc.unal@arinc9.com>
In-Reply-To: <20230218065108.8958-2-arinc.unal@arinc9.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Mon, 6 Mar 2023 14:23:34 +0100
Message-ID: <CACRpkdb5vpTW+1VmYjm_28_rFNPpuD1fANdKXN-WdFiajoe30A@mail.gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: mediatek: fix naming inconsistency
To:     arinc9.unal@gmail.com
Cc:     Sean Wang <sean.wang@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Daniel Golle <daniel@makrotopia.org>, erkin.bozoglu@xeront.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Feb 18, 2023 at 7:51 AM <arinc9.unal@gmail.com> wrote:

> From: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>
>
> Some options include "MediaTek", some "Mediatek". Rename all to "MediaTek=
"
> to address the naming inconsistency.
>
> Signed-off-by: Ar=C4=B1n=C3=A7 =C3=9CNAL <arinc.unal@arinc9.com>

Patch applied for fixes.

Yours,
Linus Walleij
