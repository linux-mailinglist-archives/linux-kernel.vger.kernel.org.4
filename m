Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D392721D3F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 06:54:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232346AbjFEEye (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 00:54:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231280AbjFEEya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 00:54:30 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 2BEBEB1;
        Sun,  4 Jun 2023 21:54:29 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 5CED280C1;
        Mon,  5 Jun 2023 04:54:28 +0000 (UTC)
Date:   Mon, 5 Jun 2023 07:54:27 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Udit Kumar <u-kumar1@ti.com>
Cc:     nm@ti.com, vigneshr@ti.com, kristo@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, conor+dt@kernel.org,
        m-chawdhry@ti.com, n-francis@ti.com
Subject: Re: [PATCH v3 1/5] arm64: dts: ti: k3-j7200: Add general purpose
 timers
Message-ID: <20230605045427.GV14287@atomide.com>
References: <20230604045525.1889083-1-u-kumar1@ti.com>
 <20230604045525.1889083-2-u-kumar1@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230604045525.1889083-2-u-kumar1@ti.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* Udit Kumar <u-kumar1@ti.com> [230604 04:57]:
> There are 20 general purpose timers on j721e that can be used for
> things like PWM using pwm-omap-dmtimer driver. There are also
> additional ten timers in the MCU domain which are meant for MCU
> firmware usage and hence marked reserved by default.
> 
> The odd numbered timers have the option of being cascaded to even
> timers to create a 64 bit non-atomic counter which is racy in simple
> usage, hence the clock muxes are explicitly setup to individual 32 bit
> counters driven off system crystal (HFOSC) as default.

Reviewed-by: Tony Lindgren <tony@atomide.com>
