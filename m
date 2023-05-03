Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A270B6F5F7A
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:57:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229632AbjECT5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjECT5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:57:05 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DF627DB4;
        Wed,  3 May 2023 12:57:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-64359d9c531so576480b3a.3;
        Wed, 03 May 2023 12:57:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683143824; x=1685735824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Tw+MfuvJyy7U9A8Ej/IC8kSXl0aMwhX8e58xBtI5EH4=;
        b=RiDuQr0rvOl6JjEq+TjkCKTPjddt/JtS5HkqLrkANiN1mpl9pBD8b35fTSzjyWU+Ji
         xn3Q0WCHgHttxbQEPMdIwBNv7pD5h5wWED+Cx6B87pBkUwRZ5Jx7AtIxMjobK5fB9JmV
         zdo7AKyww1HKF4ZVti8uJXGHPc7D/X6KCviKvhjoElI6zKyC/C9HAPy+QV9Y1vBFNI0m
         TMig6QON2DUqK9ks/X0v4EqbXTQH1iwtifoB2zAhgrrcteDk4onKg6VfTiwBQCKi2s12
         fujNU6cy1nqUz6guQy95cyiAJZJ+q2FiQQhTKfOHBukwcNOJJKsI7pbC+dBXCI1VM+Ye
         H8SA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683143824; x=1685735824;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tw+MfuvJyy7U9A8Ej/IC8kSXl0aMwhX8e58xBtI5EH4=;
        b=daPUSHp0EJe4t8aim9jCl9rnVKnUZVcxw0te4cHzW5CxWHGteos/wKEYcbQcpoHxXW
         5BkfOc5UrWc9lhKBqw6YKvccBOr8XkZu+8ga+XPRK9I0FW/Wi7N7ZcQ+y2ztBLXHFDyQ
         uGYVlgnxS9++IbKMVsXEQCRKyIvOiR3T7Xxqkn+mCj6JSXzyA4vTZbo3rhIilzs6Nh7G
         nSnx7vcuvsrmrhmUXi8e7gkVtzYUiSscRDJcr96WGB987v2WYaUeQYYkbIDiu9tH0C/y
         umM2qQAW2DIfFKy2dm/VT+J0K9qVVR08FvG13IWutNJzdUm3/3/6ZxWjVKlv4L0npACo
         l+bA==
X-Gm-Message-State: AC+VfDxL+orRHEm6/hX1Je3MItxNWy2Ch3OoynKYohUFAh4wDa6DYwqT
        4DM9beym9E87sDMQ41nenj9ksuHG1nMdL8aHGqUEJa+Y
X-Google-Smtp-Source: ACHHUZ55Ab4kZiRFReZsCAO79p9Mc6rj3ckjxcfIk4p+5Hx/eRXIA98kT4zvEcYMKN0nQYgKcA9qLBUNHJjn2D7eRwU=
X-Received: by 2002:a05:6a00:2347:b0:643:96e:666b with SMTP id
 j7-20020a056a00234700b00643096e666bmr4990164pfj.34.1683143823964; Wed, 03 May
 2023 12:57:03 -0700 (PDT)
MIME-Version: 1.0
References: <20230426185647.180166-1-robimarko@gmail.com> <b5df5692-5319-b5ff-0e9a-c66fb1f8358d@linaro.org>
In-Reply-To: <b5df5692-5319-b5ff-0e9a-c66fb1f8358d@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Wed, 3 May 2023 21:56:53 +0200
Message-ID: <CAOX2RU5WYm-wJXByAx8yavDPhR1=2MHjj0Kh1z6h_EHhS8DVGw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: qcom: ipq8074: Add QUP5 SPI node
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 1 May 2023 at 12:03, Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 26/04/2023 20:56, Robert Marko wrote:
> > Add node to support the QUP5 SPI controller inside of IPQ8074.
> > Some devices use this bus in order to manage external switches.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> >  arch/arm64/boot/dts/qcom/ipq8074.dtsi | 14 ++++++++++++++
> >  1 file changed, 14 insertions(+)
> >
> > diff --git a/arch/arm64/boot/dts/qcom/ipq8074.dtsi b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > index 64c2a30d9c25..4a682e3442f8 100644
> > --- a/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > +++ b/arch/arm64/boot/dts/qcom/ipq8074.dtsi
> > @@ -774,6 +774,20 @@ blsp1_i2c5: i2c@78b9000 {
> >                       status = "disabled";
> >               };
> >
> > +             blsp1_spi5: spi@78b9000 {
> > +                     compatible = "qcom,spi-qup-v2.2.1";
> > +                     #address-cells = <1>;
> > +                     #size-cells = <0>;
> > +                     reg = <0x78b9000 0x600>;
>
> reg is always after compatible.

I agree usually, but here its just matching the same pattern like
other BLSP nodes.

Regards,
Robert
>
> Best regards,
> Krzysztof
>
