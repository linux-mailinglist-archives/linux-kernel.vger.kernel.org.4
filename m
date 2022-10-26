Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E28060E29A
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Oct 2022 15:52:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233932AbiJZNv6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Oct 2022 09:51:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233812AbiJZNvi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Oct 2022 09:51:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F90A63E3
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 06:51:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AFCC361D77
        for <linux-kernel@vger.kernel.org>; Wed, 26 Oct 2022 13:51:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 86151C433C1;
        Wed, 26 Oct 2022 13:51:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666792297;
        bh=HKTXbklFgkZRcsC9KCxAcDRF1DhW6GsskRH6sDGwdoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TUmSDcH1+dPCaB5/1lDr7wepq/jZSmLYFP94fi90Dk7weU573EjVrO2DqKyLBmK4z
         wbiC8qFflt/alrzUQ53urFGw9D0uqoL/knn+7gb0OQipjTEuA6XRy/0+osyePZfK7w
         qNM6RISbGRSjA3I7RWUrA3q+gKFfvxQyV7IcZpPo=
Date:   Wed, 26 Oct 2022 15:52:29 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tanjuate Brunostar <tanjubrunostar0@gmail.com>
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        outreachy@lists.linux.dev
Subject: Re: [PATCH 02/17] staging: vt6655: changed variable names:
 s_vFillRTSHead
Message-ID: <Y1k7nY8LnibU5lMh@kroah.com>
References: <cover.1666740522.git.tanjubrunostar0@gmail.com>
 <8afb904f9fb22a262b3563d5cfc5804863bfb5ea.1666740522.git.tanjubrunostar0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <8afb904f9fb22a262b3563d5cfc5804863bfb5ea.1666740522.git.tanjubrunostar0@gmail.com>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Oct 25, 2022 at 11:36:58PM +0000, Tanjuate Brunostar wrote:
>     change variable names s_vFillRTSHead and wTimeStampOff to meet the
>     linux coding standard, as it says to avoid using camelCase naming style.
>     Cought by checkpatch

s_vFillRTSHead is not a variable name.  It is a function name, and ick,
that's a horrid name, please make it sane (i.e. do NOT put the type of
the function in the name like they did here.)

thanks,

greg k-h
