Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C843D6E14E9
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 21:12:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjDMTMs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 15:12:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229492AbjDMTMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 15:12:46 -0400
Received: from mail-ua1-x92d.google.com (mail-ua1-x92d.google.com [IPv6:2607:f8b0:4864:20::92d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D863C7D81;
        Thu, 13 Apr 2023 12:12:45 -0700 (PDT)
Received: by mail-ua1-x92d.google.com with SMTP id r10so2543808uat.6;
        Thu, 13 Apr 2023 12:12:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681413165; x=1684005165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rmZ0O+sn7kZQc+bw7Jf0vK7+WNBVnZzD5f3dYdmxU6w=;
        b=DGBtb62pYjawglwT2CcAlDMdolYBtCrl1+AHi5BgemglSjjwFb+eQo1dZoBX+Ou6zU
         1SJ8caR0vs4mmuLRd1ouTI9wc8jye7tkIMbMUAqnyA4+rTpUOHQvWV2Ty3FTxdKYqdCQ
         1Vkfp6khPGY0gHDC5RtFBzGMirLgWSal4j6UNTFmA2konA4u59uTF5E0ZNTg/9q80UDu
         fGJJnK8pM1Lx3EWyx/hQl7uydc3WwbNoHTkDjmFyOW4pfhDAHb9MRdV1FUX4+rkSk/9q
         UMtGY4ON/vdR6WQ/omPq2ZCWrFe7wKog5F9S1+C8vL4LG059qmHTcXnrYGg+sDp6kmHB
         l1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681413165; x=1684005165;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rmZ0O+sn7kZQc+bw7Jf0vK7+WNBVnZzD5f3dYdmxU6w=;
        b=KiTFWnSIEEkILsvjzoG4oEtgwhsPYcQL6sJsEKO/RmPB2B7YN8NZtmsoFDUBWJsy7I
         NIySIGnxVQJA4hzTL7QxCvGUUu2REalCksZisq+aENZqBmLsF85W1oli49q12iKe4U57
         iX+PCERuDA+Xfn6Eh7hSYHoLxhadRfoQsnKb9NhVpJL8f7c+KYJKdU9aFCuJjp5LruVL
         Z/HNGGmsTGb33R0aFNG4xqFvfc0jlsMkshP7zRJoSzkDJvNE8Q2KRFiSfsJyqAp52xXN
         Ix1KQEI4hYwY3QdCCUXODzkOo+MUAw6VaGSOgqkfpuNKIdr5O7hpQT6tSAQDDaqf1hT+
         +uHQ==
X-Gm-Message-State: AAQBX9dHYPCriH3TNsNvayKHUC9qaCda7yOthCjgd2UEWOMQpZ5abQjw
        ylcA1Zq813bWrSJRbweJhyTDKtCnvXdmj/E+KFuu9AUN
X-Google-Smtp-Source: AKy350adCRi60QJXZb5icO9EL7KmKwKPUNkUPxrzQUDIMbacwLKJJCempvcVFMPCJqrATmpMttviOkb1C1UBme69Zng=
X-Received: by 2002:a1f:2957:0:b0:440:380f:fc20 with SMTP id
 p84-20020a1f2957000000b00440380ffc20mr1716539vkp.0.1681413164900; Thu, 13 Apr
 2023 12:12:44 -0700 (PDT)
MIME-Version: 1.0
References: <20230412025737.20280-1-mibodhi@gmail.com> <20230412025737.20280-2-mibodhi@gmail.com>
 <168130276446.1439316.3427548118074442016.robh@kernel.org>
 <CAJaLiFxNbz+EygSy8OMKafZ667ingeiTw8Z17p3dwtPTpiH40g@mail.gmail.com> <799bd591-0f9a-e8fc-85f6-093314b6af23@linaro.org>
In-Reply-To: <799bd591-0f9a-e8fc-85f6-093314b6af23@linaro.org>
From:   Tony Dinh <mibodhi@gmail.com>
Date:   Thu, 13 Apr 2023 12:12:33 -0700
Message-ID: <CAJaLiFyqQumh4dnQ1UY0s5jqK+5pPYO50vPu+dGTtUC5UvhSTA@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: mvebu: Add device tree binding for
 Marvell Armada 38x
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh@kernel.org>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
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

On Thu, Apr 13, 2023 at 12:51=E2=80=AFAM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 12/04/2023 21:05, Tony Dinh wrote:
> > Hi Rob,
> > Hi Krzysztof,
> >
> > On Wed, Apr 12, 2023 at 5:36=E2=80=AFAM Rob Herring <robh@kernel.org> w=
rote:
> >>
> >>
> >> On Tue, 11 Apr 2023 19:57:35 -0700, Tony Dinh wrote:
> >>> Add device tree binding for Marvell Armada 38x.
> >>>
> >>> Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> >>> ---
> >>>
> >>> Changes in v2:
> >>> - Add marvell,38x.yaml. For now, add this binding to the Marvell
> >>> directory to keep it consistent with other Marvell yaml files.
> >>> At a later date and a separate patch, consolidate the Marvell
> >>> yaml files into  marvell.yaml.
> >>>
> >>>  .../bindings/arm/marvell/armada-38x.yaml      | 27 +++++++++++++++++=
++
> >>>  1 file changed, 27 insertions(+)
> >>>  create mode 100644 Documentation/devicetree/bindings/arm/marvell/arm=
ada-38x.yaml
> >>>
> >>
> >> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_che=
ck'
> >> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >>
> >> yamllint warnings/errors:
> >>
> >> dtschema/dtc warnings/errors:
> >> ./Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml: $id: =
relative path/filename doesn't match actual path or filename
> >>         expected: http://devicetree.org/schemas/arm/marvell/armada-38x=
.yaml#
> >>
> >> doc reference errors (make refcheckdocs):
> >>
> >> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202=
30412025737.20280-2-mibodhi@gmail.com
> >>
> >> The base for the series is generally the latest rc1. A different depen=
dency
> >> should be noted in *this* patch.
> >>
> >> If you already ran 'make dt_binding_check' and didn't see the above
> >> error(s), then make sure 'yamllint' is installed and dt-schema is up t=
o
> >> date:
> >>
> >> pip3 install dtschema --upgrade
> >>
> >> Please check and re-submit after running the above command yourself. N=
ote
> >> that DT_SCHEMA_FILES can be set to your schema file to speed up checki=
ng
> >> your schema. However, it must be unset to test all examples with your =
schema.
> >>
> >
> > Thanks for the reviews. After running make dt_binding_check for it
> > seems like hours (on a dual-core 1.8GHz ARM box), I got impatient and
> > used
> > make CHECK_DTBS=3Dy armada-385-thecus-n2350.dtb
> >
> > I'll move this to another faster box and run make dt_binding_check.
>
> So many questions...
> 1. Why do you have to run it on arm? Not on regular machine for work? No
> one of us does like that...

It's just more convenient for me to run on ARM (I also build ARM
kernels natively with distcc). This is not work related, so I cannot
use machines at work. I can use my personal 4-core laptop, though.

> 2. You are now mixing now two different commands. You were asked to run
> DT_SCHEMA_FILES

OK. As you can see, I have no experience with schema before.

> 3. Read the provided guide how to speed it up. It runs within few seconds=
.

Good to know there is a way. Thanks for the advice!

All the best,
Tony

>
>
> Best regards,
> Krzysztof
>
