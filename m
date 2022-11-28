Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B80C063A61A
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 11:30:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbiK1KaV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 05:30:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbiK1KaQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 05:30:16 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B992C75A
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 02:30:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=p1DKigK1jA0p63g1Gfy2HQuMxzb9udf2Q6tJF1B4FEI=; b=M2kGYCjZgwf9KyAm36OORiuBhM
        bOgkRYKrLyOJJ87+39CVKcvR8w7ulLBSIbCm8FrmoSVsZmOkgiXVa7lf5zFjVkLAIom1jncKR+0PI
        Kt+ycEm4wGZpVisLUUFYNNa6R5x/0VE4w9GKxlxa44ryqxATW2MEPTEPMkryWkzZq0/x+iFZmfOZZ
        AOj3fNB7ayULDt6BbfG24w9seSiBDB6mcV8T50LQpfTm/7STeqvw4bMzfoO7WvGcui79asPQg2Y/z
        kwln2Yam4JbNGQVGleTGy4/F3ASyJSAzd+2vJnR9qwMuUbuD1aIAMrcSyxFNFX3nb3be3ZhhT/tF7
        fm43pJow==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35456)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ozbOp-0007ui-FH; Mon, 28 Nov 2022 10:30:07 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ozbOn-0000Uy-7s; Mon, 28 Nov 2022 10:30:05 +0000
Date:   Mon, 28 Nov 2022 10:30:05 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Zhen Lei <thunder.leizhen@huawei.com>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/2] ARM: Make the dumped instructions are consistent
 with the disassembled ones
Message-ID: <Y4SNrQgON1qY9vzE@shell.armlinux.org.uk>
References: <20221126122137.2025-1-thunder.leizhen@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221126122137.2025-1-thunder.leizhen@huawei.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Nov 26, 2022 at 08:21:35PM +0800, Zhen Lei wrote:
> v3 --> v4:
> 1. The sparse warnings that are not involved in the modification are
>    not eliminated.
> 2. Eliminate the sparse warnings involved in the modification when
>    refactor dump_instr(), no longer use a separate patch.
> 
> v2 --> v3:
> 1. Don't use '__force to' cleanup the sparse warnings
> 2. Refactor dump_instr()
> 3. Relace cpu_to_le{32|16}() with __mem_to_opcode_{arm|thumb16}()
> 
> 
> v1 --> v2:
> 1. Cleanup sparse warnings.
> 
> Zhen Lei (2):
>   ARM: Refactor dump_instr()
>   ARM: Make the dumped instructions are consistent with the disassembled
>     ones

Looks good now, thanks.

Please put it in my patch system, details in my signature. Thanks.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
