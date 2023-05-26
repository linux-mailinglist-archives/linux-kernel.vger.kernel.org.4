Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20035711E84
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 05:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235156AbjEZDnq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 23:43:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229689AbjEZDnm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 23:43:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2390712F;
        Thu, 25 May 2023 20:43:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A39C464AFA;
        Fri, 26 May 2023 03:43:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CE72C433D2;
        Fri, 26 May 2023 03:43:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685072620;
        bh=/L2ak1QSeM0cCjQ48lK1EVSqL+J/A7fobg5W3LOtywM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JO/UjNZpNTEYCO6E/ikfAgokVWP/FSDJVnYoVDsTwnx64cATbJdus3/6wL/S2oEl7
         usQmN2PW4r6+7rT9/GdABsEtTrfqhCq/YvlMhMlDsWowGMnv4DzCv2507wdv1C10QE
         hCGQtB2XmW63NMb+i7sKoK5O2gtUHtHUyWEzhjFK/lmMAADcWLUfZER+fqQlsibjFi
         V2xKtH7tW/6i9tkuMIvFwfzcrkyE8fO6IYkPdKg3eW5yKNt+PKbcDNzvhuTVS8Vumc
         e3h/W4azpOqY65fKQFUXH7keAveTzvzO8zIaND2WLdwK8N7HyfDNDu5u0nSXz0Rmto
         Ied8XWvRqx/Yw==
Date:   Thu, 25 May 2023 20:43:38 -0700
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
Subject: Re: [net-next PATCH v2 00/13] leds: introduce new LED hw control
 APIs
Message-ID: <20230525204338.3de1e95c@kernel.org>
In-Reply-To: <20230525145401.27007-1-ansuelsmth@gmail.com>
References: <20230525145401.27007-1-ansuelsmth@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 25 May 2023 16:53:48 +0200 Christian Marangi wrote:
> This is based on top of branch ib-leds-netdev-v6.5 present here [1].

I merged that PR now, but you'll need to repost.
Build bots don't read English (yet?) so posting patches which can't 
be immediately applied is basically an RFC (and should be marked as
such).
