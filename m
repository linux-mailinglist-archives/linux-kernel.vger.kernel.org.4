Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B27F86422F6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 07:18:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231651AbiLEGS4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 01:18:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231239AbiLEGSu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 01:18:50 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4BB5DFEC
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 22:18:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 34AD460F64
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 06:18:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 995A9C433D6;
        Mon,  5 Dec 2022 06:18:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670221128;
        bh=W33NQFED21c+6UVqfmxS3Py544P8P6AaTZgzm21x5xo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ZI0BVErdNz6S3GY+S1GvVTKarxwpU8wiqJa3zFwHVZO6g1qDAy7EDQJO5kg5xE9sk
         3TQttRYx24UuXXEbnThaFcoJHbt6bUHXNjOSBGGaniK85qHxnQHbxhAcPZ39UjaYYW
         snQNq3ILOyofYAe2LEQ0CdIf2XCf9ts9oANlhs/f36XCL1m/3ftUFvWrWmqc3N/EL2
         +jZ7wh+0SXpMNKhkRjOjOPJke1SXaU9HWR5aP2op1flCtXzlWKW8/VAssL901VUb8G
         1N6yth0YFC7P2F20nhBO9zPi1Zo0Ps+HoT0Lt5TA15kI/8hnyNBSTIY1c4wJoVVHLu
         rcEQVeTFKgZwA==
Date:   Mon, 5 Dec 2022 14:18:45 +0800
From:   Tzung-Bi Shih <tzungbi@kernel.org>
To:     ye.xingchen@zte.com.cn
Cc:     bleung@chromium.org, groeck@chromium.org,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] platform/chrome: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <Y42NRVo9BH+EWpiF@google.com>
References: <202212021656040995199@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212021656040995199@zte.com.cn>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 02, 2022 at 04:56:04PM +0800, ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> Signed-off-by: ye xingchen <ye.xingchen@zte.com.cn>

Fixed the commit message a bit and queued the patch.

Also, I found a little more here: https://patchwork.kernel.org/project/chrome-platform/patch/20221205061042.1774769-1-tzungbi@kernel.org/
