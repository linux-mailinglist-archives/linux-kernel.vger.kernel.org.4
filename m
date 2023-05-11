Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 46F716FEB30
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 07:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232410AbjEKFay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 01:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjEKFav (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 01:30:51 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F31E2FB
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:30:49 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-965f7bdab6bso1310903166b.3
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 22:30:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683783048; x=1686375048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wS8SR9y31c6dnD5LAteD//cxbDMOfkqvXitaCTZlWPw=;
        b=j/cVE+YAkw8s3fjKcxaw16FENQWhT0YG2JxU8UzSQHE2I5mSpjpeI5nFhH4oANCfNE
         7+15BWvSUj/cY9/32vvaBPBZkLt0yG8dpc/SA+bJo/KgqfPxB/EgoD/uh5ld6lg+JQTD
         pBCSLf1iaze/JwcfyHw/inhLhmb9Z4ZUewkTzCNmJacjEs0ggpjkDv/cHCCq6gzwzZ1E
         eWW6krE4MzKa77GayBwnhyqx9u4KTwE41OkfGd4I440XdM9GidmBgHRIE93nOw4vw/+V
         gOqimp3aw5dY3S8WHDVicWeTwTGQMZd2YfM9s1HWcE+ZznOuQQLImwidDlwB+oa8qara
         M3TA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683783048; x=1686375048;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=wS8SR9y31c6dnD5LAteD//cxbDMOfkqvXitaCTZlWPw=;
        b=iNtXbF0k5YXVGQFxf6sHDtHNT9utFf2l5fDxfbXxZwMXhN+UOiVbVzaRTgepmYDUuU
         PnVWMUlo5lZO3cRRquqNdvg2Wmp3+ayBY8Zs/t71ssdQMWBGeilSMYm5i2/pKgD2pnQS
         5CZ0PLwO7MJOjXyHRCxAp05TQmWDfuV2S/lOLep5b/ll+0f1GVjG2i7GOUVItcIScDVC
         GcQJ6U2R57Zx3vE3J4KB8/ATUtmTkbV2HzAGz+jQxPC3PY05ooIXxPyRXYOAy8D/WQgw
         ZZdffJuMTJhmU8ov6gGFX0tsmO/payPsMbJcB5SNvw0JWUItIAb2XAzT5aUXM3q2MI65
         RmcQ==
X-Gm-Message-State: AC+VfDyh/BNygXjj4f2/H45DIKqY2FfZ0pk5c0Cwci04L3LSBsNEwY97
        O+8LG7Z/h9W44NtV0lgFBxivQQ==
X-Google-Smtp-Source: ACHHUZ62Kd6/mIjS5ts32ZuQpT3uuflQCqqx5uqAB/Ww6qdKZj47Wb+YKPqpge+iEVOG6OSZ8C7fMg==
X-Received: by 2002:a17:906:7952:b0:969:789d:5948 with SMTP id l18-20020a170906795200b00969789d5948mr10116343ejo.41.1683783048352;
        Wed, 10 May 2023 22:30:48 -0700 (PDT)
Received: from krzk-bin ([2a02:810d:15c0:828:a01e:5c6:be3:7baa])
        by smtp.gmail.com with ESMTPSA id n17-20020a170906725100b0096a6bf89259sm187524ejk.167.2023.05.10.22.30.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 22:30:47 -0700 (PDT)
Date:   Thu, 11 May 2023 07:30:45 +0200
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Martin =?utf-8?B?WmHFpW92acSN?= <m.zatovic1@gmail.com>
Cc:     arnd@arndb.de, linus.walleij@linaro.org,
        jacek.lawrynowicz@linux.intel.com, linux-kernel@vger.kernel.org,
        nipun.gupta@amd.com, conor+dt@kernel.org, geert+renesas@glider.be,
        krzysztof.kozlowski+dt@linaro.org, beanhuo@micron.com,
        bvanassche@acm.org, ogabbay@kernel.org, linux@zary.sk,
        mwen@igalia.com, robh+dt@kernel.org, yangyicong@hisilicon.com,
        benjamin.tissoires@redhat.com, devicetree@vger.kernel.org,
        gregkh@linuxfoundation.org, masahiroy@kernel.org
Subject: Re: [PATCHv4 3/4] dt-bindings: wiegand: add GPIO bitbanged Wiegand
 controller
Message-ID: <20230511053045.iuv6a3knfg6sob5b@krzk-bin>
References: <20230510162243.95820-1-m.zatovic1@gmail.com>
 <20230510162243.95820-4-m.zatovic1@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230510162243.95820-4-m.zatovic1@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 10 May 2023 18:22:42 +0200, Martin Za=C5=A5ovi=C4=8D wrote:
> GPIO bitbanged Wiegand controller requires definitions of GPIO
> lines to be used on top of the common Wiegand properties. Wiegand
> utilizes two such lines - D0(low data line) and D1(high data line).
>=20
> Acked-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Martin Za=C5=A5ovi=C4=8D <m.zatovic1@gmail.com>
> ---
>  .../bindings/wiegand/wiegand-gpio.yaml        | 51 +++++++++++++++++++
>  MAINTAINERS                                   |  5 ++
>  2 files changed, 56 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/wiegand/wiegand-gpi=
o.yaml
>=20

My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_check'
on your patch (DT_CHECKER_FLAGS is new in v5.13):

yamllint warnings/errors:

dtschema/dtc warnings/errors:
=2E/Documentation/devicetree/bindings/wiegand/wiegand-gpio.yaml: Unable to =
find schema file matching $id: http://devicetree.org/schemas/wiegand/wiegan=
d-controller.yaml
Documentation/devicetree/bindings/wiegand/wiegand-gpio.example.dts:20.21-29=
=2E11: Warning (unit_address_vs_reg): /example-0/wiegand@f00: node has a un=
it name, but no reg or ranges property
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/wie=
gand/wiegand-gpio.example.dtb: wiegand@f00: False schema does not allow {'c=
ompatible': ['wiegand-gpio'], 'pulse-len-us': [[50]], 'interval-len-us': [[=
2000]], 'frame-gap-us': [[2000]], 'data-lo-gpios': [[4294967295, 6, 6]], 'd=
ata-hi-gpios': [[4294967295, 7, 6]], '$nodename': ['wiegand@f00']}
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetre=
e/bindings/wiegand/wiegand-gpio.yaml
/builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/wie=
gand/wiegand-gpio.example.dtb: wiegand@f00: Unevaluated properties are not =
allowed ('frame-gap-us', 'interval-len-us', 'pulse-len-us' were unexpected)
	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devicetre=
e/bindings/wiegand/wiegand-gpio.yaml

See https://patchwork.ozlabs.org/patch/1779628

This check can fail if there are any dependencies. The base for a patch
series is generally the most recent rc1.

If you already ran 'make dt_binding_check' and didn't see the above
error(s), then make sure 'yamllint' is installed and dt-schema is up to
date:

pip3 install dtschema --upgrade

Please check and re-submit.
