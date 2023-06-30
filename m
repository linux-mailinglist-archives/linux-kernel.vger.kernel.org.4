Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 764917435AD
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 09:20:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjF3HUx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 03:20:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbjF3HUu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 03:20:50 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 67C8EE61;
        Fri, 30 Jun 2023 00:20:49 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id 7680180FE;
        Fri, 30 Jun 2023 07:20:48 +0000 (UTC)
Date:   Fri, 30 Jun 2023 10:20:47 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, nm@ti.com
Subject: Re: [PATCH 0/3] Configure usb0 as peripheral on am335x boards
Message-ID: <20230630072047.GK14287@atomide.com>
References: <20230629-usb0-as-peripheral-v1-0-167f78a11746@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230629-usb0-as-peripheral-v1-0-167f78a11746@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Julien Panis <jpanis@baylibre.com> [230629 13:10]:
> This series configures usb0 dr_mode as 'peripheral' for am335x-evm,
> am335x-evmsk, and am335x-icev2. This USB port is mainly used for
> RNDIS and DFU.

Is this a mini-B connector? Just wondering if it was originally attempted
to be configured as OTG or how it ended up with a host configuration..

> Initially, a series was submitted to overlay dr_mode in u-boot specific
> device trees ('<board>-u-boot.dtsi'):
> https://lore.kernel.org/all/20230621-fix_usb_ether_init-v2-0-ff121f0e8d7a@baylibre.com/
> 
> It was finally decided to modify linux device trees.

Do we need these as fixes? If so is there a fixes tag for these?

Regards,

Tony
