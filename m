Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A6525F2283
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Oct 2022 12:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbiJBKXl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Oct 2022 06:23:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbiJBKXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Oct 2022 06:23:38 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A544303C1
        for <linux-kernel@vger.kernel.org>; Sun,  2 Oct 2022 03:23:36 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1324e7a1284so1514619fac.10
        for <linux-kernel@vger.kernel.org>; Sun, 02 Oct 2022 03:23:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=semihalf.com; s=google;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date;
        bh=X9nF7yfV332xI2pclyCSreQbpAxeeHXwZnrfbaI8MKA=;
        b=CffKSKbiZV8Y+eJMNntuSra4NLtLhLgasKGRaI/suxM+1HUHx1DPQ+91FdSVxePeH+
         8M559dVec128pCO3ynZfQ2Sv4HJ8p3LwM5wS9C1TD0D+H8f1kFAVEzwM/H9Qneunr+8B
         tzBJ+NOpPUXGHpYx8Q2FJXBZ9HJJQkbjJo/Ldiv+ib42dpzpoD0Hj3W8ZihkjQJjCFuF
         xozSr13E0lHj5dZC4AN9ITTwhGDp2n41oYwHsR1aVC2WhCRNxpuNRvKgADPSOFQ45f+N
         mq3dULZ/bKcH/39edv2d83c9LB0/Yc7F4PgI77d/LTMgSGdXNV8yp6N02NTiIoZ9gpNu
         KECQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X9nF7yfV332xI2pclyCSreQbpAxeeHXwZnrfbaI8MKA=;
        b=pIgJhFE8kQezefqYDOXePap3Q7T2bKmYPhBW4jblvWX+1hKJxPfTcjPFynqX5taQjH
         pYnBjLy5xS6qE0aKHOYONvGk81183ANb/OtCIgZfzrI4QMHS7kd2s2dX0dAcb/2jBPOf
         G8ZLtdhA3cExF0+hd6mV9wj5Td+ttowlYEqqLVs/M1PH/Dk8ocx2RjZoZz+BxLOlMaOu
         KI6PAeZiwzcSIF/W2yK+0RRa8kxIhzGvyZCOUawpBqt+cxUJ3pBZjgHC7RjNtmmxVOlg
         QJsuRTghqMYccYFJshmnCLHML+1iTCv43poFdVxvaXddZpmd02ONjRccWEV0AaF/gzkm
         dZUQ==
X-Gm-Message-State: ACrzQf3vWtZvTAEEITivx18FVj3YfFHDajrCd8+wzk3B4zaqF6TTP5Lc
        hsW6V6Y1nHw5Q6tfHhQJPLWlFL5aSYuBQuPQWtJ9bg==
X-Google-Smtp-Source: AMsMyM6WuTchjp6IHVq0M6A85omP4rK9KT9JhLY6jQee51blcDvcvwrfKa1EN3Yk0cpDXufHnvUSsKeNk+VtPbQy+to=
X-Received: by 2002:a05:6870:790:b0:131:b107:5eea with SMTP id
 en16-20020a056870079000b00131b1075eeamr2957302oab.66.1664706215604; Sun, 02
 Oct 2022 03:23:35 -0700 (PDT)
MIME-Version: 1.0
References: <db7055da-b01f-3ca6-20f8-e9bc7ed892bc@linaro.org>
 <20221001155353.10211-1-mig@semihalf.com> <3b234066-268d-8da9-caa6-ca4d693dc0d0@linaro.org>
In-Reply-To: <3b234066-268d-8da9-caa6-ca4d693dc0d0@linaro.org>
From:   Marcin Wojtas <mw@semihalf.com>
Date:   Sun, 2 Oct 2022 12:23:27 +0200
Message-ID: <CAPv3WKcW+O_CYd2vY2xhTKojVobo=Bm5tdFdJ8w33FHximPTcA@mail.gmail.com>
Subject: Re: [PATCH v2] dt-bindings: net: marvell,pp2: convert to json-schema
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?Q?Micha=C5=82_Grzelak?= <mig@semihalf.com>,
        davem@davemloft.net, devicetree@vger.kernel.org,
        edumazet@google.com, krzysztof.kozlowski+dt@linaro.org,
        kuba@kernel.org, linux-kernel@vger.kernel.org,
        linux@armlinux.org.uk, netdev@vger.kernel.org, pabeni@redhat.com,
        robh+dt@kernel.org, upstream@semihalf.com
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

niedz., 2 pa=C5=BA 2022 o 10:00 Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> napisa=C5=82(a):
>
> On 01/10/2022 17:53, Micha=C5=82 Grzelak wrote:
> > Hi Krzysztof,
> >
> > Thanks for your comments and time spent on reviewing my patch.
> > All of those improvements will be included in next version.
> > Also, I would like to know your opinion about one.
> >
> >>> +
> >>> +  marvell,system-controller:
> >>> +    $ref: /schemas/types.yaml#/definitions/phandle
> >>> +    description: a phandle to the system controller.
> >>> +
> >>> +patternProperties:
> >>> +  '^eth[0-9a-f]*(@.*)?$':
> >>
> >> The name should be "(ethernet-)?port", unless anything depends on
> >> particular naming?
> >
> > What do you think about pattern "^(ethernet-)?eth[0-9a-f]+(@.*)?$"?
> > It resembles pattern found in net/ethernet-phy.yaml like
> > properties:$nodename:pattern:"^ethernet-phy(@[a-f0-9]+)?$", while
> > still passing `dt_binding_check' and `dtbs_check'. It should also
> > comply with your comment.
>
> Node names like ethernet-eth do not make much sense because they contain
> redundant ethernet or eth. AFAIK, all other bindings like that call
> these ethernet-ports (or sometimes shorter - ports). Unless this device
> is different than all others?
>

IMO "^(ethernet-)?port@[0-9]+$" for the subnodes' names could be fine
(as long as we don't have to modify the existing .dtsi files) - there
is no dependency in the driver code on that.

Best regards,
Marcin
