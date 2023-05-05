Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7736F8040
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:42:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231827AbjEEJmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231826AbjEEJmA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:42:00 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1C6B41A131;
        Fri,  5 May 2023 02:41:43 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 84B1880FC;
        Fri,  5 May 2023 09:41:42 +0000 (UTC)
Date:   Fri, 5 May 2023 12:41:41 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Wadim Egorov <w.egorov@phytec.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-hardening@vger.kernel.org, upstream@lists.phytec.de,
        nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, keescook@chromium.org,
        tony.luck@intel.com, gpiccoli@igalia.com
Subject: Re: [PATCH 2/2] arm64: dts: ti: Add basic support for
 phyBOARD-Lyra-AM625
Message-ID: <20230505094141.GU14287@atomide.com>
References: <20230504140143.1425951-1-w.egorov@phytec.de>
 <20230504140143.1425951-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230504140143.1425951-2-w.egorov@phytec.de>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Wadim Egorov <w.egorov@phytec.de> [230504 14:12]:
> The phyCORE-AM62x [1] is a SoM (System on Module) featuring TI's AM62x SoC.
> It can be used in combination with different carrier boards.
> This module can come with different sizes and models for
> DDR, eMMC, SPI NOR Flash and various SoCs from the AM62x family.

The patch looks good to me:

Reviewed-by: Tony Lindgren <tony@atomide.com>
