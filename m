Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2805726844
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 20:16:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjFGSQk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 14:16:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbjFGSQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 14:16:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E2712683;
        Wed,  7 Jun 2023 11:16:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 97A7A63A8B;
        Wed,  7 Jun 2023 18:15:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7AB6FC433D2;
        Wed,  7 Jun 2023 18:15:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686161720;
        bh=xvXczgHgLc/e2njQDVGdv1aXE9K26WS7TOpXP9atyXw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U4S4/Hod8bwhU2CrlhPTjzPdKlVIMiYr1ZetK6nMw29GbRB1JzjjcSRg7OMgl7pGl
         sbNwd+xErlf+D313F7N5cIsB+Xs08DxmzJtMBkteQbZIzD4y/1qp79b1cO7bi41Tke
         kO7rN/9L+U5inl7qmaL1qziT9TemwKfPOqTsj7yc=
Date:   Wed, 7 Jun 2023 20:15:17 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tudor Ambarus <tudor.ambarus@linaro.org>
Cc:     stable@vger.kernel.org, kuba@kernel.org, simon.horman@corigine.com,
        joneslee@google.com, oliver@neukum.org, davem@davemloft.net,
        bay@hackerdom.ru, linux-usb@vger.kernel.org, netdev@vger.kernel.or,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][stable-4.{14,19}.y 0/3] net: cdc_ncm: Backport fixes
Message-ID: <2023060705-thimble-kebab-d563@gregkh>
References: <20230605122045.2455888-1-tudor.ambarus@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230605122045.2455888-1-tudor.ambarus@linaro.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 12:20:42PM +0000, Tudor Ambarus wrote:
> Backport patches in order to fix the kernel bug reported at:
> Link: https://syzkaller.appspot.com/bug?extid=b982f1059506db48409d
> 
> Alexander's patches are prerequisites for the last. I made sure there
> are no other fixes in torvalds/master for the prerequisite patches.
> Compile tested. Intended for stable/linux-4.{14,19}.y.
> 
> Alexander Bersenev (2):
>   cdc_ncm: Implement the 32-bit version of NCM Transfer Block
>   cdc_ncm: Fix the build warning
> 
> Tudor Ambarus (1):
>   net: cdc_ncm: Deal with too low values of dwNtbOutMaxSize
> 
>  drivers/net/usb/cdc_ncm.c        | 435 ++++++++++++++++++++++++-------
>  drivers/net/usb/huawei_cdc_ncm.c |   8 +-
>  include/linux/usb/cdc_ncm.h      |  15 +-
>  3 files changed, 355 insertions(+), 103 deletions(-)
> 
> -- 
> 2.41.0.rc0.172.g3f132b7071-goog
> 

All now queued up, thanks.

greg k-h
