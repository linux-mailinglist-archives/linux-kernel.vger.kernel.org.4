Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8246465BDAC
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 11:08:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236815AbjACKIL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 05:08:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233233AbjACKIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 05:08:07 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B39A134;
        Tue,  3 Jan 2023 02:08:05 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 78B4D1516;
        Tue,  3 Jan 2023 02:08:46 -0800 (PST)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D97393F663;
        Tue,  3 Jan 2023 02:08:03 -0800 (PST)
Date:   Tue, 3 Jan 2023 10:08:01 +0000
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        sudeep.holla@arm.com, Rob Herring <robh+dt@kernel.org>,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 4/5] dt-bindings: firmware: arm,scmi: Add support for
 syspower protocol
Message-ID: <Y7P+gYRZDn9TggkK@e120937-lin>
References: <20221222183823.518856-1-cristian.marussi@arm.com>
 <20221222183823.518856-5-cristian.marussi@arm.com>
 <3d89e135-c8e4-ede4-950f-03900a660822@kernel.org>
 <Y6WE1zQAxYYn6Ahz@e120937-lin>
 <23436455-098f-6e21-2330-d91158a591ad@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <23436455-098f-6e21-2330-d91158a591ad@kernel.org>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 12:22:34PM +0100, Krzysztof Kozlowski wrote:
> On 23/12/2022 11:37, Cristian Marussi wrote:
> 
> >>>  
> >>> +  protocol@12:
> >>> +    type: object
> >>> +    properties:
> >>> +      reg:
> >>> +        const: 0x12
> >>> +
> >>
> >> Why? It did not got lost, it's already covered by pattern. If you refer
> >> to particular warning, please paste it in commit msg. Otherwise it looks
> >> incorrect.
> >>
> > 
> > Yes indeed, but as a matter of fact it seemed to me that we used to add an
> > entry and an example for all the currently published standard SCMI protocols,
> > even though already covered by the patternProp (which covers also any
> > custom-vendor protocol in the wild) and not sporting any additional
> > custom properties (see protocol@18), but maybe this is just a unneeded wrong
> > habit adding only cruft to the bindings.
> > 
> > If you think it does not add any value I can happily drop this, or
> > limiting the addition just to the example (and/or drop equally the unneeded
> > protocol@18 node too in this case).
> 
> Duplicating the node (once in properties, second in patternProperties)
> is not needed. I am also not sure what would be the point to add to the
> example - example does not have to be complete DTS for all cases, but
> illustrate the binding and allow is to test it.
> 

Thanks, I'll drop this patch.

Cristian

