Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2F6B6B7A1E
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 15:16:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230250AbjCMOQZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 10:16:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230146AbjCMOQX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 10:16:23 -0400
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [185.185.170.37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B1B310DE;
        Mon, 13 Mar 2023 07:16:20 -0700 (PDT)
Received: from hillosipuli.retiisi.eu (82-181-192-243.bb.dnainternet.fi [82.181.192.243])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sailus)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 4PZzGn6Kmhz4BKJH;
        Mon, 13 Mar 2023 16:16:17 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1678716978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KG7ikvzasViGTb/pL3/hJJMbpS3y8IKQUZv3vIs9R2c=;
        b=rQ01nmXN3xE8+T5powJ5sFzYKEGTRhcZL+O1TDElWMcCtbU+Aed2hyIoWu9I3EgbJ22i7G
        WOZlHPTvgykG7CjMUAtMeqYHXc3u284jCd5Tbn1jqZrlSmtFrnWNqS3VhpIQgBYYXTQjqC
        rr8E0xyaSxO1QJiBabjtMJ80vBd862656SuNko25ukaS/vHZL2/C4HEc25pzGSoS/SZS0E
        8oa33AY26jI2f96Sp1JPu5J23XZn8flU+wK2ie2Oc/sDkagiF+X30ywGs2OqopP0YAKMuQ
        ntj1hWq7fBIdKivlmHqMKTx3eROTXjRKpDyvN2DDcbw8E6+yQxlTgRAu70rlew==
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1678716978; a=rsa-sha256;
        cv=none;
        b=V9l5Dqjo0nk0Ld5hgBG8diKCaapqhPphBY3KMj9BlMrAjsFMVPUbH3f5fx1qpvPFvGhQIv
        1wkvx2GLAPIZX+S+WLg5o0aGnil5IrB+e7v8ZEV26u3kFbnmFUMdBGR+1M2sgKpUyphISK
        KrC91aCfdk4RC41jL0CrS9bMHZFpzk+blHt8LB+nYVM7utE3oYbxFqmJU/CMhCZq3Zj0zi
        WVQA3HbDSnIsoM7VKiPXxo3BDCN3szxfNeZ1Z7THLxSdU0Pk0EgRdRmxuWkGw0yRvGRNTs
        aLpXBieqCcuVYtY4G1nlHeO+m+MkxOVS52NlDtb/2BQoRWDB6uve80/k9WLlqw==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=sailus smtp.mailfrom=sakari.ailus@iki.fi
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1678716978;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KG7ikvzasViGTb/pL3/hJJMbpS3y8IKQUZv3vIs9R2c=;
        b=vvYYHV2aZ+ZUbUKNKSMDFR0Ikyj2VMrZPTfw2B7E4kqlv6NGoTZ4TicMyV5Hl1pjoopYnq
        DYvt9mpGZTa8mGGp5gXIRArXuet8dMygPZuTNQENsJPtewhVpIIDi85aKyvwmJm51wkAcV
        88IZHrMRbqMug0zL/Pdm4bsFtbl2jTTXt0YW9Rww9bZrB0q9DIPcxX0NwQgiDWbiIi6Cam
        OcEUlL2y9a60YYEtSITAykOK1zDq5d55wiJRxNi5NVBvYJgDp8YYq89eRNvdzNPtB3mpWe
        TCFVD12Pc/pGIEiXNKBAugZ745MEK/vxI9ONFQIUzMkqLFaE4K7165Cj6vcUKA==
Received: from valkosipuli.retiisi.eu (valkosipuli.localdomain [192.168.4.2])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by hillosipuli.retiisi.eu (Postfix) with ESMTPS id 0614E634C91;
        Mon, 13 Mar 2023 16:15:19 +0200 (EET)
Date:   Mon, 13 Mar 2023 16:15:19 +0200
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
Message-ID: <ZA8v98mqm4Xdt2Sl@valkosipuli.retiisi.eu>
References: <20230216142204.48394-1-krzysztof.kozlowski@linaro.org>
 <20230216142204.48394-7-krzysztof.kozlowski@linaro.org>
 <ZA8YJx+NE0+89YaD@valkosipuli.retiisi.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZA8YJx+NE0+89YaD@valkosipuli.retiisi.eu>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 13, 2023 at 02:33:43PM +0200, Sakari Ailus wrote:
> Hi Krzysztof,
> 
> On Thu, Feb 16, 2023 at 03:22:03PM +0100, Krzysztof Kozlowski wrote:
> > Convert the Samsung S5P/Exynos Camera Subsystem (FIMC) bindings to DT
> > schema.  Changes during conversion - adjust to existing DTS and Linux
> > driver: add iommus and power-domains.
> > 
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Reviewed-by: Rob Herring <robh@kernel.org>
> 
> This does not apply on top of -rc1.
> 
> ...
> 
> > -- compatible: must be "samsung,fimc"
> 
> I guess you have another patch removing "simple-bus" here and another
> location in your tree?

Ah, what's missing seems to be this set:

<URL:https://patchwork.linuxtv.org/project/linux-media/list/?series=9839>

But also the second patch of that set doesn't seem to apply. :-(

-- 
Sakari Ailus
