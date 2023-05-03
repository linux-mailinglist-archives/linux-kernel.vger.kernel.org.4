Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1441E6F5F44
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 21:40:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229922AbjECTkr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 15:40:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbjECTkq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 15:40:46 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5ACE86A63;
        Wed,  3 May 2023 12:40:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=VorYlWQvvEamK0tp9BEBG0k8GWiLXWZL2H2lBJZo/Q4=; b=aIVe1Vmc68PpIeaXlpQaOQBTSy
        yMrvsmEpiDW5r7bSkzuceaJ3YXSN3/xeI0Q8aG4wLq/2TOPJTUXjhq+8WZ+t3YGbjXpWkM4rei4tn
        eUr9zpZyN8vnra1DwqJSu5lWG6mEzECGEsDSeVdHqIjc/4wcvvwiGyeowFgUEdd5gDzE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1puIL0-00BrLE-5n; Wed, 03 May 2023 21:40:30 +0200
Date:   Wed, 3 May 2023 21:40:30 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Shenwei Wang <shenwei.wang@nxp.com>
Cc:     Simon Horman <horms@kernel.org>, Wei Fang <wei.fang@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "imx@lists.linux.dev" <imx@lists.linux.dev>
Subject: Re: [EXT] Re: [PATCH v2 net 2/2] net: fec: restructuring the
 functions to avoid forward declarations
Message-ID: <48d0de18-942e-4a1a-9774-792fe16db6c1@lunn.ch>
References: <20230502220818.691444-1-shenwei.wang@nxp.com>
 <20230502220818.691444-2-shenwei.wang@nxp.com>
 <6dff0a5b-c74b-4516-8461-26fcd5d615f3@lunn.ch>
 <PAXPR04MB9185BD38BA486104EE5B7213896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZFJ+9Ij+jOJO1+wu@kernel.org>
 <PAXPR04MB918564D93054CEDF255DA251896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
 <ZFKw5seP5WclDCG2@kernel.org>
 <PAXPR04MB9185FA526B63311C3899BD9C896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PAXPR04MB9185FA526B63311C3899BD9C896C9@PAXPR04MB9185.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Hi Simon,
> 
> I'm a bit confused.
> 
> Are you suggesting that I submit the following restructuring patch for 'net' at this time?
> [PATCH v2 net 2/2] net: fec: restructuring the functions to avoid forward declarations
> 
> Thanks,
> Shenwei

Submit the fix to 'net'. But only the fix.

Once a week, net gets merged to net-next, so the fix will also appear
in net-next. You can then do the cleanup in net-next.

   Andrew
