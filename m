Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE1E36DF6D9
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:20:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229940AbjDLNUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:20:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229817AbjDLNUn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:20:43 -0400
Received: from mail-ot1-x32d.google.com (mail-ot1-x32d.google.com [IPv6:2607:f8b0:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9875393C4;
        Wed, 12 Apr 2023 06:20:24 -0700 (PDT)
Received: by mail-ot1-x32d.google.com with SMTP id u24-20020a9d7218000000b006a413c893c8so1661737otj.10;
        Wed, 12 Apr 2023 06:20:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681305323; x=1683897323;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=MFD7NhK2n6LRm3/Y/zZUZpldkUwIJ0dQh6NwA4X/4ww=;
        b=aI8J/lKG7lcIvNHD+6PBF03S461ki22WKDo6ts3H57eEc2NMiQdbHQFtGTdVD9QfjJ
         4weRe09ZHqJbCbVao0Xood3Vjy5Eei120mb/8+RGrhPn1Eugm116YKVOZufrvBK6nkLQ
         mp9xCxqtEqI+/2xvH9CVH31HnMU2owOFrB4Y0tVnQVsg+uEs3DcqhVXqHZ/TP+skW7+E
         sJPI1odrgA1Lj/v8zIER984SR7Y5XTVfRiAWmevYU9BQfIuH+Q/Ra92bduzIwyuBv3Ed
         zj0H3mljmnuZhmWRhzuwcGVmYlGqLCnDvlNMqX8DzF7CPkIsMHbMt+a61ho5PZ9yWnb7
         hGUg==
X-Gm-Message-State: AAQBX9eg9M7RjvZuISsmn3lBvCRyTa4L8vvnqeGu6M+tBaHIHRiUBdpM
        uk9WIBBk3U6i4J7Bz2ZVsg==
X-Google-Smtp-Source: AKy350b0BHjuZKDnNLiWFaaVgnwX0CY+gcQNzPwHkH+YHkjo7NjmIWxl00hy3X6ub0x9YQkKf31V/g==
X-Received: by 2002:a9d:7586:0:b0:69f:8e11:ff36 with SMTP id s6-20020a9d7586000000b0069f8e11ff36mr8704748otk.33.1681305322844;
        Wed, 12 Apr 2023 06:15:22 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c17-20020a056830001100b006a2e9ccb42esm6413802otp.19.2023.04.12.06.15.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 12 Apr 2023 06:15:22 -0700 (PDT)
Received: (nullmailer pid 1917201 invoked by uid 1000);
        Wed, 12 Apr 2023 13:15:21 -0000
Date:   Wed, 12 Apr 2023 08:15:21 -0500
From:   Rob Herring <robh@kernel.org>
To:     Cristian Marussi <cristian.marussi@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, vincent.guittot@linaro.org,
        souvik.chakravarty@arm.com, nicola.mazzucato@arm.com,
        Tushar.Khandelwal@arm.com, viresh.kumar@linaro.org,
        jassisinghbrar@gmail.com,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: mailbox : arm,mhuv2: Allow for more RX
 interrupts
Message-ID: <20230412131521.GA1830888-robh@kernel.org>
References: <20230329153936.394911-1-cristian.marussi@arm.com>
 <20230329153936.394911-2-cristian.marussi@arm.com>
 <20230329174431.yga3c233sazimane@bogus>
 <ZCVIVhtSLKTHs+to@e120937-lin>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZCVIVhtSLKTHs+to@e120937-lin>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 09:29:23AM +0100, Cristian Marussi wrote:
> On Wed, Mar 29, 2023 at 06:44:31PM +0100, Sudeep Holla wrote:
> > On Wed, Mar 29, 2023 at 04:39:35PM +0100, Cristian Marussi wrote:
> > > The ARM MHUv2 Receiver block can indeed support more interrupts, up to the
> > > maximum number of available channels, but anyway no more than the maximum
> > > number of supported interrupt for an AMBA device.
> > > 
> > > Signed-off-by: Cristian Marussi <cristian.marussi@arm.com>
> > > ---
> > > Cc: Rob Herring <robh+dt@kernel.org>
> > > Cc: Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
> > > Cc: devicetree@vger.kernel.org
> > > 
> > >  .../devicetree/bindings/mailbox/arm,mhuv2.yaml      | 13 +++++++++----
> > >  1 file changed, 9 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> > > index a4f1fe63659a..5a57f4e2a623 100644
> > > --- a/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> > > +++ b/Documentation/devicetree/bindings/mailbox/arm,mhuv2.yaml
> > > @@ -69,10 +69,15 @@ properties:
> > >  
> > >    interrupts:
> > >      description: |
> > > -      The MHUv2 controller always implements an interrupt in the "receiver"
> > > -      mode, while the interrupt in the "sender" mode was not available in the
> > > -      version MHUv2.0, but the later versions do have it.
> > > -    maxItems: 1
> > > +      The MHUv2 controller always implements at least an interrupt in the
> > > +      "receiver" mode, while the interrupt in the "sender" mode was not
> > > +      available in the version MHUv2.0, but the later versions do have it.
> > > +      In "receiver" mode, beside a single combined interrupt, there could be
> > > +      multiple interrupts, up to the number of implemented channels but anyway
> > > +      no more than the maximum number of interrupts potentially supported by
> > > +      AMBA.
> > > +    minItems: 1
> > > +    maxItems: 9
> > 
> 
> Hi,
> 
> > I am not sure 9 is the correct value here. IIUC it is just what Linux defines
> > as AMBA_NR_IRQS. Looking at the history it was bumped from 2 to 9 for use
> > by PL330 DMA driver. I couldn't find anything to relate this 9 in any
> > AMBA or other related specification.
> > 
> 
> Yes, I could not find either where the 9 comes from, but it is what
> currently each amba device is limited to, at the software level, in terms of
> interrupts that can be detected.

IIRC, the PL330 can have an interrupt per context with up to 8 contexts 
and then 1 global interrupt.

> 
> > Ideally I would say we don't know what the max here. We just have a platform
> > implementing 2 interrupts now. Do we for with 2 for now and change it if some
> > new users require more in the future ?
> > 
> 
> By the spec seems to me that the maximum number of interrupts are equal to
> the maximum possible channels (124), or one combined interrupt.
> 
> But these in turn, as said, are capped by the AMBA_NR_IRQS and I have
> only seen one system using 2. (for which I need this series to work)
> 
> > I will leave that to the DT maintainers but 9 is simply random based on Linux
> > code so I would rather choose some other random number with a better reasoning
> > than 9 as AMBA code in the kernel is limiting it to 9.
> > 
> 
> Agreed. Aiming to describe any possible hw in the DT, I would say 124 at
> this point. (even though implausible not to use the combined interrupt
> at that point...)

Then use 124, but please describe how you get that in the description.

Rob
