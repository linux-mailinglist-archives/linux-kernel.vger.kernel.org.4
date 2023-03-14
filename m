Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 373546B8BC4
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 08:13:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230151AbjCNHNN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 03:13:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229573AbjCNHNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 03:13:10 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA0885A71;
        Tue, 14 Mar 2023 00:13:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EFDDBB818A1;
        Tue, 14 Mar 2023 07:13:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BB0D7C433EF;
        Tue, 14 Mar 2023 07:13:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678777986;
        bh=3dXATiQBn1R32lhDSO2gfWD1Ktr4c8ehbkygTblo+aA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UN6juxtnYPVC9IiRrVQ9JXJ9hhQnQt0zbJqVIDQg12/sGTQSETJGTohft+aFNrgag
         /tJkQwg8JLVhU95vvGP8qcKiIt7q2ewvCShBcZ4cSr13MOz5lU327U8YDdMjp1Wpvn
         B8o6rN8cAlnMZmFt7zhYfCLL1qwfMviK7AlUmk+J/EZ/hh2Hjs5ojewInolUKiJciN
         iHbvwjVpom2fq1yWJ7R82LQvYepGkia5gd0MBb5vPcBfnlA6h+/zMTljLMdwaO6orI
         DoFVpXHa2423cLpWn1d29rEp4Jn4AplbtqKtK1/3vMGRzbpFNLOjnUqnH0X082y0Bw
         ic0+VVC+9fmDA==
Date:   Tue, 14 Mar 2023 15:12:55 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: imx8: align thermal node names with bindings
Message-ID: <20230314071255.GB143566@dragon>
References: <20230312201335.498759-1-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230312201335.498759-1-krzysztof.kozlowski@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Mar 12, 2023 at 09:13:35PM +0100, Krzysztof Kozlowski wrote:
> Bindings expect thermal node names to end with '-thermal':
> 
>   imx8qxp-mek.dtb: thermal-zones: 'pmic-thermal0' does not match any of the regexes: '^[a-zA-Z][a-zA-Z0-9\\-]{1,12}-thermal$', 'pinctrl-[0-9]+'
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Applied, thanks!
