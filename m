Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28518665CB2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 14:34:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238898AbjAKNd3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 08:33:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239202AbjAKNcc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 08:32:32 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B3849266A
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 05:30:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 22AA5CE1B6E
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 13:30:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A2ABC43396;
        Wed, 11 Jan 2023 13:30:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673443816;
        bh=yqVgwWvB4/KMucLBOLI63/hATRZpVbXQMLtw0697zJI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=FuWmDJHbYuPi3yPnixcamijaM6M03H1GVoryiqGjS30zSx82mZxgh1i85zC5k1sOl
         R/7jvsJqf4Y65BMFEWKPJ5GtcJUDCqE1iiEOzH8q/o5uJ/zeBcJQxu495xXVwB/XcM
         bGZvd/RWHTVbyv/Lam7RCYRPVsJV3wfFwgxXJjKBjlCEVizBphfl4pJMGblGyvQVu0
         IKp6wJiuD3s5UwkfirWXn/yfEGE2EHDsUT0NdqVAsdp44XkrZrQtdWDYJBj7Op2wx7
         V2XP8OKZ31EOV/pgGRJOhqK9kfU+SGJ0oYT2ayn4JeCmQVLOnaBCWDhhxDdWd9tJXv
         Orsd3For0y6EQ==
Message-ID: <aed2e21a-84b1-667f-c194-dda01bdaef6c@kernel.org>
Date:   Wed, 11 Jan 2023 21:30:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] f2fs: update comment about f2fs_issue_discard_timeout()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20221220185459.55950-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20221220185459.55950-1-frank.li@vivo.com>
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

On 2022/12/21 2:54, Yangtao Li wrote:
> After commit 4d67490498ac ("f2fs: Don't create discard thread when
> device doesn't support realtime discard"), f2fs_issue_discard_timeout()
> is not only called by f2fs_put_super().

Actually, it also comes from error path of fill_super().

We don't need to update this comments all the time, how about removing
this since it's trivial.

Thanks,

> 
> Let's update it.
