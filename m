Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CF445B52E9
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 05:38:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229872AbiILDiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Sep 2022 23:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbiILDhu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Sep 2022 23:37:50 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC6022D1F3;
        Sun, 11 Sep 2022 20:36:13 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id h188so7032415pgc.12;
        Sun, 11 Sep 2022 20:36:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date;
        bh=28/DbnWRsqXYe1eOweFp4AtNKeSEOcgZmxd8skmN3WY=;
        b=q8CO8T4v7fXmaBih607EW5eE39K7eFFcD3VcaQYIVPH6l/I8h8aZFkuZb1ZN4sO7IH
         I1JaKGYJnnkQcH/smeQYTxculfu09pHcUY2f44bg/m9uw8oyfvUBAoXLEiN7HV4AKed0
         fhZSB5qnmjf9vFHPS7WnASw8RswmVeD2A2QMQFg5YyuIltBnz59pk82EHZWOK8e1SmRw
         qthVgSC1hmNp7C47WUxDEz1HuKce9TbHh8eTEY+pGFebQbR5/sHHrMYtVgf5rCsIBomt
         jW7bA+TTzvO0PeHnoO9q0EleMxq1VgdDyWX5UBzKdzWTxyT43zCbGM5tlqIZVoZqHCYI
         tM4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date;
        bh=28/DbnWRsqXYe1eOweFp4AtNKeSEOcgZmxd8skmN3WY=;
        b=da9D0d8kmiCWEB5mKagFEvdPDtswHucWlKxNluozTfGoOF/+cD9gneyE5X+W4p706L
         tvuxN53gWjO47nSUqm53rxWgd5DV/2D9bjO6RmDM3ZbTacFRyhzO6aejFNkO8D+MiVrB
         TA22FLERRBd7qwOFjYwqVPzzmc+y+UtO5IJvpvK+2k4p5Mfee1Wk5xru/Hiv2Kos+taM
         DEoO0BHMOw3/K6U19vw3mqjNenr2+hM+WmHIqUfmHRuRss0OuSvUwkF6V422R6gi4sU7
         olMCsqgCoYwmBNsqbUWP8oqme+GgGUhMhXrPmYW3tQ5TJZlcPJJ+oF2KkFXTCZ5OJgXH
         JSJQ==
X-Gm-Message-State: ACgBeo0LqN4ivy8T/FmCas4OxI2GzbSagPAOErUyg3JF3fN+4Pl65dU5
        bc74j/xesYviELmIleXBaLLLyR/Pg6sysg==
X-Google-Smtp-Source: AA6agR6YmOJZmt1wEo4MqljCt99ps2A60hby6DjbT9rgMFoEuWZ/6rfiFpF0Hde+lOqCcmAivT60yA==
X-Received: by 2002:a63:34b:0:b0:438:e839:f840 with SMTP id 72-20020a63034b000000b00438e839f840mr3612977pgd.540.1662953772564;
        Sun, 11 Sep 2022 20:36:12 -0700 (PDT)
Received: from localhost ([2406:7400:61:8a0f:392d:db19:673c:627a])
        by smtp.gmail.com with ESMTPSA id s185-20020a625ec2000000b00539aa7f0b53sm4031691pfb.104.2022.09.11.20.36.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 11 Sep 2022 20:36:12 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 12 Sep 2022 09:06:04 +0530
Message-Id: <CMU3WT0AU1BP.1BXXFEIOXQTXG@skynet-linux>
Cc:     <linux-remoteproc@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <bjorn.andersson@linaro.org>,
        <linux-kernel@vger.kernel.org>, "Rob Herring" <robh+dt@kernel.org>,
        <~postmarketos/upstreaming@lists.sr.ht>,
        "Konrad Dybcio" <konrad.dybcio@somainline.org>,
        "Andy Gross" <agross@kernel.org>,
        "Mathieu Poirier" <mathieu.poirier@linaro.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH v2 2/4] dt-bindings: remoteproc: qcom: Convert wcnss
 documentation to YAML
From:   "Sireesh Kodali" <sireeshkodali1@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Rob Herring" <robh@kernel.org>
X-Mailer: aerc 0.12.0
References: <20220908184925.2714098-1-sireeshkodali1@gmail.com>
 <20220908184925.2714098-3-sireeshkodali1@gmail.com>
 <1662671776.543526.3355395.nullmailer@robh.at.kernel.org>
 <ec73f713-2e42-3282-2e04-97a5db367702@linaro.org>
In-Reply-To: <ec73f713-2e42-3282-2e04-97a5db367702@linaro.org>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri Sep 9, 2022 at 1:30 PM IST, Krzysztof Kozlowski wrote:
> On 08/09/2022 23:16, Rob Herring wrote:
> > On Fri, 09 Sep 2022 00:19:23 +0530, Sireesh Kodali wrote:
> >> This is a direct conversion of the existing txt documentation to YAML.
> >> It is in preparation for the addition of pronto-v3 to the docs. This
> >> patch doesn't document any of the existing subnodes/properties that ar=
e
> >> not documented in the existing txt file. That is done in a separate
> >> patch.
> >>
> >> Signed-off-by: Sireesh Kodali <sireeshkodali1@gmail.com>
> >> ---
> >>  .../bindings/remoteproc/qcom,wcnss-pil.yaml   | 263 +++++++++++++++++=
+
> >>  1 file changed, 263 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/remoteproc/qcom,=
wcnss-pil.yaml
> >>
> >=20
> > My bot found errors running 'make DT_CHECKER_FLAGS=3D-m dt_binding_chec=
k'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> >=20
> > yamllint warnings/errors:
> >=20
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/remoteproc/qcom,wcnss-pil.example.dtb: pronto@a21b000: iris: 'vddxo-supply=
' is a required property
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devic=
etree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/remoteproc/qcom,wcnss-pil.example.dtb: pronto@a21b000: iris: 'vddrfa-suppl=
y' is a required property
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devic=
etree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/remoteproc/qcom,wcnss-pil.example.dtb: pronto@a21b000: iris: 'vddpa-supply=
' is a required property
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devic=
etree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/remoteproc/qcom,wcnss-pil.example.dtb: pronto@a21b000: iris: 'vdddig-suppl=
y' is a required property
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devic=
etree/bindings/remoteproc/qcom,wcnss-pil.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings=
/remoteproc/qcom,wcnss-pil.example.dtb: wcnss: 'bt' does not match any of t=
he regexes: 'pinctrl-[0-9]+'
> > 	From schema: /builds/robherring/dt-review-ci/linux/Documentation/devic=
etree/bindings/soc/qcom/qcom,wcnss.yaml
> >=20
>
> This needs to be fixed.
>
> Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
>
Will be fixed in v3

Regards,
Sireesh
>
> Best regards,
> Krzysztof

