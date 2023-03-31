Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9BE006D283E
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:55:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231800AbjCaSzS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:55:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232933AbjCaSzP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:55:15 -0400
Received: from mail-oi1-f169.google.com (mail-oi1-f169.google.com [209.85.167.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BC2A23B50;
        Fri, 31 Mar 2023 11:55:09 -0700 (PDT)
Received: by mail-oi1-f169.google.com with SMTP id bi31so17389015oib.9;
        Fri, 31 Mar 2023 11:55:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680288909;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mtr7oYDgi8JGwna/I5scrpSAxJ3BYloEo7NMWeb8wuw=;
        b=539pousP+kUJ/t9FmE5XV/aZZx6DhSKbM1+XXd49WKco3ML0RHexZvsDFAbfH4QKTp
         2UnDwJIXvgH9m6gL7vUHL0EKl1aCw2ChrbhrAmQwTB2qJVjhviyDjuOa8HhdPlRZNvAX
         cdhdfSAVA/syZMsNYP+h5hppGMRRkVoVhqYTvRI+nEfi7Dt77jw/18L3xG8ClwIvA0Uh
         JLJ/tzLiK5wMJXEaSJcjlH2P46BoEqnuR35VwBfTinGWvVs3Cxux3hpfETT7wH/VYlcC
         WPl7Kxrs081AjNgd/wENqnRh4oD5sJwPuT7wvxcSTULheSj6AMvXR1IzFwpNAGxLhvX2
         GTag==
X-Gm-Message-State: AO0yUKWopiDs+3l0FpQ1QcRF8wrheA7Jd2lojpNF8As0Gi//Tz0O7qpc
        JB8ZMjMHPAIGB4OiRGaJSg==
X-Google-Smtp-Source: AK7set9rE8V0D7Mkm6u6BKy31Gro0pBbciJN0nkEe9makaNh0+jQ3N9T+R7xR8W0v+XzPgjwslSw7g==
X-Received: by 2002:aca:d10:0:b0:383:f4fb:be63 with SMTP id 16-20020aca0d10000000b00383f4fbbe63mr11902671oin.37.1680288908719;
        Fri, 31 Mar 2023 11:55:08 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id s3-20020acac203000000b0038694b7dc09sm1253716oif.55.2023.03.31.11.55.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Mar 2023 11:55:07 -0700 (PDT)
Received: (nullmailer pid 1945063 invoked by uid 1000);
        Fri, 31 Mar 2023 18:55:07 -0000
Date:   Fri, 31 Mar 2023 13:55:07 -0500
From:   Rob Herring <robh@kernel.org>
To:     Roger Quadros <rogerq@kernel.org>
Cc:     heikki.krogerus@linux.intel.com, gregkh@linuxfoundation.org,
        vigneshr@ti.com, srk@ti.com, r-gunasekaran@ti.com,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: usb: tps6598x: make interrupts optional
Message-ID: <20230331185507.GA1938596-robh@kernel.org>
References: <20230324131853.41102-1-rogerq@kernel.org>
 <20230324133741.43408-1-rogerq@kernel.org>
 <271f0be0-9cb2-0c74-c112-33020e9a7342@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <271f0be0-9cb2-0c74-c112-33020e9a7342@kernel.org>
X-Spam-Status: No, score=0.8 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 29, 2023 at 10:05:33AM +0300, Roger Quadros wrote:
> Hi Heikki & Rob,
> 
> On 24/03/2023 15:37, Roger Quadros wrote:
> > The driver can poll for interrupt status so interrupts
> > can be optional. It is still recommended to use the
> > interrupt line. Polling should only be used for debug
> > and prototyping.
> > 
> > Signed-off-by: Roger Quadros <rogerq@kernel.org>
> > ---
> >  Documentation/devicetree/bindings/usb/ti,tps6598x.yaml | 2 --
> >  1 file changed, 2 deletions(-)
> > 
> > diff --git a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> > index 348a715d61f4..8c2db282735a 100644
> > --- a/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> > +++ b/Documentation/devicetree/bindings/usb/ti,tps6598x.yaml
> > @@ -35,8 +35,6 @@ properties:
> >  required:
> >    - compatible
> >    - reg
> > -  - interrupts
> > -  - interrupt-names
> >  
> >  additionalProperties: true
> >  
> 
> We need this patch as well along with the driver changes [1]
> Could you please Ack. Thanks!

If get_maintainers.pl had been properly used, then it probably would 
have been acked by Krzysztof already. Otherwise, it's in my queue if the 
DT list is copied.

Acked-by: Rob Herring <robh@kernel.org>

Rob
