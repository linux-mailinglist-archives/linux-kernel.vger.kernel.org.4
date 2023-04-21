Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1992F6EB166
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 20:10:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231571AbjDUSKR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 14:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjDUSKQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 14:10:16 -0400
Received: from mail-ot1-f52.google.com (mail-ot1-f52.google.com [209.85.210.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73E502109;
        Fri, 21 Apr 2023 11:10:15 -0700 (PDT)
Received: by mail-ot1-f52.google.com with SMTP id 46e09a7af769-6a60460a23dso2038741a34.0;
        Fri, 21 Apr 2023 11:10:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682100615; x=1684692615;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XTxHxsPgtJkHHRMPUNuy+fEDFkDFR/EnI+ukh9jGLRc=;
        b=CJUmO6cjzd7SPs36vVLtrmb72E+ija9JFn5Wd+ZAmbmUPjoyvOtFMzMxDLdwbc9N9P
         OkSJwm9z5VWv0Pn6rUYLpaqfb4l7Dhxo5b92dotv1NEvFqVHW3ReEWrDjKlBIP71cDEO
         B5rp3pikvV1AAIOEjixbGzawXgcJ/TFhNsbeGqGJy9/tU/1uOlUdAEfMK9f53NJmQO5a
         o7ScQkttLMjrD26O/AR8QckRCIZBzyRm7djJa9euh/k1VRWEWfT/S0+/lEIn00Ym1U4E
         WimTI39di49YlSZpLSCoO0pGAPP6qmF3g486UzH0jRrAOY8jRNFARIBsINUM0xm3U5BB
         bkQA==
X-Gm-Message-State: AAQBX9eGVUZ33019Whe5Sm7YGOOncAd8W+FHHE5e0R9qaZ+WN+bHluzP
        BwGShEsW1aE3HQxyKHz7US6eLvH4bA==
X-Google-Smtp-Source: AKy350aPx+4wMKMj0Tuo7ZPmjyvkMDtdb/7rNapFkmJLEefK5dw7GdWojEpMhh3cG7Lh8Ca8FjDVQQ==
X-Received: by 2002:a05:6830:108:b0:69c:36e6:5413 with SMTP id i8-20020a056830010800b0069c36e65413mr3492390otp.11.1682100614700;
        Fri, 21 Apr 2023 11:10:14 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p7-20020a9d7447000000b006a4cceaf8ecsm2017093otk.48.2023.04.21.11.10.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 21 Apr 2023 11:10:14 -0700 (PDT)
Received: (nullmailer pid 1563775 invoked by uid 1000);
        Fri, 21 Apr 2023 18:10:13 -0000
Date:   Fri, 21 Apr 2023 13:10:13 -0500
From:   Rob Herring <robh@kernel.org>
To:     Naresh Solanki <naresh.solanki@9elements.com>
Cc:     Zev Weiss <zev@bewilderbeest.net>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: regulator: Add dt property
Message-ID: <20230421181013.GA1561415-robh@kernel.org>
References: <20230418145051.4192963-1-Naresh.Solanki@9elements.com>
 <0da2b301-8780-48c0-a5dc-326474011e8d@hatter.bewilderbeest.net>
 <9f425205-c395-648a-3f42-a776c7580a8f@9elements.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <9f425205-c395-648a-3f42-a776c7580a8f@9elements.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 20, 2023 at 01:52:30PM +0530, Naresh Solanki wrote:
> Hi Zev,
> 
> On 20-04-2023 05:31 am, Zev Weiss wrote:
> > On Tue, Apr 18, 2023 at 07:50:50AM PDT, Naresh Solanki wrote:
> > > Add DT property regulator-supplies.
> > > This enables us to couple one or more regulator output to gether. This
> > > is use in case of Single connector having 2 or more supplies.
> > > 
> > > Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
> > > ---
> > > .../bindings/regulator/regulator-output.yaml         | 12 +++++++++---
> > > 1 file changed, 9 insertions(+), 3 deletions(-)
> > > 
> > > diff --git
> > > a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> > > b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> > > index 078b37a1a71a..17f683d3c1f3 100644
> > > --- a/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> > > +++ b/Documentation/devicetree/bindings/regulator/regulator-output.yaml
> > > @@ -21,13 +21,19 @@ properties:
> > >   compatible:
> > >     const: regulator-output
> > > 
> > > -  vout-supply:
> > > +  regulator-supplies:
> > >     description:
> > > -      Phandle of the regulator supplying the output.
> > > +      Specifies the name of the output supply provided by the regulator.
> > > +      Defaults to "vout".
> > > +    default: "vout"
> > > +
> > 
> > Was this meant to be specified as a string-array to allow providing
> > multiple names?
> Yes. This is string-array.
> > 
> > > +patternProperties:
> > > +  ".*-supply":
> > > +    description:
> > > +      Specified the phandle for various supplies
> > > 
> > > required:
> > >   - compatible
> > > -  - vout-supply
> > > 
> > > additionalProperties: false
> > > 
> > > 
> > 
> > I think it would be nice to also update the examples to show what a
> > multi-supply instance would look like.
> Ack. Will do that.
> > 
> > A slightly more descriptive subject line would also be good -- "Add dt
> > property" is a bit vague.
> Suggestion ?
> How about like 'Allow multiple supplies' or 'Add support for multiple
> supplies'

And indicate this is for regulator-output, As-is looks like it's 
something for all regulators.

Rob
