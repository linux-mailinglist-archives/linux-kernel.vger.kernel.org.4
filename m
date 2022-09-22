Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4EE95E5D68
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 10:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiIVI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229774AbiIVI0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 04:26:21 -0400
Received: from mail-ua1-x92e.google.com (mail-ua1-x92e.google.com [IPv6:2607:f8b0:4864:20::92e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202D8A5986;
        Thu, 22 Sep 2022 01:26:21 -0700 (PDT)
Received: by mail-ua1-x92e.google.com with SMTP id p17so3343120uao.11;
        Thu, 22 Sep 2022 01:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=UEA8ooFTNqtXq+77opiJRgCnVU8OJk7FFOA5sDDKilg=;
        b=VHgYbQSFlaC7MEce3j43T9smtKpuzO/hqHxxZcoGidfy7F/fRONUkCiVJU1TcbMnXB
         xu29mrqEyZWndoYglYm41D/ibzQqOrJ6TO9e52DwzIrgpUrp6Xz64/62oPV0chLe25o6
         ZeRmbLsuP9EPiquMuygvchF/5iFt/1FqwLlT02Xu6XwptvZpC1WUc9dTtyglQVTDBRcN
         SsCAgrtd9MypxJkN/QbZXJmsANzFRc37BHoNV1Wk7OLEZ5RIZ8zQnBKcwxh08zC2NM1L
         xG1ujztSYq5MrVfZB9h8okYZdz5tYIdIv3PSlGHv5fizWaBXIs71hnmIP6tykrx/pABQ
         mzIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=UEA8ooFTNqtXq+77opiJRgCnVU8OJk7FFOA5sDDKilg=;
        b=XQxFX99MG+9D2hOaDXyKGpJ2LpvSm3/Srrv4iEhgnuL0YL00JInQghUNtdgsnoNLCN
         PAcUXKX0529UM/tailA/ti4oMAJH8Xaqa1a3sQUlKUBAMS6lSB0CeIiJLAdVF1a7M3/t
         Wl/UIIkaBJolaFIVjjo3iEwTQvCx8CvQJmHXnMLJHpR0fApMPa7d7nWSWnQb6IZUZdhV
         0HiKl3+SzFO5zKZJMwyq7RM/Rf/UiKgo0Vj1b6kKnHembFqEyEZtqL/Tv7+B4+DCmy+A
         /XuT8aK30bCjlj0Iz+YIb+GUXdh9ct0s2ot69btN8U1JRixV91jN3kCdVYQBg/fuUnkm
         bhHQ==
X-Gm-Message-State: ACrzQf20RYyQJoxhLynCWPbF1WmOfDywHzO2bJVX9Iz8lrN8uB0dYEFU
        MW0dtZwTUaiq4eNrqIbN+bz81J8afmgU+Opdps0=
X-Google-Smtp-Source: AMsMyM4FgFLyZsi48F7mPHKt50RJpp/tW7TlStKAZlfc3N89B28A5HzsfdxgqAxAaY7eDmhQdk/sk6v5oGo+HpDNW90=
X-Received: by 2002:ab0:60b2:0:b0:3c2:5006:e4b6 with SMTP id
 f18-20020ab060b2000000b003c25006e4b6mr744957uam.110.1663835180205; Thu, 22
 Sep 2022 01:26:20 -0700 (PDT)
MIME-Version: 1.0
References: <20211008031953.339461-1-zhang.lyra@gmail.com> <20211008031953.339461-3-zhang.lyra@gmail.com>
 <YY5wPh0rwRvFjSRG@sirena.org.uk>
In-Reply-To: <YY5wPh0rwRvFjSRG@sirena.org.uk>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 22 Sep 2022 16:25:44 +0800
Message-ID: <CAAfSe-uA3iowafC25zRqoTSaub1PbOzUvQgukLm=szEge_abvw@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] dt-bindings: regulator: Add bindings for Unisoc's
 SC2730 regulator
To:     Mark Brown <broonie@kernel.org>, Lee Jones <lee.jones@linaro.org>
Cc:     Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mark,

Sorry for the late response.
[1] is the v1 on which we had some discussion. I hope that can help
recall the issue below.

On Fri, 12 Nov 2021 at 21:46, Mark Brown <broonie@kernel.org> wrote:
>
> On Fri, Oct 08, 2021 at 11:19:53AM +0800, Chunyan Zhang wrote:
>
> > +properties:
> > +  compatible:
> > +    const: sprd,sc2730-regulator
>
> I still don't understand why this MFD subfunction for a specific device
> is a separate binding with a separate compatible string, the issues I
> mentioned previously with this just encoding current Linux internals
> into the DT rather than describing the device still apply.

I understand your point. But like I described previously [1], if we
still use the current solution (i.e. use devm_of_platform_populate()
to register MFD subdevices), a compatible string is required. I'm open
to switching to other solutions, do you have some suggestions?

Thanks,
Chunyan

[1] https://lkml.org/lkml/2021/9/29/1166
