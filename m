Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0221472350C
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233672AbjFFCGs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:06:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233152AbjFFCGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:06:32 -0400
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3277E44;
        Mon,  5 Jun 2023 19:06:26 -0700 (PDT)
Received: by mail-qv1-xf30.google.com with SMTP id 6a1803df08f44-62614a1dd47so41111576d6.2;
        Mon, 05 Jun 2023 19:06:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686017186; x=1688609186;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fHxYxgoeO4Fz6rNQej/wSf+qvSfbEPqyAolfpowpldM=;
        b=acthjTFnSNF5zKRRlhGw+vu3sBJkQfXpmpXAoiZAvL7d24CZE6ZABgRhPubR/9PFEU
         bM3XFVjFd+D8kAZrZs7FwT4ohc3FMIDX1HcpQm8G+1XhEY90fk+RYl2XPyTMNrWGt/UT
         dOCFIn0mguhJ4RgtpFXtp6JsxXig1i41Z09BWYzkjB9kabDK/K2KA8VgVB+aD+qNcG2N
         cDjIs98Mnbc7YvvyGXtQZ8SttnUO0QJLWVkTTu4Tn7HSxf7K022xiC3UUy60PEyhy732
         hWNRKp6OLIYnq9iSZIbDk5MyDtr3YbSo0LHulc+HB3YEgGGJeu8oGFWGsZq+TvwahBXP
         X6Ng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017186; x=1688609186;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=fHxYxgoeO4Fz6rNQej/wSf+qvSfbEPqyAolfpowpldM=;
        b=RiuqxPlY7eYlFtKXWLhsPMdTfsX9ilLPlHr13na2WgaZTcEqQ9o8JNmAc5DVjh9jlC
         kV631bo3o5n9SHiXRRgrz1VeNBS9odywlc9YJt9HnVLWd8B2GKb7e7S7WI54HFmeSKce
         5wRfTSswaKTvhgKe8d2mEdgayYAexyYzH586XBTxENbIgZ+Xgyprw5sempWkd9jQ/vCp
         8GtdIxlf50DxrgiB3raXhFJ1xt789YIAtRzm+jlOGbSiq8B/8ZRbNfyj35TYG1FY4P0P
         pCIUd90iiei4tQjC8sfki57Wyo0uoGkUcZ76BhjqTKaMNuhIaW8wb712bBCypBQqXEIY
         4e0Q==
X-Gm-Message-State: AC+VfDxEgoTap+YEJJLTBbHtJfHyVR97lXogq4KTT6c3O7eAV/GF6f28
        NXMp4oZ4b3gSqcNyY4/MtYYCrE6mSE3JGQ==
X-Google-Smtp-Source: ACHHUZ40R/7DwONJjQlPcqGT36cqBtgKGygl2J4alUiZu16uhr29ahIhA1q8+RczUQBCu26cwcVQvA==
X-Received: by 2002:a05:6214:f25:b0:623:a5d0:1daf with SMTP id iw5-20020a0562140f2500b00623a5d01dafmr767371qvb.48.1686017185826;
        Mon, 05 Jun 2023 19:06:25 -0700 (PDT)
Received: from localhost ([2600:4040:2007:9800:ab:4faa:880f:7b91])
        by smtp.gmail.com with ESMTPSA id v6-20020ad45286000000b006257e64474asm5022256qvr.113.2023.06.05.19.06.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 19:06:25 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 05 Jun 2023 22:06:23 -0400
Message-Id: <CT577LF6NJLX.3OVACDQO6WGDE@Latitude-E6420>
From:   "Rudraksha Gupta" <guptarud@gmail.com>
To:     "Rob Herring" <robh@kernel.org>
Cc:     "Kishon Vijay Abraham I" <kishon@kernel.org>,
        <linux-phy@lists.infradead.org>, "Olof Johansson" <olof@lixom.net>,
        "Vinod Koul" <vkoul@kernel.org>, "Arnd Bergmann" <arnd@arndb.de>,
        <soc@kernel.org>, <devicetree@vger.kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Andy Gross" <agross@kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: phy: qcom,usb-hs-phy: Add
 compatible
X-Mailer: aerc 0.8.2
References: <20230604063032.365775-1-guptarud@gmail.com>
 <20230604063032.365775-3-guptarud@gmail.com>
 <168586340547.3052749.2763112173580157119.robh@kernel.org>
In-Reply-To: <168586340547.3052749.2763112173580157119.robh@kernel.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jun 4, 2023 at 3:23 AM EDT, Rob Herring wrote:
>
> On Sun, 04 Jun 2023 02:30:19 -0400, Rudraksha Gupta wrote:
> > Adds qcom,usb-hs-phy-msm8960 compatible
> >=20
> > Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
>
> My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
>
> yamllint warnings/errors:
>
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
hy/qcom,usb-hs-phy.example.dtb: phy: resets: [[4294967295, 10], [1, 0]] is =
too long
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicet=
ree/bindings/phy/qcom,usb-hs-phy.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
hy/qcom,usb-hs-phy.example.dtb: phy: reset-names:0: 'por' was expected
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicet=
ree/bindings/phy/qcom,usb-hs-phy.yaml
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/p=
hy/qcom,usb-hs-phy.example.dtb: phy: reset-names: ['phy', 'por'] is too lon=
g
> 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicet=
ree/bindings/phy/qcom,usb-hs-phy.yaml
>
> doc reference errors (make refcheckdocs):
>
> See https://patchwork.ozlabs.org/project/devicetree-bindings/patch/202306=
04063032.365775-3-guptarud@gmail.com
>
> The base for the series is generally the latest rc1. A different dependen=
cy
> should be noted in *this* patch.
I see. Why is it off the latest rc1 and not off the latest commit?

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
Thanks. I didn't see these errors as I was only looking for expressatt
binding errors.
