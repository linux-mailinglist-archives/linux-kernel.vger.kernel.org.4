Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D26871FAD8
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 09:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234188AbjFBHUv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 03:20:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233227AbjFBHUr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 03:20:47 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F131FC0;
        Fri,  2 Jun 2023 00:20:46 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 658688111;
        Fri,  2 Jun 2023 07:20:46 +0000 (UTC)
Date:   Fri, 2 Jun 2023 10:20:45 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Tero Kristo <kristo@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
Subject: Re: [PATCH v2 1/5] dt-bindings: arm: ti: add toradex,verdin-am62 et
 al.
Message-ID: <20230602072045.GO14287@atomide.com>
References: <20230601131332.26877-1-francesco@dolcini.it>
 <20230601131332.26877-2-francesco@dolcini.it>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601131332.26877-2-francesco@dolcini.it>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Francesco Dolcini <francesco@dolcini.it> [230601 13:15]:
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
> 
> Add toradex,verdin-am62 for Toradex Verdin AM62 SoM, its
> nonwifi and wifi variants and the carrier boards (Dahlia,
> Verdin Development Board and Yavia) they may be mated in.

Looks like you have wifi on sdio, there should be no need for separate
compatible properties. The sdio wifi will try to probe and will just bail
out if no wifi is populated.

If however the non-wifi variants are recycling the sdio pins for something
else, then it's it's a different story. In that case you want either
seprate compatible properties, or want to use dts fragments possibly.

Regards,

Tony
