Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF57262A130
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 19:17:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229766AbiKOSQ7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 13:16:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231447AbiKOSQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 13:16:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B5812FC15;
        Tue, 15 Nov 2022 10:16:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1FA91B81A5F;
        Tue, 15 Nov 2022 18:16:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4B96C4347C;
        Tue, 15 Nov 2022 18:16:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668536211;
        bh=nzoZVtAKQJIQTeBQutSbLNEtJkG6ZK7nNNBfDg5J8IA=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=UvaUm07ab0P3VMqxkWKNgDghtJE+sdtZU1KHbWuBHxvVyOJ9sO61YjPzGaKkmKYrq
         f7JGa153pJJU9JEud0fFO9J4y9NOGg9zeYUr/0B3Vv52YIWEWAb5HN6sAnvqin8B4o
         iynVRwQvBe0avgQkEsCj379VZM8etj5v6EdNlAjhkazH7zDcGIFGZTkoLBwfkHkaFs
         p/WDMqPuvPlNZ3PUhqlPZUInDfzeXcF3LDAmHDdv8BdudC0VczKdrbCYT3XAEUs3Op
         FuHn4kCjcsNAStEAMdonN/qbzJP09QF+zn/icCLJFKyMGC7IeAT+iAJ5Sbw75ZejZs
         K/8Z1P7Ixxc6Q==
Received: by mail-lf1-f54.google.com with SMTP id c1so25721791lfi.7;
        Tue, 15 Nov 2022 10:16:51 -0800 (PST)
X-Gm-Message-State: ANoB5pno0b0n3PePQMgINym4MGj1rooed6kql1dzP4ErKwNEa7B2AZXp
        0EHPygDxSmoUWk22ohVqG7gONwdffhvGrPLkoA==
X-Google-Smtp-Source: AA0mqf5ylXTe8JPsQerawu90MDYFzRHw/tk4HjTbjmj7U/3adbjHDxKMSHfzzcjyFwjdnPjfg8KUmkUC1XS9l9OLAcg=
X-Received: by 2002:ac2:5cc3:0:b0:4ab:5a19:3455 with SMTP id
 f3-20020ac25cc3000000b004ab5a193455mr5796390lfq.462.1668536209685; Tue, 15
 Nov 2022 10:16:49 -0800 (PST)
MIME-Version: 1.0
References: <20221103094436.2136698-1-demonsingur@gmail.com>
 <20221103094436.2136698-2-demonsingur@gmail.com> <20221106154634.2286faf3@jic23-huawei>
 <c01b0e56563b2b6f8ef48ad90977646706a2c933.camel@gmail.com>
 <20221112154040.54dc5cf2@jic23-huawei> <c54200fb70d638c572a0596a78d956d9f61d89a4.camel@gmail.com>
 <20221115160724.00007460@Huawei.com>
In-Reply-To: <20221115160724.00007460@Huawei.com>
From:   Rob Herring <robh+dt@kernel.org>
Date:   Tue, 15 Nov 2022 12:16:41 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLt6B73XSE8dMHMGuw1N9m1v1xwr3sOEEHonGgLAYya=A@mail.gmail.com>
Message-ID: <CAL_JsqLt6B73XSE8dMHMGuw1N9m1v1xwr3sOEEHonGgLAYya=A@mail.gmail.com>
Subject: Re: [PATCH v2 1/2] dt-bindings: iio: addac: add AD74115
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Cosmin Tanislav <demonsingur@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Michael Hennerich <Michael.Hennerich@analog.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        William Breathitt Gray <william.gray@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 15, 2022 at 10:07 AM Jonathan Cameron
<Jonathan.Cameron@huawei.com> wrote:
>
> On Tue, 15 Nov 2022 14:43:53 +0200
> Cosmin Tanislav <demonsingur@gmail.com> wrote:
>
> > On Sat, 2022-11-12 at 15:40 +0000, Jonathan Cameron wrote:
> > > > >
> > > > > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > > > > +    description: |
> > > > > > +      Conversion range for ADC conversion 2.
> > > > > > +      0 - 0V to 12V
> > > > > > +      1 - -12V to +12V
> > > > > > +      2 - -2.5V to +2.5V
> > > > > > +      3 - -2.5V to 0V
> > > > > > +      4 - 0V to 2.5V
> > > > > > +      5 - 0V to 0.625V
> > > > > > +      6 - -104mV to +104mV
> > > > > > +      7 - 0V to 12V
> > > > >
> > > > > For a lot of similar cases we handle these numerically to give
> > > > > a human readable dts.  Is there a strong reason not to do so here (in mv)
> > > > >
> > > >
> > > > I used this approach mostly because it maps dirrectly to register values
> > > > and because it's easier to parse. dts isn't exactly nice at handling
> > > > negative values. I can switch it to mv array if you insist.
> > >
> > > We have quite a few existing cases of
> > > adi,[output-]range-microvolt so it would be good to copy that style here.
> > >
> >
> > With this:
> >
> >   adi,conv2-range-microvolt:
> >     description: Conversion range for ADC conversion 2.
> >     oneOf:
> >       - items:
> >           - enum: [-2500000, 0]
> >           - const: 2500000
> >       - items:
> >           - enum: [-12000000, 0]
> >           - const: 12000000
> >       - items:
> >           - const: -2500000
> >           - const: 0
> >       - items:
> >           - const: -104000
> >           - const: 104000
> >       - items:
> >           - const: 0
> >           - const: 625000
> >
> > And this:
> >
> > adi,conv2-range-microvolt = <(-12000000) 12000000>;
> >
> > I get this:
> >
> > Documentation/devicetree/bindings/iio/addac/adi,ad74115.example.dtb:
> > addac@0: adi,conv2-range-microvolt: 'oneOf' conditional failed,
> > one must be fixed:
> >         4282967296 is not one of [-2500000, 0]
> >         4282967296 is not one of [-12000000, 0]
> >         -2500000 was expected
> >         -104000 was expected
> >         625000 was expected
> >         From schema: Documentation/devicetree/bindings/iio/addac/adi,ad74115.yaml
> >
> > As I said, negative numbers don't play too nice...
>
> From what I recall we just ignore those warnings :)
>
> Rob, do I remember correctly that there was a plan to make this work longer term?

Yes, but handling signed types is working now (since the move to
validating dtbs directly).

The issue here is -microvolt is defined as unsigned. IIRC, I had some
issue changing it, but I think that was just with the YAML encoding
which I intend to remove. I'll give it another look and update the
type if there's no issues.

Rob
