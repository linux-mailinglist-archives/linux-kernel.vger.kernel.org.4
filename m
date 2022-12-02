Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAD7B640271
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 09:45:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232515AbiLBIp4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 03:45:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbiLBIpx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 03:45:53 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D66F88D649;
        Fri,  2 Dec 2022 00:45:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 726F4620C4;
        Fri,  2 Dec 2022 08:45:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9AF1C433D7;
        Fri,  2 Dec 2022 08:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669970751;
        bh=hDmZqsd7AJJxOMoxzHTR52gCbav9a+GxJD/BS3XjpII=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=VqCM4by0pHsnUb1iEwlvpUP1enuixl7U2F7RgEkEP8Vp+uGRSrY0+Vf9p7qi9XDeq
         zFBgYQJSxZmX7NYXS3nQ01jkEzeA4QtG33YKk5ZF8r1xCK/MKFeHaVSt10FO5xJZhk
         hW/wu3jQnrcvpMhcHUdKw24e1ieoJtDHvK7dTq3UbtVu7MUA2LlljZSUKDS7MfzEke
         7VmJTCverf6KfVGog0bIeEKcTOxJ+dOsmDP2WGPBkn2c2Qxw6iCG/SKUM2iv5ZKKdc
         tFyyIARGMpM9QioKGsPw48JltOptv7qja7IZL78o7ugEqVy5eQsdo+PxvwufUELQke
         iU8BQX88rGl8g==
Received: from disco-boy.misterjones.org ([51.254.78.96] helo=www.loen.fr)
        by disco-boy.misterjones.org with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.95)
        (envelope-from <maz@kernel.org>)
        id 1p11g5-00A1Xo-FE;
        Fri, 02 Dec 2022 08:45:49 +0000
MIME-Version: 1.0
Date:   Fri, 02 Dec 2022 08:45:49 +0000
From:   Marc Zyngier <maz@kernel.org>
To:     Huacai Chen <chenhuacai@kernel.org>
Cc:     Liu Peibao <liupeibao@loongson.cn>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        WANG Xuerui <kernel@xen0n.name>,
        Jianmin Lv <lvjianmin@loongson.cn>,
        Yinbo Zhu <zhuyinbo@loongson.cn>,
        wanghongliang <wanghongliang@loongson.cn>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] irqchip: loongarch-cpu: add DT support
In-Reply-To: <CAAhV-H4euj53v=5k7iw5Ts7i41fpnRfWCUaAKuOTPpjRDushFg@mail.gmail.com>
References: <20221114113824.1880-1-liupeibao@loongson.cn>
 <20221114113824.1880-2-liupeibao@loongson.cn>
 <CAAhV-H4euj53v=5k7iw5Ts7i41fpnRfWCUaAKuOTPpjRDushFg@mail.gmail.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <ea43e46f0ee749e4c00acb91fe670632@kernel.org>
X-Sender: maz@kernel.org
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 51.254.78.96
X-SA-Exim-Rcpt-To: chenhuacai@kernel.org, liupeibao@loongson.cn, tglx@linutronix.de, robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org, kernel@xen0n.name, lvjianmin@loongson.cn, zhuyinbo@loongson.cn, wanghongliang@loongson.cn, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-12-02 02:07, Huacai Chen wrote:
> Hi, Peibao and Marc,
> 
> I found this patch has merged but lkp report a problem, this can
> simply fixed by add "static" before loongarch_cpu_irq_of_init
> definition. Since Marc's next branch hasn't been tagged yet, can
> Peibao send a new version and Marc rebase it?

Please send in a fix on top of the existing series.

Thanks,

         M.
-- 
Jazz is not dead. It just smells funny...
