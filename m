Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C96CE723579
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:48:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233306AbjFFCs2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:48:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234288AbjFFCsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:48:23 -0400
Received: from mail-qt1-x82b.google.com (mail-qt1-x82b.google.com [IPv6:2607:f8b0:4864:20::82b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 522FC11B;
        Mon,  5 Jun 2023 19:48:22 -0700 (PDT)
Received: by mail-qt1-x82b.google.com with SMTP id d75a77b69052e-3f7f73e90f9so51077541cf.2;
        Mon, 05 Jun 2023 19:48:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686019701; x=1688611701;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Ii0fg77US/518xlxOEKIJghiUHbirfwTQhyyLf4nwFk=;
        b=YkUAc4TC3M1Q7pCTfVYgwp8p3uTUDeIiMRqCzgyoTa20P97S9RC/mGarXO0x4BSSRh
         zJUCmjcmXzeWkdsz5eWNhwLbAnyd9uZ63+6M06ZchzkuB7402BsLgArOsvMD6fNoPU7X
         g8fzbr7P5Z+UDsMCLfX+sQx3x7VlTu1j3+/2JuYdGglYDMV5VZUKwZRCKUX4LXo168L6
         0wm0kqgDbVsl2/jr6Uy8CgZrOk4qGYN6g7+ySMFx91USPVed0qLGFzhKt9vo9NGVb8dT
         Y0NAQeZcnofVfCeS2KrGQnEyN6FvE9VshL7k6yBJEMLkzRR/tRtel8AVdWX8NDTADjyU
         wabg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686019701; x=1688611701;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Ii0fg77US/518xlxOEKIJghiUHbirfwTQhyyLf4nwFk=;
        b=OrIFLyg1Xm7+yp9cVjyfCRKDxFbx6KXtgi21Au3AOOlYH43R7zHnbQpUhKhyRkW6Wi
         03CSfW3i2tDFmHhyEdhfr3fLUGKsLIEZ0x6pXibRf8bCIWeFyeaj7w8+eqWoi2MtlRIC
         Cb/Evp6imhgVO62IYA3rjATPpFgYZrOXEteLJdphKAhYq7v69/4ma4QhRn1QSmJOkekV
         tuGRBpIHYNzsm5px+RuWo7m+s0dyU1h/rw8xyGtlygA1YX7oh+5c1w2KmZN5zQdO3nm+
         uIaeVJFnKjsdMAtFI0E+xaMlhKSuYPIn1MCGbra82iUtEAVnGNLz5HWDVIrViBG80PRv
         fADw==
X-Gm-Message-State: AC+VfDw8p+30IN3uWmzq2+vObT/x17CpcSkHWjlQUL7Z+zySExo2I55e
        Kq/35LZ9zk3R9fycJ36TyLg=
X-Google-Smtp-Source: ACHHUZ6EocqF7qgJM5pijhVqVHXWobos6JTE51MNtne+mUY0p/4PNoR4T2eozOpHO56zeFS1sz/hBw==
X-Received: by 2002:ac8:7d52:0:b0:3ef:4100:cd0c with SMTP id h18-20020ac87d52000000b003ef4100cd0cmr718727qtb.63.1686019701039;
        Mon, 05 Jun 2023 19:48:21 -0700 (PDT)
Received: from localhost ([2600:4040:2007:9800:ab:4faa:880f:7b91])
        by smtp.gmail.com with ESMTPSA id h22-20020ac846d6000000b003ef2db16e72sm5186302qto.94.2023.06.05.19.48.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 19:48:20 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Mon, 05 Jun 2023 22:48:18 -0400
Message-Id: <CT583OP69XTU.3E141NE263OR3@Latitude-E6420>
Cc:     <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-phy@lists.infradead.org>,
        <linux-arm-kernel@lists.infradead.org>
Subject: Re: [PATCH v3 2/4] dt-bindings: phy: qcom,usb-hs-phy: Add
 compatible
From:   "Rudraksha Gupta" <guptarud@gmail.com>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Conor Dooley" <conor+dt@kernel.org>,
        "Vinod Koul" <vkoul@kernel.org>,
        "Kishon Vijay Abraham I" <kishon@kernel.org>,
        "Arnd Bergmann" <arnd@arndb.de>, "Olof Johansson" <olof@lixom.net>,
        <soc@kernel.org>
X-Mailer: aerc 0.8.2
References: <20230604063032.365775-1-guptarud@gmail.com>
 <20230604063032.365775-3-guptarud@gmail.com>
 <3c781ae6-4a45-1d6d-840c-d25f33684b00@linaro.org>
In-Reply-To: <3c781ae6-4a45-1d6d-840c-d25f33684b00@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun Jun 4, 2023 at 6:30 AM EDT, Krzysztof Kozlowski wrote:
> On 04/06/2023 08:30, Rudraksha Gupta wrote:
> > Adds qcom,usb-hs-phy-msm8960 compatible
> >=20
> > Signed-off-by: Rudraksha Gupta <guptarud@gmail.com>
> > ---
> >  Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml | 5 ++++-
> >  1 file changed, 4 insertions(+), 1 deletion(-)
> >=20
> > diff --git a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml=
 b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> > index aa97478dd016..63b6914993fe 100644
> > --- a/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> > +++ b/Documentation/devicetree/bindings/phy/qcom,usb-hs-phy.yaml
> > @@ -13,7 +13,9 @@ if:
> >    properties:
> >      compatible:
> >        contains:
> > -        const: qcom,usb-hs-phy-apq8064
> > +        items:
> > +          - const: qcom,usb-hs-phy-apq8064
> > +          - const: qcom,usb-hs-phy-msm8960
>
> I have no clue what you want to achieve here. You break the bindings.
When I added the USB node to the msm8960 dtsi file, I got similar
messages for the expressatt/cdp that Rob mentioned in his email reply:

phy: resets: [[25, 0]] is too short
phy: reset-names:0: 'phy' was expected
phy: reset-names: ['por'] is too short

I will send an updated patch soon that addresses this.

>
> It does not look like you tested the bindings, at least after quick
> look. Please run `make dt_binding_check` (see
> Documentation/devicetree/bindings/writing-schema.rst for instructions).
> Maybe you need to update your dtschema and yamllint.
>
> Best regards,
> Krzysztof
Sorry. I was only looking for expressatt errors/warnings and failed to
see the other errors/warnings in the sea of text.
