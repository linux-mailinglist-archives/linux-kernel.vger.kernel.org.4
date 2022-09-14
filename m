Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5C115B7FBE
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 05:51:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229814AbiINDvI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 23:51:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37480 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiINDvG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 23:51:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC0726BD62;
        Tue, 13 Sep 2022 20:51:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 48D926172C;
        Wed, 14 Sep 2022 03:51:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D39B1C433C1;
        Wed, 14 Sep 2022 03:51:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663127463;
        bh=z8tc2ny0iFtuM5BfRqU4jj6Iv1L3O0pRxMBp27sVGlE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s+EkfzWhfz6I0+9PBt12GbOskPncWqFE0sEtFo5zv/hgxDwWNOJ87fqwA7ibJrPWb
         M+SYHXFdEvhlqpMcfSSwfzEoPHPoSTU0hlXOAsOpzwlEm0Z/oQ4vWrTGWwvHZ8sOtQ
         gyvZuypo0tavxdQwlYbjplrOsyDVqIv4RzjdDiz5A5/G7AsxRzqewt/XO+XPRIuVH/
         LOxFmWDo8xx8rOMevJzO7HeV4sEdXdZy0v0jEjF/xtOa/oiihM23m7/38FdjpDh9X+
         GQvtZQ7PBZ0GnDSu7iT8kJDyXlPFaLLnUu7onndf3SSoj7bxNMtHA/WBf8ZwKH723W
         rLYdZ25EL4LHA==
Date:   Wed, 14 Sep 2022 11:50:47 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: Add i.MX8M Mini Gateworks
 GW7904 board
Message-ID: <20220914035047.GJ1728671@dragon>
References: <20220912181819.775919-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220912181819.775919-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 11:18:18AM -0700, Tim Harvey wrote:
> Add DT compatible string for i.MX8M Mini based Gateworks GW7904 board.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>

Applied both, thanks!
