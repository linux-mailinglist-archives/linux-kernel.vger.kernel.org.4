Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D4D21600665
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:40:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbiJQFkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:40:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230076AbiJQFkN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:40:13 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3324220F69
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 22:40:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E67E8B80F01
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:39:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2935C433C1;
        Mon, 17 Oct 2022 05:39:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665985198;
        bh=nQpWioaLzb9aE0GIgK/k8NqWcTPKAfl43vnaIeeoDMc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s1HpwzKE/xsQo7cMEJ6fEdiB832lOrdVg6ELOrZkNydo6oyFJ5v+VeZP1Y9ffM2eJ
         cohE0ieJ3VbJh0ojTi3IZOuS5V5/DPIEO7FLKgJlVLErUbEiVNgyMiNtQ48jDMyqEX
         JmrMagTxPKni0+1QXvrkBqMwTu6QDrx0EoekLDa2KSRtw3Pdg7qTnDP/qEGe9BfhC3
         pQrm/UFlnpYqJV2oOdil7uTv7mVKOqxRcIoLwo5nbY1nwOb54MTE+K5GpvDT/OHgZT
         iL1XM6NxtDRsV6f1PAtiPWe1RfjdS1VepUwibuMqLwyr5spVayeQO6NCSoFanZFIJx
         FeLa0HLk/gZWw==
Date:   Mon, 17 Oct 2022 11:09:54 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>
Cc:     "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] phy: marvell: phy-mvebu-a3700-comphy: Reset COMPHY
 registers before USB 3.0 power on
Message-ID: <Y0zqqvs91ByWcH4K@matsya>
References: <20220920121154.30115-1-pali@kernel.org>
 <20220921050300.riwyofdncxscrwe3@shindev>
 <20220921080557.jdg5wywpa5qxcyo2@pali>
 <Yy6uaaZUbZsBSqrw@matsya>
 <20220924083127.oht57ivvsr4obrjr@pali>
 <20220930234541.hsf6ryketcdukpia@pali>
 <Y0OrZ8d4GBC0Cp8q@matsya>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y0OrZ8d4GBC0Cp8q@matsya>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10-10-22, 10:49, Vinod Koul wrote:
> On 01-10-22, 01:45, Pali Rohár wrote:
> > On Saturday 24 September 2022 10:31:27 Pali Rohár wrote:

> > 
> > Vinod, could you describe a bit more what is needed to update? Because
> > this patch fixes regression - USB 3.0 support on Turris Mox board.
> 
> Sorry to have missed this...
> 
> Somehow I misunderstood that the USB 3.0 was not working and log needs
> update... I will apply this once merge window closes

Applied now, thanks

-- 
~Vinod
