Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E05A1603DF5
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232664AbiJSJI1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:08:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232364AbiJSJFs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:05:48 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B595121A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 01:59:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=e/05vtL3e/h8I5D8aNJsFpE9yNHf7vv2MC9iGk/Z/xo=; b=mYz4VmAwJs4WLjg3KwmQSHUNn6
        zjIu2MWjjda50OJmlIEAWcV05OvnCVI35YWd+P3lqlUjP9AXtH9+gbrRC3PqGQGQQP6+xrixUpLXy
        AsnDpZ8f2tdmCGxTLjKcOXECwbykdsKW5B+z6iiMH0nRiTPzR42hj5mg7aD8dBLAWHNR9upz6A6y8
        A9+8r4X5jBcWxZHsubFNdiBBwQAa2nHyajSRyRrhdjtbj0OCuVNSc9cySGxLkyjRbFGwLvY8LF/xu
        SF9QjOiWbVH2s2OaGpx4l46nBVCQWn/EBADoFSOIP+md+jFWvHF3KlLW9xcgrjR7aAUF8SDZEYBn5
        reo/Icmw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:34786)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ol4iq-0005Mw-Po; Wed, 19 Oct 2022 09:46:46 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ol4im-0001xS-D1; Wed, 19 Oct 2022 09:46:40 +0100
Date:   Wed, 19 Oct 2022 09:46:40 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Suzuki Kuruppassery Poulose <suzuki.poulose@arm.com>
Cc:     Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        yehaiyang2@hisilicon.com, wanghuiqiang <wanghuiqiang@huawei.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>, mark.rutland@arm.com,
        Catalin Marinas <catalin.marinas@arm.com>,
        Anshuman Khandual <Anshuman.Khandual@arm.com>
Subject: Re: [Question] Question about supporting sysreg only CoreSight
 ETMv4.4 on ACPI machines
Message-ID: <Y0+5cESVK1LVXROj@shell.armlinux.org.uk>
References: <6e85db13-a65f-d4c6-1b6b-660a94cb7060@huawei.com>
 <9fc5ab20-c7f0-a917-4938-403e3661109f@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9fc5ab20-c7f0-a917-4938-403e3661109f@arm.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 18, 2022 at 10:18:08AM +0100, Suzuki Kuruppassery Poulose wrote:
> That is true. Unfortunately, supporting this requires us to move away from
> the AMBA framework (at least) for ETM4x devices. This is currently
> developed by Anshuman. We can share it as soon as this is complete.

Can we not find a way to create AMBA devices from ACPI?

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
