Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9DF70C155
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 16:42:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234038AbjEVOm0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 10:42:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234021AbjEVOmR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 10:42:17 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A38411F;
        Mon, 22 May 2023 07:42:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=yfi//GuVvnr5PG0d0W18/s2Qr7V1R3hb5jrrCaCC3TI=; b=anG5KyX3cDc/wpxOdVMDgva8g1
        96+jO8g6+JTdj0nXlDFytD2t8ZuhNjId6uKXNV/1aWUW+jJ6QmgA/zBULGq+MIE45x/2f3m1lwZMk
        TcSkJXgu3Z98UaovUT+/DIjlZ+CUJ8OZD+4YFVLvL47A1rPU8MlewUU03r/Mgp0zTs4A=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q16ja-00DYOd-Ih; Mon, 22 May 2023 16:42:02 +0200
Date:   Mon, 22 May 2023 16:42:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     David Epping <david.epping@missinglinkelectronics.com>
Cc:     Vladimir Oltean <olteanv@gmail.com>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH net 3/3] net: phy: mscc: enable VSC8501/2 RGMII RX clock
Message-ID: <70234187-3e7d-4932-8b07-42973337ecb1@lunn.ch>
References: <20230520160603.32458-1-david.epping@missinglinkelectronics.com>
 <20230520160603.32458-4-david.epping@missinglinkelectronics.com>
 <20230521134356.ar3itavhdypnvasc@skbuf>
 <20230521161650.GC2208@nucnuc.mle>
 <20230522095833.otk2nv24plmvarpt@skbuf>
 <20230522140057.GB18381@nucnuc.mle>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230522140057.GB18381@nucnuc.mle>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Its my first patch re-submission, so sorry for the noob question:
> Should I include your "pw-bot: changes-requested" tag with the third
> patch? Probably not.

No.

There is a robot listening to emails, and when it sees pw-bot: It uses
the label to change the state of the patch in patchworks:

https://patchwork.kernel.org/project/netdevbpf/list/

The robot does have some basic authentication, so it should actually
ignore such a line from you, since you are not a Maintainer. But even
so, you don't want to make your own new patches as needing changes.

    Andrew
