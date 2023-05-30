Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 093687154D3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 07:17:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230132AbjE3FRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 01:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjE3FRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 01:17:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29353F0;
        Mon, 29 May 2023 22:17:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A46B361F84;
        Tue, 30 May 2023 05:17:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 703FFC433D2;
        Tue, 30 May 2023 05:17:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685423844;
        bh=k884gDEJ5Px9eCtShgMPs/yMOdJUjvXbTW8ERplzsfg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=aki9TRTKAPGTRUcXDrGPWTWNhhpS5uaSPsrlNxHzUCuhdye9mifJEYG539XDCG/6m
         8YVuVjYPPt3nlBoQBAVFD/gcDa/pjb6yvY5iLIxWF57y6pCv0vRbHj7HnDsu5VpoId
         85xRV5hBTVh2VTgGPX7CSETSuQno5PWyNE6Px8ROc/yG9mCi/o4AH5L/ei/bpM6MPN
         GRy5bUEaR1/vfVouxPLQiMNt+Res1cV0QE3tWiPdcf4tcfW5NpGfySp0QtsFBIhAkL
         MMcVBFG1OmRYzB+lg+E08Qb1j9pcCY1d4KjsLisUfjhp4iLesQVHD91cEZgUMpqASx
         7KqcscRQuqwTw==
Date:   Mon, 29 May 2023 22:17:22 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Lee Jones <lee@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, Andrew Lunn <andrew@lunn.ch>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>, linux-leds@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org
Subject: Re: [net-next PATCH v4 00/13] leds: introduce new LED hw control
 APIs
Message-ID: <20230529221722.549dfbd8@kernel.org>
In-Reply-To: <20230529163243.9555-1-ansuelsmth@gmail.com>
References: <20230529163243.9555-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 29 May 2023 18:32:30 +0200 Christian Marangi wrote:
> Since this series is cross subsystem between LED and netdev,
> a stable branch was created to facilitate merging process.
> 
> This is based on top of branch ib-leds-netdev-v6.5 present here [1]
> and rebased on top of net-next since the LED stable branch got merged.
> 
> This is a continue of [2]. It was decided to take a more gradual
> approach to implement LEDs support for switch and phy starting with
> basic support and then implementing the hw control part when we have all
> the prereq done.
> 
> This is the main part of the series, the one that actually implement the
> hw control API.

Just to be 100% sure - these go into netdev/net-next directly, right?
No stable branch needed?
