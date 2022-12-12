Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1876464ABD9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Dec 2022 00:55:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233744AbiLLXzg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 18:55:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229944AbiLLXz1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 18:55:27 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [217.70.183.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D448514D16;
        Mon, 12 Dec 2022 15:55:26 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id EB5BA240005;
        Mon, 12 Dec 2022 23:55:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1670889325;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9ePabqc+7cC0/UaZKrAYhyBgYRi0kbDxozWzURzMwUw=;
        b=mmv5VaQMh/vMpCRGByESBoQX2M3D239kNVz4lI1tZgEP+rsEbp+Wiq0ejw7ZrpuyFMZsQ9
        xNCa1B+RWYZzFAdewbD8yK+JqfiMtqSjSjRHPBtnTfid9nKyPslIO9SxB8XmnMxprjJqmh
        wLHQRMqdcJAH52szUixa/36HCGBYsHl5gZCEJq5BlVqM+/GoN2P9FUgzvgnsuADpnjKnkp
        aZE41hbIYr6FsLJQCUF1e42y2C0LbBAi5loOVQRVdumJPwRza6QSl27Hihw74BJ2eDgL/y
        taR/zZNVaKGblP8CbfotOOQ1pWrYidvWv9j1oHxKz15NvEUURqH58rvh91lYZg==
Date:   Tue, 13 Dec 2022 00:55:24 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     ye.xingchen@zte.com.cn
Cc:     a.zummo@towertech.it, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org
Subject: Re: [PATCH linux-next] rtc: ds1307: use sysfs_emit() to instead of
 scnprintf()
Message-ID: <167088930337.313278.11105022204603125591.b4-ty@bootlin.com>
References: <202212051134455911470@zte.com.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212051134455911470@zte.com.cn>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 5 Dec 2022 11:34:45 +0800 (CST), ye.xingchen@zte.com.cn wrote:
> From: ye xingchen <ye.xingchen@zte.com.cn>
> 
> Follow the advice of the Documentation/filesystems/sysfs.rst and show()
> should only use sysfs_emit() or sysfs_emit_at() when formatting the
> value to be returned to user space.
> 
> 
> [...]

Applied, thanks!

[1/1] rtc: ds1307: use sysfs_emit() to instead of scnprintf()
      commit: 20ff2be9cf5c1951e5a14e570129cf118039a25a

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
