Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2E7961EA40
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 05:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230418AbiKGEus (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 23:50:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230160AbiKGEuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 23:50:46 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F14295F7B;
        Sun,  6 Nov 2022 20:50:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A9AAAB80DB7;
        Mon,  7 Nov 2022 04:50:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 96E4EC433C1;
        Mon,  7 Nov 2022 04:50:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667796643;
        bh=TZ9bEh8ECp5206JWTREk+68oOp2OK/IFrlmPHp3w1LM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=u3QBv8YadaiiEfl+5oeFspF1n1sEW98bFix0NkenXN09e1FEUMFRxfSc9Q42yeyP7
         +EDSoYNC8Vz874SqwMuCDab4fQ3ioQnwh4ignFXH6U2mZ+f9Yse26uQHT7sQusnyMD
         PODXq2nMXH+ZuS153SOnlpYyEZgQeAvz5dAEnGNaryGLaNCaNNgkoJ71d8YNseEdXi
         dNOvnhXiDSRM/Lg6peo5lSUKZbVv6lZSU5cOMfNZzTJ+GLaVIn9F7NqQgWKOlfeZD3
         VPkEbk7ay7GV/NLNpyozb3mAY73Szfl5j7VgXnvydW0C3nxbQoo7HGirJOPAHrPwPv
         iGjjssKbsZMzg==
Date:   Mon, 7 Nov 2022 10:20:38 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Al Cooper <alcooperx@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: Fixes tag needs some work in the phy-next tree
Message-ID: <Y2iOng7bwrWFboIV@matsya>
References: <20221107081332.391638fc@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221107081332.391638fc@canb.auug.org.au>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07-11-22, 08:13, Stephen Rothwell wrote:
> Hi all,
> 
> In commit
> 
>   3ef54ad3004a ("phy: usb: s2 WoL wakeup_count not incremented for USB->Eth devices")

Thanks for reporting, fixed now

> 
> Fixes tag
> 
>   Fixes: f1c0db40a3ad ("usb: Add "wake on" functionality")
> 
> has these problem(s):
> 
>   - Subject does not match target commit subject
>     Just use
> 	git log -1 --format='Fixes: %h ("%s")'
> 
> -- 
> Cheers,
> Stephen Rothwell



-- 
~Vinod
