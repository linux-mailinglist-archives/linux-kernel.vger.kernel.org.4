Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0A562CD81
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Nov 2022 23:19:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234788AbiKPWTT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Nov 2022 17:19:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234789AbiKPWTO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Nov 2022 17:19:14 -0500
Received: from mail-ot1-f47.google.com (mail-ot1-f47.google.com [209.85.210.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 089516A68E;
        Wed, 16 Nov 2022 14:19:13 -0800 (PST)
Received: by mail-ot1-f47.google.com with SMTP id a7-20020a056830008700b0066c82848060so11334552oto.4;
        Wed, 16 Nov 2022 14:19:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=C1BseCQ919mBRDJ4MavG4MG7H9ttIbDk/xHMoGJiS7w=;
        b=7O72zFjzF+EjbNtsilcSLKtz2441KmRTBcoHm0UXf68n4CjKGQagdqQSueQpfIx0NU
         48O7cRHvMSR9wuMkhXuJlyGUMI6M0LKgU1FVt+j5L9S4rYSeGmOqZBaJRKM83m0OaMU+
         CHL1hHCoG+YFyfEQvlDp55ZNCNBz8edGO0raqoXGxOcApwqi9kiqsFw7oSdz0Frwm+Oa
         4Nw/HtM1A/BbKfFcolGclTTJzVXM813S9FYdtGbO0JlchLC7SPtZgJPKdTYv9kCI6kPO
         2tD4Rrx46kh600jBvcJaBxk9pnj52P2NHFKIH1qzmAHswU+aNwm4doc+mKOPygo0JVQi
         uerg==
X-Gm-Message-State: ANoB5pmIXLfjYgrHDIisrOxCLKDTs9O0aclEmZIfyWLY0GcnA2t10x2n
        a6kRETZ5wsoriLfRHxIJlg==
X-Google-Smtp-Source: AA0mqf6Eebdg5PeMSU93AwHCbQ145qDurdgn9Iyf/Z25WtRx17/SMhDd27vWtGm1avZsTvXXn+MsOA==
X-Received: by 2002:a9d:730d:0:b0:661:a568:7b27 with SMTP id e13-20020a9d730d000000b00661a5687b27mr118701otk.28.1668637152220;
        Wed, 16 Nov 2022 14:19:12 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id h12-20020a056870538c00b0013ae39d0575sm8623086oan.15.2022.11.16.14.19.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 16 Nov 2022 14:19:11 -0800 (PST)
Received: (nullmailer pid 1130415 invoked by uid 1000);
        Wed, 16 Nov 2022 22:19:13 -0000
Date:   Wed, 16 Nov 2022 16:19:13 -0600
From:   Rob Herring <robh@kernel.org>
To:     Alex Helms <alexander.helms.jy@renesas.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sboyd@kernel.org, mturquette@baylibre.com, geert+renesas@glider.be
Subject: Re: [PATCH v3 1/2] dt-bindings: clock: Add bindings for Renesas ProXO
Message-ID: <20221116221913.GA1122997-robh@kernel.org>
References: <20221115233749.10161-1-alexander.helms.jy@renesas.com>
 <20221115233749.10161-2-alexander.helms.jy@renesas.com>
 <83492f7f-1217-69aa-8b38-ec1f08995832@linaro.org>
 <abc55598-8833-c4b2-aadc-c4e589aa775a@renesas.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <abc55598-8833-c4b2-aadc-c4e589aa775a@renesas.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 16, 2022 at 01:17:54PM -0700, Alex Helms wrote:
> On 11/16/2022 1:50 AM, Krzysztof Kozlowski wrote:
> > On 16/11/2022 00:37, Alex Helms wrote:
> >> Add dt bindings for the Renesas ProXO oscillator.
> >>
> >> Signed-off-by: Alex Helms <alexander.helms.jy@renesas.com>
> >> ---
> >>  .../bindings/clock/renesas,proxo.yaml         | 51 +++++++++++++++++++
> >>  MAINTAINERS                                   |  5 ++
> >>  2 files changed, 56 insertions(+)
> >>  create mode 100644 Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> >>
> >> diff --git a/Documentation/devicetree/bindings/clock/renesas,proxo.yaml b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> >> new file mode 100644
> >> index 000000000..ff960196d
> >> --- /dev/null
> >> +++ b/Documentation/devicetree/bindings/clock/renesas,proxo.yaml
> >> @@ -0,0 +1,51 @@
> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> >> +%YAML 1.2
> >> +---
> >> +$id: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fschemas%2Fclock%2Frenesas%2Cproxo.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C248dc84dbca44a4013d408dac7af9cf1%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638041854305996374%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=iGbtWJLjV%2FM%2Fps0lPk7f40bMzX8qdt8VZBtH9J4LdOw%3D&amp;reserved=0
> >> +$schema: https://jpn01.safelinks.protection.outlook.com/?url=http%3A%2F%2Fdevicetree.org%2Fmeta-schemas%2Fcore.yaml%23&amp;data=05%7C01%7Calexander.helms.jy%40renesas.com%7C248dc84dbca44a4013d408dac7af9cf1%7C53d82571da1947e49cb4625a166a4a2a%7C0%7C0%7C638041854305996374%7CUnknown%7CTWFpbGZsb3d8eyJWIjoiMC4wLjAwMDAiLCJQIjoiV2luMzIiLCJBTiI6Ik1haWwiLCJXVCI6Mn0%3D%7C3000%7C%7C%7C&amp;sdata=zYh4aHuw6G6A35rXBD7FTKeFrC7Hfcxag60ghkKUaGA%3D&amp;reserved=0
> >> +
> >> +title: Renesas ProXO Oscillator Device Tree Bindings
> > 
> > Same comments as for your other patch. All the same...
> > 
> >> +
> >> +maintainers:
> >> +  - Alex Helms <alexander.helms.jy@renesas.com>
> >> +
> >> +description:
> >> +  Renesas ProXO is a family of programmable ultra-low phase noise
> >> +  quartz-based oscillators.
> >> +
> >> +properties:
> >> +  '#clock-cells':
> >> +    const: 0
> >> +
> >> +  compatible:
> >> +    enum:
> >> +      - renesas,proxo-xp
> >> +
> >> +  reg:
> >> +    maxItems: 1
> >> +
> >> +  clock-output-names:
> >> +    maxItems: 1
> >> +
> >> +  renesas,crystal-frequency-hz:
> >> +    description: Internal crystal frequency, default is 50000000 (50MHz)
> > 
> > If it is internal, then it is fixed, right? Embedded in the chip, always
> > the same. Why do you need to specify it?
> > 
> 
> Yes, it is embedded in the package but there are different values
> depending on what chip is ordered and therefore must be specified for
> some configurations.
> 
> I'm also not sure what you mean by me ignoring Rob's comment. I
> explained my case for calling it "crystal-frequency-hz" and moved
> forward. I can call it "clock-frequency" if you want but I find that
> more confusing. Yes it is a built-in name in the schema but it seems to
> be used in a variety of ways. Some devices use it as a crystal input,
> but most seem to use it as the desired output frequency of the device
> which is not how it is used here. Therefore I chose a more clear name
> that better reflects what it is doing.

I think it is fine as-is. But you should have 'default: 50000000' 
instead of prose.

Rob
