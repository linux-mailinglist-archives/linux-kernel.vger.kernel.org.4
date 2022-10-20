Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E773606499
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 17:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230012AbiJTPdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 11:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJTPc5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 11:32:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8B951D1E24
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 08:32:52 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D16D61BDF
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 15:32:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5CCCCC433D7;
        Thu, 20 Oct 2022 15:32:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666279971;
        bh=MIwXW+lRvthZkwxf5Rk6tHYJaZ3mnMTh3sSJ4bAV7t8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=0TCq97O92tT1p+gRJMlxmAMNOiJopBZSiazSkr4s39n4uwHs4Ry5+kPoMJhmWHzVL
         eWTyaX/PK5lcSYVmfmBrMKYAoGFgKpdSeEZ4HcvN0d8PEIVbk4N0AJNYxgszzHYRgU
         JEAwn3r3/ZJnkFKbfkHg8awaLUiL3DfUbzv9ezJc=
Date:   Thu, 20 Oct 2022 17:32:49 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Dragan Cvetic <dragan.m.cvetic@gmail.com>
Cc:     philipp.g.hortmann@gmail.com, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] staging: rtl8192e: Rename Enable, cck_Rx_path and
 disabledRF
Message-ID: <Y1FqIYgP4F6hhyAY@kroah.com>
References: <20221010190457.13199-1-dragan.m.cvetic@gmail.com>
 <20221010190457.13199-3-dragan.m.cvetic@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221010190457.13199-3-dragan.m.cvetic@gmail.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 08:04:56PM +0100, Dragan Cvetic wrote:
> Rename variable Enable to enable, cck_Rx_path to cck_rx_path and
> disabledRF to disabled_rf to avoid CamelCase which is not accepted
> by checkpatch.
> 
> Signed-off-by: Dragan Cvetic <dragan.m.cvetic@gmail.com>
> ---
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.c | 20 ++++++++++----------
>  drivers/staging/rtl8192e/rtl8192e/rtl_dm.h |  6 +++---
>  2 files changed, 13 insertions(+), 13 deletions(-)

This change did not apply to my tree.

Please rebase and resend.

thanks,

greg k-h
