Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 266586BA4E9
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 02:54:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229616AbjCOByO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 21:54:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjCOByM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 21:54:12 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDAF776AF
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:54:11 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y15-20020a17090aa40f00b00237ad8ee3a0so343656pjp.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 18:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1678845251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=V9x3nWBy4tBaxSkg9Su97HA6+gfPBWicU1zJD5hYG+0=;
        b=6Qg7bqqCVjvOFA/ZAA91vgkMLQEyl1IkEeFxoC3T/WZcXg/dLhd7si5wCstPzq3zmb
         /Z+el1uqWH8pOfSyB8EeHoBUzb6SV1pwDmQ2myOfRqzVYPUjQDOV1w8jnyQhah9W6WDh
         ki+5NmqlDMCctOS3WsJQZww3IwUWIJAQbYcKMbPFemy6zfT243dgZm+nqyAQekahCOtp
         lHcmq5KF3ET/qcqAh7rFOzK5tMM7FEsqkisDkz1yeennCIZEMSiZz4h8KG0ALmtWZgKK
         1zXkYeyJE+hwu/S+P5Uy9IU6dBBzXJKIG4YJXffDi1LyLJEhOKOCeLPSuPtHTJPTHYvS
         jyDw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678845251;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V9x3nWBy4tBaxSkg9Su97HA6+gfPBWicU1zJD5hYG+0=;
        b=h9n9RdDgL5wB4yIeqkQUhXc+rQ0T412K4avOTxMte9CyVcCT9c3Io7Vxzgnc8ROeNI
         Yo1jOTtb9UF/cqfZFJrirY80PvNWJR2H8cwA5hS7Fzn0DtGgD6bPFsUhEojDPnWm3RyR
         wyRTr8WT0nIgx6lr8Ls8nM/IxX6EAcJ3B/KQCIAchKWhpB/YrOSTCBZeIvtFBBO57JQX
         iC9HV0oDg4fAIuUUtakzHXmqVBp4n0AQ0SE2Kh6O3p5cVcVDbAl7+zw6nf/dYQQVnBFF
         VXUd9qKnRbe+7yiOUZoImqw4/rqSpJ6gmW06TEjPu4wp8UciRd9limBbQuksWHdWaL7o
         BBJg==
X-Gm-Message-State: AO0yUKX4gscpdCVXQUc3SKBB46HNYaaGPNflScfA6GX99sWJtrMLGTyy
        poYhiHy9F5PXiaWDTvDkhIQhQg==
X-Google-Smtp-Source: AK7set+1O2Pq/kw2xXzXOTsgejyaxIIXcB6Xmc5X8B9FZO4ISNBBCXYh0IV3Xzs9NK+Lxd/IJOXrgw==
X-Received: by 2002:a17:902:cf4e:b0:19a:a815:2877 with SMTP id e14-20020a170902cf4e00b0019aa8152877mr14755466plg.6.1678845251190;
        Tue, 14 Mar 2023 18:54:11 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id km15-20020a17090327cf00b00194c2f78581sm2345537plb.199.2023.03.14.18.54.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 18:54:10 -0700 (PDT)
Message-ID: <ae41fa86-35e2-58c0-5dd5-0fba9146e803@kernel.dk>
Date:   Tue, 14 Mar 2023 19:54:09 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20230315124830.1c2bd002@canb.auug.org.au>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230315124830.1c2bd002@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/14/23 7:48 PM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> include/linux/pipe_fs_i.h:214: warning: Function parameter or member 'nonblock' not described in 'pipe_buf_confirm'
> 
> Introduced by commit
> 
>   342a048d7390 ("fs: add 'nonblock' parameter to pipe_buf_confirm() and fops method")

Thanks, I'll fix that up.

-- 
Jens Axboe


