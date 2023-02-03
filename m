Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91A276899F3
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Feb 2023 14:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232100AbjBCNmM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Feb 2023 08:42:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232542AbjBCNmJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Feb 2023 08:42:09 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA6807DBF9;
        Fri,  3 Feb 2023 05:42:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7157F61F31;
        Fri,  3 Feb 2023 13:42:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39156C433D2;
        Fri,  3 Feb 2023 13:42:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675431726;
        bh=RnwQVyGFLcxgHt6nfUiqt/UjT70bTIiQ8XkNhyLtBdI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=LQNXdeb8gqQj1nVZXdb6t5NXlNJswHnII/ZLBcQhY5bfBg3rCzpfGaVampjRbGXoT
         K7m+tLNGHe0YcTZDHzKBo0mZqSXuNmSH9mEbXC0Nxx30GP7BkhNDCo4mqcFar6nXvI
         XVHSwmkyNCgh30t0MS+7yM+c9ukaC5MG5d95AfKFTEWM5xalERuSLNGyP1N0REMhMf
         L6bqjGeqT3rhumyOZguejAfl85h37WPyFTx+lKODUZUF+CZdDhPlYbqmS2rpD0oDae
         OuHdFPqhAKG1mqmNJO6bJB0UpbZ8tH+1DGCa1Lq4qpyXhLfekm8kx5UAheMMm32rb9
         iwilUKGp4WCCg==
Date:   Fri, 3 Feb 2023 19:12:03 +0530
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
Subject: Re: [PATCH 5/8] phy: samsung,mipi-video-phy: deprecate syscon phandle
Message-ID: <Y90PK8TKilJRItU1@matsya>
References: <20230127194057.186458-1-krzysztof.kozlowski@linaro.org>
 <20230127194057.186458-6-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230127194057.186458-6-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27-01-23, 20:40, Krzysztof Kozlowski wrote:
> The MIPI phy is actually part of the Power Management Unit system
> controller, thus it should be its child, instead of sibling node with
> syscon phandle.

Acked-By: Vinod Koul <vkoul@kernel.org>

-- 
~Vinod
