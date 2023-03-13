Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C10226B779D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 13:35:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229906AbjCMMfI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 08:35:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229909AbjCMMe5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 08:34:57 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A341574D1;
        Mon, 13 Mar 2023 05:34:47 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PZx1Z3f5Vz4BKJT;
        Mon, 13 Mar 2023 14:34:42 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678710883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJ9bcmqVqz/Sh/xRji2EFdVxMLOfeVSW3VOI8SvASAk=;
        b=dStFuEC8lhvJTLDXuMBClU4jnw+s42ZM//I+UBNEztPjcWjfpgXt8jYMkIMDHom8yEw5Bb
        JP4R+9cKtKKp8Ji4sTcZyYzUw95qbVuE4SNvJzUhwD9JovyGsy+Gfh/e59o4c8pH2msprv
        ssBR9kcDPAj5O5n9DdwV9aBPFh+n3IShkeTw+gm7Is1vfnC36wzFLj8nzgk8LRNgZIU8uE
        w8o9R6Bbh79G84R5eI74ZjDpevdZ9dJ9CMPWdq+6zAuGYJPXfmjpRcoqd+LlkyswSbgns7
        WFzTSmLnT443eLf8Qnki+1a2p/yH6ndP+G8XLYWsjaIA7mB84OobZMrFZzWyDg==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678710883; a=rsa-sha256;
        cv=none;
        b=B7ZCq4ozsuWb7x/uBQsmLjwA1/nEijpQg9oP3Br1RlQgx7jBNTf6bNyQGvHbnp9lTnKSGv
        ncOM9MQ07o/m2q2hqzPek82K+4MvTdf+VlLebC89k3fj2m+sRJicXWA2qqwPEswKnEc3gI
        /AdeZp94xjquMP7pLcg/wqBPN+pyT9FCmg0OrFjDkgszQDcs1sKpJ2z2z5ekKVz1t5Gnig
        iy7sjRuO5zDNaOIlmo2ydYq1hx8F3beMySTns31fyYJQLUFCJHINrihf9tOrhYwHG5bASN
        ecA4cEkSfmJqWLiDTGDm6sbTEZSuNEbxFqgVKkwd0RqY0mtFAn9vxS/eybqpnw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678710883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GJ9bcmqVqz/Sh/xRji2EFdVxMLOfeVSW3VOI8SvASAk=;
        b=ac5Imymz4ViCpMVcjFpO89zdj80Lz3kShNl3Q/60vmZ2M8MTFFExWxYGd6vdLNKCp4OBAz
        uqczkvPbWgAJyLLVStTP0l2d0AUcz4Vgl8Yhl3JkyNtaIr2obLieQya/7+/k/dLv8LgEE9
        RMA+Pean0Sj8mxwOLNO0MEIXAbyiGapIU0vKWBSi6JSJW2fZZrBxeHSJE1lWKwEIGtec3w
        itku33tDUVnCwnYQNx55Oj3aFv+yn8yWFhflZrxekVsRptJ8RHeXl9LV8aH2mklXRs0ouS
        wn3tLMOmTJiNql94/X+n/OcuQUsIWuaDWDacE2Co+Sh0goWmyrtnPJ+Z/dmowg==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 0C3F9634C91;
        Mon, 13 Mar 2023 14:33:43 +0200 (EET)
Date:   Mon, 13 Mar 2023 14:33:43 +0200
From:   Sakari Ailus <sakari.ailus@iki.fi>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH v3 6/7] media: dt-bindings: samsung,fimc: convert to
 dtschema
Message-ID: <ZA8YJx+NE0+89YaD@valkosipuli.retiisi.eu>
References: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
 <20230216142204.48394-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216142204.48394-7-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof,

On Thu, Feb 16, 2023 at 03:22:03PM +0100, Krzysztof Kozlowski wrote:
> Convert the Samsung S5P/Exynos Camera Subsystem (FIMC) bindings to DT
> schema.  Changes during conversion - adjust to existing DTS and Linux
> driver: add iommus and power-domains.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Rob Herring <robh@kernel.org>

This does not apply on top of -rc1.

...

> -- compatible: must be "samsung,fimc"

I guess you have another patch removing "simple-bus" here and another
location in your tree?

-- 
Kind regards,

Sakari Ailus
