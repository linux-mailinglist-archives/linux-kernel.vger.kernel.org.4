Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A3AD675658
	for <lists+linux-kernel@lfdr.de>; Fri, 20 Jan 2023 15:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230131AbjATOJU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 Jan 2023 09:09:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjATOJS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Jan 2023 09:09:18 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3019ABCE10
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 06:09:18 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BBFA461F7F
        for <linux-kernel@vger.kernel.org>; Fri, 20 Jan 2023 14:09:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19677C433D2;
        Fri, 20 Jan 2023 14:09:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1674223757;
        bh=PjuMatcChQbPdhII6R/88Er6YBM1MSQYQbZBWOMCv0A=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=txgD0c2aSps7I0PeevJd5PAdxpmQMEhHtwS/xRE8kB91slBH96Tt1GnbK6szcfVSl
         5Azo9pQec/8IU8xomVf0qfDmhu6k2kIWyZh770Xr+DcdUzkJfwajT90naMWuBJNMFW
         tLAMLgLbDlW8YKVuSi7Dom0nsosmgcjNuohF73w1LTTtbelZlWNcJIVVw60RNiWu+e
         JJCRZlszE3NxXzZpsHzD6wzK88SjrzjqK4rsuuzkDIU29/CMFbNcCwo4YLjLe/Y4ge
         TROYxXolcHOUw/gvcYLk0ieTmb+qwFhzlcPApfpwLlGhQ9RmyzuHDFxK9FJcsQ1Ywr
         m0alPvRlGpLpg==
Date:   Fri, 20 Jan 2023 14:09:11 +0000
From:   Lee Jones <lee@kernel.org>
To:     Arnd Bergmann <arnd@kernel.org>
Cc:     Robert Jarzmik <robert.jarzmik@free.fr>,
        Daniel Mack <daniel@zonque.org>,
        Haojian Zhuang <haojian.zhuang@gmail.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Arnd Bergmann <arnd@arndb.de>,
        Philipp Zabel <philipp.zabel@gmail.com>
Subject: Re: [PATCH 27/27] mfd: remove htc-pasic3 driver
Message-ID: <Y8qgh+A1GDy3I5kc@google.com>
References: <20230105134622.254560-1-arnd@kernel.org>
 <20230105134622.254560-28-arnd@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230105134622.254560-28-arnd@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 05 Jan 2023, Arnd Bergmann wrote:

> From: Arnd Bergmann <arnd@arndb.de>
> 
> The htc-pasic3 MFD device was only used in the PXA magician
> machine that is now removed, so this can be recycled as well.
> 
> Cc: Lee Jones <lee@kernel.org>
> Cc: Philipp Zabel <philipp.zabel@gmail.com>
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
> ---
>  drivers/mfd/Kconfig            |   9 --
>  drivers/mfd/Makefile           |   2 -
>  drivers/mfd/htc-pasic3.c       | 210 ---------------------------------
>  include/linux/mfd/htc-pasic3.h |  54 ---------
>  4 files changed, 275 deletions(-)
>  delete mode 100644 drivers/mfd/htc-pasic3.c
>  delete mode 100644 include/linux/mfd/htc-pasic3.h

Applied, thanks

-- 
Lee Jones [李琼斯]
