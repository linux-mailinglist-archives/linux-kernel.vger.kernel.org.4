Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A9A665BEC
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 13:59:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbjAKM7d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 07:59:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231820AbjAKM7L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 07:59:11 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C2A81C4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 04:59:11 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BC656B81BDF
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 12:59:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A26C1C433EF;
        Wed, 11 Jan 2023 12:59:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673441948;
        bh=OAonq7L5C7h3Xoo6q19gjPkLzGp0g1x2P9DhUt1v8hI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GV3BX3Is8fihkER4CBDTPRxoH1npx49IA5MwgoZNJ/pTM2WVicgW13s5H60VOXhss
         jO5Tu+CrP2EblZBd/nNmX0XdgIHEhn6NcArebCVLqTEzd/vdfIr4J4A+d1A9s1gc1e
         AramKK0FpWGHVWVry5CngLVJOm1z6oj4aFQLgv1K1O+JJBLDr5GChu3F8RGtQX64Vy
         /W4VEz/me4m5/g7OxN3SsX828F7jgWJaGJRHiLMXgXfAVUoC4mht8SZmnt1Lhz0muo
         Hx6bUmsGdbyZg8IC+4Egeq4MPhBmYWEromzjcM70SgMg2ktJdMuTac+g/E3vpzbAgi
         yxBNgRK5r1gwg==
Message-ID: <25f7845d-5bf6-7948-d063-747186ff0d74@kernel.org>
Date:   Wed, 11 Jan 2023 20:59:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] MAINTAINERS: Add f2fs's patchwork
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221216024506.77048-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221216024506.77048-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/16 10:45, Yangtao Li wrote:
>  From now on, f2fs also has its own patchwork link, thanks to Jaegeuk
> for starting this tool!
> 
> Let's update it to f2fs entry.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
