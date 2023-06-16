Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D5235733638
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 18:36:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345769AbjFPQgL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 12:36:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345760AbjFPQfo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 12:35:44 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2C473C23
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 09:35:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3AB8D60DD7
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 16:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B831C433C8;
        Fri, 16 Jun 2023 16:35:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686933330;
        bh=9WHjM9VXrkjIaIufT08irEDtCWmEn429IWbU2+liu/I=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Dvj+xlvBnJYF5gUspWYhy0sY6iy+C1Hkm0tbFteBUZwdW2O8oqiXSzrvwUhKbqYD3
         rEUO3/zwf+vBcDJtdYLayYgsXYeo/0/xiZ/FGNdvd4OQ6RZeZq4rL2VEHQSe3CHeel
         +dtmn0/Ym3AKwC91jMpZTN2bCspol7HmKpJqTHFgRMWDT10V2uhN6EuOqC7hwZQynM
         Dy4yf8jqXTENaQYygKSt+ZtVzrqOKny5a31c2ADZZOrgBi1dgvUbc9hIFBgQMIhlYC
         UjbOiVjab2jt6IYmDQ7YtnSELoKPqTpmotwrsIIZqSpFQnsEFRvzEL4osFM71IMQD3
         GmYeAZRfxKmbA==
Date:   Fri, 16 Jun 2023 09:35:29 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Ganesh Babu <ganesh.babu@ekinops.com>
Cc:     Stephen Hemminger <stephen@networkplumber.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] net: mroute6.h: change type of mif6c_pifi to __u32
Message-ID: <20230616093529.21fe1a0b@kernel.org>
In-Reply-To: <PAZP264MB406423636D35E139C50BCD2BFC58A@PAZP264MB4064.FRAP264.PROD.OUTLOOK.COM>
References: <PAZP264MB4064279CBAB0D7672726F4A1FC889@PAZP264MB4064.FRAP264.PROD.OUTLOOK.COM>
        <20230328191456.43d2222e@kernel.org>
        <PAZP264MB406414BA18689729DDE24F3DFC659@PAZP264MB4064.FRAP264.PROD.OUTLOOK.COM>
        <20230502085718.0551a86d@kernel.org>
        <20230502105820.2c27630d@hermes.local>
        <PAZP264MB4064D9406001EB75D768D0E7FC449@PAZP264MB4064.FRAP264.PROD.OUTLOOK.COM>
        <PAZP264MB406423636D35E139C50BCD2BFC58A@PAZP264MB4064.FRAP264.PROD.OUTLOOK.COM>
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

On Fri, 16 Jun 2023 09:52:44 +0000 Ganesh Babu wrote:
> I would appreciate any feedback or updates on the status of patch.
> Thank you for your attention, and I look forward to hearing from you soon.

You can try reposting with the commit format fixed after 6.5-rc1 is
released. Make sure the commit messages answers _all_ the questions
and concerns raised. Read this before posting:

https://www.kernel.org/doc/html/next/process/maintainer-netdev.html
