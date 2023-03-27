Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E90846CA8C7
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:18:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232220AbjC0PSH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:18:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231717AbjC0PSF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:18:05 -0400
Received: from mail-oi1-f170.google.com (mail-oi1-f170.google.com [209.85.167.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A3C09106;
        Mon, 27 Mar 2023 08:18:04 -0700 (PDT)
Received: by mail-oi1-f170.google.com with SMTP id q27so5865119oiw.0;
        Mon, 27 Mar 2023 08:18:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679930284;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUSCOsxTscJFykA96S2HHz11yN7G7jVkej50uNItSXY=;
        b=Oxz9Lq5Qss0glRzgWHB2m0SlgVVhids3lzYBVJRnuehoq0KH6pqTdh0l3hUvT7fK41
         /9wH+eeEKBKOt8ZfscXoBTfM6D5nk7a1YQFI8XyCgvXKEIwBzab8izy5+BwfXqxjajkk
         eQUH7QanLO9WTUAm8NLdtkkOH5HfjsyJlpMJmXi4ZapwmMyE8taMqkCeFKjast+olroV
         kr7xSW2NQJjVPOGMn0RSQhR1N63iG5HG8/ULwQ7PqAbWNMqKqxrMhylOdnBa7a+MLfZR
         MhXjm5KRst/w+Wjhv6HPX1Y0hE4TWpuaGv29fjveMqB89gnOh3ewYId7ABYC7g9wdPCp
         PPPA==
X-Gm-Message-State: AAQBX9dFY6ADVjIONdmvQxQKVjydo99Hl1mwHM3nCoBaharP2VlMoqrL
        5zT1kN9W369ZyczJ+yDRew==
X-Google-Smtp-Source: AKy350aYr658iaouhuPMz5BUi/6LPvCml2JNjfTHY3Dd+GRk2+ni9Tm9z1RVzieyWuXYsh0ctaPzTA==
X-Received: by 2002:a05:6808:93:b0:389:1601:fb7 with SMTP id s19-20020a056808009300b0038916010fb7mr2090348oic.51.1679930283810;
        Mon, 27 Mar 2023 08:18:03 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id z6-20020a4aae06000000b0051763d6497fsm11218156oom.38.2023.03.27.08.18.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:18:03 -0700 (PDT)
Received: (nullmailer pid 3893016 invoked by uid 1000);
        Mon, 27 Mar 2023 15:18:02 -0000
Date:   Mon, 27 Mar 2023 10:18:02 -0500
From:   Rob Herring <robh@kernel.org>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        arnd@arndb.de, linux-aspeed@lists.ozlabs.org,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH v2 2/4] doc: Add Atmel AT30TSE serial eeprom
Message-ID: <20230327151802.GA3485600-robh@kernel.org>
References: <20230321151642.461618-1-eajames@linux.ibm.com>
 <20230321151642.461618-3-eajames@linux.ibm.com>
 <6d4cf513-0787-6b39-8d38-30484be7ddff@linaro.org>
 <baf7ad36-0410-3063-7960-8dd7040fb8fd@linux.ibm.com>
 <5993d93e-f57b-51aa-85a3-f58ca0cf846d@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5993d93e-f57b-51aa-85a3-f58ca0cf846d@linux.ibm.com>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 10:55:43AM -0500, Eddie James wrote:
> 
> On 3/21/23 10:46, Eddie James wrote:
> > 
> > On 3/21/23 10:19, Krzysztof Kozlowski wrote:
> > > On 21/03/2023 16:16, Eddie James wrote:
> > > > The AT30TSE is compatible with the JEDEC EE1004 standard. Document it
> > > > as a trivial I2C device.
> > > > 
> > > > Signed-off-by: Eddie James <eajames@linux.ibm.com>
> > > Use subject prefixes matching the subsystem (which you can get for
> > > example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
> > > your patch is touching).
> > 
> > 
> > Oops, sorry, will fix.
> > 
> > 
> > > 
> > > > ---
> > > >   Documentation/devicetree/bindings/trivial-devices.yaml | 2 ++
> > > >   1 file changed, 2 insertions(+)
> > > > 
> > > > diff --git
> > > > a/Documentation/devicetree/bindings/trivial-devices.yaml
> > > > b/Documentation/devicetree/bindings/trivial-devices.yaml
> > > > index 6f482a254a1d..43e26c73a95f 100644
> > > > --- a/Documentation/devicetree/bindings/trivial-devices.yaml
> > > > +++ b/Documentation/devicetree/bindings/trivial-devices.yaml
> > > > @@ -47,6 +47,8 @@ properties:
> > > >             - ams,iaq-core
> > > >               # i2c serial eeprom (24cxx)
> > > >             - at,24c08
> > > > +            # i2c serial eeprom (EE1004 standard)
> > > AT30TSE?
> > > 
> > > > +          - atmel,at30tse
> > > Microchip does not find anything on AT30TSE. Are you sure this is the
> > > model name?
> > 
> > 
> > Yes: https://www.microchip.com/content/dam/mchp/documents/OTH/ProductDocuments/DataSheets/Atmel-8868-DTS-AT30TSE004A-Datasheet.pdf
> > 
> > 
> > Maybe it's actually an 8868? Or should I include the 004A as well?
> 
> 
> I found some other AT30TSE (AT30TSE752A for example) devices that do not
> appear compatible with the EE1004 standard, so I will include the full model
> number.

If this standard is sufficiently complete, then you might want a EE1004 
fallback compatible. Complete would mean power supply(ies) and any extra 
i/o are defined and the exact device model is discoverable.

Rob
