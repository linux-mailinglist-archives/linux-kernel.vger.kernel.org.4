Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98A4766117F
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232494AbjAGULi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230092AbjAGULa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:11:30 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 206F1C1
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 12:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673122286; bh=2jAWUHpZvG9WVuKVdH4/vwk9rrSIoQjgFwnQvFJzt2s=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=IYYpVMBy5dmCuZ4rVG8wPfx8XAqDH3bEm3Do3QGYY3GQ/l/ZxChDCNeIwcS2YkSkw
         voZ+Wd79S12PZjrqYdBCPfpRohUKuEwf59r48qRdSx4ERm7e/iVhNJkyDamn49YdG6
         +h7eUmbYfxRYY1Jw/lDgqe8qmnZ2JPZ763rCoX5o=
Received: by b-2.in.mailobj.net [192.168.90.12] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  7 Jan 2023 21:11:26 +0100 (CET)
X-EA-Auth: 4l5+Xe6Ly/VAYW6moYYL7Yx7Ru1d5vZaMwThYkslI9LWlt5Jg0CSvmdYol5TWm30bYf01yHcJhqI5GGdVLA26iavnqIHHJLm
Date:   Sun, 8 Jan 2023 01:41:18 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Evgeniy Polyakov <zbr@ioremap.net>, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] w1: Use kfree_sensitive to clear sensitive information
Message-ID: <Y7nR5iBW3fdvVhFO@ubun2204.myguest.virtualbox.org>
References: <Y6TcmtlRvvblvL2f@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6TcmtlRvvblvL2f@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 04:09:22AM +0530, Deepak R Varma wrote:
> Replace combination of 'memset(0) + kfree()' by kfree_sensitive() as it
> prevents compiler from optimizing away from zeroing out memory at the
> end of a scope. kfree_sensitive() is also safe in case the memory
> pointer turns out to be null, which simply gets ignored.
>
> Issue identified using kfree_sensitive.cocci coccinelle semantic patch.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello,
Requesting a review and feedback on this patch proposal.

Thank you,
./drv


