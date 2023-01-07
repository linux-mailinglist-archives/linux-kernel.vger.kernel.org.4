Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0585666117D
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 21:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232653AbjAGUKF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 15:10:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbjAGUJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 15:09:48 -0500
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D4E21AD8D
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 12:09:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1673122179; bh=YLQN1N9pihHAMf/zPpPhdNCRrp7JZhMqhZrFNGqFCOA=;
        h=X-EA-Auth:Date:From:To:Cc:Subject:Message-ID:References:
         MIME-Version:Content-Type:In-Reply-To;
        b=WPlK/TzmPkFIKvCTSw0gvRo8HkMakaZ02kRqbma1ZjobJwvMLIGby59M6lE7iE55b
         4a5O7gsRybdrrEDP8l2C5z+scr+WoPZc0Kzge1PGGFQgUrqoA/uxMlKN5kA4+m4mQv
         G2tst9k8cOe8deQBx1uA9lJjv4xLf1WuhZ/bkJ9A=
Received: by b-3.in.mailobj.net [192.168.90.13] with ESMTP
        via ip-206.mailobj.net [213.182.55.206]
        Sat,  7 Jan 2023 21:09:38 +0100 (CET)
X-EA-Auth: OKIrZ39R0cxkfSoB8rZ3cbEymhSiYYRsf2Ge4ZAJPNVBogv6yPdBfIWwKDQ+fcdWWcucLzl1+F3zAqBv1n32/7nTHA8/h5BJ
Date:   Sun, 8 Jan 2023 01:39:25 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     Felix Kuehling <Felix.Kuehling@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc:     Saurabh Singh Sengar <ssengar@microsoft.com>,
        Praveen Kumar <kumarpraveen@linux.microsoft.com>,
        Deepak R Varma <drv@mailo.com>
Subject: Re: [PATCH] drm/amdkfd: Use resource_size() helper function
Message-ID: <Y7nRdaDtptxE8Rwd@ubun2204.myguest.virtualbox.org>
References: <Y6TI1O9adSP/OrnT@qemulion>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y6TI1O9adSP/OrnT@qemulion>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 02:45:00AM +0530, Deepak R Varma wrote:
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



