Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ABD4672352D
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 04:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbjFFCTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 22:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233867AbjFFCTI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 22:19:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3ECFC120
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 19:19:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-2566ed9328eso4757377a91.2
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 19:19:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686017946; x=1688609946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SSBB+TeKkPXz17eYvgCRhaR0tPZlT7t+oy06lLtdV3o=;
        b=guxz2C3LpRr3yHFCPMCRRP1cf1VHEaG5ZYn9jzfpbOaDbu2wK0W81AqxdxKHvF5Dz8
         QC8+vJ4ArOaeWdDD6V/7j7x6zlCMIZhR7hsjXkL+qpRSFFyfK1ZSAfxI9JUYmUFogFK+
         XOWM5lZfFfv7rY8nB3obpf1Thyy48G/hLCs6YxmKcrRvaVx8Kc4kiqYMO6MhD91qswtz
         ceNrDn8Jdf+rZhNYr2Twccts+qn+9ZH8hQL7tTDnemu7LGELG6/AI5IwFtke7hrEfims
         DgZLGnuk+nkeDEN7u89uE8nZDYH+AGnXfe1iyEdlhm752Od3ZLeUN+5+8KZv2wjNyb8v
         4DeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686017946; x=1688609946;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SSBB+TeKkPXz17eYvgCRhaR0tPZlT7t+oy06lLtdV3o=;
        b=aj3H2U8DykvHBZCBwvy0+uoZ7CzqehhrGK+D5ci1jQlXopvjBtKcmcXCZKS9tfHRlI
         SQwSROopOkUDQXFDtMFAAg/uISxlkf3GlSPao2kxjRMIjf78ddTyC5/eizFfmL4V3BuB
         hGR+jrIw/eZaMlpQ68UN7pMD9+A3yQxFQGC/hSUu/zr8AbjNcS314jEYaXHQmHvshyj2
         UISgIRIu2x3Ry8b7dvW07RK7AZoHa5evI/kFYimqlXANIGi0Gj9YQo5o50bVmNbS7p7+
         lb4U9OtfuU79H8vUlGwcLbvq0jQIDA1iQllBlzYIw+7T1Tw1e+GtCiLS2i/XKFA1Zjcs
         4uAQ==
X-Gm-Message-State: AC+VfDzJtHyHCAAwX+PHqdKVYVUF9Fj5YlW+ig1ZUH29sP5pRs0EOW0x
        XhItiMAovAz7XnZvcoDJyiQhsIg3nOPpiV1Ci1x2PA==
X-Google-Smtp-Source: ACHHUZ77jgRRpLTAVUGoEg6GR0CaMPypTruqaTUqdwmOkGhcRVu1EWuKeL8uGlKC+rblFVX3v/qj7M+sM0as4xrsRXk=
X-Received: by 2002:a17:90b:682:b0:250:132a:5d93 with SMTP id
 m2-20020a17090b068200b00250132a5d93mr364634pjz.49.1686017946716; Mon, 05 Jun
 2023 19:19:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230605060524.1178164-1-yangcong5@huaqin.corp-partner.google.com>
 <20230605060524.1178164-2-yangcong5@huaqin.corp-partner.google.com> <6818f4b0-4222-c3bb-c55f-bc0d26d7a681@linaro.org>
In-Reply-To: <6818f4b0-4222-c3bb-c55f-bc0d26d7a681@linaro.org>
From:   cong yang <yangcong5@huaqin.corp-partner.google.com>
Date:   Tue, 6 Jun 2023 10:18:55 +0800
Message-ID: <CAHwB_NLOrecxxP0kGS2ycXAw93XOSOiR+qPo50D292tDNKiqQQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: input: touchscreen: Add ilitek 9882T
 touchscreen chip
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, dmitry.torokhov@gmail.com, jikos@kernel.org,
        benjamin.tissoires@redhat.com, dianders@chromium.org,
        hsinyi@google.com, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,Krzysztof

On Mon, Jun 5, 2023 at 6:34=E2=80=AFPM Krzysztof Kozlowski
<krzysztof.kozlowski@linaro.org> wrote:
>
> On 05/06/2023 08:05, Cong Yang wrote:
> > Add an ilitek touch screen chip ili9882t.
> >
> > Signed-off-by: Cong Yang <yangcong5@huaqin.corp-partner.google.com>
> > ---
> >  .../bindings/input/elan,ekth6915.yaml         | 23 ++++++++++++++++---
> >  1 file changed, 20 insertions(+), 3 deletions(-)
> >
> > diff --git a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml=
 b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > index 05e6f2df604c..f0e7ffdce605 100644
> > --- a/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > +++ b/Documentation/devicetree/bindings/input/elan,ekth6915.yaml
> > @@ -15,11 +15,14 @@ description:
> >
> >  properties:
> >    compatible:
> > -    items:
> > -      - const: elan,ekth6915
> > +    enum:
> > +      - elan,ekth6915
> > +      - ilitek,ili9882t
> >
> >    reg:
> > -    const: 0x10
> > +    enum:
> > +      - 0x10
> > +      - 0x41
> >
> >    interrupts:
> >      maxItems: 1
> > @@ -29,11 +32,13 @@ properties:
> >
> >    vcc33-supply:
> >      description: The 3.3V supply to the touchscreen.
> > +                 If using ili9882t then this supply will not be needed=
.
>
> What does it mean "will not be needed"? Describe the hardware, not your
> drivers.
>
> I don't think you tested your DTS. Submit DTS users, because I do not
> believe you are testing your patches. You already got such comment and I
> don't see much of improvements here.

I ran make dt_binding_check in the codebase root directory before
sending the V2 Patch, and there were no errors or warnings (the V1
version run reported some errors). Is there some other way to test DTS
?

>
> >
> >    vccio-supply:
> >      description:
> >        The IO supply to the touchscreen. Need not be specified if this =
is the
> >        same as the 3.3V supply.
> > +      If using ili9882t, the IO supply is required.
>
> Don't repeat constraints in free form text.

Got it.thanks.

> >
> >  required:
> >    - compatible
> > @@ -41,6 +46,18 @@ required:
> >    - interrupts
> >    - vcc33-supply
> >
> > +if:
>
> Keep it in allOf. Will save you one indentation later.

Got it.thanks.

>
> > +  properties:
> > +    compatible:
> > +      contains:
> > +        const: ilitek,ili9882t
> > +then:
> > +  required:
> > +    - compatible
> > +    - reg
> > +    - interrupts
>
> Don't duplicate.

Got it.thanks.

>
> > +    - vccio-supply
>
>
> Best regards,
> Krzysztof
>
