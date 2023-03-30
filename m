Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C53FF6D04DC
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 14:36:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbjC3Mgk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 08:36:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230019AbjC3Mgi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 08:36:38 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB47A8B;
        Thu, 30 Mar 2023 05:36:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6C7F3B828A2;
        Thu, 30 Mar 2023 12:36:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA578C433D2;
        Thu, 30 Mar 2023 12:36:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680179779;
        bh=apjuJydxqBhPZhcIQdOGZhWg7a9aRiJmg/9aojOU6Xs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RXaFiCOOxBKkVMcldHGDcX6733J33G2LEWE5xW6ucRxTHIWhm0oq7BtWWwcJY5q2p
         WE+0gRNRZNf5aON1M4JNrLmVbZLA5vPBvtvc8P06F66dRMmP/6iNHaKtiwlWgPWQAZ
         9sv3/AoChFrvBnml58hsP8OwG9JTFmSU2kCJCJoONWE+6K8H6GT5+wDflwAm/HyphD
         8ckzN2KJfBwpd1bqPij40bRNUC6y8t3UM8ZqRKJ+YIVbQYsXnNmPpehopi7v4rV8qh
         KjRfAn8Pi02/WqTe5a9tedvFFrPxjklyudHWPscom1ReRc41Y9PT+1RFi/aSN8ih5q
         mmLMdszS/4DUA==
Date:   Thu, 30 Mar 2023 13:36:14 +0100
From:   Lee Jones <lee@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     tony@atomide.com, nathan@kernel.org, ndesaulniers@google.com,
        linux-omap@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] mfd: omap-usb-tll: remove unused usbtll_readb function
Message-ID: <20230330123614.GH434339@google.com>
References: <20230322125803.2570968-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230322125803.2570968-1-trix@redhat.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Mar 2023, Tom Rix wrote:

> clang with W=1 reports
> drivers/mfd/omap-usb-tll.c:128:18: error: unused function
>   'usbtll_readb' [-Werror,-Wunused-function]
> static inline u8 usbtll_readb(void __iomem *base, u32 reg)
>                  ^
> This function is not used so remove it.
>
> Signed-off-by: Tom Rix <trix@redhat.com>
> ---
>  drivers/mfd/omap-usb-tll.c | 5 -----
>  1 file changed, 5 deletions(-)

Applied, thanks

--
Lee Jones [李琼斯]
