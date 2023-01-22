Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7AC6770A5
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 17:39:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbjAVQjH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 11:39:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229837AbjAVQjF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 11:39:05 -0500
Received: from mail-vs1-xe33.google.com (mail-vs1-xe33.google.com [IPv6:2607:f8b0:4864:20::e33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A500193DE;
        Sun, 22 Jan 2023 08:39:03 -0800 (PST)
Received: by mail-vs1-xe33.google.com with SMTP id p1so10601769vsr.5;
        Sun, 22 Jan 2023 08:39:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qACnEDq7CQssFw5cLANDAZIL8Q9CdsrvgqR6kIK4R8c=;
        b=jJdJqLIc+y4MZw9WOKgOIdA8RdCtfAyAC4ly6O+FiaPwA6i9Vkj6mOnl7k0Nid0rin
         vUWH1uUMl96R8SgK/deZTF8bEAmms9Nlqbdz/TqRNyH/n8LkH0+FUYwEqxlIEhBl2UaO
         e3C4TFeYyqsO46rVZHVBRMjOJeJQ7Ces6Woo+UX2sZJG7T3RmJ+erLJK5cdvVFz9qcLq
         TjvZVcQEhCXfFKSNPapz+4oBkNleg/HQVrykDvKhs0V1kciTCYEsLoe9n86Vm3UqjEgn
         bApLH9Pjo2Jj82mMMZm1CfXu9qfcTDbem4SSaMcmxZzZOQ/uIp0lXWdwvusE3CcjAraJ
         l9Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qACnEDq7CQssFw5cLANDAZIL8Q9CdsrvgqR6kIK4R8c=;
        b=Qou7xKrx5/CZqnzmtZoUSXS6EEJkD1CxPLElH/pSFn87n2sdzOexwopPW8Mo6GWC4l
         Brh0279cHfimKybrL7DPtaAAdyb09gxJu683EVhtj7eYVfkGml86PfM8IN7LfQYP1Vh6
         1T69nDI8goP6vfiO+h+iO6ISBmuq0+8oT5IB0cWPkTYiYxwOjZaqP4cXbY+/JWGjTFoF
         FH/u7PThSdqL3eoaEbrGb/2Wec5mAfeqokAWxQKWqyVK0CNJJcfEli14EEMcGpvAxqKU
         rPLcaPakwyos3GopuunCfZJauEBc4zBQJQX3IIf81pQR8m1jT8LCpIxjlNlgLDNWgwhc
         MC8Q==
X-Gm-Message-State: AFqh2krlI9ZFf2wIG/mLCslnVcEg+a71u57/IdxqLCcqwkbBYezH4f4u
        sdo5YlFCUMRX2maRU6oqd5p1yS4LTYoGt0COH4A=
X-Google-Smtp-Source: AMrXdXsCmLpwa6AXzrh9D8riQ0Uxyadw4wR/THSg7SpKGBjdHUSxiY3O2+LwgCKTZeAjUn4YRFUUtNU3XJBaid5WnCg=
X-Received: by 2002:a67:d097:0:b0:3d0:cb3d:ad47 with SMTP id
 s23-20020a67d097000000b003d0cb3dad47mr3416403vsi.76.1674405542264; Sun, 22
 Jan 2023 08:39:02 -0800 (PST)
MIME-Version: 1.0
References: <20230121175639.12818-1-linux.amoon@gmail.com> <20230121175639.12818-6-linux.amoon@gmail.com>
 <d0bdc8f9-5ea8-5c77-3193-a2932c87156a@linaro.org> <CANAwSgT4P544a2MeybV_hXkDfc_HXiO4Rnxt4qG3RM1-X-KCEQ@mail.gmail.com>
 <07ce1655-d84b-e4f1-02d4-b69568830175@linaro.org>
In-Reply-To: <07ce1655-d84b-e4f1-02d4-b69568830175@linaro.org>
From:   Anand Moon <linux.amoon@gmail.com>
Date:   Sun, 22 Jan 2023 22:08:47 +0530
Message-ID: <CANAwSgSxasuEsqvwE-DLzjh8wBt3cRuWkHQv6aaWeXEgrvkRjQ@mail.gmail.com>
Subject: Re: [PATCH v3 5/9] vendor-prefixes: Add VIA Labs, Inc.
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-amlogic@lists.infradead.org,
        Matthias Kaehlcke <mka@chromium.org>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Johan Hovold <johan@kernel.org>, Rob Herring <robh@kernel.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sun, 22 Jan 2023 at 15:06, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 22/01/2023 08:04, Anand Moon wrote:
> > Hi Krzysztof,
> >
> > On Sun, 22 Jan 2023 at 00:21, Krzysztof Kozlowski
> > <krzysztof.kozlowski@linaro.org> wrote:
> >>
> >> On 21/01/2023 18:56, Anand Moon wrote:
> >>> Add the vendor prefix for VIA Labs, Inc. (VLI) is a supplier
> >>> of USB and USB Power Delivery controllers for multi-functional devices
> >>> and platforms.
> >>>
> >>> Website: https://www.via-labs.com/
> >>>
> >>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Signed-off-by: Anand Moon <linux.amoon@gmail.com>
> >>> ---
> >>> v3: - None
> >>> V2: - drop Drop marketing, so without "leading".
> >>
> >> Wasn't this merged? Didn't you get email?
> >>
> >
> > Yes, it was merged into USB testing branch.
> > I have rebased it on Linux master 6.2-rc5,
> > I hope this series picks up again.
>
> No, that's not how it works. If patch was picked up, you must drop it.
> Otherwise you might mislead maintainers (e.g. other maintainer) to pick
> it up again.
>

Ok I will keep this in my mind for the future.

>
> Best regards,
> Krzysztof
>
Thanks
-Anand
