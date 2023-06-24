Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F50A73CC98
	for <lists+linux-kernel@lfdr.de>; Sat, 24 Jun 2023 21:32:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233255AbjFXTcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 24 Jun 2023 15:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230307AbjFXTcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 24 Jun 2023 15:32:18 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC9B113;
        Sat, 24 Jun 2023 12:32:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aIy5duMOo06XIGthrtpl3zXpBJyqV3FYXMiwfetYexs=; b=5yTrm7v1mclQNQdAgbEMHsamh+
        5OCNYLuCkMqmRuezUAD1SqvUHhmAw1Zzn2BGhVZsceiv5ga3CllUavZbBSXE+two/48ZPvDOg/DyS
        SCkvpI92qWKaTYrdfc/uPcGJqw3C4iZCH2lJL58mcs59/PXQ6Biao+IxrO5tp4AzudVs=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qD8zR-00HRcR-UD; Sat, 24 Jun 2023 21:32:09 +0200
Date:   Sat, 24 Jun 2023 21:32:09 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com
Subject: Re: [PATCH v2 11/13] net: phy: nxp-c45-tja11xx: run cable test with
 the PHY in test mode
Message-ID: <5ce0d9e9-46d4-4e44-97cd-4fd45cf42487@lunn.ch>
References: <20230623074123.152931-1-radu-nicolae.pirea@oss.nxp.com>
 <20230623074123.152931-12-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230623074123.152931-12-radu-nicolae.pirea@oss.nxp.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 10:41:21AM +0300, Radu Pirea (NXP OSS) wrote:
> For TJA1120, the enable bit for cable test is not writable if the PHY is
> not in test mode.
> 
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew

