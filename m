Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6676D70EBE7
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 05:32:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239271AbjEXDc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 23:32:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239193AbjEXDcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 23:32:47 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 935EE184
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 20:32:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2A315620AE
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 03:32:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8F3CC433D2;
        Wed, 24 May 2023 03:32:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684899163;
        bh=YgsyuTaG2HS/cCFKOvPCnWA0FKkNUnDfel1neHERp7c=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qCYYR2vd3Pd2a2mSnVE5PsD2IgslHVX/rTMAF6v4LhxRFYwvBDDxxEGlSz0RKd2MU
         i5FMuAZRrP0bPv6+QoWYcY2mevBDqXRjA9zBdIlC+rguXVOs1UdeLHVdSoRgHjetdc
         grjR4K6y3g00EKIDfpSPeaZxUS8sTMVOe55A45Qiu7M8EZBiPXg0lhQ/CZQc5vXHnH
         gh20f5Ht+IAbVbvLRMh+JYjp2zJC/tI8DzVVh1ZGDt8ie8mbd93FnXWPCvu/l8ukbA
         yiliSSGKFN+XQHjSFMeclRpShEF42panbznBXnHDuYV2jayVBCWPM2EGm1AU/JivKe
         fZss3EB0z89Tw==
Date:   Tue, 23 May 2023 20:32:40 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     <andrew@lunn.ch>, <vladimir.oltean@nxp.com>
Cc:     Harini Katakam <harini.katakam@amd.com>, <hkallweit1@gmail.com>,
        <linux@armlinux.org.uk>, <davem@davemloft.net>,
        <edumazet@google.com>, <pabeni@redhat.com>,
        <wsa+renesas@sang-engineering.com>, <simon.horman@corigine.com>,
        <netdev@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <harinikatakamlinux@gmail.com>, <michal.simek@amd.com>,
        <radhey.shyam.pandey@amd.com>
Subject: Re: [PATCH net-next v4 2/2] phy: mscc: Add support for RGMII delay
 configuration
Message-ID: <20230523203240.32519af8@kernel.org>
In-Reply-To: <20230522122829.24945-3-harini.katakam@amd.com>
References: <20230522122829.24945-1-harini.katakam@amd.com>
        <20230522122829.24945-3-harini.katakam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 May 2023 17:58:29 +0530 Harini Katakam wrote:
> Add support for optional rx/tx-internal-delay-ps from devicetree.
> - When rx/tx-internal-delay-ps is/are specified, these take priority
> - When either is absent,
> 1) use 2ns for respective settings if rgmii-id/rxid/txid is/are present
> 2) use 0.2ns for respective settings if mode is rgmii
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>

PHY folks, looks good?
