Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AA9672E6C3
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 17:12:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239765AbjFMPLx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 11:11:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239762AbjFMPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 11:11:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57F41CA
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 08:11:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E06D763757
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 15:11:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF3EFC433F0;
        Tue, 13 Jun 2023 15:11:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686669108;
        bh=dykc957lGLgdxPlNU4/r7Oycthfggx01N7MsscTBIvA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=1e2G9F7B3TVcjRo6+ch4D5hTe+JPGZnG4p2hHDxXr0BQ3BNnlwDJdW/7r2llFx3Ia
         x10VI+OaLrkPfi0r5qBSYR9vm6iZ4u5bLpTHpubWanheHuAFCoClCR8UZ3XjICWZti
         mFHa8h0ubjhxoIFrcaAZIgZR9oldAeN2DotcEejw=
Date:   Tue, 13 Jun 2023 17:11:45 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     laurentiu.tudor@nxp.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        ioana.ciornei@nxp.com, Bharat Bhushan <Bharat.Bhushan@nxp.com>
Subject: Re: [PATCH 1/3] virt/vgic: Increase number of DeviceIDs to 17
Message-ID: <2023061311-fragrance-gangway-b301@gregkh>
References: <20230613150804.20595-1-laurentiu.tudor@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230613150804.20595-1-laurentiu.tudor@nxp.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 06:08:01PM +0300, laurentiu.tudor@nxp.com wrote:
> From: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> 
> FSL-MC bus devices uses device-ids from 0x10000 to 0x20000.
> So to support MSI interrupts for mc-bus devices we need
> vgi-ITS device-id table of size 2^17 to support deviceid
> range from 0x10000 to 0x20000.
> 
> Signed-off-by: Bharat Bhushan <Bharat.Bhushan@nxp.com>
> ---
>  arch/arm64/kvm/vgic/vgic-its.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Is there a reason you didn't cc: any of the relevant maintainers for
this change?  Please use scripts/get_maintainer.pl on your patch to
determine who is responsible for it (hint, not me!)

thanks,

greg k-h
