Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E860B72327F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 23:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232878AbjFEVqM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 17:46:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230207AbjFEVqK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 17:46:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 662FC106;
        Mon,  5 Jun 2023 14:46:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DCED262B20;
        Mon,  5 Jun 2023 21:46:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0457C433EF;
        Mon,  5 Jun 2023 21:46:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686001566;
        bh=ruKKekv1mdzJIBzHaypDGjsbXQi+hjq8aqAGGuaFVig=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qgxShDrPLicbM0MFZ4ctiQMuSPZKVpELfH/YxjpY5/btRZk2iL0qaUwmsHqLcSJpT
         vUqSB6NzG3iwMCse67Pb0DSAJaRHN2JZhtdrqRBezKq6orcBv9+iNAjPiiEGgxwTAr
         4oFe1S01/UZSWYznxzxWw2R2cbhl1WZ4wqpxgru6ksqi1POHqrRwVeWgtbTY52XFIE
         7TnObDDinm/TMiI66TzmO+2TsjO1i3XH0JC/Ng3u+WqIBSpDiLFUqhjT/u+ZIb36J/
         d/FvMMRqp3AfQHRCllOa34JteynsSs4wPMW+PqGLwiGOxRJgSJZcNfhYzzOtV3y2HJ
         GpsKckCUUXpQw==
Date:   Mon, 5 Jun 2023 14:46:05 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org, Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: net: phy: realtek: Support external PHY clock
Message-ID: <20230605144605.63d43396@kernel.org>
In-Reply-To: <20230605144501.31f49920@kernel.org>
References: <20230605151953.48539-1-detlev.casanova@collabora.com>
        <20230605144501.31f49920@kernel.org>
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

On Mon, 5 Jun 2023 14:45:01 -0700 Jakub Kicinski wrote:
> On Mon,  5 Jun 2023 11:19:50 -0400 Detlev Casanova wrote:
> > Some PHYs can use an external clock that must be enabled before
> > communicating with them.  
> 
> Please add a [PATCH v4 0/0] prefix to the subject of the cover letter
> (or use --cover-letter with git format-patch to generate the template).
> Otherwise patchwork doesn't realize this is a cover letter.

And so it didn't realize you already sent a v4...
FWIW we ask people not to repost within 24h, confuses reviewers.
