Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECD2C6DF52D
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:27:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230098AbjDLM1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230141AbjDLM0n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:26:43 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A24536188;
        Wed, 12 Apr 2023 05:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=qkNd91mc0wlb2VPKu+SyH5ISGGmmbOrNHWSQupS56iM=; b=WZCWrWYbQ4ZSJIOzFEnG7+lWwj
        bRqu/CHjEZ+F/0Z+DoAGQMMjSa6r9/P89eQedGa59zn2475FPvmVhcShraAtW6t0DMJ3ujRkz7nbD
        BHmb95TGPbCEJ8cDCQhzBNNB8WUs8bxlp06GtpvPAcikO4aDADD8o63uoIM1o5cMQQZI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pmZYf-00A5OU-1G; Wed, 12 Apr 2023 14:26:41 +0200
Date:   Wed, 12 Apr 2023 14:26:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     INAGAKI Hiroshi <musashino.open@gmail.com>
Cc:     Gregory CLEMENT <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        sebastian.hesselbarth@gmail.com, arnd@arndb.de, olof@lixom.net,
        soc@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Subject: Re: [PATCH 2/2] ARM: dts: mvebu: add device tree for IIJ SA-W2
 appliance
Message-ID: <b9cb92ea-6a11-4299-a963-b9674faa4011@lunn.ch>
References: <20230223132502.2045-1-musashino.open@gmail.com>
 <20230223132502.2045-2-musashino.open@gmail.com>
 <Y/d7gjqQCKKXMHqj@lunn.ch>
 <7d4a218d-8b8a-5a1d-eff8-e154bfde69be@gmail.com>
 <87jzyn3dv9.fsf@BL-laptop>
 <64b5504d-c81d-f77e-da67-c6d9e76aedd6@gmail.com>
 <b153523b-45cf-4e2e-8d62-de15b01a158d@lunn.ch>
 <231f9093-968b-e008-f2ff-899d8b24459c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <231f9093-968b-e008-f2ff-899d8b24459c@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023 at 02:21:27PM +0900, INAGAKI Hiroshi wrote:
> Hello Andrew Lunn,
> 
> thank you for your guidance, I'll do it.

You probably want to talk to Tony Dinh <mibodhi@gmail.com>.

https://lore.kernel.org/linux-arm-kernel/20230412025737.20280-2-mibodhi@gmail.com/T/

    Andrew
