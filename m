Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43C93713428
	for <lists+linux-kernel@lfdr.de>; Sat, 27 May 2023 12:59:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230446AbjE0K73 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 May 2023 06:59:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE0K71 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 May 2023 06:59:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0712CD3;
        Sat, 27 May 2023 03:59:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 976E660B39;
        Sat, 27 May 2023 10:59:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 640F2C433D2;
        Sat, 27 May 2023 10:59:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685185164;
        bh=OC4Rq902wh35fSKpBf4IfsUs4gYUwzgE2myu8k6Vmz4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=qQv12nBrz/UL21KtQWhpq2oa0lifmjnNIbCilcf007e2rRsYa/qALr5fUaopE+WOm
         C3ReeseCU4sAiGxANmzDxqOcgn7UB8pGzuu0ESyo8ut/Az2MRZfghvgv2AisVKlhup
         C25gATRCzgvsE9Xhs/+cQzgrRuqmzjne8Y8bdXGv2k86mLD2rZUJIHH8uzR0Z1EAyl
         r4A1JBCDqH5hZusSj3rGfItm5cuTIaa2+Tr2pavpsOdEy4HpWOTixwEmR+ntQCaWZg
         766fsS5nKcGEHuPtnYkgOC7gCUUyU5og90CU0JWVeQOAbobah+hf2tW7c8pE/mZROn
         jv0IMgcNK2MGw==
Date:   Sat, 27 May 2023 18:59:12 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Tim Harvey <tharvey@gateworks.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Li Yang <leoyang.li@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH V2 1/2] dt-bindings: arm: Add Gateworks i.MX8M GW7905-2x
 board
Message-ID: <20230527105912.GM528183@dragon>
References: <20230516190041.476045-1-tharvey@gateworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516190041.476045-1-tharvey@gateworks.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 12:00:40PM -0700, Tim Harvey wrote:
> Add DT compatible string for a Gateworks GW7905-2x board based on
> the i.MX8MPlus from NXP.
> 
> Signed-off-by: Tim Harvey <tharvey@gateworks.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied both, thanks!
