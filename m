Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83E617050CD
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:32:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233934AbjEPOcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233613AbjEPOcJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:32:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85DF819A5
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:32:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 87A3D63A8A
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:32:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6109FC433D2;
        Tue, 16 May 2023 14:32:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684247521;
        bh=H7zehSHe6OxhJ9CICtzRIHG3toGkV9epwmeZGTu5uoI=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=m5zR2HT2O31WqtGq/ArnyvhZGdDpe4Is3e+stzeh6btOST4n5CRTjuZTamGm5oxHF
         ztBVjhziUEG7BIUzBPeBkHHuzf2Swsw+PIdgl25PVr1gAkOEAURGuWR7MOcJHxzdvw
         tBvijbYpY+pYJBUsvrHpyqrA/DTWSbTr8OSrwzrugY1cIpRKhMq8tCv4Xr5fhw2L5k
         laGpt92F4BtKQBIXaa2eJfcK5r1SUPKH4iB5uE6BFSJS6RBow5puERlIyLJksme+gq
         D0EqeBurZFyySCvUY1Xc8UXIgw/VbeqYKoGEG+dusY6tNg70Pq0LaAq95zSXXIwMWe
         Kcq6i9irp4pbQ==
Date:   Tue, 16 May 2023 20:01:57 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     kishon@kernel.org, rogerq@kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
Subject: Re: [PATCH 0/2] PHY-GMII-SEL: Add support for J784S4 SoC
Message-ID: <ZGOT3Y/tzkv4i9uV@matsya>
References: <20230331062521.529005-1-s-vadapalli@ti.com>
 <ZCbhRQ2B8+RrSh5z@matsya>
 <8d159cc9-ecdb-b96f-052a-42377a549839@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8d159cc9-ecdb-b96f-052a-42377a549839@ti.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31-03-23, 19:19, Siddharth Vadapalli wrote:
> Hello Vinod,
> 
> On 31-03-2023 19:03, Vinod Koul wrote:
> > On 31-03-23, 11:55, Siddharth Vadapalli wrote:
> >> Hello,
> >>
> >> This series TI's J784S4 SoC. A new compatible is added for the J784S4 SoC,
> >> with QSGMII mode enabled. Also, the CPSW9G instance of J784S4 SoC supports
> >> USXGMII mode. Thus, add support to configure USXGMII mode.
> > 
> > Sorry this fails to apply for me, pls rebase and send
> 
> This series has to be applied after the following series:
> https://lore.kernel.org/r/20230309063514.398705-1-s-vadapalli@ti.com/
> as mentioned below.

Okay applied now

-- 
~Vinod
