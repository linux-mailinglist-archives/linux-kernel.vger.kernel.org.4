Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AE96C2931
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 05:34:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229642AbjCUEef (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 00:34:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229511AbjCUEec (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 00:34:32 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84D5D166D5;
        Mon, 20 Mar 2023 21:34:30 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17786581fe1so15132067fac.10;
        Mon, 20 Mar 2023 21:34:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679373270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qUs2zAXPOtYAth4VTg4HJovCnt+hv90v8Ki9Yz6QDEM=;
        b=D1zurgf5l5miMav/cDjr6nTTo186jRP0iGjwFIiktstGupS8nmgn4htAeBYBSgHljI
         rSisNmlYoRYhCQo/bAHHcTVjJyEBK0qgCP9zQTbAjoTbIP1TVranXL1P9rphcMzdRXcO
         50BmV7lnSO6Z/EK1fralFJ0nEveVYhS8gPm0vLD+UYcy5NQH13yd2o0SKrXNALuhpuTx
         3p4zC6CwcoeQOiK7MGiStbyTBn4F1hT4OFBLEjdUiY/UKho8Tml+AZ5HavEL1gRraNJE
         /ohriEDTsVSWMTDyJZTEUZVpA6yxoGUa6Y2+HkTQ10YLnEnE8W2Hf7owxjfAhDl2KO3Q
         yZgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679373270;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qUs2zAXPOtYAth4VTg4HJovCnt+hv90v8Ki9Yz6QDEM=;
        b=wb7YwP+3YWqx0jBmPskK+QE9i9nOMArm1YOXxakWdSi2LHRGxNcGF+0ZEOtlw57yOE
         4i7nRJgiVf565fNmozGX6lsjSn68EG5PlOtfdp3C35bMzhIEVMBfzI/YPqW+q0WvYISi
         hKPd+Kv9Ba2zrCeHmNYB4skHPOwikk/k+a2oYvOOblq6DUK1OULSMZWbyr0UHjshveqo
         ofV7imYDqZ1XpQfg96QQnfhpsfOpnpP/jqzP4rryi8BYYxMG+WjVFleq1moQRfDRI36t
         nVo4sVPq+JGiSDl8n/TXgoR4CbKXQdxqSFvoubrrx3eJqj3q4B0PYB60SUHyyGnB8cpY
         obpQ==
X-Gm-Message-State: AO0yUKXT2SnAqiHaVES8AFPejl3xoUFzRtWc19HbyzSuIomBU8LGCnOp
        ekCrzF/89yehFKAWyIk41ITQpRa+Pl8qaSp0pwc=
X-Google-Smtp-Source: AK7set/osPTPV+KDWROSFxeQ82lsZ+D0kNpgb59DbwDtGICu0p3iR8Hxq9STdb/+qZ+B8ermE+gUjBLk3Sz0i1AEZPI=
X-Received: by 2002:a05:6871:e02:b0:17b:e128:b4c2 with SMTP id
 vj2-20020a0568710e0200b0017be128b4c2mr229523oab.0.1679373269867; Mon, 20 Mar
 2023 21:34:29 -0700 (PDT)
MIME-Version: 1.0
References: <20230320161823.1424278-1-sergio.paracuellos@gmail.com>
 <20230320161823.1424278-2-sergio.paracuellos@gmail.com> <1e2f67b4-3bfb-d394-4f60-e6f63ce6a2fd@linaro.org>
 <CAMhs-H8OQ9gJLsifLuHD2GN8rYwnY=Zmdb0kMEfX4UUHhjMUyQ@mail.gmail.com>
 <d0f74721-bf5a-62de-53dc-62e7e735e2dc@linaro.org> <bdc82b4a-f1a9-0372-5a57-200a422b1b70@arinc9.com>
 <21a90597-78c9-4d46-7b01-257702e7afca@linaro.org> <525a6388-a4b8-3052-fe81-5aa21d8f424a@arinc9.com>
 <507f79cf-acd8-5238-031a-fd71024e0c6a@linaro.org>
In-Reply-To: <507f79cf-acd8-5238-031a-fd71024e0c6a@linaro.org>
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
Date:   Tue, 21 Mar 2023 05:34:18 +0100
Message-ID: <CAMhs-H8_S5eO7B+dZ7jeq7Jjnw71QBmSo4M+woe3U5sH7dCADg@mail.gmail.com>
Subject: Re: [PATCH 01/10] dt: bindings: clock: add mtmips SoCs clock device
 tree binding documentation
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     =?UTF-8?B?QXLEsW7DpyDDnE5BTA==?= <arinc.unal@arinc9.com>,
        linux-clk@vger.kernel.org, linux-mips@vger.kernel.org,
        tsbogend@alpha.franken.de, john@phrozen.org,
        linux-kernel@vger.kernel.org, p.zabel@pengutronix.de,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        devicetree@vger.kernel.org
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

On Mon, Mar 20, 2023 at 7:15=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 20/03/2023 19:09, Ar=C4=B1n=C3=A7 =C3=9CNAL wrote:
> >>> Would mediatek,mtmips-clock.yaml make sense?
> >>
> >> More, except:
> >> 1. This is not clock, but sysc.
> >
> > Sergio, beware.
>
> I meant, that's what I understood from what Sergio said. :)

Yes, you understood properly. I will use 'sysc' instead.

>
> >
> >> 2. mips sounds redundant. Do you have rt2xxx and mt7xxx chips which ar=
e ARM?
> >
> > All of the SoCs, RTXXXX, MT7620, MT7621, MT7628, MT7688 are MIPS. So I
> > decided to call this platform MTMIPS as I've seen MediaTek use this on
> > other projects like U-Boot. This is what I did on my pinctrl patch
> > series as well.
>
> Ah, but indeed there are newer Mediatek MT6xxx and MT8xxx SoCs which are
> ARM, so mediatek,mtmips-sysc would work.

I can use 'mediatek,mtmips-sysc.yaml' as the name but compatibles will
start with ralink. There are already some existent compatibles for
mt762x already having ralink as prefix, so to be coherent ralink
should be maintained as prefix.

>
> Best regards,
> Krzysztof
>

Thanks,
   Sergio Paracuellos
