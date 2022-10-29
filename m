Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843FC612110
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 09:38:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229904AbiJ2HiQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 03:38:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiJ2HiN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 03:38:13 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1BD60E92
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 00:38:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 800F960C99
        for <linux-kernel@vger.kernel.org>; Sat, 29 Oct 2022 07:38:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 83740C433C1;
        Sat, 29 Oct 2022 07:38:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1667029091;
        bh=TXFmIk2R49R5R9V/eeK+lu3Gk0L3bKmdIfyZaChP0AM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jtB0GrVOEBcSfTbEtXj88dmf++U7/JBHu9iQPuWN0EwFH5uVX8vmIV+37H+B95VjS
         IHWz+JxSQf3SV3b526seyopu4gfsB6ZL2gFw/8FXRScu67jzzKvuct7/S+8sYz0DNS
         w4sI+VxVv+sxKnWRTjWX7c0fsxZ7CCwoik1EGlg4=
Date:   Sat, 29 Oct 2022 09:39:07 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH v9 0/6] Checkpatch cleanup in rxtx.c
Message-ID: <Y1zYmxKscLQsk9ZW@kroah.com>
References: <cover.1666995639.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666995639.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Oct 28, 2022 at 11:23:21PM +0000, Tanjuate Brunostar wrote:
> v9: reorganized the changelog messages on this patch

You dropped the "staging: vt6655: " from this 0/X email, why?

Please take a day or two off, relax, and resubmit the series with _ALL_
review comments addressed.

thanks,

greg k-h
