Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC36F6D0C38
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 19:07:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231953AbjC3RHV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 13:07:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjC3RHS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 13:07:18 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85BD9D323
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 10:07:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0D803B8299A
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 17:07:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B321C433EF;
        Thu, 30 Mar 2023 17:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680196029;
        bh=fbUrcBtKlIQ8xswo/hpvPxSlZ7vHYTjb2CAUD8tVgk4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aIG8KbFVOauIYqn36aG/SkA60mLdvo2gtAsQaEx+l9j+h80oSLhi7OUgvJda6YipL
         G4xIxfdOqAB7c1FPlB9neyyKlnuhjq0bpNDnx063o8m89kEprC2ptDVfu/en/mJJIG
         ywo6Cvq5rLX0pfxQBYuofgGqeVI3zIg5X4sUiI8vlpAb88Y3ZblK2QwyHEH7PNXnT3
         LYRy2hh1qSfZVKGivL9EO9ifd8j8aYXG2gOEHXU7xoQftnaYFSI8mkCTdPHdwkqNce
         +AA+LNoo0pbKJWWO81a1iNkab+/aKdPaREyu0gkCLKLWahApZstThkUJDPioDmhNdC
         JNChTjgJ8W7hw==
Date:   Thu, 30 Mar 2023 18:07:05 +0100
From:   Lee Jones <lee@kernel.org>
To:     Qiang Ning <qning0106@126.com>
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MFD: dln2: fix memory leak in dln2_probe
Message-ID: <20230330170705.GB548901@google.com>
References: <20230330024353.4503-1-qning0106@126.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230330024353.4503-1-qning0106@126.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 30 Mar 2023, Qiang Ning wrote:

> When dln2_setup_rx_urbs() in dln2_probe() fails, error out_free
> forgets to call  usb_put_dev to decrease the refcount of
> dln2->usb_dev.
>
> Fix this by adding usb_put_dev() in the error handling code
> of dln2_probe().
>
> Signed-off-by: Qiang Ning <qning0106@126.com>
> ---
>  drivers/mfd/dln2.c | 1 +
>  1 file changed, 1 insertion(+)

Applied, thanks

--
Lee Jones [李琼斯]
