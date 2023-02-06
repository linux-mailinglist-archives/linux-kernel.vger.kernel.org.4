Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4163368C444
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 18:10:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjBFRKz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 12:10:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230089AbjBFRKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 12:10:51 -0500
Received: from out-89.mta1.migadu.com (out-89.mta1.migadu.com [95.215.58.89])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB15D29408
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 09:10:40 -0800 (PST)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1675703438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7XA5QSv63VPLcx4lyZYrcadMEE8df20CdUUmx5nHgas=;
        b=Ocq17HFPSuGO2rdJRrkICnLujG+dbdeX0meG860noBXqCG/ROK7nBXtflFJw8c5eX0EAlY
        d5U2LuHdv+Y/bhg6wJ2+rsViGK/A78siNc/CLB7/VpIhj258kPzj1DKCi7t+A9gYlvsBzg
        a3eUGpQ3OljGSXbZGr0tLnKiKn5oJ00=
From:   Oliver Upton <oliver.upton@linux.dev>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>, maz@kernel.org
Cc:     Oliver Upton <oliver.upton@linux.dev>,
        linux-arm-kernel@lists.infradead.org, suzuki.poulose@arm.com,
        will@kernel.org, yuzenghui@huawei.com, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, james.morse@arm.com,
        Abaci Robot <abaci@linux.alibaba.com>, catalin.marinas@arm.com
Subject: Re: [PATCH] arm64/sysreg: clean up some inconsistent indenting
Date:   Mon,  6 Feb 2023 17:10:27 +0000
Message-Id: <167570340669.3821815.15020392607863462264.b4-ty@linux.dev>
In-Reply-To: <20230131082703.118101-1-jiapeng.chong@linux.alibaba.com>
References: <20230131082703.118101-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 31 Jan 2023 16:27:03 +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> ./arch/arm64/kvm/sys_regs.c:80:2-9: code aligned with following code on line 82.
> 
> 

Applied to kvmarm/next, thanks!

[1/1] arm64/sysreg: clean up some inconsistent indenting
      https://git.kernel.org/kvmarm/kvmarm/c/242b6f34b5b5

--
Best,
Oliver
