Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 698646F6C6C
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 14:53:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230481AbjEDMxH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 08:53:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230179AbjEDMxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 08:53:04 -0400
X-Greylist: delayed 464 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 04 May 2023 05:52:48 PDT
Received: from connect.vanmierlo.com (fieber.vanmierlo.com [84.243.197.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEFEA6E8E;
        Thu,  4 May 2023 05:52:47 -0700 (PDT)
X-Footer: dmFubWllcmxvLmNvbQ==
Received: from roundcube.vanmierlo.com ([192.168.37.37])
        (authenticated user m.brock@vanmierlo.com)
        by connect.vanmierlo.com (Kerio Connect 9.4.2) with ESMTPA;
        Thu, 4 May 2023 14:22:13 +0200
MIME-Version: 1.0
Date:   Thu, 04 May 2023 14:22:13 +0200
From:   m.brock@vanmierlo.com
To:     Manikanta Guntupalli <manikanta.guntupalli@amd.com>
Cc:     gregkh@linuxfoundation.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, michal.simek@xilinx.com,
        linux-serial@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, jirislaby@kernel.org,
        linux-arm-kernel@lists.infradead.org, michal.simek@amd.com,
        git@amd.com, radhey.shyam.pandey@amd.com,
        shubhrajyoti.datta@amd.com, srinivas.goud@amd.com,
        manion05gk@gmail.com
Subject: Re: [PATCH 0/2] Add rs485 support to uartps driver
In-Reply-To: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
References: <1682512187-8828-1-git-send-email-manikanta.guntupalli@amd.com>
Message-ID: <6b72c56e79a44fec348de26d14d9dce0@vanmierlo.com>
X-Sender: m.brock@vanmierlo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Manikanta Guntupalli wrote 2023-04-26 14:29:
> Add optional gpio property to uartps node to support rs485
> Add rs485 support to uartps driver
> 
> Manikanta Guntupalli (2):
>   dt-bindings: Add optional gpio property to uartps node to support
>     rs485
>   tty: serial: uartps: Add rs485 support to uartps driver
> 
>  .../devicetree/bindings/serial/cdns,uart.yaml |  5 +
>  drivers/tty/serial/xilinx_uartps.c            | 96 ++++++++++++++++++-
>  2 files changed, 100 insertions(+), 1 deletion(-)

Why would you want to use a GPIO and not RTS for choosing the direction
as is more common in this case?
And have you thought about configuring the polarity?
How long will the signal be active before the real transmission begins
so the driver can settle?

Maarten

