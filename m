Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62A9B6F3AB8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 00:47:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233341AbjEAWrt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 18:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233241AbjEAWr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 18:47:28 -0400
Received: from mail-vk1-xa31.google.com (mail-vk1-xa31.google.com [IPv6:2607:f8b0:4864:20::a31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FD3D3C16;
        Mon,  1 May 2023 15:47:00 -0700 (PDT)
Received: by mail-vk1-xa31.google.com with SMTP id 71dfb90a1353d-4404c4221e2so917731e0c.2;
        Mon, 01 May 2023 15:47:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682981219; x=1685573219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qFlRRyBX+qLg5CbJaCq82+Xf/kSAJGQfyPo18ON4HZs=;
        b=nbjyx7ndtnRk1XL70mrpEJMcBktLZLya57UMrTom9Fr0ykZmfbhoXRIuwQ5b812zOo
         UY/aASqhVpy2Y1IjpfIhkd1LA1aiumPNgNZY0FeKS79jYpJVgA6UqbxWt8QxZLtq6/e7
         M1YeOEP6MyzAF7DUpWgDMovBbdjKBQb1wecL9Mr2bdbJ5EFuRpmpJiS/SCcm4To+XPWh
         00zRIIXJBSPc1/cG6YviNfarFd2dJhObaQQ8FFdbO1H1B3cVm9I6yRCWY9xkLejdqOTG
         QbzZ4xUsIcJUVHpGvBtd1s4kzYePDGuNHXo4ehfSOCRx7ZajAG+AWwN6n7LtuWAWumJl
         hStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682981219; x=1685573219;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qFlRRyBX+qLg5CbJaCq82+Xf/kSAJGQfyPo18ON4HZs=;
        b=Z9Wetc7YIwBpis9a1l0nW2innReuIoNMbnasvaNJ0UhbGivaeR6BBopLYEDsJcMzVZ
         7iTt9OV8n+ECvsylCmJEs0PcBOXdArCWpVX7fD8BUK/cUlFPf7HCXzQfBWpl8qqaPJQj
         le9G0Ohvaj2cmPY4DdTCMGH/k2iCk+Oa1Inou9aQn1cm4+YMAo8Zs1E8yr1PH3Ei/NcA
         jWPpxWVwlLMi3RZBpUtj/n7Tpbs3Xc/BCeayK33nKe3DWZrmL0+8yyZGot6qLS/2jYHx
         a4hab/6sGdsJjXPtWFyYN0rgHss0i58t5U0CVG1qRk1juPolbA3+tRjGke/yld9Z0PHr
         3vQA==
X-Gm-Message-State: AC+VfDxNoxSBKQ+fB6PT6hoCOupIfVnYvEtT1hYE0L+3XNL0bQGZvyDx
        v72wQhEae1lPSFLQKB5uuZtqeCWCPOy+UB7OTXf400iMwZI=
X-Google-Smtp-Source: ACHHUZ7JWhe3Pnobnb7aDw7FhytdbfpRmnGT8U9jC+iH5nm42liqjkZT1eKNTyEs+BeGULQf4BDn+FflixEsLikvgC0=
X-Received: by 2002:a1f:bf47:0:b0:440:2d96:80d5 with SMTP id
 p68-20020a1fbf47000000b004402d9680d5mr4136436vkf.5.1682981219518; Mon, 01 May
 2023 15:46:59 -0700 (PDT)
MIME-Version: 1.0
References: <20230412025737.20280-1-mibodhi@gmail.com> <20230412025737.20280-2-mibodhi@gmail.com>
 <168130276446.1439316.3427548118074442016.robh@kernel.org>
In-Reply-To: <168130276446.1439316.3427548118074442016.robh@kernel.org>
From:   Tony Dinh <mibodhi@gmail.com>
Date:   Mon, 1 May 2023 15:46:48 -0700
Message-ID: <CAJaLiFyJcMxcJ-z0LRtazoMtGZCqdNXWMv7ZnvCdXREVDeMGEw@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] ARM: dts: mvebu: Add device tree binding for
 Marvell Armada 38x
To:     Rob Herring <robh@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>
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

Hi Rob,

On Wed, Apr 12, 2023 at 5:36=E2=80=AFAM Rob Herring <robh@kernel.org> wrote=
:
>
>
> On Tue, 11 Apr 2023 19:57:35 -0700, Tony Dinh wrote:
> > Add device tree binding for Marvell Armada 38x.
> >
> > Signed-off-by: Tony Dinh <mibodhi@gmail.com>
> > ---
> >
> > Changes in v2:
> > - Add marvell,38x.yaml. For now, add this binding to the Marvell
> > directory to keep it consistent with other Marvell yaml files.
> > At a later date and a separate patch, consolidate the Marvell
> > yaml files into  marvell.yaml.
> >
> >  .../bindings/arm/marvell/armada-38x.yaml      | 27 +++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >  create mode 100644 Documentation/devicetree/bindings/arm/marvell/armad=
a-38x.yaml
> >
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> ./Documentation/devicetree/bindings/arm/marvell/armada-38x.yaml: $id: rel=
ative path/filename doesn't match actual path or filename
>         expected: http://devicetree.org/schemas/arm/marvell/armada-38x.ya=
ml#
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202304=
12025737.20280-2-mibodhi@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
>
> If you already ran 'make dt_binding_check' and didn't see the above
> error(s), then make sure 'yamllint' is installed and dt-schema is up to
> date:
>
> pip3 install dtschema --upgrade
>
> Please check and re-submit after running the above command yourself. Note
> that DT_SCHEMA_FILES can be set to your schema file to speed up checking
> your schema. However, it must be unset to test all examples with your sch=
ema.
>

Would dt-schema in Debian 12 work? or must it be the latest dtschema
installed by pip3 or from GitHub?

Thanks,
Tony
