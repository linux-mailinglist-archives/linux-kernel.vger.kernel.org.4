Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5D166899EA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:38:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232372AbjBCNiu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:38:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231478AbjBCNis (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:38:48 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA0AD53F;
        Fri,  3 Feb 2023 05:38:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 7146DCE3011;
        Fri,  3 Feb 2023 13:38:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2CED9C433D2;
        Fri,  3 Feb 2023 13:38:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675431521;
        bh=BqaOPD7dtW+RNHVp4mgKLBVQpvvG60YANreOlI0gJxg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=evKiwZSWWHq/qBOOG0ag4W1iOjACpWe36QHwp8aizUTnsxnR1+MetWq3qDf6/cAmF
         BIlDSLxJj27+Xx/j14ggrXENJ10kGmiFxOiYPZOEWv73XL7lckK4lttRXbx6yLmWBU
         hwSHfI6XPrp/SXz7v5LixhNp5bNv7jA3KZVKzxz5UjWAyCbulnutb5+7AncRuo8dnm
         PBIpi+tYEVPJeO++fjxN5t7q6H6nQhJmgFB1qRwjl+fi6owKGM8p0DMDiZecebCt7W
         0J562Lda99U9aC85GuwtRUbyKcvR6CLzA9kyItTEbbF0L8UUDrcEINWEpzBrsOc6lN
         odKbmnsDv6uRw==
Date:   Fri, 3 Feb 2023 19:08:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, replicant@osuosl.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Martin =?iso-8859-1?Q?J=FCcker?= <martin.juecker@gmail.com>,
        Henrik Grimler <henrik@grimler.se>,
        Chanwoo Choi <cw00.choi@samsung.com>
Subject: Re: [PATCH 2/8] dt-bindings: phy: samsung,dp-video-phy: deprecate
 syscon phandle
Message-ID: <Y90OXce5NRgt8HWn@matsya>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
 <20230127194057.186458-3-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127194057.186458-3-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-23, 20:40, Krzysztof Kozlowski wrote:
> The DisplayPort phy is actually part of the Power Management Unit system
> controller, thus it should be its child, instead of sibling node with
> syscon phandle.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
