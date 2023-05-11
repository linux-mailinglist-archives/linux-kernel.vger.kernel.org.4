Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CA8F6FF3D9
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:17:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237993AbjEKOQb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:16:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238499AbjEKOQU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:16:20 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD311BE;
        Thu, 11 May 2023 07:16:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=9xKlrKhFYqLyQTlWQo4MBtluka9IvgO2ZSWgQPkAczs=; b=FPoI5diA/0zZy8JMmK+sAC9n+G
        C6uTsBO8yEpp/fYSDyMQrvRMplR23ccV6M495JzZwzexuX36dvw5iWI29VG52MbK7ysvIA4z6uakM
        NeuY7gGAdkIaQ5Hu+6X4sfqYYtS36zuxGxbGcueP24TrcDXp6jPnBmyLcrsqe8AZ0dus=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1px75P-00CZ0N-89; Thu, 11 May 2023 16:16:03 +0200
Date:   Thu, 11 May 2023 16:16:03 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@amd.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
        vladimir.oltean@nxp.com, wsa+renesas@sang-engineering.com,
        simon.horman@corigine.com, mkl@pengutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com
Subject: Re: [PATCH net-next v3 3/3] phy: mscc: Add support for VSC8531_02
Message-ID: <3a8e10f6-ea98-4c6d-b89e-06d659365acb@lunn.ch>
References: <20230511120808.28646-1-harini.katakam@amd.com>
 <20230511120808.28646-4-harini.katakam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511120808.28646-4-harini.katakam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 05:38:08PM +0530, Harini Katakam wrote:
> Add support for VSC8531_02 (Rev 2) device. Use exact PHY ID match.

Please add a comment:

Rev 2 requires its own entry so that...

Just to make it clear why the existing PHY_ID_VSC853/0xfffffff0 is not
sufficient.

	Andrew

