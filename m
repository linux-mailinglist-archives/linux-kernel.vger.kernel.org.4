Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E98D26D3845
	for <lists+linux-kernel@lfdr.de>; Sun,  2 Apr 2023 16:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230434AbjDBOST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 2 Apr 2023 10:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230383AbjDBOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Apr 2023 10:18:17 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC92A4207
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 07:18:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6F5BDB80E99
        for <linux-kernel@vger.kernel.org>; Sun,  2 Apr 2023 14:18:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCE42C433D2;
        Sun,  2 Apr 2023 14:18:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680445094;
        bh=fz7rffbHJHElbGaSr0rWltKJ8qv5T/nMbg9/U/QGbR8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=NGDxqod1lu+IQfUhErJqUeKVJC2V2yJcp7v90Q62vCmFN3NzlrwAOS8+2lMQ5qCeL
         nTG5nZT4KYABdXCQPxrKbjZX7hCo0YVBSI39zhZTSTVbiT0H7cwFioOIPe3Em5ANS6
         sOH0uqHZDz/7+rAhPChZJurdLMToHKki4khUksXyy4VpHV4Ilh9ppza8NW8LL8FQZI
         JZbgzwgr4Q/yVfY2LvnXsAoHGkJMAKrCDjUwGQyY0HzS1MjH7Q0wcZi5+V5kGX28Uj
         wDtWEOrPsV5VkkI/BwrpgiFedmTBVIG7RN3KzizmeBsx4vY0drtKclCb7ZXFktgag7
         1vVR8NELY0ZCg==
Message-ID: <cafc34c2-4d55-0a4b-336f-cadf039e21dc@kernel.org>
Date:   Sun, 2 Apr 2023 22:18:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] f2fs: fix align check for npo2
Content-Language: en-US
To:     Yohan Joung <jyh429@gmail.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, Yohan Joung <yohan.joung@sk.com>
References: <20230402031259.286-1-yohan.joung@sk.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230402031259.286-1-yohan.joung@sk.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/4/2 11:12, Yohan Joung wrote:
> From: Yohan Joung <jyh429@gmail.com>
> 
> Fix alignment check to be correct in npo2 as well
> 
> Signed-off-by: Yohan Joung <yohan.joung@sk.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
