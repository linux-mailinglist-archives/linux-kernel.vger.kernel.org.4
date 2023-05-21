Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB90470AD0D
	for <lists+linux-kernel@lfdr.de>; Sun, 21 May 2023 10:57:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229641AbjEUI5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 21 May 2023 04:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231180AbjEUI4d (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 04:56:33 -0400
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29901CA;
        Sun, 21 May 2023 01:53:56 -0700 (PDT)
Received: by mail-qt1-x833.google.com with SMTP id d75a77b69052e-3f690149f13so29224271cf.1;
        Sun, 21 May 2023 01:53:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684659235; x=1687251235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=vEIrP2ynpjpmZmVLItYY+rNU7ObAmm9vuXWERHD5GRU=;
        b=ST1pQhAY8zUonWh1liTdSJ9j7v/hDgthAFgILkfcxi45vkQc3G8QRUcfP+y9nu2KwA
         l4wE1CQt9UdkqXi79C/5vUnjAtVaGYe0rPXsUrFv1/cz0CgPXogrHjSd3PBuwzq1caQX
         fV7ni8gC8vZWgDMxFpRtvSe5vMSPDdsx/OL/81/uIrS4UgtoxCnvSKsAaZ3d3z26B5Ea
         DW3Ilxw5K3VQc4K4zhg9l8sx+ckiAEFZPgrPiqjGBz3BaJ9hGElT/LkZeZKYc5SRJ8JF
         3YoxtdkrhdnisGE02CKYjm9+Y9KlucNVulLe9/If4BeAZjjYf/qOq+/ympibu5iGR750
         lFRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684659235; x=1687251235;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=vEIrP2ynpjpmZmVLItYY+rNU7ObAmm9vuXWERHD5GRU=;
        b=c5yor4UmvO/Pzks4GF6UGzXcmHvJSGDI17zVy8eWxt8AUgnWSQTmFb9A7r3Cru7xQs
         0rhp+BCg934UU/xhZF7RqHVXa/l7WZTjq2DVkNRJuII3DD6R7rdYuptew81fuIzSK/Ko
         dwe4OXvbouNZI9pS1nlWGg9Ihpl5z91sVQkn04/P1hqnlUYX1Lu32qpZg36CZw3XOYjZ
         rwKhaIHST6pDly0a5/ea5+0Wy+MHxQLkLe2LEsenh2yn0hJOBVvbINIjsBvt336bufAZ
         xdbcr5zpgG7F1ePqX+AopSSWW+B9nZPH0LVz0JOJ4DxDHDCCoFIryafpq7KmFXeWC2mD
         TdZg==
X-Gm-Message-State: AC+VfDzinW5bTkWMIejvcL62BeA32Gc/sPA6sTZlodYmg0VVRkn6ZZJE
        rBCsKWpRaK8SbxGp4aDfF75qMFZHyaSr3LDoy8c4GA+/JsI=
X-Google-Smtp-Source: ACHHUZ6Z2pP9QjNcRZjEfdfq0bpt+soUrXi6Q3GIPCsRITb5cwsQAg6J8GvUL5nww5ZFgbGQm+YwX9aaD1UulpmaEHU=
X-Received: by 2002:ac8:5d8d:0:b0:3f5:543:4c3f with SMTP id
 d13-20020ac85d8d000000b003f505434c3fmr12959562qtx.66.1684659235216; Sun, 21
 May 2023 01:53:55 -0700 (PDT)
MIME-Version: 1.0
References: <20230515210545.2100161-1-gnstark@sberdevices.ru>
 <CAFBinCCc+t7Ks6fqz38cVrufPRFdxFgC9Qp+JhcM1KfD6pupTg@mail.gmail.com>
 <f0966e95-43c7-e6f6-8aeb-05f27691cec3@sberdevices.ru> <20230520164618.08f26fd9@jic23-huawei>
In-Reply-To: <20230520164618.08f26fd9@jic23-huawei>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sun, 21 May 2023 11:53:19 +0300
Message-ID: <CAHp75VenNPOK7X=vOoZE2rGyC46q4qdNOgSDbDMqV+Gdigm81Q@mail.gmail.com>
Subject: Re: [PATCH v1] meson saradc: fix clock divider mask length
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     =?UTF-8?B?0KHRgtCw0YDQuiDQk9C10L7RgNCz0LjQuSDQndC40LrQvtC70LDQtdCy0LjRhw==?= 
        <GNStark@sberdevices.ru>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        "lars@metafoo.de" <lars@metafoo.de>,
        "neil.armstrong@linaro.org" <neil.armstrong@linaro.org>,
        "khilman@baylibre.com" <khilman@baylibre.com>,
        "jbrunet@baylibre.com" <jbrunet@baylibre.com>,
        "nuno.sa@analog.com" <nuno.sa@analog.com>,
        "linux-iio@vger.kernel.org" <linux-iio@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-amlogic@lists.infradead.org" 
        <linux-amlogic@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        kernel <kernel@sberdevices.ru>
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

On Sat, May 20, 2023 at 6:30=E2=80=AFPM Jonathan Cameron <jic23@kernel.org>=
 wrote:
> On Wed, 17 May 2023 16:47:59 +0000
> =D0=A1=D1=82=D0=B0=D1=80=D0=BA =D0=93=D0=B5=D0=BE=D1=80=D0=B3=D0=B8=D0=B9=
 =D0=9D=D0=B8=D0=BA=D0=BE=D0=BB=D0=B0=D0=B5=D0=B2=D0=B8=D1=87 <GNStark@sber=
devices.ru> wrote:
> > On 5/16/23 22:08, Martin Blumenstingl wrote:

...

> > I've checked datasheets of all chips listed in meson_sar_adc_of_match a=
rray in meson_saradc.c and everywhere this field is 6 bits long. According =
to driver code and existing dts files this patch affects all supported chip=
s except meson8.
>
> On that note, do we want to add any clarifying text on the scope to the
> commit message?

We should, I think, but according to Martin's message, as I may
interpret it, the datasheet may also be wrong and some experiments on
a real hardware should prepend any change in the code.


--=20
With Best Regards,
Andy Shevchenko
