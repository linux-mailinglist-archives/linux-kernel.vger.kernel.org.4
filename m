Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA00768196F
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 19:38:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238351AbjA3SiW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 13:38:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237410AbjA3SiB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 13:38:01 -0500
Received: from mail-oa1-f42.google.com (mail-oa1-f42.google.com [209.85.160.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E26170F;
        Mon, 30 Jan 2023 10:37:08 -0800 (PST)
Received: by mail-oa1-f42.google.com with SMTP id 586e51a60fabf-15085b8a2f7so16264747fac.2;
        Mon, 30 Jan 2023 10:37:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QYdypphiGiORHl5j+yMljNsD206DEi5H26RsKdcAI+U=;
        b=Qcsfcuw3JsZ3s+ul+flK+YNEKgIisO4V3wKaxtz2zvdgh7zjLMKGVfFxUxqGaKunX1
         +Z3jvrLd1z+KXPQ0VsDdN6CS1ljv9ui3pqEHYywQ3jLtXpQKnKhkSPCRKuFPLTgjrjmf
         rCgC+XUH9OhNcC4Ij65SRREKJrVp17A7k4IfaPGj1dT1I9KLGLFyE9NVFcyYmh40p6mW
         RPvPxJ7dlLTvuTsvbYb/cubD9U6ZGSJgD0ZZPvLqhPaav2JmebpnAjkX8EZtPigt9d0o
         BKvDq5AhW9La9/gw0DVpHEoEJSkjU2f/cJPi40ZJJpRcz9clIB7tGjOX35Ibvdo2SuDQ
         rUAw==
X-Gm-Message-State: AO0yUKWlJu5wikZQ/eN+SyXvvxFBjPcNnsdImm6qD5WYyfywR5F8YbvK
        ENj1UJi3JlOCRI5fB1S9Lpsk38j9mg==
X-Google-Smtp-Source: AK7set/Idt/xWQrTCTneEaD3YHNIFguFuZSIGGEp1x4r/NuMnynSUl3elQgOA/OFI4IM6OQ2n1CcmA==
X-Received: by 2002:a05:6870:ac1e:b0:163:28c9:beef with SMTP id kw30-20020a056870ac1e00b0016328c9beefmr11845994oab.59.1675103827642;
        Mon, 30 Jan 2023 10:37:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id c11-20020a544e8b000000b0037854b52db4sm1270294oiy.55.2023.01.30.10.37.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 Jan 2023 10:37:07 -0800 (PST)
Received: (nullmailer pid 3088245 invoked by uid 1000);
        Mon, 30 Jan 2023 18:37:06 -0000
Date:   Mon, 30 Jan 2023 12:37:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     "Leonard, Niall" <Niall.Leonard@ncr.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
 bindings
Message-ID: <20230130183706.GA3079628-robh@kernel.org>
References: <20230126-gpio-mmio-fix-v1-0-8a20ce0e8275@ncr.com>
 <20230126-gpio-mmio-fix-v1-1-8a20ce0e8275@ncr.com>
 <d4a70ab2-c5a2-2478-3fa9-c703c1619252@linaro.org>
 <MW5PR15MB52184F83BA524D9600B820F5FDCC9@MW5PR15MB5218.namprd15.prod.outlook.com>
 <ed16faa2-eb04-772d-8762-0c3f90fddbcb@linaro.org>
 <c95cea18-5b92-e16c-f4f6-cde93ca22ca1@ncr.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c95cea18-5b92-e16c-f4f6-cde93ca22ca1@ncr.com>
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

On Mon, Jan 30, 2023 at 01:20:55PM +0000, Leonard, Niall wrote:
> On 29/01/2023 15:59, Krzysztof Kozlowski wrote:
> > *External Message* - Use caution before opening links or attachments
> > 
> > On 27/01/2023 12:39, Leonard, Niall wrote:
> >>
> >>
> >>> -----Original Message-----
> >>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> >>> Sent: 26 January 2023 12:29
> >>> To: Leonard, Niall <Niall.Leonard@ncr.com>; Linus Walleij
> >>> <linus.walleij@linaro.org>; Bartosz Golaszewski <brgl@bgdev.pl>; Rob
> >>> Herring <robh+dt@kernel.org>; Krzysztof Kozlowski
> >>> <krzysztof.kozlowski+dt@linaro.org>
> >>> Cc: linux-gpio@vger.kernel.org; devicetree@vger.kernel.org; linux-
> >>> kernel@vger.kernel.org
> >>> Subject: Re: [PATCH 1/3] gpio: dt-bindings: add new property to wd,mbl-gpio
> >>> bindings
> >>>
> >>> *External Message* - Use caution before opening links or attachments
> >>>
> >>> On 26/01/2023 11:17, Niall Leonard via B4 Submission Endpoint wrote:
> >>>> From: Niall Leonard <nl250060@ncr.com>
> >>>
> >>> Subject: missing "wd,mbl-gpio:" prefix.
> >>>
> >>> Subject: drop second/last, redundant "bindings". The "dt-bindings"
> >>> prefix is already stating that these are bindings.
> >>>
> >>>>
> >>>> Added optional "no-input" property
> >>>
> >>> Missing full stop.
> >>>
> >>>>
> >>>> Signed-off-by: Niall Leonard <nl250060@ncr.com>
> >>>> ---
> >>>>   Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt | 1 +
> >>>>   1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> >>>> b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> >>>> index 038c3a6a1f4d..9405f9dad522 100644
> >>>> --- a/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> >>>> +++ b/Documentation/devicetree/bindings/gpio/wd,mbl-gpio.txt
> >>>> @@ -18,6 +18,7 @@ Required properties:
> >>>>
> >>>>   Optional properties:
> >>>>   	- no-output: GPIOs are read-only.
> >>>> +	- no-input: GPIOs are write-only. Read is via a shadow register.
> >>>
> >>> Why this property is needed? Why driver cannot always use shadow
> >>> register?
> >>>
> >> The shadow register is currently only used during the write operation. It is not available during the read operation.
> > 
> > You just wrote above that reading is via shadow register, so how can it
> > not be available for reads? Again, why you cannot always read via shadow
> > register and need to make a property? You mean that for other GPIOs
> > there is no shadow register at all?
> > 
> The existing read method does not use the shadow register.
> 
> static int bgpio_get(struct gpio_chip *gc, unsigned int gpio)
> {
> 	return !!(gc->read_reg(gc->reg_dat) & bgpio_line2mask(gc, gpio));
> }
> 
> > What changes between one board and another that justifies this property?
> 
> I have a couple of boards where the electronics engineer decided to only 
> use the chip select line, so no read/write signal is connected. This 
> means that reading the address activates the chip select and drives the 
> contents of the data bus to the port. 

This part makes sense as you explained the h/w.

> For example is someone reads the 
> file /sys/kernel/debug/gpio this corrupts the port. So I have had to add 
> this property to avoid that situation.

Not quite relevant to the DT binding being a Linux detail.

> 
> If you are strongly against this then just reject it and I will look 
> after it myself. I thought there may be others who would find this 
> change useful.

A property for a board level quirk is appropriate. You just need to 
explain that in the commit message rather than stating what the diff 
already tells us.

Rob
