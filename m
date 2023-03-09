Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A5B46B26F1
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:34:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231715AbjCIOen (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:34:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230387AbjCIOel (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 09:34:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD0D4ECC0
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 06:34:40 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0A1A6B81F4B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 14:34:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 085EDC433D2;
        Thu,  9 Mar 2023 14:34:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678372477;
        bh=ZsnqhLeziSj/YtY1oiLcjsHq/QNNk3mZ9dJ9Pt4h/ng=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=sQoKF2uX7GbyTVc/Pr2PeE1QT3nPbvZF+Y+F7cEOrqQHjgItkt1f2bAAHf9ydq26T
         XrIIQ95xwSeGTa0eXY/Fs4XMlQq77DgbZCgR68c3WOXszRmozUiwM8QVMpoeZ/K9UK
         Mw/Mfl4QUf8W0S3yNq69LQNux/zy+0BAbx/WoL5ji9Nxio5hGyysunQsT70aUgcWAX
         VucYSy2r8kXoi0HpLoix+aqGzosa8o1jtuHNuJOgQp3X4doPGb+BU2lU1FGKlb0hFH
         2NrB6qD7kzIhlfxAfvVidHyAUy7CHM0qSNwOWCiQm2PhPKuxEqcQRgk1g3/H1z4uEA
         79fB2mHqt35Qw==
Message-ID: <56992244-f656-8945-94d1-801223530259@kernel.org>
Date:   Thu, 9 Mar 2023 22:34:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] erofs: get rid of an useless DBG_BUGON
Content-Language: en-US
To:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        linux-erofs@lists.ozlabs.org
Cc:     LKML <linux-kernel@vger.kernel.org>
References: <20230309053148.9223-1-hsiangkao@linux.alibaba.com>
 <20230309053148.9223-2-hsiangkao@linux.alibaba.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230309053148.9223-2-hsiangkao@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/9 13:31, Gao Xiang wrote:
> `err` could be -EINTR and it should not be the case.  Actually such
> DBG_BUGON is useless.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
