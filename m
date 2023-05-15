Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB18E704106
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 00:38:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245742AbjEOWiH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 18:38:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231416AbjEOWiF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 18:38:05 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B946A5DA;
        Mon, 15 May 2023 15:38:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=jnDRWuNSWsp6KYhPmlwWmea/YvyxX4wTa6fZnl4J24c=; b=EYbU0a3j0wQDP84sU0LLnS8jpc
        1iKmZBD8ldErq0TIqmefbrbJX1Ady1G/gcNtqBPmoQGIP7LDcXk/kKywuZyEb7OczTerVF4+WTQ7G
        WtbmEVw0JSD2pUaPJ/gpoLB10zwUZ5QXojqWRsBRdUrAFPCIE2f4J1ny78oy1COkOkog=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pygp8-00CwZS-89; Tue, 16 May 2023 00:37:46 +0200
Date:   Tue, 16 May 2023 00:37:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marco Migliore <m.migliore@tiesse.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: dsa: mv88e6xxx: Fix mv88e6393x EPC write command
 offset
Message-ID: <93b20305-72e2-4916-aa72-7595a776917f@lunn.ch>
References: <20230515220918.80709-1-m.migliore@tiesse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230515220918.80709-1-m.migliore@tiesse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 12:09:18AM +0200, Marco Migliore wrote:
> According to datasheet, the command opcode must be specified
> into bits [14:12] of the Extended Port Control register (EPC).
> 
> Signed-off-by: Marco Migliore <m.migliore@tiesse.com>

Hi Marco

Please read the netdev FAQ:

https://www.kernel.org/doc/html/latest/process/maintainer-netdev.html#netdev-faq

Please add a Fixes: tag, to indicate the patch which introduced the
problem and needs fixing. Also, set the subject to indicate this is
for the net tree.

Thanks
	Andrew
