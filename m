Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AE707267F5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:07:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232457AbjFGSHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:07:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjFGSHC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:07:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 466202132;
        Wed,  7 Jun 2023 11:06:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BCA656419F;
        Wed,  7 Jun 2023 18:06:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CC230C433EF;
        Wed,  7 Jun 2023 18:06:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686161205;
        bh=C/lHo+ZleFjO9LWFKlT+1j26eXRjziuLsc+qH3svza4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=QzWaZ33ZncOK/LsiwA3boNsDl4XQVmccX89UKv3/6Sy91XNSeMnvrLyd8lNkFxs6l
         V6XS2QUKtVuzFeq9126guglD4ucAkL2SWPesUht16gE8z9RsGjecV3UdYtHf+gix/A
         78YaBJTRRAM1clbJW6zr+WdG4hzOAneLMxl0274Y=
Date:   Wed, 7 Jun 2023 20:06:42 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Rishabh Bhatnagar <risbhat@amazon.com>
Cc:     sfrench@samba.org, stable@vger.kernel.org,
        linux-cifs@vger.kernel.org, linux-kernel@vger.kernel.org,
        Paulo Alcantara <pc@cjr.nz>, Aurelien Aptel <aaptel@suse.com>,
        Steve French <stfrench@microsoft.com>
Subject: Re: [PATCH 5.4 1/2] cifs: get rid of unused parameter in
 reconn_setup_dfs_targets()
Message-ID: <2023060758-identify-awkward-8f86@gregkh>
References: <20230601205817.3957-1-risbhat@amazon.com>
 <20230601205817.3957-2-risbhat@amazon.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601205817.3957-2-risbhat@amazon.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 01, 2023 at 08:58:16PM +0000, Rishabh Bhatnagar wrote:
> From: Paulo Alcantara <pc@cjr.nz>
> 
> commit baf3f08ef4083b76ca67b143e135213a7f941879 upstream.
> 
> The target iterator parameter "it" is not used in
> reconn_setup_dfs_targets(), so just remove it.
> 
> Signed-off-by: Paulo Alcantara (SUSE) <pc@cjr.nz>
> Reviewed-by: Aurelien Aptel <aaptel@suse.com>
> Signed-off-by: Steve French <stfrench@microsoft.com>
> ---

When passing on patches from other people, you too have to sign-off on
the patch, saying that you are ok with it.

Please resend this series with your signed-off on it as well (after
reading the documentation to understand what you are agreeing to.)

thanks,

greg k-h
