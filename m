Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE298609436
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 17:04:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229961AbiJWPE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 11:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51524 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229728AbiJWPEY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 11:04:24 -0400
Received: from vps0.lunn.ch (unknown [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A68DDD2;
        Sun, 23 Oct 2022 08:04:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=zD1/O95Ipbj62gpaq/sH2Kd/rzbC4LwRUNP3m1EDqpY=; b=z31RuW5fMiibdWjPzlL1ZgqS3O
        3qc5gImKpvsh0vNVBbMxS9SGptDkqKxWmcQzkt7sk0EaKs+sfIypIMs22TuVpePBR7KbpPvjH5ttn
        DVJQVw3ZuVx64LCV7/B68BIoNvxuq+ZUyJ0MtVpRGyyxd8dXZSwtXwbe7zp+ZdzSaBUA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1omcW9-000KId-8y; Sun, 23 Oct 2022 17:04:01 +0200
Date:   Sun, 23 Oct 2022 17:04:01 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marcin Wojtas <mw@semihalf.com>
Cc:     linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, gregory.clement@bootlin.com,
        sebastian.hesselbarth@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, hch@lst.de, kabel@kernel.org,
        jaz@semihalf.com
Subject: Re: [PATCH] ARM: dts: armada-38x: Mark devices as dma-coherent
Message-ID: <Y1VX4RtzKQZHe/oO@lunn.ch>
References: <20221022234024.87475-1-mw@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221022234024.87475-1-mw@semihalf.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NEUTRAL,SPF_NEUTRAL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 23, 2022 at 01:40:24AM +0200, Marcin Wojtas wrote:
> Armada 38x platforms marks all devices as coherent via
> mvebu_hwcc_notifier(), whereas the standard way to determine
> this is by of_dma_is_coherent(). Reflect the hardware
> capabilities by adding 'dma-coherent' properties to the device tree.

Hi Marcin

Does this need to go to -rc for 6.0? The DMA issues being reported?
If so, please add a Fixed: tag.

   Andrew
