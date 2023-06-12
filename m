Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32FCD72C6A1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 15:56:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237155AbjFLN4X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 09:56:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237153AbjFLNzp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 09:55:45 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C0DC1AC;
        Mon, 12 Jun 2023 06:55:12 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686578100;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=RqB14FqjZetw3vUT7sSjjLHunlcdUXO1np1Fyg+X7pY=;
        b=aPktwyVQYyqBYqxjJDP6Lt427ACZzOhSEo81X1DCVDwA1asKqr+Lt4vQ8DYzlnHHCA034M
        p3Ewv2AKgkGNalAMuF914LX0sShTij8IfQvYiiFhxSz01KxftJcbLP3pZxHW9N6UgtSg1M
        MdDBOgH9PGKBORbucxCQgaEj6vE7prwme03tUi3FhVJnpbMJOSjwvntgNcvO5I1It7bU6o
        WKqyOwZvkgRE8mETaTQxNzOgP3s9s3GTJb2Q198l9xMWnXb6DQ4ngN2Kb7mKa6musKDz5C
        CWFhlUyVtqxraqXh8veuv+CaA0Qj0zQK5i6g4N5SLd7gUd3Zfy7M7xyBz6JV1Q==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id ABC62C000E;
        Mon, 12 Jun 2023 13:54:59 +0000 (UTC)
Date:   Mon, 12 Jun 2023 15:54:59 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Rob Herring <robh@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        linux-rtc@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        devicetree@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-kernel@vger.kernel.org,
        Alessandro Zummo <a.zummo@towertech.it>
Subject: Re: [PATCH 2/8] dt-bindings: rtc: Move isil,isl12022 from
 trivial-rtc.yaml into own schema file
Message-ID: <20230612135459689ba11d@mail.local>
References: <20230612113059.247275-1-linux@rasmusvillemoes.dk>
 <20230612113059.247275-3-linux@rasmusvillemoes.dk>
 <168657279982.4044345.9896354759743085279.robh@kernel.org>
 <2a2fa3c5-739c-6bcf-3c41-3db1aac5ccca@rasmusvillemoes.dk>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2a2fa3c5-739c-6bcf-3c41-3db1aac5ccca@rasmusvillemoes.dk>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/06/2023 14:36:03+0200, Rasmus Villemoes wrote:
> On 12/06/2023 14.26, Rob Herring wrote:
> > 
> > On Mon, 12 Jun 2023 13:30:52 +0200, Rasmus Villemoes wrote:
> >> Move the isil,isl12022 RTC bindings from trivial-rtc.yaml into its own
> >> intersil,isl12022.yaml file, in preparation for adding more bindings.
> >>
> >> Signed-off-by: Rasmus Villemoes <linux@rasmusvillemoes.dk>
> >> ---
> >>  .../bindings/rtc/intersil,isl12022.yaml       | 42 +++++++++++++++++++
> >>  .../devicetree/bindings/rtc/trivial-rtc.yaml  |  2 -
> >>  2 files changed, 42 insertions(+), 2 deletions(-)
> >>  create mode 100644 Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml
> >>
> > 
> > My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> > on your patch (DT_CHECKER_FLAGS is new in v5.13):
> > 
> > yamllint warnings/errors:
> > 
> > /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/rtc/intersil,isl12022.yaml: 'maintainers' is a required property
> > 	hint: Metaschema for devicetree binding documentation
> > 	from schema $id: http://devicetree.org/meta-schemas/base.yaml#
> 
> Hm ok. Can/should I copy the value from the trivial-rtc.yaml? Alexandre,
> would that be ok with you?
> 

Yes

> Is there some simple way to do that dt_binding_check for a single file
> or just a few? It seems to take forever to run on the whole tree.
> 

The kernel documentation has this example:

make dt_binding_check DT_SCHEMA_FILES=trivial-devices.yaml


-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
