Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF5907439C3
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 12:42:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232817AbjF3KmT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 06:42:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232903AbjF3Klz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 06:41:55 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 32FA746BA;
        Fri, 30 Jun 2023 03:40:32 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E5C1ED75;
        Fri, 30 Jun 2023 03:39:34 -0700 (PDT)
Received: from e120937-lin (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id DD2A03F663;
        Fri, 30 Jun 2023 03:38:49 -0700 (PDT)
Date:   Fri, 30 Jun 2023 11:38:47 +0100
From:   Cristian Marussi <cristian.marussi@arm.com>
To:     Oleksii Moisieiev <Oleksii_Moisieiev@epam.com>
Cc:     "sudeep.holla@arm.com" <sudeep.holla@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>
Subject: Re: [PATCH v3 0/4] firmware: arm_scmi: Add SCMI v3.2 pincontrol
 protocol basic support
Message-ID: <ZJ6wtw7mz/FjBcx6@e120937-lin>
References: <cover.1686063941.git.oleksii_moisieiev@epam.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686063941.git.oleksii_moisieiev@epam.com>
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 04:22:26PM +0000, Oleksii Moisieiev wrote:
> This Patch series is intended to introduce the potential generic driver for
> pin controls over SCMI protocol, provided in the latest beta version of DEN0056 [0].
> 
> On ARM-based systems, a separate Cortex-M based System Control Processor (SCP)
> provides control on pins, as well as with power, clocks, reset controllers. In this case,
> kernel should use one of the possible transports, described in [0] to access SCP and
> control clocks/power-domains etc. This driver is using SMC transport to communicate with SCP via
> SCMI protocol and access to the Pin Control Subsystem.
> 

Hi Oleksii,

sorry this review has been a bit delayed, I tested V3 in my setup and found no
practical issue. I'll post a few comments/remarks along the series.

Beside addressing pending comments, I suppose that the next step will be anyway
to address the upcoming changes in the new v3.2 BETA regarding support for
multiple type/value set/get operations as requested by Peng.

Thanks,
Cristian
