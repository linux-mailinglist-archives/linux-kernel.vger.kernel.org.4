Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A3694A5F
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 16:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229545AbjBMPIb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 10:08:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231467AbjBMPI0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 10:08:26 -0500
Received: from soltyk.jannau.net (soltyk.jannau.net [144.76.91.90])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99A351BD4;
        Mon, 13 Feb 2023 07:08:25 -0800 (PST)
Received: by soltyk.jannau.net (Postfix, from userid 1000)
        id E16F326F77F; Mon, 13 Feb 2023 16:08:23 +0100 (CET)
Date:   Mon, 13 Feb 2023 16:08:23 +0100
From:   Janne Grunau <j@jannau.net>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Hector Martin <marcan@marcan.st>, Sven Peter <sven@svenpeter.dev>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Kettenis <kettenis@openbsd.org>, asahi@lists.linux.dev,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 17/17] arm64: dts: apple: t8112: Initial t8112 (M2)
 device trees
Message-ID: <20230213150823.GF17933@jannau.net>
References: <20230202-asahi-t8112-dt-v1-0-cb5442d1c229@jannau.net>
 <20230202-asahi-t8112-dt-v1-17-cb5442d1c229@jannau.net>
 <1ea2107a-bb86-8c22-0bbc-82c453ab08ce@linaro.org>
 <20230213140113.GE17933@jannau.net>
 <16804864-dce2-d68c-ce81-b6fdeb20a527@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <16804864-dce2-d68c-ce81-b6fdeb20a527@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023-02-13 15:36:33 +0100, Krzysztof Kozlowski wrote:
> On 13/02/2023 15:01, Janne Grunau wrote:
> >>> +
> >>> +		pmgr: power-management@23b700000 {
> >>> +			compatible = "apple,t8112-pmgr", "apple,pmgr", "syscon", "simple-mfd";
> >>
> >> Why this is simple-mfd?
> > 
> > I suppose because the syscon device is not limited to power domain 
> > controls. The dt-bindings in arm/apple/apple,pmgr.yaml specify those 
> > compatibles. See the original discussion in:
> > 
> > https://lore.kernel.org/linux-devicetree/57991dac-196e-a76d-831a-d4ac166bfe29@marcan.st/  
> 
> This did not answer my concerns. There are no children here.

The child nodes are in t8112-pmgr.dtsi

Janne
