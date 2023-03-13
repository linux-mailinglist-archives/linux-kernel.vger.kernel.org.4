Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2DC96B6F60
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 07:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229726AbjCMGLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 02:11:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229655AbjCMGLS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 02:11:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEB3342BC6
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 23:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 2FBEC61062
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 06:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6EA3CC433EF;
        Mon, 13 Mar 2023 06:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678687874;
        bh=M71ZgoxDEaJTFCv9qREabe0T9N5RycER19GdQFWzbI8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=beUYWcxOBI/bMBoLACq41rtJTHvWko0t1YY2YLj5gj4hMpx36WEov3F/6ZlzOT3p/
         evNnrbDADol2psYbO2lGfHx51GMtZ81Osx1LkAp40397Ejt/anxzF4G5R+dKpHa9cs
         zZv1lDXDJFytXGksVcuJrdiGMa/rIbVviQ0uPko2OqUid7faTQx06L+wDSHRwEmeib
         K/TUtUYo0u9O33eE8iG7OlCX3j9CrEGe3wMMlK8+iIVrNfBitjiCoXF4zN4HijadBy
         W4ougqdYUT54M6Qlk6k1MDdU70sdBsSh+QUgpQNckKPo0eA2WFxYc+Rzr8wsnkm7X0
         r66H8IJfJ5OrQ==
Message-ID: <67687aed-df8e-4264-57fd-f19dcc36ae10@kernel.org>
Date:   Mon, 13 Mar 2023 14:11:10 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v2] f2fs: fix uninitialized skipped_gc_rwsem
Content-Language: en-US
To:     Jaegeuk Kim <jaegeuk@kernel.org>,
        Yonggil Song <yonggil.song@samsung.com>
Cc:     "linux-f2fs-devel@lists.sourceforge.net" 
        <linux-f2fs-devel@lists.sourceforge.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "daehojeong@google.com" <daehojeong@google.com>,
        Seokhwan Kim <sukka.kim@samsung.com>,
        Daejun Park <daejun7.park@samsung.com>
References: <CGME20230215024850epcms2p22be2cc864d82b44f31c19a7ef28770b6@epcms2p7>
 <20230216071350epcms2p7b3f5f37b168b634ec7a7ba8555fd0b49@epcms2p7>
 <ZAZgf4sbh14sVZMp@google.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <ZAZgf4sbh14sVZMp@google.com>
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

On 2023/3/7 5:51, Jaegeuk Kim wrote:

> Applied with the below fix.
> 
> Fixes: 6f8d4455060d ("f2fs: avoid fi->i_gc_rwsem[WRITE] lock in f2fs_gc"

')' was missed.

> 
>> Signed-off-by: Yonggil Song <yonggil.song@samsung.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
