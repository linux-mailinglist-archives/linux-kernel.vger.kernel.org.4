Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 76CEE70161F
	for <lists+linux-kernel@lfdr.de>; Sat, 13 May 2023 12:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237331AbjEMKVn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 13 May 2023 06:21:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229653AbjEMKVj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 May 2023 06:21:39 -0400
Received: from mail-ej1-x635.google.com (mail-ej1-x635.google.com [IPv6:2a00:1450:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6745C4C38;
        Sat, 13 May 2023 03:21:38 -0700 (PDT)
Received: by mail-ej1-x635.google.com with SMTP id a640c23a62f3a-965ab8ed1fcso2001299366b.2;
        Sat, 13 May 2023 03:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683973297; x=1686565297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=VfXf7Z/pwISSyuK+G+umykCTaKNJLWzISvgkZ065u5k=;
        b=aR6Sr3i5k6WraX9j/SyZ2Rxrq7j31Tk45stLmYBeyAGOgaR2TR3tP1VaG5v7dbGscu
         8pOw7C4PSCdVcXlDOe/kNdIFvO7I9Vnd4jKmCekdV8+DLPuNi7uzFADogRFQLbzGVBSE
         4lr6PqMINBzXP4cEgQjt62DrwEBLBMITxVFfijt/oz9ITGvKuvXL/l0EpPZjRz7uBT0j
         tkMVfvHX/TyM3T7mpECAqzPW5E4XeBcWGqV3yEM4AKwNJniJiYzio8LLgPZBFtPG+fUd
         x6voE9h29AS6ZVvQ7vNSTaT9B9YXfqytPGVJCTh/wMaQpfsVoG3IaEmG6QuHUy8GeV6q
         Y+fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683973297; x=1686565297;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VfXf7Z/pwISSyuK+G+umykCTaKNJLWzISvgkZ065u5k=;
        b=FWDsKyXoRDCNK6O8hRgywzT5PdfWdgFtulUAZY2i63u9ZKsLDCL1BYj4uHJcXcUqq0
         FnFkGj2SP46B7rNtfIFDbl2yM7kTiweJZDxG9783G342GccceN+OqKJkplhKD44/6i4G
         1E5Z8+d4JrxKCnFmrTpdjf+7XloDxaf/KY9YrMYkURnA1HhiArnkbct2qCJH95bBpsgl
         pxRW10M+uFRLmSfwBFxGtJo+K+nf4sPsjldudPO4aBp5fIJPzv0Q5rrZie373KP+z9/D
         Hk5b6o9bTlRaZ5Ti31JiAg3t+l9DOuZ/1b8CJHw43wueB2YrYPox8q1zHEZBQmqU61Oy
         c6jA==
X-Gm-Message-State: AC+VfDw5echIApLTrmYEb8dmaU936K7rX/Ag98lNMIjCfaEzaJi18SRw
        rox80ixP8tpuiEG30XimqKZPqsJOidZLfwx8pec=
X-Google-Smtp-Source: ACHHUZ4de0cW1jvj/9uHt+A8zE/qtBZ1cxXz0GH361g1zYUo9VbzkUW+vXmb5SVO1ltaKq1HwKDg6xa4D0S3/9GPg+E=
X-Received: by 2002:a17:907:1c14:b0:95e:d74d:c4e6 with SMTP id
 nc20-20020a1709071c1400b0095ed74dc4e6mr33805176ejc.25.1683973296581; Sat, 13
 May 2023 03:21:36 -0700 (PDT)
MIME-Version: 1.0
References: <20230513065228.25971-1-cnsztl@gmail.com> <ff7aa7b6-dc45-25ba-9636-058c2bb73a6d@linaro.org>
In-Reply-To: <ff7aa7b6-dc45-25ba-9636-058c2bb73a6d@linaro.org>
From:   Tianling Shen <cnsztl@gmail.com>
Date:   Sat, 13 May 2023 18:21:24 +0800
Message-ID: <CAOP2_TjbWMpqPtpAfRZSh5+da6HxCJb_f59_jNX73Cc0vg_n2Q@mail.gmail.com>
Subject: Re: [PATCH 1/2] dt-bindings: Add doc for FriendlyARM NanoPi R2C Plus
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andy Yan <andyshrk@163.com>,
        Chris Morgan <macromorgan@hotmail.com>,
        Nicolas Frattaroli <frattaroli.nicolas@gmail.com>,
        Brian Norris <briannorris@chromium.org>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Michael Riesch <michael.riesch@wolfvision.net>,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Andrew Powers-Holmes <aholmes@omnom.net>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Sat, May 13, 2023 at 5:17=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 13/05/2023 08:52, Tianling Shen wrote:
> > Add devicetree binding documentation for the NanoPi R2C Plus.
> >
> > Signed-off-by: Tianling Shen <cnsztl@gmail.com>
>
> subject: missing prefixes (arm: rockchip:)
>
> Drop "doc for"
>
> Subject: drop second/last, redundant "doc". The "dt-bindings" prefix is
> already stating that these are bindings and it is documentation.

Thanks for the suggestion! Will send v2 for it.

Regards,
Tianling.

> > ---
> >  Documentation/devicetree/bindings/arm/rockchip.yaml | 1 +
>
>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>
> Best regards,
> Krzysztof
>
