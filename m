Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B37455FBB66
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 21:37:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJKThw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Oct 2022 15:37:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiJKThq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Oct 2022 15:37:46 -0400
Received: from mail-oa1-f41.google.com (mail-oa1-f41.google.com [209.85.160.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF70B814DC;
        Tue, 11 Oct 2022 12:37:44 -0700 (PDT)
Received: by mail-oa1-f41.google.com with SMTP id 586e51a60fabf-1324e7a1284so17144737fac.10;
        Tue, 11 Oct 2022 12:37:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LlAJGnPyj1A3ETlIge5PWjY1J90VuYIAynT20wsgRJk=;
        b=pcpw/vOsTH5GkdgZuRDM6+GyK+J66I8JDc6r+tQ1DcfkbWzR+0yYgikiFyy+EBD/Wp
         UGEzTcB673Ai+c2h01OBYNS+9F/lqjU6ptg63V6dD38Al1HgDMBapXuSlHaV4OKI5p4f
         lMeyI5E42si/0/+wQDtb1emI4dE0MWKoDEuQ2CRw1pSFq/EOzMXl0ps9GOeqLDDDT027
         n5CrieQsAoOw9/WbQz5KMDGXXx12fp6t0BClW4ec1hGPX6jumopWMOH7fKaHEvztAyBv
         0p1JVc6LY5Lxb5uE9+WrdFjXMeekutSd+N5war0UJx0wdT5ic20+hylCOk/J7qSnEjw9
         IPMw==
X-Gm-Message-State: ACrzQf1IUhSbbdNoew2sMwTwJXMC4w0lydJCBpt1uyAUxn+XK2akF4hs
        J/74IPKoKjh7D+WclBOxdw==
X-Google-Smtp-Source: AMsMyM6qZ38xr6P0L8rkral0zexw7X1cJxjsH2N2lJhpfnjAWU2WmnxXYq66uI7K319YPMbgmtdpVQ==
X-Received: by 2002:a05:6870:d61e:b0:132:bc09:4b8c with SMTP id a30-20020a056870d61e00b00132bc094b8cmr477444oaq.32.1665517063906;
        Tue, 11 Oct 2022 12:37:43 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id g9-20020a056870d20900b0011bde9f5745sm247619oac.23.2022.10.11.12.37.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Oct 2022 12:37:43 -0700 (PDT)
Received: (nullmailer pid 4172857 invoked by uid 1000);
        Tue, 11 Oct 2022 19:37:44 -0000
Date:   Tue, 11 Oct 2022 14:37:44 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guenter Roeck <linux@roeck-us.net>
Cc:     Naresh Solanki <naresh.solanki@9elements.com>,
        devicetree@vger.kernel.org, Jean Delvare <jdelvare@suse.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: hwmon: fan: Add fan binding to schema
Message-ID: <20221011193744.GA4051000-robh@kernel.org>
References: <20221011104739.53262-1-Naresh.Solanki@9elements.com>
 <20221011104739.53262-2-Naresh.Solanki@9elements.com>
 <d2c83c4f-653c-438e-a91a-d17b846dec5b@roeck-us.net>
 <CABqG17hBJBU2rZSq4qy6Fn=pDH9ezwL=Fjh5vhj_G0cge-07mQ@mail.gmail.com>
 <8d2e905b-8669-b7ec-c7c0-1b0d78fded92@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d2e905b-8669-b7ec-c7c0-1b0d78fded92@roeck-us.net>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 11, 2022 at 09:46:08AM -0700, Guenter Roeck wrote:
> On 10/11/22 09:12, Naresh Solanki wrote:
> > Hi Guenter,
> > 
> > fan-common is intended for fan properties. i.e., those derived from
> > fan datasheets.
> > For min-rpm, some fans have minimum non zero rpm like 1900rpm below which
> > the fan cannot run.
> > 
> 
> I would argue the properties are for fan controllers, not for fans.
> Fans don't have or depend on specific pwm frequencies. Fan controllers
> do.

Presumably fan controllers can produce a range of frequencies. If they 
need a specific frequency, then why are they programmable? Something 
outside the fan controller must have the constraint.

> Fans don't have a configurable pwm polarity. Fan controllers do,
> to match the hardware on a board.

We don't model an inverter, so it's got to go somewhere.

> Fans don't have or rely on
> a target rpm. That is a system property, configured into the
> fan controller. And so on.

Yes, but it is per fan. per fan properties/settings should go in the fan 
node IMO.

> If this is for fans, we'll need another set of properties for
> fan controllers. The driver for max6639, being a fan controller,
> would need to implement those properties.
> 
> Also, as implemented in the MAX6639, max-rpm is the fan's
> rpm range, not the actual rpm. Your implementation is just
> confusing, including the example in the bindings. Valid values
> should be what the chip accepts, not some random value.

A fan would have some design maximum RPM depending on its mechanical 
design and lifetime requirements. A controller would have some maximum 
in terms of electrical pulse frequency or register bit sizes (depending 
how RPM or pulse counts are exposed to s/w. That should all be implied 
from the controller part and not in DT. It's the mechanical limits of 
the fan we should be defining here.

> Really, I don't understand where you are going with this.

Certainly it needs more thought for different cases.

Rob
