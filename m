Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB4C75EEF78
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 09:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235279AbiI2HoF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 03:44:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiI2Hnp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 03:43:45 -0400
Received: from mail-ua1-x935.google.com (mail-ua1-x935.google.com [IPv6:2607:f8b0:4864:20::935])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BCF27D789;
        Thu, 29 Sep 2022 00:43:41 -0700 (PDT)
Received: by mail-ua1-x935.google.com with SMTP id a4so209066uao.0;
        Thu, 29 Sep 2022 00:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=hUW+w97bjwcMZAz2wEha3h2rI21nTjZgAo+7PEzzR7o=;
        b=IE9LHSxpzmDUKXAXpwHaYnHjLj1WufJVEYfJ1hGOFxil3rrScoNoLneEmDUcqYGDo/
         cmnDLwBy5pEenkueOTqCV+am/5vXym19TECHw5twZhfNwDVDerAskkddsMYTI5iyXcb9
         DKeNtto5a2ndL2uhg4dGQ+GhgCdAK8SvkRUTbps0BQnaxHCtqGHEWrXW1L8fXhtkJtvK
         xEbpRhYNxNBRsDCHgiwHkY7GxRqwABdkPK0KVFe4aKZvOyCNtvpSM5qwc9EXYZdj7Ccx
         +pI87QqvzlYDGu6n8JKzdWzkbjB8p0Z8F352cBkYLNp5LL5IyZKCRiZJ4CAtoLvoTv3W
         5eTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=hUW+w97bjwcMZAz2wEha3h2rI21nTjZgAo+7PEzzR7o=;
        b=iA3hcRubxNaD3F5znpW2v21sAUQ02aV/Eme5ySqZHWX2XGMZ0hqc6PqrS2aNYJzCNM
         7XOvA9WeLsxI9jSHdYHeYAUmcSjsTRoM3vxHH7+QNUAIXQhUPRmtN/p1fuQWuVwaY+yY
         NqLdeyF/QAJmjpVkMMMVAuksYkSA7dTkMKpTXCQej3Rgmoq+bIg//oIsJuqJcTFSXN1r
         97IbqBFpd5a90gMxtx/NJO6ArIouOZ17FKvICxpO6nIMeM+O298LNBshSr6kCFsg8oqn
         tABsvapuLbbAg6Ba5zRcZcDTRyBDniyGf+wIk5KefrcvGObvxQA5EEAs9p+/5BzIRvy0
         p03g==
X-Gm-Message-State: ACrzQf1hS+urFFtsOMtrmsHyu8dYArGsdKXmUErK191kYZC4dOmVgEZT
        yPsBZmS3mPj7refPDuVFDeUGfv+OConztQZYPD8=
X-Google-Smtp-Source: AMsMyM7ZHbYAiRKbQseodi2xdbkJcMUR30vIeLDXSMJPODyQS/Sgc7Hny7j2kIzLs5PAY4GuSRRyTMEfCI5USrXqyrw=
X-Received: by 2002:a9f:3767:0:b0:3d1:2de3:12a8 with SMTP id
 a36-20020a9f3767000000b003d12de312a8mr881708uae.47.1664437420589; Thu, 29 Sep
 2022 00:43:40 -0700 (PDT)
MIME-Version: 1.0
References: <20220928092937.27120-1-zhang.lyra@gmail.com> <fca2b97c-9d4f-d372-ef2a-aae8b367bbe5@linaro.org>
 <CAAfSe-t=-pZAcrY0o-ct1uJaNhtkCMQKNW5gOrJfE6DEOhSZDw@mail.gmail.com> <bb61ff78-182f-f4e2-bee8-556234ca07ee@linaro.org>
In-Reply-To: <bb61ff78-182f-f4e2-bee8-556234ca07ee@linaro.org>
From:   Chunyan Zhang <zhang.lyra@gmail.com>
Date:   Thu, 29 Sep 2022 15:43:04 +0800
Message-ID: <CAAfSe-veC5syRMLbDDxDsYXTx=OS09DEMGS-O=c_9PSa7r9tuA@mail.gmail.com>
Subject: Re: [PATCH 1/3] dt-bindings: gpio: Conver Unisoc GPIO controller
 binding to yaml
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        Baolin Wang <baolin.wang7@gmail.com>,
        Orson Zhai <orsonzhai@gmail.com>,
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

On Thu, 29 Sept 2022 at 15:02, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 29/09/2022 04:29, Chunyan Zhang wrote:
> > Hi Krzysztof,
> >
> > On Wed, 28 Sept 2022 at 19:31, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 28/09/2022 11:29, Chunyan Zhang wrote:
> >>> From: Chunyan Zhang <chunyan.zhang@unisoc.com>
> >>>
> >>> Convert the Unisoc gpio controller binding to DT schema format.
> >>>
> >>
> >>
> >> Thank you for your patch. There is something to discuss/improve.
> >>
> >>> diff --git a/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
> >>> new file mode 100644
> >>> index 000000000000..c0cd1ed9809b
> >>> --- /dev/null
> >>> +++ b/Documentation/devicetree/bindings/gpio/sprd,gpio.yaml
> >>> @@ -0,0 +1,70 @@
> >>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >>> +# Copyright 2022 Unisoc Inc.
> >>> +%YAML 1.2
> >>> +---
> >>> +$id: http://devicetree.org/schemas/gpio/sprd,gpio.yaml#
> >>
> >> Use compatible as filename, so sprd,sc9860-gpio.yaml
> >
> > Humm... This is not only for SC9860, also for other IPs, UMS512 as an
> > example which added in this patchset.
> >
>
>
> Then it's ok. It seems you have also typo in commit subject (Conver).

Ah yes -_-||, will fix that.

>
> Best regards,
> Krzysztof
>
