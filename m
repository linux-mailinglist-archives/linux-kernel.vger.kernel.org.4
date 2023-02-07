Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 02AF168E05D
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 19:45:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231684AbjBGSpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 13:45:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjBGSpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 13:45:07 -0500
Received: from smtp-out-06.comm2000.it (smtp-out-06.comm2000.it [212.97.32.74])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AB091E1D5;
        Tue,  7 Feb 2023 10:45:03 -0800 (PST)
Received: from francesco-nb.int.toradex.com (31-10-206-125.static.upc.ch [31.10.206.125])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: francesco@dolcini.it)
        by smtp-out-06.comm2000.it (Postfix) with ESMTPSA id AF97C56195F;
        Tue,  7 Feb 2023 19:44:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailserver.it;
        s=mailsrv; t=1675795499;
        bh=3dLDRuA2AJ5PxVv2gzG3URELYq25ZE7Is9IesfzdR0o=;
        h=Date:From:To:Cc:Subject;
        b=YB5uRJgoiZpbvMq26zvhTXjT+y5ye8EDXhQ2ZPBYHD78IvZbJKdqcdqrLsUJ7PH/i
         ziEsc4AxalpAKQfT0Jlgds6DkSImtBQfBzlEmy/We5QASmNcDuC9wlBrntxDEB91de
         GdpMy9VqrBcxoVwO2VsE5iI5w9qXqr69f2+2uAag8aznj3DZVWRrtAeK3swQ6MmEI2
         R34tE39vHBjz7Blj7/diZFb1kyYXYyMmkIu9liQk+WUC2fh/HUMK55E2oi91RyWtOH
         39HL6rPH8Wk759Fern5QhgPCwe7UVk05BVTN7OWtyjhiNtI1TcvyzT0T4RzK3jxuPK
         uJ1BAzRTDC6kA==
Date:   Tue, 7 Feb 2023 19:44:53 +0100
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Dave Gerlach <d-gerlach@ti.com>
Cc:     Tero Kristo <kristo@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, francesco.dolcini@toradex.com
Subject: K3 AM62x SoC dts/dtsi include hierarchy and naming scheme
Message-ID: <Y+KcJdvgDw9EqFCz@francesco-nb.int.toradex.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Vignesh and all,
I am writing you to get some clarification on the way the dts/dtsi
naming and include hierarchy is designed for the TI K3 AM62x SOC family.

I read commit f1d17330a5be ("arm64: dts: ti: Introduce base support for AM62x SoC").

I plan to send in the next few weeks some device tree files for
inclusion in the kernel for SOM (or computer on module) based on the
AM62x SOC.

I do envision to have the same dts file for different machine that are
going to use different variant of the AM62x SOC, e.g. AM623 vs AM625 or
just a different number of CPU cores, handling the differences at
runtime (patching the .dtb in U-Boot?) to limit the maintenance effort and
limit the amount of very similar dts files.

Said that we would prefer to stay close with what is considered/agreed
to be the best approach.

Would something like that work or you would have a completely different
expectation?

What would be the expected naming scheme? k3-am62-${board_name}.dts ?
Something else?

k3-am625.dtsi defines the CPU nodes, why are these in a AM625 specific
file? To me this looks like something that would be just the same with
AM623, and at the same time AM6251 has only one core (see [0] Table 5-1).
Am I missing something?

Thanks for your help,
Francesco

[0] https://www.ti.com/lit/ds/symlink/am625.pdf 

