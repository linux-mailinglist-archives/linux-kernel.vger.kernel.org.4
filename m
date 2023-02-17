Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D565F69B56A
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Feb 2023 23:21:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229684AbjBQWU6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Feb 2023 17:20:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229647AbjBQWU4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Feb 2023 17:20:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 462AC64B00
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 14:20:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F2CAB82E67
        for <linux-kernel@vger.kernel.org>; Fri, 17 Feb 2023 22:20:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE774C433EF;
        Fri, 17 Feb 2023 22:20:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676672441;
        bh=Ci+YtBm+2vVo35FIk9grJV+rpK+o1hDBVw15G6dHE8k=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pd4CjfBSLbhMloMWTuBseMfzuH2JYB2vZse3lrsNFgsNAps8GXcIg+Tg3r3X79DH1
         rV+IPMky74p/WJN4RzUx9Fl71pop/VFXs6ZmfZx1wbQLSlTlFwSA3QiOVqD6WFWxBB
         TbWBgtUh6I7tijoVNHGNnXdTB5SCVgrxlKd3uoT13BPbw7CNQkKQfuokaG5ZspAsbi
         tzibjSE3g1DIGNjZ9Dtr4vaodJzubrjL5qI1vBhND+FYbTlf16A8M/YLDkWM4BKZao
         UriziFydA9ljoGRjyH1AXXh6qztmDv9nm/RtmcXS84kpf3iAWYhy6TmCoY+Xd4uuI0
         5wVtXCtdxKBEw==
Message-ID: <357dd312-a2e8-2bfa-887d-5ba7c7f31fb6@kernel.org>
Date:   Sat, 18 Feb 2023 00:20:35 +0200
MIME-Version: 1.0
Subject: Re: [PATCH] mailmap: Map Georgi Djakov's old Linaro address to his
 current one
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     patches@linaro.org, Arnd Bergmann <arnd@arndb.de>,
        Qais Yousef <qyousef@layalina.io>,
        Vasily Averin <vasily.averin@linux.dev>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Colin Ian King <colin.i.king@gmail.com>,
        Kirill Tkhai <tkhai@ya.ru>, linux-kernel@vger.kernel.org
References: <20230217203516.826424-1-konrad.dybcio@linaro.org>
Content-Language: en-US
From:   Georgi Djakov <djakov@kernel.org>
In-Reply-To: <20230217203516.826424-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17.02.23 22:35, Konrad Dybcio wrote:
> Georgi's old email is still picked up by the likes of get_maintainer.pl
> and it keeps bouncing every time one submits an interconnect patch.
> Map it to his current @kernel.org one.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Acked-by: Georgi Djakov <djakov@kernel.org>

> ---
> Cc: Georgi Djakov <djakov@kernel.org>
>   .mailmap | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/.mailmap b/.mailmap
> index a872c9683958..fb65947d671d 100644
> --- a/.mailmap
> +++ b/.mailmap
> @@ -150,6 +150,7 @@ Gao Xiang <xiang@kernel.org> <gaoxiang25@huawei.com>
>   Gao Xiang <xiang@kernel.org> <hsiangkao@aol.com>
>   Gao Xiang <xiang@kernel.org> <hsiangkao@linux.alibaba.com>
>   Gao Xiang <xiang@kernel.org> <hsiangkao@redhat.com>
> +Georgi Djakov <djakov@kernel.org> <georgi.djakov@linaro.org>
>   Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@de.ibm.com>
>   Gerald Schaefer <gerald.schaefer@linux.ibm.com> <gerald.schaefer@de.ibm.com>
>   Gerald Schaefer <gerald.schaefer@linux.ibm.com> <geraldsc@linux.vnet.ibm.com>

