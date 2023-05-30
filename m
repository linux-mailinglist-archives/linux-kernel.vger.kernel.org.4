Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B3AB371530E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 03:52:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229656AbjE3BwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 21:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbjE3BwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 21:52:02 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 775D7DB
        for <linux-kernel@vger.kernel.org>; Mon, 29 May 2023 18:51:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 05A0E6293C
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 01:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2831CC433D2;
        Tue, 30 May 2023 01:51:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685411517;
        bh=ReN2zhudjKLiRnbxWFv3XyZ1DZM3aQ+PwJvVpX8b2bc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pahBLZL0lYOWj/oK2HjxKx2UVR0ssEdHSeXFLNHWp2qYBB1xaesKInwu0WIj03WMT
         XttlqJWfXVMvKnL6vIsAQhxRicFXVK3hzBbBG6XnQnzYG1LEsIQ/AxQVFeWngOZAdp
         cN/2ZGjosw93DaAc+mOUdznu8dScAXVU082wrcFKizetC00/TpKLscz7s02MGnIQSu
         8a1h3JZChJy+KeO8JQIdWMjrHhlA7lz7MXAQngrHf6fF+r5Yz+5x5uYHsz9Ejtdop5
         wlLiJNUOsI9BlVx/O3oplZz7OLmXR/eOEqjZIzaqhGMhtN80ebllNCdCZEH7FU1SXg
         X/PUdn/sFWSLg==
Message-ID: <9cd28186-4213-b900-23e7-24581e748479@kernel.org>
Date:   Tue, 30 May 2023 09:51:53 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 1/1] f2fs: fix args passed to trace_f2fs_lookup_end
Content-Language: en-US
To:     Wu Bo <bo.wu@vivo.com>, Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org, wubo.oduw@gmail.com
References: <20230530012118.74228-1-bo.wu@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230530012118.74228-1-bo.wu@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/5/30 9:21, Wu Bo wrote:
> The NULL return of 'd_splice_alias' dosen't mean error. Thus the
> successful case will also return NULL, which makes the tracepoint always
> print 'err=-ENOENT'.
> 
> Signed-off-by: Wu Bo <bo.wu@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
