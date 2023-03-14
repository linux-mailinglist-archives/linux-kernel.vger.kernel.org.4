Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 952F26B929C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:05:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229436AbjCNMFm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbjCNMFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:05:34 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D95D71C58D;
        Tue, 14 Mar 2023 05:05:02 -0700 (PDT)
Received: from meesny.iki.fi (meesny.iki.fi [IPv6:2001:67c:2b0:1c1::201])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by lahtoruutu.iki.fi (Postfix) with ESMTPS id 4PbXHw1rpRz4BKJt;
        Tue, 14 Mar 2023 14:04:11 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678795452;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZdVO+o6NVisvLLp0fz85lQ/En55DCtDZZ8CJdoWRLw=;
        b=Zc1R1I3rg1hRsMfrhRw1YtTL0+SD+swa8meOGKm7k1dEwbQSj16Ii5opPRmeu904Hqk8Wl
        LHE5P8FZGrVpfCCOf8vh/65UHb1tQzt2L/gy8TBTwYlP5O+G/gvc5DtEhr1YotI5gQfdQs
        HxmUh1SM/P4O6TkOBGK9Wt5IGrDE7+88Sq8sxmipCtZWAgNALAD3UpUTWEbjDxpUpFIdZk
        LfTg7MulJNWvhIkOsjVaBmZyqrYALnN8Qy1tToIgzwbwvTspeAR6hOjXTDGz2AyKiqizNH
        DaXigB1cDHSFeWBI1qap+baUm9Z6arBmJ4mcAEv68pgrRqZ+v6MqUjsA6XnN6g==
Received: from hillosipuli.retiisi.eu (dkzbhx1tyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4502:69d6::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PbXFG658tzyQx;
        Tue, 14 Mar 2023 14:01:54 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1678795317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZdVO+o6NVisvLLp0fz85lQ/En55DCtDZZ8CJdoWRLw=;
        b=g4p6lmMNIEZi5Hxya3lo2eH88giekGBrGSaNMkJJA1vCIRxaWYSrvMP1xmiMOlptEyoQUs
        3bCxMoWjbG6wbZmBPCELDT27lHPIUx1OH6sIWi6Pa8cLqNSF9oR/lH3VP+U0h0ta577kRs
        iWilPkVEVHG8/AmclaxCkJTWVCM0/Ik=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1678795317; a=rsa-sha256; cv=none;
        b=BvgKPCSD9q6pUJSAxUy+VizHYYIbjg9ezjQHh5QXGQbEZT+GCzXbVU1eLEO4U391sDQS4u
        +HPMyX5cMepisp8vRwjTRTpBuj/bxnPgc8ugDSKe5otTQLiIwOBTjlVt0BbwX3YLPs555f
        Ud59qiYSrCYs3qTAkg6uXrJLnMsW1z8=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1678795317;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qZdVO+o6NVisvLLp0fz85lQ/En55DCtDZZ8CJdoWRLw=;
        b=OkKVUPXuzmIvASe6puyQy2dN6TuBvyb+QKZfD0GrMbuycT0e4eQY84BRKIVAr1eXt3p/oW
        sDfHnF0SOKX0niSvK1QzzepUQvH7HRfkRj4s8yJz10vSBg+ZpFQlzXt5rApHPruLKpbyez
        SKaN1DNDcC5J3QvHiy/Ig3JeNK3EtcM=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id CFAAB634C91;
        Tue, 14 Mar 2023 14:00:52 +0200 (EET)
Date:   Tue, 14 Mar 2023 14:00:52 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        ~postmarketos/upstreaming@lists.sr.ht,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-media@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        phone-devel@vger.kernel.org,
        Helen Koike <helen.koike@collabora.com>
Subject: Re: [PATCH] media: dt-bindings: ov2685: convert to dtschema
Message-ID: <ZBBh9Euor7R24euV@valkosipuli.retiisi.eu>
References: <20230206-ov2685-dtschema-v1-1-9e4da3474c10@z3ntu.xyz>
 <167572017056.1564123.13342855865502188090.robh@kernel.org>
 <2665862.mvXUDI8C0e@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2665862.mvXUDI8C0e@z3ntu.xyz>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Thu, Feb 09, 2023 at 05:46:48PM +0100, Luca Weiss wrote:
> +CC Helen Koike
> 
> On Montag, 6. Februar 2023 22:50:08 CET Rob Herring wrote:
> > On Mon, 06 Feb 2023 21:23:16 +0100, Luca Weiss wrote:
> > > Convert the text-based dt-bindings to yaml.
> > > 
> > > Changes from original txt:
> > > * Take wording for various properties from other yaml bindings, this
> > > 
> > >   removes e.g. volt amount from schema since it isn't really relevant
> > >   and the datasheet is a better source.
> > > 
> > > * Don't make reset-gpios a required property since it can be tied to
> > > 
> > >   DOVDD instead.
> > > 
> > > Signed-off-by: Luca Weiss <luca@z3ntu.xyz>
> > > ---
> > > 
> > >  .../devicetree/bindings/media/i2c/ov2685.txt       |  41 ---------
> > >  .../devicetree/bindings/media/i2c/ovti,ov2685.yaml | 101
> > >  +++++++++++++++++++++ MAINTAINERS                                       
> > >  |   1 +
> > >  3 files changed, 102 insertions(+), 41 deletions(-)
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > dtschema/dtc warnings/errors:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/medi
> > a/rockchip-isp1.example.dtb: camera@3c: 'clocks' is a required property From
> > schema:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> > ia/i2c/ovti,ov2685.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> > ia/rockchip-isp1.example.dtb: camera@3c: 'clock-names' is a required
> > property From schema:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> > ia/i2c/ovti,ov2685.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> > ia/rockchip-isp1.example.dtb: camera@3c: 'dvdd-supply' is a required
> > property From schema:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> > ia/i2c/ovti,ov2685.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> > ia/rockchip-isp1.example.dtb: camera@3c: 'avdd-supply' is a required
> > property From schema:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> > ia/i2c/ovti,ov2685.yaml
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> > ia/rockchip-isp1.example.dtb: camera@3c: 'dovdd-supply' is a required
> > property From schema:
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/med
> > ia/i2c/ovti,ov2685.yaml
> 
> Looks like rockchip-isp1.yaml uses very incomplete sensor examples in their 
> binding example, which sort of makes sense since those bindings are showing 
> the rockchip isp bindings and contain the bare minimum to show how a sensor is 
> connected in dt.
> 
> Not sure how to solve this - ov2685 is also one of three sensors that are used 
> very abbreviated there.

Could these regulators be simply made optional?

-- 
Kind regards,

Sakari Ailus
