Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219336C6C30
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 16:22:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232105AbjCWPWF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 11:22:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232100AbjCWPWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 11:22:01 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2517D2E835
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 08:22:00 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D6DCEB81C67
        for <linux-kernel@vger.kernel.org>; Thu, 23 Mar 2023 15:21:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A68B4C433D2;
        Thu, 23 Mar 2023 15:21:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679584917;
        bh=YvVGKCdwQu+XxQ/xz4BpccBC+1S6ABeihvmlP/NHXcs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GhvzEMrE7FW3uFrKxxKzEi4uVsoIOIoH9LGEbPtLI2AbBfHfRkqobbr0pJbfgyYkC
         4p8KHqzmxllt2n0gQK5O4FeV0Hl/lkeSWhKjrGiOpHk3h4FHKqu4GL5j8V2xpnM7t8
         75opAcCa4zzDhzfQIg4LEd6foW6UvDJoX5hTd+Ky87OJOY+GcLUhEmtH5dgluT0b3R
         vzrpu5y3wWqdM2CqBL+6lMm9lWNc5ctqA6srqIotSMF0nEpeiKRgihjHopaxJOb+xo
         BqhCV6Sk1Jwpza9w69ZFMTprqr8uj7fIQz4KSgnusH91/7/VjD8T0VFvl5GoCfz6/s
         B/+8VJFddjnxA==
Message-ID: <679df776-6ad0-df80-d00f-30467009ebbe@kernel.org>
Date:   Thu, 23 Mar 2023 23:21:55 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2] f2fs: convert to MAX_SBI_FLAG instead of 32 in
 stat_show()
Content-Language: en-US
To:     Yangtao Li <frank.li@vivo.com>, jaegeuk@kernel.org
Cc:     linux-f2fs-devel@lists.sourceforge.net,
        linux-kernel@vger.kernel.org
References: <20230308140623.35942-1-frank.li@vivo.com>
From:   Chao Yu <chao@kernel.org>
In-Reply-To: <20230308140623.35942-1-frank.li@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2023/3/8 22:06, Yangtao Li wrote:
> BIW reduce the s_flag array size and make s_flag constant.
> 
> Signed-off-by: Yangtao Li <frank.li@vivo.com>

Reviewed-by: Chao Yu <chao@kernel.org>

Thanks,
