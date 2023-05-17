Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9AF96707331
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:39:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjEQUjn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:39:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjEQUjl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:39:41 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36FE6C0;
        Wed, 17 May 2023 13:39:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=Mt3aB20cxB1M3U/YG/ZB3G0WgRWyy+pj0efMkcJEk8M=; b=4Z
        A3KAEH9BIwV+s3VooFYIPWWpP62N0RG1xfdlZsRxA3cy0rBLzMLmMcR9ltQcDl9GQKhJG5v2aaMF0
        5LhTY89m5uUW9eJ6FZ/vcNc5qbTsw0bHopYwfGVT48A/ntQbOMjifrbAAHogulfvidgBaO0DrTrVh
        8mBcsF5vPYyaJFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pzNvo-00DAg2-16; Wed, 17 May 2023 22:39:32 +0200
Date:   Wed, 17 May 2023 22:39:32 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     alexis.lothore@bootlin.com
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Richard Cochran <richardcochran@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, thomas.petazzoni@bootlin.com,
        paul.arola@telus.com, scott.roberts@telus.com
Subject: Re: [PATCH net-next 1/2] dt-bindings: net: dsa: marvell: add
 MV88E6361 switch to compatibility list
Message-ID: <d5f6b115-155c-4768-b600-012bafb41b98@lunn.ch>
References: <20230517203430.448705-1-alexis.lothore@bootlin.com>
 <20230517203430.448705-2-alexis.lothore@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230517203430.448705-2-alexis.lothore@bootlin.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 17, 2023 at 10:34:29PM +0200, alexis.lothore@bootlin.com wrote:
> From: Alexis Lothoré <alexis.lothore@bootlin.com>
> 
> Marvell MV88E6361 is an 8-port switch derived from the
> 88E6393X/88E9193X/88E6191X switches family. Since its functional behavior
> is very close to switches from this family, it can benefit from existing
> drivers for this family, so add it to the list of compatible switches
> 
> Signed-off-by: Alexis Lothoré <alexis.lothore@bootlin.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
