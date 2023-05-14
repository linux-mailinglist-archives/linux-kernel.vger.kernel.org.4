Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80E55701BFB
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 08:33:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233014AbjENGdK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 02:33:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjENGdH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 02:33:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C40EA1FF2
        for <linux-kernel@vger.kernel.org>; Sat, 13 May 2023 23:33:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 590E760FBB
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 06:33:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6FE55C433EF;
        Sun, 14 May 2023 06:33:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1684045985;
        bh=0H0QpCOFgRPnk7q/AXlWAjR4u5GPYVQ66kT7i58zt40=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=DjVInvHCA+JpE73QxJ9TzWz+qWT+j8Vae1JnT3aSA8enN3vY7Qv7ItS9vXRc+bS+O
         EvziSoqX4x+4v45N39yA2AYuNrWN7dWWCSMluyCBskbqFS6E+4EojF239uMDbdjenW
         jQ6bzd7aRGIXFd5z2VUUp+zNAZ575hBauOdW/H2k=
Date:   Sun, 14 May 2023 06:40:25 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Deepanshu Kartikey <kartikey406@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Staging: rts5208 :rtsx : fixed  a brace coding style
 issue
Message-ID: <2023051433-skies-hastily-71a1@gregkh>
References: <20230514030940.4820-1-kartikey406@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230514030940.4820-1-kartikey406@gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 14, 2023 at 08:39:40AM +0530, Deepanshu Kartikey wrote:
> Fixed  a coding style issue

And you added another one when doing so :(

Please be specific about what you are fixing, and look at your use of
spaces in the subject and in the changelog text to verify it all makes
sense.

Please fix up and submit a new version of this change.

thanks,

greg k-h
