Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4A326D1CCA
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:43:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjCaJn0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:43:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232054AbjCaJnP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:43:15 -0400
Received: from meesny.iki.fi (meesny.iki.fi [195.140.195.201])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC6F51F783;
        Fri, 31 Mar 2023 02:42:49 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (dkzcv-3yyyyyyyyyyyyyt-3.rev.dnainternet.fi [IPv6:2001:14ba:4505:1fdc::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by meesny.iki.fi (Postfix) with ESMTPSA id 4PnwLD2CtzzyRB;
        Fri, 31 Mar 2023 12:42:12 +0300 (EEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=meesny;
        t=1680255734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puXl1O5LTLm6mQC1hY7tBUYCwI/kPsGafEK/CuEAVhM=;
        b=J8sJddVL9ds5RZrJJVE6QICLnEV+Q9LHZ3tVXQLhln9EOv4JZIIC3LBuXaj1ZsSrkZa9w1
        og3HojgJki8ayz+ESSOdoY8S6QuOWuFEsaIiOLBNRQjxQnx3O7ZlOg6uhTaSkMava9NMhL
        U3tRe1L9TtmAIV8EHwlxC9E5XE1pcsk=
ARC-Seal: i=1; s=meesny; d=iki.fi; t=1680255734; a=rsa-sha256; cv=none;
        b=tAa0IExFH7cbCQ2EDGsYFAeoVVC77NOWpDz8LScrE6s6R0r7Y3vaxujy9NXEdFmoA0Yxg4
        bFb0iQFY0ajiHBi9ZZJYyXEOQTEddl9VlwRuMN4fS8NLzD9khLqmPy9rFHhHoC+a0WwvTV
        eOe8iUQii5P/kjSunKAurL6TyVoyOo8=
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=meesny; t=1680255734;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=puXl1O5LTLm6mQC1hY7tBUYCwI/kPsGafEK/CuEAVhM=;
        b=d6sCkbwuvAkqzIyKF1nM1fVHhznKjvI5Jza4Ahb0FDDIdZrz/VMR5XqnNLd6/kPnSn+x8L
        cEw5mhMGG3Vc17amBKOhb483aKjp6NW6K5CUWFo+TVwpby55wuV70/2wcBKiji7DchldNY
        s5xt9+D4z5TiVc32lFsLpFzLNJe9usg=
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 03A26634C99;
        Fri, 31 Mar 2023 12:39:56 +0300 (EEST)
Date:   Fri, 31 Mar 2023 12:39:56 +0300
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Luca Weiss <luca@z3ntu.xyz>
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shunqian Zheng <zhengsq@rock-chips.com>,
        Jacopo Mondi <jacopo.mondi@ideasonboard.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v4 2/3] media: dt-bindings: ov2685: convert to dtschema
Message-ID: <ZCaqbL4plknXYPCT@valkosipuli.retiisi.eu>
References: <20230129-ov2685-improvements-v4-0-e71985c5c848@z3ntu.xyz>
 <20230129-ov2685-improvements-v4-2-e71985c5c848@z3ntu.xyz>
 <ZCacNEbg8cJo0VAm@valkosipuli.retiisi.eu>
 <9AF47749-12CB-40D5-A300-170A35390CFD@z3ntu.xyz>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9AF47749-12CB-40D5-A300-170A35390CFD@z3ntu.xyz>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Luca,

On Fri, Mar 31, 2023 at 11:18:29AM +0200, Luca Weiss wrote:
> >> +        properties:
> >> +          data-lanes:
> >> +            maxItems: 1
> >
> >This should be 2 --- the sensor supports two lanes (even if the driver
> >doesn't).
> 
> Right, for some reason the product brief mentions that it features "a
> single-lane MIPI interface" but the datasheet I have writes that it has a
> 2-lane MIPI serial output, so I guess it does support two lanes?

I suppose the datasheet is right. Well, if someone proves otherwise, we can
always change this.

> 
> >
> >I can address this when applying if that's ok.
> 
> That would be nice, thanks!

Done, thanks!

-- 
Kind regards,

Sakari Ailus
