Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80D1A678938
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 22:07:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232920AbjAWVHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 16:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbjAWVHJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 16:07:09 -0500
Received: from mail-oa1-f50.google.com (mail-oa1-f50.google.com [209.85.160.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A691C38667;
        Mon, 23 Jan 2023 13:07:08 -0800 (PST)
Received: by mail-oa1-f50.google.com with SMTP id 586e51a60fabf-15ff0a1f735so7254605fac.5;
        Mon, 23 Jan 2023 13:07:08 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CADNFe6R10wkswq9pySVFFUriCC1NhXTNYYz3U5dPho=;
        b=OkEUccvimqLaU14wV72sCLRqDqWYa+MSlpfNEcmQxzuIzYL7c+wOCplXeBPgfrnF6m
         L8sch+dxbsOsmlHeeswD2aRQV8Hyt96QXpGPEWwO8ccuvx597G7q6ab8Wr9kQaXd5OR0
         1WjNzbBwWvfpjsQ9/tXNTnfoWxOTbsaX5quNVtsN5p3f7urP4K4r6iWWdN29rn3m6e6+
         9Tk0PeKXgIOdRDuV0lv3/n8ctrc3msrMoTgVb9BjkndVZq+CYUToI9gi091kC9dAh1zP
         82GJ5bysjrmLii9kAMQNUMYHbgUhnSKF5lW7DrPfJgpYOymOBoay4pPI2o/WQoCmXwgr
         97ew==
X-Gm-Message-State: AFqh2koIsLavNhmnYidxMj9TOXY81EYv+KdBHeTKF16fc/WURTSTcTeu
        /ytVNP7SIHIz+NM7pOts+9V6QouwvQ==
X-Google-Smtp-Source: AMrXdXtV9ocXW03GZSJCxa5MfMJy/xxFJnzNCrZoRiE/vvrfehKtCq3M2nfTBomny44RX0TFjadxRA==
X-Received: by 2002:a05:6870:4c83:b0:150:14a3:6556 with SMTP id pi3-20020a0568704c8300b0015014a36556mr13995312oab.51.1674508027223;
        Mon, 23 Jan 2023 13:07:07 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id r38-20020a05687108a600b0015fa95b00d1sm6491872oaq.22.2023.01.23.13.07.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 13:07:06 -0800 (PST)
Received: (nullmailer pid 2534798 invoked by uid 1000);
        Mon, 23 Jan 2023 21:07:06 -0000
Date:   Mon, 23 Jan 2023 15:07:06 -0600
From:   Rob Herring <robh@kernel.org>
To:     Johan Jonker <jbx6244@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Felipe Balbi <balbi@kernel.org>,
        Heiko Stuebner <heiko@sntech.de>,
        linux-rockchip@lists.infradead.org,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        linux-arm-kernel@lists.infradead.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] dt-bindings: usb: rockchip,dwc3: Move RK3399 to
 its own schema
Message-ID: <20230123210706.GA2496689-robh@kernel.org>
References: <20230118193056.673514-1-robh@kernel.org>
 <20230118193056.673514-2-robh@kernel.org>
 <4eca2695-cb73-eaad-4c8a-82dec923825e@gmail.com>
 <CAL_JsqKqiRbBJErkh2Hch+XZyLggGyjYo1rvKWPhxb99pA8mAA@mail.gmail.com>
 <be193659-e97f-23b9-b89c-d02205705db6@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <be193659-e97f-23b9-b89c-d02205705db6@gmail.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 21, 2023 at 12:40:12AM +0100, Johan Jonker wrote:
> 
> 
> On 1/20/23 21:30, Rob Herring wrote:
> > On Wed, Jan 18, 2023 at 3:05 PM Johan Jonker <jbx6244@gmail.com> wrote:
> >>
> >> Hi,
> >>
> >> Some alignment at the examples and the unknown extcon property.
> >>
> >> usb@fe800000: 'extcon' does not match any of the regexes
> > 
> > Does that go in the wrapper or dwc3 node?:
> > 
> > arch/arm64/boot/dts/rockchip/rk3399-puma-haikou.dtb: usb@fe800000:
> > usb@fe800000: Unevaluated properties are not allowed ('extcon' was
> > unexpected)
> >         From schema:
> > /home/rob/proj/linux-dt/Documentation/devicetree/bindings/usb/rockchip,rk3399-dwc3.yaml
> > 
> 
> 
> > That's the dwc3 node, but the majority are in the wrapper node, so I'm
> > going with the majority and leaving this one.
> 
> In wrapper code for rk33899 in dwc3-of-simple.c I don't see no extcon activity I think.

So all the other cases are just a stray property and the above one is 
correct.

'extcon' should be replaced in favor of a connector node, so if not 
used, it should be able to be removed. Though maybe BSD or something 
else cares.

> In core there's recently made some changes:
> https://github.com/torvalds/linux/blame/master/drivers/usb/dwc3/core.c#L1710
> 
> usb: dwc3: Don't switch OTG -> peripheral if extcon is present 
> https://lore.kernel.org/all/20221017233510.53336-1-andriy.shevchenko@linux.intel.com/
> 
> Binding status update for that is unknown for me.
> Do whatever suites you best.

I'm going to leave it as-is for now.

Rob
