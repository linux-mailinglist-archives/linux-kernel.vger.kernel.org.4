Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23DD265C6C7
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 19:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238561AbjACSwR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 13:52:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238773AbjACSwF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 13:52:05 -0500
Received: from mail-io1-f45.google.com (mail-io1-f45.google.com [209.85.166.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7030727A;
        Tue,  3 Jan 2023 10:52:04 -0800 (PST)
Received: by mail-io1-f45.google.com with SMTP id h6so17035006iof.9;
        Tue, 03 Jan 2023 10:52:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gm7xlk40RJ4XhPbmP5r8PjIXUo/5C8wCjuCRwKYtEwo=;
        b=rWCnlmg2YqR3WE7GJ930yF5cP5uT88z1sWvqWioxaiHbOogjKWbzZ6YgCHI7nrgdnn
         At3kmnljoB+CCtTYwyPI1e/9vlh97VT9Yq5gmkunFd+KO8B+vxNDnuvvMDEbTVgUvbkR
         6nCZI6VcneAz12QYJ1TYm+YsXkTqqogSqnUScq5/wvqJbbAfWDkDsAtn1d9r6Wrikcpk
         BmqkOHTRXuZo/lNwl9kxfijhSbb3SBHu3d+PK0SATqOx7Bk7iQxMHgnFFFWowcUAWgTo
         Laqofa1n7sd+XUKiutyZ1mMYwDwYpdreE3ElX06oIoKDyTdeGg1Cs+0gIYfRIMjqZPzS
         EbRg==
X-Gm-Message-State: AFqh2kr298FAdONBLaafVP6Ywx228gZ2Sg3QtNIgWym+NqnitSXHTwyT
        zUHJBA6pwrOHXUMIE9tZhg==
X-Google-Smtp-Source: AMrXdXv7OOsrhVOoIf3EDP6AS5H8BDQI89ZyvKLhO8wd7ZGuXw04tq8zhovhjgSvEMimP8VZs0jiBQ==
X-Received: by 2002:a5e:c80a:0:b0:6e3:f1da:fe9a with SMTP id y10-20020a5ec80a000000b006e3f1dafe9amr30300669iol.18.1672771923240;
        Tue, 03 Jan 2023 10:52:03 -0800 (PST)
Received: from robh_at_kernel.org ([64.188.179.248])
        by smtp.gmail.com with ESMTPSA id x6-20020a056602160600b006e00556dc9esm11470725iow.16.2023.01.03.10.52.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 03 Jan 2023 10:52:02 -0800 (PST)
Received: (nullmailer pid 3660699 invoked by uid 1000);
        Tue, 03 Jan 2023 18:52:01 -0000
Date:   Tue, 3 Jan 2023 12:52:01 -0600
From:   Rob Herring <robh@kernel.org>
To:     Jung Daehwan <dh10.jung@samsung.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Felipe Balbi <balbi@kernel.org>,
        "open list:USB SUBSYSTEM" <linux-usb@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>, sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com
Subject: Re: [RFC PATCH v2 3/3] dt-bindings: usb: snps,dwc3: add generic-xhci
 as child
Message-ID: <20230103185201.GA3650723-robh@kernel.org>
References: <1672307866-25839-1-git-send-email-dh10.jung@samsung.com>
 <CGME20221229100416epcas2p18f7600737b8f4149a1d75d2d8db3317a@epcas2p1.samsung.com>
 <1672307866-25839-4-git-send-email-dh10.jung@samsung.com>
 <f9b59733-61b1-67d8-01fa-fb3d3d7fbe0e@linaro.org>
 <20230102054517.GB74470@ubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230102054517.GB74470@ubuntu>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 02, 2023 at 02:45:17PM +0900, Jung Daehwan wrote:
> On Thu, Dec 29, 2022 at 11:23:02AM +0100, Krzysztof Kozlowski wrote:
> > On 29/12/2022 10:57, Daehwan Jung wrote:
> > > Currently, dwc3 invokes just xhci platform driver(generic-xhci) without
> > > DT schema even though xhci works as child of dwc3. It makes sense to add
> > > xhci as child of dwc3 with DT schema. It also supports to use another
> > > compatible in xhci platform driver.
> > 
> > You use some driver as an argument for hardware description, which is
> > not what we need. Describe the hardware.
> > 
> 
> OK. I will it on next submission.
> 
> > > 
> > > Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
> > > ---
> > >  .../devicetree/bindings/usb/snps,dwc3.yaml    | 29 +++++++++++++++++++
> > >  1 file changed, 29 insertions(+)
> > > 
> > > diff --git a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > index 6d78048c4613..83ed7c526dba 100644
> > > --- a/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > +++ b/Documentation/devicetree/bindings/usb/snps,dwc3.yaml
> > > @@ -360,8 +360,22 @@ properties:
> > >      description:
> > >        Enable USB remote wakeup.
> > >  
> > > +  "#address-cells":
> > > +    enum: [ 1, 2 ]
> > > +
> > > +  "#size-cells":
> > > +    enum: [ 1, 2 ]
> > > +
> > > +  ranges: true
> > > +
> > >  unevaluatedProperties: false
> > >  
> > > +# Required child node:
> > > +patternProperties:
> > > +  "^usb@[0-9a-f]+$":
> > > +    $ref: generic-xhci.yaml#
> > > +    description: Required child node
> > 
> > DWC does not have another piece of controller as child... DWC is the
> > controller. Not mentioning that you now affect several other devices
> > without describing the total hardware picture (just some drivers which
> > is not that relevant).
> > 
> 
> DWC controller supports USB Host mode and it uses same resource and
> really works as a child. I guess it's same on many SOCs, especially
> mobile..

Yes, and we already support all those platforms just fine without this 
child node. Adding it means we have to then support *both* ways in the 
driver.


> I just want to modify it to work with DT schema (dwc3 -> xhci-plat).
> I think it needs to dicuss more..

Why doesn't it work with the schema?

It's convenient when DT nodes == device drivers, but hardware is messy 
sometimes. Linux (and other OSs) have to deal with that. We can't write 
the DT to reflect the current (and evolving) needs of a particular OS. 

Rob
