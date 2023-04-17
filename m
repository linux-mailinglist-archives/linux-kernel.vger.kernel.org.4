Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 688926E40DE
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 09:28:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjDQH2E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 03:28:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230356AbjDQH1i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 03:27:38 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 477DA4686
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:27:19 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id 38308e7fff4ca-2a8c30ac7e3so5637011fa.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 00:27:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20221208.gappssmtp.com; s=20221208; t=1681716437; x=1684308437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ZRTjTCycaHpBoU3Ym49sFGw6ZqxWkZq2ouAKqZjTUf0=;
        b=SGplJOaL64R5/0tIMdtE03R4gbz/df9dbBh8U/U8v6QoBoUruMrooZUre/Xg5n0kuc
         KEmYgAX8H+Cd94C88zxoToF64Lfqx9Qi5hGJiIlw1nzozpdzYDuQ9jAI44L4dUQRGu5s
         tHDkJQCCBLXaSCmdWMqOckOqzFDEQu6wvM95LNCn04KTi1e+O4V2nPKXwbVZdr/DEauJ
         dh+SOUf8fF1vaRskM40ljLPNPAifqEasnUff5WL0g8vOHUewQPyWZI6ncV+vq515imKn
         h8XR5EIBW+IzD2vKMkbIxL9Ye6yCGqPVb9/LsHfMkjcHblT6tGMAOnGf25/LZfVUAzTJ
         H/Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681716437; x=1684308437;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ZRTjTCycaHpBoU3Ym49sFGw6ZqxWkZq2ouAKqZjTUf0=;
        b=bxft8csHbyKuzjhDcsvpXOGhpVw9h4G47KH6ZH+YyQElK0Ce/MijJa1DWhbp/x5bZh
         HsABxOIEAN37EVBwsN2Tq19bghNXVyO9a1B1ckQBpzWWEjPrN89VP0CS9NG5+N+FLYUK
         l45UmO0tCSHSfhRRqHjzaN29vjFVoju7scQkPNI4ZhWmyUU1hHDwBC6C5PCDkVwzDMtS
         VAClsMQcH8bIlNEHxg8aWV0As8wQK3XVWFgjRi113BhEiVNW8gVDOy21lhenjNbG+ksz
         UgJzsDV8ZvCqdv5LobXxiOaMYDfctfM8QoYrXffeKTR/riFQ7tlFKxh8VXBF2V5GlxIa
         Drpg==
X-Gm-Message-State: AAQBX9fzvu8Z1sdHVLe1IkOxRFLdqhK7RAdU4FdogZoFlBDjSqC3Eeps
        2GY2mbB2A3m68Z4yzSfiJ0cVrJsHA9a1rAfMJV4sLw==
X-Google-Smtp-Source: AKy350adRCczlvYcQuXt4pzto30Ej659CwCZRjppsj9dwGtViyMwGcjFzfiWOWUmUg+nQZ7mefY326ufEAdBZnqfwLc=
X-Received: by 2002:a05:6512:408:b0:4ec:90b2:b514 with SMTP id
 u8-20020a056512040800b004ec90b2b514mr1874854lfk.6.1681716437538; Mon, 17 Apr
 2023 00:27:17 -0700 (PDT)
MIME-Version: 1.0
References: <20230327125316.210812-1-brgl@bgdev.pl> <20230327125316.210812-4-brgl@bgdev.pl>
 <CAMRc=Mfe6gCM=Mz6Can6xsSsrjX-9T_aR2Yev+b57koky_az-A@mail.gmail.com>
 <CAMRc=Mfw+4Co8JPz51_E+DSawijO8EB6rMmFXEmM0e5F3Fg_8A@mail.gmail.com> <3877cb9e-9647-0acf-f705-d34fe2c731ff@linaro.org>
In-Reply-To: <3877cb9e-9647-0acf-f705-d34fe2c731ff@linaro.org>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 17 Apr 2023 09:27:04 +0200
Message-ID: <CAMRc=MeT4VLiLu5DJSXHqDdZv2gEoC-B7aPvoXVpc3SokQcrFg@mail.gmail.com>
Subject: Re: [PATCH v3 03/18] dt-bindings: interrupt-controller: qcom-pdc: add
 compatible for sa8775p
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        Bartosz Golaszewski <bartosz.golaszewski@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 16, 2023 at 5:04=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 14/04/2023 11:33, Bartosz Golaszewski wrote:
> > On Thu, Apr 6, 2023 at 4:10=E2=80=AFPM Bartosz Golaszewski <brgl@bgdev.=
pl> wrote:
> >>
> >> On Mon, Mar 27, 2023 at 2:53=E2=80=AFPM Bartosz Golaszewski <brgl@bgde=
v.pl> wrote:
> >>>
> >>> From: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>>
> >>> Add a compatible for the Power Domain Controller on SA8775p platforms=
.
> >>> Increase the number of PDC pin mappings.
> >>>
> >>> Signed-off-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
> >>> Cc: Thomas Gleixner <tglx@linutronix.de>
> >>> Cc: Marc Zyngier <maz@kernel.org>
> >>> ---
> >>>  .../devicetree/bindings/interrupt-controller/qcom,pdc.yaml     | 3 +=
+-
> >>>  1 file changed, 2 insertions(+), 1 deletion(-)
> >>>
> >>> diff --git a/Documentation/devicetree/bindings/interrupt-controller/q=
com,pdc.yaml b/Documentation/devicetree/bindings/interrupt-controller/qcom,=
pdc.yaml
> >>> index 94791e261c42..641ff32e4a6c 100644
> >>> --- a/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc=
.yaml
> >>> +++ b/Documentation/devicetree/bindings/interrupt-controller/qcom,pdc=
.yaml
> >>> @@ -26,6 +26,7 @@ properties:
> >>>    compatible:
> >>>      items:
> >>>        - enum:
> >>> +          - qcom,sa8775p-pdc
> >>>            - qcom,sc7180-pdc
> >>>            - qcom,sc7280-pdc
> >>>            - qcom,sc8280xp-pdc
> >>> @@ -53,7 +54,7 @@ properties:
> >>>    qcom,pdc-ranges:
> >>>      $ref: /schemas/types.yaml#/definitions/uint32-matrix
> >>>      minItems: 1
> >>> -    maxItems: 32 # no hard limit
> >>> +    maxItems: 38 # no hard limit
>
> I don't think the limit is correct. I still see warnings with this
> patch. We already have 57 elements, so limit should be I guess 128 or
> something.
>

You mean for other platforms? This limit applies to sa8775p as the
goal of the patch is to add its own PDC compatible. If other platforms
have more interrupts then we need to fix it first with a separate
commit IMO. I'll send out two patches for that.

Brt
