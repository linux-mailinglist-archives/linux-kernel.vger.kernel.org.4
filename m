Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A169C6DA26F
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 22:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238542AbjDFUQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 16:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237830AbjDFUQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 16:16:15 -0400
Received: from mout.kundenserver.de (mout.kundenserver.de [212.227.17.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C315555BD;
        Thu,  6 Apr 2023 13:16:13 -0700 (PDT)
Received: from localhost ([31.220.116.195]) by mrelayeu.kundenserver.de
 (mreue106 [212.227.15.183]) with ESMTPSA (Nemesis) id
 1MWBC8-1pv0e90CYE-00Xf2U; Thu, 06 Apr 2023 22:15:55 +0200
Date:   Thu, 6 Apr 2023 22:15:54 +0200
From:   Andreas Klinger <ak@it-klinger.de>
To:     Jonathan Cameron <jic23@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Angel Iglesias <ang.iglesiasg@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/3] dt-bindings: iio: pressure: Support Honeywell mpr
 sensors
Message-ID: <ZC8oepuINTaMqN9M@arbad>
References: <20230401185717.1b971617@jic23-huawei>
 <20230401162701.1d3caebc@jic23-huawei>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230401162701.1d3caebc@jic23-huawei>
X-Provags-ID: V03:K1:iRs4rZwA59GOGxzEuqb6D5jilhgxNPdfXbRVIshLue07kgRWjNV
 RckfhXjz7OYFrr5SSyxmBhcl+cpExy/DO3uCe+s8qpB7vu5KVdv4qT8fcIVzmoVZO7FTc6/
 7OvQqA3qWKoXtScI+tUJ61bnu/rOszyFhM1UTf/0IsV9Tm4JjvAsy3Gt0/ikSPFoXJE79iV
 ey/0gNp9QIo6MVqVF2cPg==
UI-OutboundReport: notjunk:1;M01:P0:Hqse2F2pWKI=;7ULkrfL4+qZpEcRHFzXFG/SPC5U
 k2KWl6l55mm3TWi2zqZWkW8ZJQ/pe/KyDv2LPiGVvB6zmq35m0+6ZE3TUOaK5Z0nx8z0CT6Oq
 S7+psb694g4TcERYfdoHJkzdCcmqB561PwvaHwQ7l56JkIk8YkePedH8lmOx8hqdX6QKS2dlX
 qN7mFCPG1JSJ3XoJlueJ2wDES6HZfX2NR5UEJAXmzgeiczeOpA3cY7yh6va+fxdc5wAJMOzpg
 T0qOy8PAAg0NUWvaXro/Xyuq8M4oWtFDokKJrTzCQU8oeGyFlOjjTMtfplm2VYfD04B31iOEy
 jbt6YDJRDgrcxVHEt18QAaTQoMIBOjuDaLbrG6f1vJVvDwUHhZmlDcmTQVstwjtcdTyeumHDs
 NOWqrMLJ+O25VMXmll1A/wDaubCfg6gMlKZCWryxjsj0yDl8G9kEXlqfdBjJuDNbg6Yh4jk25
 jtRFBMoY61PqXJqO7W3P038dbTJwXoPpAvmD7NEKxA9uwnCAI+AzHKMhqnM7axSPBkZDv64kb
 +bVVUI40BmAnZvow68Id+FvY+MtcaLybegTllZV4uBYO6LsrGHyXgtqatFDIWt8Oo4abBLdiX
 +B2WTgzwAxnNoRuYBinJtFbftDfdpCHcxO76zJ73xEmEl5wYJ0BzV8YWitkHW+cl1h18wi3Y3
 DLxLshpPsVVsDz1rweCnWN1cfaatT+dfr5GV68E0rA==
X-Spam-Status: No, score=-0.0 required=5.0 tests=RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

thanks to Krzysztof, Lars-Peter and Jonathan for the review and suggestions. I
have one thing to clarify. See below.

Jonathan Cameron <jic23@kernel.org> schrieb am Sa, 01. Apr 16:27:
> On Sat, 1 Apr 2023 11:42:15 +0200
> Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:
> 
> > On 01/04/2023 11:09, Andreas Klinger wrote:
[...]
> > > +  honeywell,pmin:
> > > +    description:
> > > +      Minimum pressure value the sensor can measure in pascal.  
> > 
> > Use standard unit suffix:
> > https://github.com/devicetree-org/dt-schema/blob/main/dtschema/schemas/property-units.yaml
> > 
> > > +    $ref: /schemas/types.yaml#/definitions/uint32
> > > +
> > > +  honeywell,pmax:
> > > +    description:
> > > +      Maximum pressure value the sensor can measure in pascal.
> > > +    $ref: /schemas/types.yaml#/definitions/uint32  
> > 
> > Same.
> > 
> > Why these values are suitable for DT? Does it depend on type of sensor
> > (thus it is implied from compatible) or on system setup?
> 
> I think we'll end up with a lot of compatibles, but that's still better
> than free form description.  May still need these as well though given
> the datasheet helpfully adds a foot note.
> 
> 1. Custom pressure ranges are available.
> 
> Might not be worth including all the details though but unhelpfully the
> bits we care about are after details like is the gel food grade or the port long.
> Definitely can ignore the encoding of i2c address / spi in the last few bits but
> may need the transfer function.
> 
> 
> mpr-0025GA-A maybe as a form?

Just to clarify: There are 32 different pressure ranges and 3 transfer functions
which means we'll end up with 96 compatibles and 96 I2C ids.

Would it be an option to have only one dt compatible and to add the pressure
range as dt property?
e. g.: honeywell,range = "0025PA";

But because of "Custom pressure ranges" we still need the DT properties. In this
case there's another "mpr-custom" compatible, right?

Andreas

