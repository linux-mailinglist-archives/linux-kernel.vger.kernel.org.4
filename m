Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6049D6D7B85
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 13:39:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237607AbjDELjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 07:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237539AbjDELjE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 07:39:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DE54203;
        Wed,  5 Apr 2023 04:39:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 96F156233F;
        Wed,  5 Apr 2023 11:39:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C62CBC433EF;
        Wed,  5 Apr 2023 11:39:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680694740;
        bh=Ac8wTw9RR/85DVjXUxxvaiBRTiHVdB/k4QsbhkKgWLM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JIqe1gT4vcZIjvsLtoiJSi7tp746yDBu8/mBlP7hSvfcy6MiuGPFRFV6I6sGvAcqY
         XtsGkzf23WgZfFcc5+tYHRwqD7PmCkFKK66bhRC9NV7yETzLjwFoX8mszseSHlHiEN
         Z7SyhqCLWzqji4K5cPC14ShD5XRljk/DznftXq1oszUh7/Igqt/DQk8+UJjnqsmdsr
         asjOUvsKkgudJc5SeChHwKi3d8WqhlE7rCo6/E6+w5joroS2iYKklD23zo1WeI9sNo
         cH/VyU/2rANX8tas5/ILiklfubyKhrBbrjR/AfxJRhBSVNGvQ43gbNvyWji9l/ftCi
         BDvz5roOGy2Uw==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pk1UB-00059d-BR; Wed, 05 Apr 2023 13:39:31 +0200
Date:   Wed, 5 Apr 2023 13:39:31 +0200
From:   Johan Hovold <johan@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     gregkh@linuxfoundation.org, nathan@kernel.org,
        ndesaulniers@google.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH] USB: serial: quatech2: remove unused qt2_setdevice
 function
Message-ID: <ZC1d850dwMjggbzo@hovoldconsulting.com>
References: <20230321181255.1825963-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321181255.1825963-1-trix@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 02:12:55PM -0400, Tom Rix wrote:
> clang with W=1 reports
> drivers/usb/serial/quatech2.c:179:19: error: unused function
>   'qt2_setdevice' [-Werror,-Wunused-function]
> static inline int qt2_setdevice(struct usb_device *dev, u8 *data)
>                   ^
> This function is not used, so remove it.
> 
> Signed-off-by: Tom Rix <trix@redhat.com>

Now applied, thanks.

Johan
