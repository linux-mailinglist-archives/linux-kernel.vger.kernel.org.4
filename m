Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BD31646B70
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 10:07:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230232AbiLHJHU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 04:07:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230330AbiLHJHD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 04:07:03 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC6CB2F66E;
        Thu,  8 Dec 2022 01:05:35 -0800 (PST)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 25D7F1C000B;
        Thu,  8 Dec 2022 09:05:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670490334;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=AJxDLt8hUXawCrNccreH5yy8sxv6TlhzobWAynLdewY=;
        b=TOXe+X3BQntT96xi2Ug7VH3tEmj51ZQztuaqU5bz2r4tdYhil9On1DRHvt+7BE7x1TQwFA
        MmR15kYRhimQE+pIvybnaA0uX9lDNXth17AFiLfNhUNdx9rDb3HcPORaNnse8kIQys5bVL
        F9LqFrRDh3uNoEjOx/fZoiCQXF+hFEUNXifopRt2YnoSFAjQV19ueUyP9oWbJS7/xHMTYn
        C4Y8rpDQdSg2oQPwkvz9hHeWcUJm7SVNkHYHFlQHxb9gB3VH01Ww+aXcTssY512rXYhH2K
        SPTkUC15Nf15yoBeH64AbCgppjkyqRgwseYs2ukZtRGv+dFijeZsgs8g+iyCbQ==
Date:   Thu, 8 Dec 2022 10:05:30 +0100
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Gareth Williams <gareth.williams.jx@renesas.com>,
        linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>
Subject: Re: [PATCH v3 3/9] dt-bindings: PCI: renesas,pci-rcar-gen2:
 'depends-on' is no more optional
Message-ID: <20221208100530.137fa8b7@bootlin.com>
In-Reply-To: <36895e49-aea5-3676-e7df-78b30277e6a0@linaro.org>
References: <20221207162435.1001782-1-herve.codina@bootlin.com>
        <20221207162435.1001782-4-herve.codina@bootlin.com>
        <36895e49-aea5-3676-e7df-78b30277e6a0@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, 8 Dec 2022 09:26:41 +0100
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 07/12/2022 17:24, Herve Codina wrote:
> > The 'depends-on' property is set in involved DTS.
> > 
> > Move it to a required property.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  Documentation/devicetree/bindings/pci/renesas,pci-rcar-gen2.yaml | 1 +  
> 
> This should be squashed with previous patch. There is no point to add
> property and immediately in the next patch make it required. Remember
> that bindings are separate from DTS.
> 
> Best regards,
> Krzysztof
> 

I though about make dtbs_check in case of git bisect.

But, ok I will squash or perhaps remove completely this commit.
It introduces a DT compatibility break adding a new mandatory
property (raised by Rob on cover letter review).
Is this compatibility break can be acceptable ?

Best regards,
Herve
