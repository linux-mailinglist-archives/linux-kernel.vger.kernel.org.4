Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF895714EC2
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 19:07:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229550AbjE2RHv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 13:07:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjE2RHt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 13:07:49 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D57DBE;
        Mon, 29 May 2023 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=ctAn0AM1Vo5Aq8eCIhGC4WHg91BjrPdeqG9a05gQ9v4=; b=tk43u7gI1eHeQ16EAYoaZmTk70
        GAsIPIOCiKZFDwokn88VKJslyoyuNaZRZ+efWs/zqHnAE6+5BPVFpfcU52Yo/0IIHOPdxi9spogjr
        7SwEN1SxrWEF8HcwAuftKT1+aGJk/ECacrLHJBXjdrstJvqWQTEXcRYCV4zFNgra2HO4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q3gLI-00EFbZ-E3; Mon, 29 May 2023 19:07:36 +0200
Date:   Mon, 29 May 2023 19:07:36 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-leds@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v4 03/13] Documentation: leds: leds-class:
 Document new Hardware driven LEDs APIs
Message-ID: <dc8c8a5b-8922-4c0e-95d8-7914ea6272d3@lunn.ch>
References: <20230529163243.9555-1-ansuelsmth@gmail.com>
 <20230529163243.9555-4-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529163243.9555-4-ansuelsmth@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 06:32:33PM +0200, Christian Marangi wrote:
> Document new Hardware driven LEDs APIs.
> 
> Some LEDs can be programmed to be driven by hardware. This is not
> limited to blink but also to turn off or on autonomously.
> To support this feature, a LED needs to implement various additional
> ops and needs to declare specific support for the supported triggers.
> 
> Add documentation for each required value and API to make hw control
> possible and implementable by both LEDs and triggers.
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
