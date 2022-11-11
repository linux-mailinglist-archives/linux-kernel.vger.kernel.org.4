Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 306026256DB
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:29:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233661AbiKKJ3u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:29:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233816AbiKKJ3b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:29:31 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF08F787B8;
        Fri, 11 Nov 2022 01:29:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BF3061F16;
        Fri, 11 Nov 2022 09:29:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5669C433D6;
        Fri, 11 Nov 2022 09:29:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668158951;
        bh=tbFXzrgZcLvWGkQWi50aw7qsYZUHqfE43WL2OltpPEA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BeXZ2pEbNkbabI9elHe03WsBQ5bPZ7Kq8H7vpvJlxlQaeh7pBzTQ3Ynfvwi41yzHO
         fg3L4UgapLb2qC70zIoncrmtuR0ttBl0u72N5LyB4geEUSavJRs/NyWFrvI2hcpSi2
         9/1Ve08mSKHL4xEC3RZL/nCtDIlgnEVOjozMJMyb/mE+DygQQcDJU7X2JinaDosThE
         xHQgpAM1qOaA2mjOrHmeJUuHcYJmqyKgSH745vBFJnOWBEX1odF2uDfyYpKqcDMovy
         s7CjWwkrTKhehJ2NbKwjzsY4JKXtoe6sMIpoZd9NUn4LYjaim8XTYEW5D26XGqJqQ0
         c5WactmUeLOuA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1otQL4-0002qC-SI; Fri, 11 Nov 2022 10:28:42 +0100
Date:   Fri, 11 Nov 2022 10:28:42 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Johan Hovold <johan+linaro@kernel.org>
Cc:     Vinod Koul <vkoul@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/14] phy: qcom-qmp-combo: restructure PHY creation
Message-ID: <Y24Vyn8o1VkUecKY@hovoldconsulting.com>
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-5-johan+linaro@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111092457.10546-5-johan+linaro@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 11, 2022 at 10:24:47AM +0100, Johan Hovold wrote:
> In preparation for supporting devicetree bindings which do not use child
> nodes, move the PHY creation to probe() proper and parse the serdes,
> dp_com and dp_serdes resources in a dedicated legacy devicetree helper.
> 
> Signed-off-by: Johan Hovold <johan@kernel.org>

Please drop this first stray SoB line when applying (or I'll remove it
for v2).

> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>

Johan
