Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5DA75BA46C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 04:02:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbiIPCBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Sep 2022 22:01:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229959AbiIPCBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Sep 2022 22:01:31 -0400
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E70E386FE5;
        Thu, 15 Sep 2022 19:01:23 -0700 (PDT)
Received: by mail-io1-xd2a.google.com with SMTP id h194so14588891iof.4;
        Thu, 15 Sep 2022 19:01:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=vUOZTBGoBv99MDEQndk9eXZRqRCGzryyELAstPK3MfY=;
        b=GwuL35qvgBHdK8reXlxhq9kUhkxy22VNoi7FENABZhBHXm1ErcmRPEwQoNe4KXX1nf
         pFcPJxhpAkzmYJ0hTVe2bEWWZmT5nKE0HzUwkVKV+7Ef19swp5AXl7VpM9+siW2yADTT
         Us/ZcayNlJXAl1Fg3pk8xIjelVz3Ip9EXtLIA+bO1jtOEjRChoA2/sgvpv47YQevOhAO
         yspl7n3ocg1LIZGxpYB1V/H859ZxLQbUDdIJrTJ4oxauJSUDO6vaToDErYHC9hc/v9cj
         OsJY7phQKC2ovUFbZfyLTX0DA8bFToeCZ+mkvtlsEPxrBDGFxQzfqk0MwFHstNEMU5Y4
         PVUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=vUOZTBGoBv99MDEQndk9eXZRqRCGzryyELAstPK3MfY=;
        b=WJl5EAO+ulHrUZrDycWIxre51qoDjlcu0IwELsNXz0vcaDtBVqN25rPM8Rg7slALa6
         Qreo7rIYqRVEeu5laaTmh1UrWEU5EHyBR9Def2W0CecXHzNb2s/M3zBzbrQI2K/LFBlV
         7I+/C0J7o3vmvvP+u8fEJkoqFccCybZb5F3EK7nQBmr1Un7MHMXbHJkzGXaJs76h2Okf
         Un926t+5axO5m81QLoT7zN6qZYyvvwT34tuaFzsIlHL0sbiI1xFLDDnJX5PJ0Dv7QmZG
         PoJpP0QI2/45NQUR/H4TK3IelB2GUrOlG2m8RIYB3eKbMR62FFVrU4bxZ11KLEnXINyU
         +CHQ==
X-Gm-Message-State: ACrzQf2FogidwNuiXJRibnBSKqJ3MGTcLiEjXm3FSBbVIYoKied22EmR
        twE2j0/qof+jVT8FlO5lXi4=
X-Google-Smtp-Source: AMsMyM4XoQt4fRUDgMoNCX19tFY6eJqLtNQViE+ucF/8vsrlU/ea8IfcT5fHBeQjpsxmpJdi/Pvc+A==
X-Received: by 2002:a02:85a1:0:b0:349:2e9f:794 with SMTP id d30-20020a0285a1000000b003492e9f0794mr1400822jai.113.1663293682109;
        Thu, 15 Sep 2022 19:01:22 -0700 (PDT)
Received: from localhost ([2607:fea8:a2e2:2d00::af41])
        by smtp.gmail.com with UTF8SMTPSA id i2-20020a056e02152200b002eb255d81b0sm8502497ilu.65.2022.09.15.19.01.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 15 Sep 2022 19:01:21 -0700 (PDT)
From:   Richard Acayan <mailingradian@gmail.com>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht,
        Richard Acayan <mailingradian@gmail.com>
Subject: Re: [PATCH 2/2] pinctrl: qcom: add sdm670 pinctrl
Date:   Thu, 15 Sep 2022 22:01:17 -0400
Message-Id: <20220916020117.227480-1-mailingradian@gmail.com>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220914023900.z64wugbq7p2gfb32@builder.lan>
References: 
MIME-Version: 1.0
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

> > diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfi=
g=0D
> > index 2961b5eb8e10..7aba4188110c 100644=0D
> > --- a/drivers/pinctrl/qcom/Kconfig=0D
> > +++ b/drivers/pinctrl/qcom/Kconfig=0D
> > @@ -283,6 +283,15 @@ config PINCTRL_SDM660=0D
> >  	 Qualcomm Technologies Inc TLMM block found on the Qualcomm=0D
> >  	 Technologies Inc SDM660 platform.=0D
> >  =0D
> > +config PINCTRL_SDM670=0D
> > +	tristate "Qualcomm Technologies Inc SDM670 pin controller driver"=0D
> > +	depends on (OF || ACPI)=0D
> =0D
> I believe you can drop ACPI from this?=0D
=0D
Yes, I adapted this driver from the SDM845 driver and removed the ACPI=0D
features but forgot to remove the config dependency.=0D
=0D
> > +	depends on PINCTRL_MSM=0D
> > +	help=0D
> > +	 This is the pinctrl, pinmux, pinconf and gpiolib driver for the=0D
> > +	 Qualcomm Technologies Inc TLMM block found on the Qualcomm=0D
> > +	 Technologies Inc SDM670 platform.=0D
> > +=0D
> >  config PINCTRL_SDM845=0D
> >  	tristate "Qualcomm Technologies Inc SDM845 pin controller driver"=0D
> >  	depends on (OF || ACPI)=0D
=0D
> > +/* Every pin is maintained as a single group, and missing or non-exist=
ing pin=0D
> > + * would be maintained as dummy group to synchronize pin group index w=
ith=0D
> > + * pin descriptor registered with pinctrl core.=0D
> > + * Clients would not be able to request these dummy pin groups.=0D
> =0D
> The client wouldn't be able to define pinmux/pinconf, but I'm not able=0D
> to spot anything that would prevent a client from referencing the gpio?=0D
> =0D
> Perhaps I'm missing something?=0D
=0D
No, you're not. I kept this comment because I saw it in other pinctrl=0D
drivers and thought it was standard:=0D
=0D
    ~/linux $ grep dummy -RC1 drivers/pinctrl/qcom/=0D
    drivers/pinctrl/qcom/pinctrl-qcs404.c-/* Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-qcs404.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-qcs404.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-qcs404.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-qcs404.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sc7180.c-/* Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sc7180.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sc7180.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sc7180.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sc7180.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sc7280.c-/* Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sc7280.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sc7280.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sc7280.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sc7280.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sdx55.c-/* Every pin is maintained as a si=
ngle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sdx55.c: * would be maintained as dummy gr=
oup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sdx55.c- * pin descriptor registered with =
pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sdx55.c: * Clients would not be able to re=
quest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sdx55.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sdx65.c-/* Every pin is maintained as a si=
ngle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sdx65.c: * would be maintained as dummy gr=
oup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sdx65.c- * pin descriptor registered with =
pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sdx65.c: * Clients would not be able to re=
quest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sdx65.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sm6115.c-/* Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sm6115.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sm6115.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sm6115.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sm6115.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sm8350.c-/* Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sm8350.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sm8350.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sm8350.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sm8350.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-qcm2290.c-/* Every pin is maintained as a =
single group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-qcm2290.c: * would be maintained as dummy =
group to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-qcm2290.c- * pin descriptor registered wit=
h pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-qcm2290.c: * Clients would not be able to =
request these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-qcm2290.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sm6125.c- * Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sm6125.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sm6125.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sm6125.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sm6125.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sm6350.c- * Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sm6350.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sm6350.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sm6350.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sm6350.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sm8150.c- * Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sm8150.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sm8150.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sm8150.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sm8150.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sm8450.c-/* Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sm8450.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sm8450.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sm8450.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sm8450.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sdm845.c-/* Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sdm845.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sdm845.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sdm845.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sdm845.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sm6375.c- * Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sm6375.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sm6375.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sm6375.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sm6375.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sm8250.c-/* Every pin is maintained as a s=
ingle group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sm8250.c: * would be maintained as dummy g=
roup to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sm8250.c- * pin descriptor registered with=
 pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sm8250.c: * Clients would not be able to r=
equest these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sm8250.c- */=0D
    --=0D
    drivers/pinctrl/qcom/pinctrl-sc8180x.c-/* Every pin is maintained as a =
single group, and missing or non-existing pin=0D
    drivers/pinctrl/qcom/pinctrl-sc8180x.c: * would be maintained as dummy =
group to synchronize pin group index with=0D
    drivers/pinctrl/qcom/pinctrl-sc8180x.c- * pin descriptor registered wit=
h pinctrl core.=0D
    drivers/pinctrl/qcom/pinctrl-sc8180x.c: * Clients would not be able to =
request these dummy pin groups.=0D
    drivers/pinctrl/qcom/pinctrl-sc8180x.c- */=0D
=0D
Since this driver has dummy pingroups, it is a bit confusing to see this=0D
inaccurate information because it is relevant. I'll rewrite the comment so=
=0D
that it makes sense.=0D
=0D
> Otherwise, I think you should be able to specify reserved_gpios in=0D
> sdm670_pinctrl and list the dummy items. This would ensure that the gpio=
=0D
> code as well treat them as absent.=0D
=0D
Yes, as long as I can reserve pins 0, 1, 2, 3, 81, 82, 83, and 84 for the=0D
Pixel 3a. However, I think reserved_gpios overrides the DT schema where it=
=0D
would be sensible to add it:=0D
=0D
drivers/pinctrl/qcom/pinctrl-msm.c:690:=0D
=0D
	/* Driver provided reserved list overrides DT and ACPI */=0D
=0D
Perhaps I should omit the dummy pingroups from the driver and try to handle=
=0D
the gpio numbers discrepency on the DT side, like:=0D
=0D
    gpio-ranges =3D <&tlmm 0 0 58>, <&tlmm 65 59 4>, ...=0D
=0D
I don't see this being done anywhere else but it should clear up the=0D
debugfs problems I was having.=0D
=0D
> > + */=0D
> > +static const struct msm_pingroup sdm670_groups[] =3D {=0D
> > +	PINGROUP(0, SOUTH, qup0, _, _, _, _, _, _, _, _),=0D
> > +	PINGROUP(1, SOUTH, qup0, _, _, _, _, _, _, _, _),=0D
