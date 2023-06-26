Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B14A873D9AC
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Jun 2023 10:28:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229973AbjFZI22 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Jun 2023 04:28:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33160 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbjFZI2Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Jun 2023 04:28:25 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45D41B9
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:28:23 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id a640c23a62f3a-98de21518fbso256504766b.0
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 01:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=fairphone.com; s=fair; t=1687768102; x=1690360102;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=/z2l2uTy/cBaqn0Tj/q1FNG0VhYAlt0fDLzRyz8E7k8=;
        b=JK5Nbe7Dt4FaRC3i+ebjZ+e0vhMzQx2cFFP5o267c/8rnB6/rAqolMs+Y4JVh2qRCx
         EkRV2ih17UcjtBT5pMKWqiDGo60x6hNYBCvyMqPxY3wV8O3z6gNzZFHJwG0BTJlIrIbT
         m4+Kja0R+lw+EZMJp1et/dsUO+ZgUSEqr8qiPmpb4OTu1iMxZcs0smriM//JFJ834qPn
         lwhRtgd0+CmMdp9gWVWEnM5jFhE3oWR7ywGIG5tX2UgyO6ZumUGh3xtfWekJLYCW3bY8
         CA02vwhK0y1kB2qvp7smxHSy8EKSJEphhxtz4xANhkFN1iddgX0WEAI3Thre7JYtepuI
         T1yA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687768102; x=1690360102;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=/z2l2uTy/cBaqn0Tj/q1FNG0VhYAlt0fDLzRyz8E7k8=;
        b=gGqBHwKIeFruSo+Z+WIK7xorqc68kRLLBT4K3wNVtHlHjRk2CLapm+BBpWae7pRSIc
         jMXCzNmlOwx5lIohQ5vFV0KvDQsIP3cyCTdH0Zm4qamPVJXzAai8Vt9vC/9+Ai6soukH
         x/e0CbJAY5pEjx/G3cf0O5Apq2ygLaGOekrOH1H27oaxBNYr1jwjD7joTqKN02AmcuJs
         ufwSMNtDXRBjx6dr9DUP/hzy1pQCoxRUjxMtTcinNIY9EgrLLBORyOs5OZV4+jvMRfTa
         /02JvpEbkiWXiQ1LuC4xxCcLr2v3VNC9r3pMikz9K52wFri+Gb54nLAR6mwFucW5ryGd
         rl+g==
X-Gm-Message-State: AC+VfDzEsMEteptV+m08XxOuausoz9ly58dkBFKunSHaM2FayOlnrgI6
        q57H3B9lMADm84HQ6o3l/M79TQ==
X-Google-Smtp-Source: ACHHUZ55jsXkC5JC4+uTvSts1tb2kV+vphkAvEWRrtvIWOryFAfdpEri5J0hl9YafwrnH52f1kpHBw==
X-Received: by 2002:a17:907:9450:b0:989:3670:3696 with SMTP id dl16-20020a170907945000b0098936703696mr14285227ejc.58.1687768102200;
        Mon, 26 Jun 2023 01:28:22 -0700 (PDT)
Received: from localhost (144-178-202-138.static.ef-service.nl. [144.178.202.138])
        by smtp.gmail.com with ESMTPSA id lc6-20020a170906f90600b0096637a19dccsm2956929ejb.210.2023.06.26.01.28.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 26 Jun 2023 01:28:21 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 26 Jun 2023 10:28:21 +0200
Message-Id: <CTMFUY0GPRNK.532E4O05LWKW@otso>
Cc:     <konrad.dybcio@linaro.org>, <u.kleine-koenig@pengutronix.de>,
        <linux-leds@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-pwm@vger.kernel.org>
Subject: Re: [PATCH 0/7] Add support for LUT PPG
From:   "Luca Weiss" <luca.weiss@fairphone.com>
To:     "Anjelique Melendez" <quic_amelende@quicinc.com>, <pavel@ucw.cz>,
        <lee@kernel.org>, <thierry.reding@gmail.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <agross@kernel.org>, <andersson@kernel.org>
X-Mailer: aerc 0.15.1
References: <20230621185949.2068-1-quic_amelende@quicinc.com>
In-Reply-To: <20230621185949.2068-1-quic_amelende@quicinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anjelique,

On Wed Jun 21, 2023 at 8:59 PM CEST, Anjelique Melendez wrote:
> In certain PMICs, LUT pattern and LPG configuration can be stored in SDAM
> modules instead of LUT peripheral. This feature is called PPG.
>
> This change series adds support for PPG. Thanks!

Thanks for sending this series!

I've tested this on SDM632 Fairphone 3 and everything appears to work
fine with setting the pattern. Using fbcli from feedbackd[0] the pattern
shows up correctly.

The only thing missing really is the addition of the pbs node and adding
the nvmem/nvmem-names & qcom,pbs-client to the lpg node in pmi632.dtsi -
something like the patch below.

Are you planning to include this in the next revision? Otherwise I can
also send a patch for the pmi632.dtsi after this series has landed.

Tested-by: Luca Weiss <luca.weiss@fairphone.com> # sdm632-fairphone-fp3 (pm=
i632)

[0] https://source.puri.sm/Librem5/feedbackd

Regards
Luca

diff --git a/arch/arm64/boot/dts/qcom/pmi632.dtsi b/arch/arm64/boot/dts/qco=
m/pmi632.dtsi
index add206dee01d2e..92ddb7ac6bf311 100644
--- a/arch/arm64/boot/dts/qcom/pmi632.dtsi
+++ b/arch/arm64/boot/dts/qcom/pmi632.dtsi
@@ -127,6 +127,11 @@
 			status =3D "disabled";
 		};
=20
+		pmi632_pbs_client3: qcom,pbs@7400 { // TODO: generic node name
+			compatible =3D "qcom,pbs";
+			reg =3D <0x7400>;
+		};
+
 		pmi632_sdam_7: nvram@b600 {
 			compatible =3D "qcom,spmi-sdam";
 			reg =3D <0xb600>;
@@ -155,6 +160,10 @@
 		pmi632_lpg: pwm {
 			compatible =3D "qcom,pmi632-lpg";
=20
+			nvmem =3D <&pmi632_sdam_7>;
+			nvmem-names =3D "lpg_chan_sdam";
+			qcom,pbs-client =3D <&pmi632_pbs_client3>;
+
 			#address-cells =3D <1>;
 			#size-cells =3D <0>;
 			#pwm-cells =3D <2>;

>
> Anjelique Melendez (7):
>   dt-bindings: soc: qcom: Add qcom-pbs bindings
>   dt-bindings: leds: leds-qcom-lpg: Add support for LUT through NVMEM
>     devices
>   soc: qcom: add QCOM PBS driver
>   leds: rgb: leds-qcom-lpg: Add support for LUT pattern through single
>     SDAM
>   leds: rgb: leds-qcom-lpg: Update PMI632 lpg_data to support PPG
>   leds: rgb: leds-qcom-lpg: Support two-nvmem PPG Scheme
>   leds: rgb: Update PM8350C lpg_data to support two-nvmem PPG Scheme
>
>  .../bindings/leds/leds-qcom-lpg.yaml          |  85 ++++
>  .../bindings/soc/qcom/qcom-pbs.yaml           |  41 ++
>  drivers/leds/rgb/leds-qcom-lpg.c              | 393 ++++++++++++++++--
>  drivers/soc/qcom/Kconfig                      |   9 +
>  drivers/soc/qcom/Makefile                     |   1 +
>  drivers/soc/qcom/qcom-pbs.c                   | 343 +++++++++++++++
>  include/linux/soc/qcom/qcom-pbs.h             |  36 ++
>  7 files changed, 877 insertions(+), 31 deletions(-)
>  create mode 100644 Documentation/devicetree/bindings/soc/qcom/qcom-pbs.y=
aml
>  create mode 100644 drivers/soc/qcom/qcom-pbs.c
>  create mode 100644 include/linux/soc/qcom/qcom-pbs.h

