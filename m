Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6111A749479
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 05:51:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232772AbjGFDvo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 23:51:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231868AbjGFDvm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 23:51:42 -0400
Received: from muru.com (muru.com [72.249.23.125])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 040951BD3;
        Wed,  5 Jul 2023 20:51:40 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by muru.com (Postfix) with ESMTPS id F0BE3807E;
        Thu,  6 Jul 2023 03:51:39 +0000 (UTC)
Date:   Thu, 6 Jul 2023 06:51:38 +0300
From:   Tony Lindgren <tony@atomide.com>
To:     Julien Panis <jpanis@baylibre.com>
Cc:     Roger Quadros <rogerq@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, linux-omap@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        vigneshr@ti.com, nm@ti.com, Tom Rini <trini@konsulko.com>
Subject: Re: [PATCH 0/3] Configure usb0 as peripheral on am335x boards
Message-ID: <20230706035138.GA5089@atomide.com>
References: <20230629-usb0-as-peripheral-v1-0-167f78a11746@baylibre.com>
 <20230630072047.GK14287@atomide.com>
 <f4fa80fd-1a6a-4718-0287-f5288cd9d912@baylibre.com>
 <7f44798b-e2bf-1620-da37-ca13bfd07a21@kernel.org>
 <babf5f20-ddf4-74bf-1788-f8e356acaa92@baylibre.com>
 <9ef45899-c766-e839-522a-3b048f8106f7@kernel.org>
 <6a51d860-2d20-6c35-3935-985d5b41853e@baylibre.com>
 <73a4545a-e149-261a-a0c5-a526e8740bd5@kernel.org>
 <6d485ee7-9b8a-626e-da8a-bbff37bcde61@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6d485ee7-9b8a-626e-da8a-bbff37bcde61@baylibre.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

* Julien Panis <jpanis@baylibre.com> [230703 15:51]:
> OK. In other words, we just need to reconsider my previous u-boot series. :-)
> I was setting usb0 as 'peripheral' in 'am335x-*-u-boot.dts' here:
> https://lore.kernel.org/all/20230621-fix_usb_ether_init-v2-0-ff121f0e8d7a@baylibre.com/

It would be best to not change the dts as it's describing the hardware
capabilities. Instead, it would be better to parse the capability in the
driver to handle a dual-role wired usb-ab connector as peripheral only in
u-boot.

Regards,

Tony
