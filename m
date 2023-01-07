Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 702E966117E
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:10:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232634AbjAGUKp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:10:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGUKm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:10:42 -0500
Received: from msg-1.mailo.com (msg-1.mailo.com [213.182.54.11])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F3741AD8D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 12:10:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673122220; bh=hAjillLEKOx2KmC7SP1Nia4Gp6cK8M5rjgl3kDoyrUE=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=f56d3kd2p+l3ftFIVwSlWkwZZPVE1FAFzBM31XqhT7auIGo92pwG+k/WVNF0pTHKr
         gTj1XBUbINpYY0EeTLxSYLSHtzFXpdTiICRX6PUjNZ/InWGxUy6krB55dUZV5IvMyD
         QaLYZ3pWOO+PUwArT1rJ7PBJITVPfut0JfccPFWw=
Received: by b-5.in.mailobj.net [192.168.90.15] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  7 Jan 2023 21:10:20 +0100 (CET)
X-EA-Auth: b7pO3chvbNWR4+eUZY0WKsgCt5PFeQvNz7SvHGCWIGrrx7unZhEvVtsYX06rlAeLm12NYV7HCNgXeELGGaee3Ey4ky9N9a9W
Date:   Sun, 8 Jan 2023 01:40:12 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Yinbo Zhu <zhuyinbo@loongson.cn>, loongarch@lists.linux.dev,
        linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] soc: loongson: use resource_size() helper function
Message-ID: <Y7nRpEQSYRkZk3kw@ubun2204.myguest.virtualbox.org>
References: <Y6TM4ZidDExh8SPx@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6TM4ZidDExh8SPx@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 03:02:17AM +0530, Deepak R Varma wrote:
> Use the resource_size() function instead of a open coded computation
> resource size. It makes the code more readable.
>
> Issue identified using resource_size.cocci coccinelle semantic patch.
>
> Signed-off-by: Deepak R Varma <drv@mailo.com>
> ---

Hello,
Requesting a review and feedback on this patch proposal?

Thank you,
./drv


