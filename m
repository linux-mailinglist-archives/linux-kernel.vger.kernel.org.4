Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66C6F613C00
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 18:14:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231517AbiJaROe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 13:14:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJaROb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 13:14:31 -0400
Received: from mail-oi1-f175.google.com (mail-oi1-f175.google.com [209.85.167.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 75BE611C13;
        Mon, 31 Oct 2022 10:14:30 -0700 (PDT)
Received: by mail-oi1-f175.google.com with SMTP id l5so13425188oif.7;
        Mon, 31 Oct 2022 10:14:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=JEJuSP4SzGGx3G9nJXKm0WGzK76Ngq+oDrE3OWYXzEM=;
        b=pHeMebVJlWRKo7jNfNfehrIRrcjYB+zczaAbeQf5p3PLKEHyyY5thmlV/4fGefU8X8
         q8Qpug7Lg+BNs6Kp9TguxG0ph5aldqCd+rS5Jy9f2NaLyBWafw0LPf5FoYRLf+fVskc3
         JpVyQuM461sE/oyaZPJXqCUsd8XtvxXix5u9icC8QMo7x/Y03bDOa3DzTOOam/sMUNRp
         WwEyT1ZInbcWD68xP0ZJYbYRFHdtmvMtE9oHm8oGxnIrwKnDJ/TJFYdkJhnptBw6wEVr
         ZcDxT1W1YWXcYgV8OFLqjb0Q3Gqsn6fSmBwNIHWG3J9M7Fv6B8uk0X4aRq1vKq/mOlF+
         OC6A==
X-Gm-Message-State: ACrzQf1GbzMXylpVigUacBTPkIzdLn49z0eLOak/tj0ez56WUefv9/DI
        wdI9QVagf3c5MvP3a1PqGQ==
X-Google-Smtp-Source: AMsMyM7ep6NKKjc8r3IZjKHxrsJnZy2UavnVoBQ2WQ1ZlCOLPhSHyeS4s6pfRkVzE8kZ+eIfvdBGQA==
X-Received: by 2002:a54:4485:0:b0:359:ad61:ba26 with SMTP id v5-20020a544485000000b00359ad61ba26mr14743705oiv.224.1667236469536;
        Mon, 31 Oct 2022 10:14:29 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id bx25-20020a056830601900b0066c312b044dsm2988953otb.27.2022.10.31.10.14.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 31 Oct 2022 10:14:28 -0700 (PDT)
Received: (nullmailer pid 3021775 invoked by uid 1000);
        Mon, 31 Oct 2022 17:14:30 -0000
Date:   Mon, 31 Oct 2022 12:14:30 -0500
From:   Rob Herring <robh@kernel.org>
To:     Andrew Davis <afd@ti.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Daniel Tang <dt.tangr@gmail.com>,
        Fabian Vogt <fabian@ritter-vogt.de>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/9] ARM: dts: nspire: Use syscon-reboot to handle
 restart
Message-ID: <20221031171430.GA2981736-robh@kernel.org>
References: <20221027181337.8651-1-afd@ti.com>
 <20221027181337.8651-3-afd@ti.com>
 <050f3d65-5720-9c97-1930-bc458c4c2fb8@linaro.org>
 <a4688f2d-0a0f-dffc-92cc-4fa50938d0d8@ti.com>
 <4236ab07-6ad3-efcd-7d5e-c244581d2944@linaro.org>
 <0025ec36-0632-b79e-beba-cf838018a704@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0025ec36-0632-b79e-beba-cf838018a704@ti.com>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 31, 2022 at 09:30:45AM -0500, Andrew Davis wrote:
> On 10/27/22 4:27 PM, Krzysztof Kozlowski wrote:
> > On 27/10/2022 17:07, Andrew Davis wrote:
> > > On 10/27/22 2:33 PM, Krzysztof Kozlowski wrote:
> > > > On 27/10/2022 14:13, Andrew Davis wrote:
> > > > > Writing this bit can be handled by the syscon-reboot driver.
> > > > > Add this node to DT.
> > > > > 
> > > > > Signed-off-by: Andrew Davis <afd@ti.com>
> > > > > Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> > > > > Tested-by: Fabian Vogt <fabian@ritter-vogt.de>
> > > > > Reviewed-by: Fabian Vogt <fabian@ritter-vogt.de>
> > > > > ---
> > > > >    arch/arm/boot/dts/nspire.dtsi | 7 +++++++
> > > > >    1 file changed, 7 insertions(+)
> > > > > 
> > > > > diff --git a/arch/arm/boot/dts/nspire.dtsi b/arch/arm/boot/dts/nspire.dtsi
> > > > > index bb240e6a3a6f..48fbc9d533c3 100644
> > > > > --- a/arch/arm/boot/dts/nspire.dtsi
> > > > > +++ b/arch/arm/boot/dts/nspire.dtsi
> > > > > @@ -172,7 +172,14 @@ rtc: rtc@90090000 {
> > > > >    			};
> > > > >    			misc: misc@900a0000 {
> > > > > +				compatible = "ti,nspire-misc", "syscon", "simple-mfd";
> > > > 
> > > > You have syscon and simple-mfd, but bindings in patch #1 say only syscon.
> > > > 
> > > 
> > > I'm not following, are you just saying my wording in the patch message just
> > > wasn't complete?
> > 
> > Your binding patch adds nspire compatible to the list of two items, so
> > you have two items in total - nspire followed by syscon.
> > 
> > What you implemented here is different.
> > 
> 
> Is there a list of three items I can add this compatible? If instead you
> mean I should go make a new binding, just say so :)

An MFD should define its own schema file.

The original intent of syscon.yaml was for just single nodes with 
'syscon' (and a specific compatible). Adding in simple-mfd was probably 
a mistake. Certainly we need to rework the schema as you should get a 
warning in this case.

> > > Or are you saying something more about nodes that are both syscon and simple-mfd?
> > > In that case, having both syscon and simple-mfd seems rather common, looks like
> > > you added the rule for it[0].
> > > 
> > > Thinking on this, they almost represent the same thing. simple-mfd says "my child
> > > nodes should be considered devices", why do we need that? Couldn't we simply state
> > > that "syscon" node's children are always devices, I mean what else could they be,
> > > syscon is an MFD after all (and lives in drivers/mfd/).
> > 
> > No, syscon is not an MFD. Syscon means system controller and alone it
> > does not have children.
> > 
> 
> The binding lives in devicetree/bindings/*mfd*/, it is mentioned as one
> in devicetree/bindings/mfd/mfd.txt. If it is not an MFD then the bindings
> are giving out mixed signals here..
> 
> > > 
> > > "syscon" often just says, others can use the registers within this node, so as a
> > > different option, make "syscon" a property of "simple-mfd" nodes. I'm seeing all
> > > these examples of devices that should have been children of the "syscon" device,
> > > but instead use
> > > 
> > > regmap = <&x>;
> > > syscon = <&x>;
> > > 
> > > or similar and put the device node out somewhere random. And in those cases,
> > > wouldn't it have been more correct to use the normal "reg" and "regions" to
> > > define the registers belonging to the child node/device?..
> > 
> > Sorry, I do not follow. How this is even related to your patch?
> > 
> > Your bindings say A, DTS say B. A != B. This needs fixing.
> > 
> 
> I said it was compatible with "syscon", not that it is incompatible
> with "simple-mfd" devices.
> 
> What I've done here gives no dtbs_check warnings and
> "devicetree/bindings/mfd/mfd.txt" explicitly allows what I am doing.
> Unless we do not consider the old bindings valid? 

Only that the example is not because it doesn't have a specific 
compatible.

What needs to be clarified is that MFDs must define all the child nodes 
whether they are 'simple' or not.

> If so, would you
> like me to convert mfd.txt to yaml, just let me know.

No, because I don't think there is anything to define as a schema.


> > Unless you are asking me what your device is in general. This I don't
> > really know, but if you want to use it as regmap provider for system
> > registers and as a parent of syscon-based reboot device, then your
> > device is syscon and simple-mfd. With a specific compatible. Was this
> > your question?
> > 
> 
> Yes, I would like to use it as a regmap provider, my question here is
> a much more general one: why do I need to specify that in device tree?
> That is not a hardware description, my hardware is not "regmap" hardware.
> This "syscon" stuff feels like a bodge to make the Linux drivers and bus
> frameworks interact the way we want.

Bingo! It's a hint for create a regmap. We could just have a compatible 
list in the kernel for compatibles needing a regmap. Maybe that list 
would be too long though. So call it h/w description for this h/w is 
referenced by other places.


> I know at this point this has little to do with this series, but I'd like
> to just think this out for a moment. The latest Devicetree Specification
> talks about "simple-bus" as a special compatible that communicates that
> child nodes with compatible strings need probed also. ("simple-mfd" seems
> to be used the same way but without needing a "ranges" property..)

Yes, both cases are saying there is no dependency or setup of the parent 
needs. If the child nodes depend on the regmap, then it's not a 
'simple-mfd' IMO. Therefore 'syscon' together with 'simple-mfd' is wrong 
unless it's other nodes that need the regmap. The schema can't really 
check that.

> Both of these are properties of a node, not something a device is "compatible"
> with. "compatibles" are also supposed to be listed "from most specific to
> most general", so which is more specific, "simple-mfd" or "syscon", etc..

I would say 'syscon' is more specific if I have to pick. It implies some 
registers exist. 'simple-mfd' should mean there are no parent resources 
(...the children depend on).

We've probably got enough of a mixture of the order, it wouldn't be 
worth the effort to try to enforce the order here.

> Seems like Rob might agree[0], these are not really compatibles. We cant fix
> history, but for new nodes, instead of growing the problem and forcing these to
> be overloaded compatibles, we allow these to become new standard node properties.
> 
> For instance:
> 
> main_conf: syscon@43000000 {
> 	compatible = "ti,j721e-system-controller";
> 	reg = <0x0 0x43000000 0x0 0x20000>;
> 
> 	simple-bus;
> 	syscon;

Umm, no. This ship already sailed and we don't need a 2nd way to do 
things.

Rob
