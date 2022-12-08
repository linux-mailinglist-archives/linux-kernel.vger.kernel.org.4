Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C5DC6470A8
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 14:18:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230224AbiLHNSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 08:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229601AbiLHNSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 08:18:03 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2224743AD5
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 05:18:03 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC83B61EAB
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 13:18:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AF0CCC433B5;
        Thu,  8 Dec 2022 13:18:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1670505482;
        bh=truX/ZpVDN5TEyfVc1MtGApLFXGe2FYCr1TxAk3v3y0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YzAM4QkBdlhqOplnoC2ZXv7FeAjhwCpyTGiEeGzQhO68EWJRQYC+t82eY26tfdCGk
         xg9NfzKr0VtiVZ2u9y5wu66EWrwaCQQdMExbE/h//UwnagWvWIskXgOAnI/GTf3cef
         u6DzvRhXQuuaKU6JkBBg8TuPq1A2hAzacN4jOZy8=
Date:   Thu, 8 Dec 2022 14:17:58 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Matt Jan <zoo868e@gmail.com>
Cc:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: Re: [PATCH v2 1/3] staging: vme_user: add the spaces around the "*"
Message-ID: <Y5HkBnptiY06DtRL@kroah.com>
References: <20221208103813.GA100066@zoo868e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221208103813.GA100066@zoo868e>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 08, 2022 at 06:38:13PM +0800, Matt Jan wrote:
> Add a space around the "*" at vme_bridge.h to clear up a checkpatch
> check.
> 
> Signed-off-by: Matt Jan <zoo868e@gmail.com>
> ---
>  drivers/staging/vme_user/vme_bridge.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
> index 0bbefe9851d7..e17a8f7de165 100644
> --- a/drivers/staging/vme_user/vme_bridge.h
> +++ b/drivers/staging/vme_user/vme_bridge.h
> @@ -4,7 +4,7 @@
>  
>  #include "vme.h"
>  
> -#define VME_CRCSR_BUF_SIZE (508*1024)
> +#define VME_CRCSR_BUF_SIZE (508 * 1024)
>  /*
>   * Resource structures
>   */
> -- 
> 2.25.1
> v2: Resend the correct patch set, noted by Greg Kroah-Hartmamn <gregkh@linuxfoundation.org>

This "v2" stuff goes below the "---" line, not down here below the patch
itself.

Also this series is not properly threaded at all, please use 'git
send-email' to do so so that our tools will properly pick up the whole
thread, and not just individual emails.

Can you fix this all up and send a v3 please?

thanks,

greg k-h
