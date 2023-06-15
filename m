Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729E1731589
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 12:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343662AbjFOKhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 06:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343544AbjFOKhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 06:37:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73B62294E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 03:36:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2E28D61DB0
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 10:36:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 41EA7C433C8;
        Thu, 15 Jun 2023 10:36:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686825407;
        bh=Z+/UrCjTJEwpHXg3x8sSXwJU8DdqLCVAEYPIixBuOtA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=PZGxKh4VSWuKh0Akzvn/bxzu2m5nWNoOUISwhW7vwMbmuzrY2WYdHt4/coyQ+u/kL
         YJWxftFfg2jLGg7iNNv6IX9NP3BcvYPJCi38/5RGziCQnN4arAd/y+k3Y6ySManhN0
         WYbKbexeCv7AttSlWeNY2+O0uMrFha5/IZh0dTgQ=
Date:   Thu, 15 Jun 2023 12:36:45 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Yogesh Hegde <yogi.kernel@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/5] Trivial code cleanup patches
Message-ID: <2023061532-fall-earthy-c429@gregkh>
References: <cover.1686149467.git.yogi.kernel@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1686149467.git.yogi.kernel@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 07, 2023 at 08:31:19PM +0530, Yogesh Hegde wrote:
> These patches remove variables in the struct rtllib_device that were 
> set only once throughout the driver. Instead of using these variables, 
> the patches modify the relevant code to directly call the corresponding 
> functions, eliminating unnecessary indirection and removing CamelCase.
> The patches are required to be applied in sequence.
> 
> Yogesh Hegde (5):
>   staging: rtl8192e: Remove variable SetWirelessMode
>   staging: rtl8192e: Remove variable SetBWModeHandler
>   staging: rtl8192e: Remove variable LeisurePSLeave
>   staging: rtl8192e: Remove variable InitialGainHandler
>   staging: rtl8192e: Remove DRV_NAME definition in rtllib_debug.h
> 
>  drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c |  4 ++--
>  drivers/staging/rtl8192e/rtl8192e/rtl_core.c   |  4 ----
>  drivers/staging/rtl8192e/rtl819x_HTProc.c      |  8 ++++----
>  drivers/staging/rtl8192e/rtllib.h              |  6 ------
>  drivers/staging/rtl8192e/rtllib_debug.h        |  5 -----
>  drivers/staging/rtl8192e/rtllib_rx.c           |  3 ++-
>  drivers/staging/rtl8192e/rtllib_softmac.c      | 16 +++++++---------
>  drivers/staging/rtl8192e/rtllib_softmac_wx.c   |  9 +++++----
>  8 files changed, 20 insertions(+), 35 deletions(-)
> 
> -- 
> 2.25.1
> 
> 

These break the build, as reported by the test robot, please fix up.

thanks,

greg k-h
