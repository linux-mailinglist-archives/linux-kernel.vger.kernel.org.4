Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34FB8721E8A
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 08:50:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229515AbjFEGuB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 02:50:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230264AbjFEGtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 02:49:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECDCFF4
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 23:49:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5A78F61E6C
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:49:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B94E9C433EF;
        Mon,  5 Jun 2023 06:49:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685947784;
        bh=sWek4UJej+pwglFrB5AmndNwRxzhGRg7HhPEFHCcGIw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JXHFAZBcDv1qyZGzUx/APX4UiSy7SQohohjs5Jx2bw/PmEXNYNclxvlbs5YEY/aYu
         dSvyz5Ru9GoCGN2pOEYCBmIEdrYR2Zv3LG48n8xoBjwo6+olm0bbzFk49dlq8ihx/m
         kw3i9DwDnn/zUSvuDiahkJBRXDkot6JfS83AJLkPrglSb6KakCZPcZnkQ4t7Mh2dyw
         LcQRxZrgCipq7qDWt8Hr/FwSOGFHiLjv5Gziw/NvULXuW2FFe0UlV2MGppQ276rNiP
         UTricbAIhwx8yKQK5ZlEnpj65tOAFGVWDF/QwjUPRaCozd7LeQP+XVY0/vrgAUNUxJ
         u8Nnzj5u/IzFQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1q642T-0006v6-OT; Mon, 05 Jun 2023 08:50:01 +0200
Date:   Mon, 5 Jun 2023 08:50:01 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Philip Li <philip.li@intel.com>
Cc:     kernel test robot <lkp@intel.com>, oe-kbuild@lists.linux.dev,
        Dan Carpenter <error27@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: The robot is broken (was: Re: [PATCH 1/3] USB: serial: return
 errors from break handling)
Message-ID: <ZH2FmTrOkQI8FA__@hovoldconsulting.com>
References: <202306031014.qzAY3uQ6-lkp@intel.com>
 <ZHyGd5BRjUaOdYyF@hovoldconsulting.com>
 <ZH1lAtO0nG801FrZ@rli9-mobl>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <ZH1lAtO0nG801FrZ@rli9-mobl>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 12:30:58PM +0800, Philip Li wrote:
> On Sun, Jun 04, 2023 at 02:41:27PM +0200, Johan Hovold wrote:

> > The robot currently appears to be broken though as this report was never
> > sent to me or the relevant mailing lists (and I just happened to see it
> > by chance).
> 
> Thanks a lot Johan for checking this. For now, the bot has 2 similar mailing lists,
> one is oe-kbuild-all@lists.linux.dev, which contains the high confidence report that
> is sent directly to author and related CC. Another one is this oe-kbuild@lists.linux.dev,
> that we will send low confidence issues here and they will only be really reported
> out after manual check. So we can reduce false positives.

Ah, thanks for the explanation and sorry about the noise.

Johan
