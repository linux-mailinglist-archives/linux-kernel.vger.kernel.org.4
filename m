Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26BD2647222
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 15:46:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbiLHOqg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 09:46:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbiLHOqa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 09:46:30 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2739B788
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 06:46:26 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A8CCBB822DD
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 14:46:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6513C433D6;
        Thu,  8 Dec 2022 14:46:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670510784;
        bh=SQDouDcc+xCO7nvBwL6upRwe7Ke31Oyl2pa3FlKFdcc=;
        h=Date:Subject:To:References:From:In-Reply-To:From;
        b=eX3kbkreiZ9ixIL8Wp4d+SdUay/ywx1wAypQTlBLwuuJ2ClrhaPDHwYXpueVbLeZy
         u0xZEIL1eVQInz+dEQORUL9Zw/ctccyMOKct2c8IFdnGxC03TtouczpU0hPaLkvVJa
         h0FpBf6A/CnP9eiwckh/tP6HlNxpq2qHLIv+a6+OEYc2vAnyWPifke1KhBOYk1AV/E
         bsCkqLNkC6axHkAzkPx5Yrn2B3XRIanmunIP4eT4LVQ+q6QzcCOSpr/f9DTp5HBjo2
         MjWRwJymjFikwGAcIYFCh5UwB8MMCgvv9d654+2fMMzV5r+c6f1vVGIDyBbdekYdr2
         nWKlqy7mXypbQ==
Message-ID: <bd4ad040-8a9c-5bfa-fad5-22ab5cc861d4@kernel.org>
Date:   Thu, 8 Dec 2022 22:46:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [f2fs-dev] [PATCH 2/6] f2fs: move internal functions into
 extent_cache.c
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>, linux-kernel@vger.kernel.org,
        linux-f2fs-devel@lists.sourceforge.net
References: <20221205185433.3479699-1-jaegeuk@kernel.org>
 <20221205185433.3479699-2-jaegeuk@kernel.org>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221205185433.3479699-2-jaegeuk@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/12/6 2:54, Jaegeuk Kim wrote:
> No functional change.
> 
> Signed-off-by: Jaegeuk Kim <jaegeuk@kernel.org>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,

