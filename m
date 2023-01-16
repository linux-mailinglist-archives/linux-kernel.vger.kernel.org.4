Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5DF2366C6D0
	for <lists+linux-kernel@lfdr.de>; Mon, 16 Jan 2023 17:25:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233134AbjAPQZT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 Jan 2023 11:25:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233074AbjAPQYq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 Jan 2023 11:24:46 -0500
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34FB2B608
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:13:29 -0800 (PST)
Received: by mail-pj1-x1036.google.com with SMTP id bj3so26362824pjb.0
        for <linux-kernel@vger.kernel.org>; Mon, 16 Jan 2023 08:13:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ssed8DInnM71XIc+teZFBrxTcFsJv8I7y0kSbwsq6vs=;
        b=x4lpgeaDP+yUy/FbvwgImDpEdigIEFkLxiDZXJ0MRC2ObvpA5Tz4eHrkcmqGtpAuOd
         fhdoFHZ1NFbUyNo98zbyjta8YhU3+fpr+NBXlAGuhBY/W+wfTd8mcp309FHTuLTOkCWw
         7Qjs7uJAD346BIEURjQOMlrzIkIKizkwR2b9gkKLSMj4UUtdHdZqnSPVZyzUKhRLZgls
         SYW708El2/NXNVcM1RLeCFCUIiEp/2DPkELYk9HyYWpipocoZNOePUPcqX31Mt9Kb+iG
         A5bFoMbO/rn7BJKLrTGKdnCV8z+97uqbshh+So/G3K0cV8Ot8hQCe1PkAKbhQAU6vmFZ
         hOog==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ssed8DInnM71XIc+teZFBrxTcFsJv8I7y0kSbwsq6vs=;
        b=i6+yYcrhto/llpW+9Tp6K+Hu30O3BhIgb7eGSVfa9H8FQtJhomTa4UEvYGLfbK1EYd
         U7GonpRx0dbncgyT8BnU7mgXiqFs95wWeBs2sSiiG8X13Ct7uhEBHvbsT9r9+RvJ0I5N
         VWRczVfjRd5Edy/aT/IcnpnlKG4IJfNka8eaOj2/3ZABhi0gZ/L4tr4MANTq+9ZB4+sm
         0aUiPchrNCP4azzUXvMnMcJEBCfDGwbjaBk4eFiVkMBM47qfmW1f0Q4kM+1+Kr4rW2bI
         /AxGIivVHGf0ZupENtdDL64wgGFZexFVderO82hskhxggozYqH3jG8HOCBFN/5SWrMji
         2hIw==
X-Gm-Message-State: AFqh2krZuKHi5gWh2pM0CJtvN0LFFC6thkRSfT8sckm6G2G6wWw55UmK
        qzfn4t12IEIP7HGoAkrpBOihE8yDqCAF+YHf
X-Google-Smtp-Source: AMrXdXvOKWDmjx28jzODhYsUmgL8fT/rw9O/J8ZugsIQukSEBPi+pJIu01/qfJZlC5XNitaNIwftYg==
X-Received: by 2002:a17:902:9681:b0:194:4c4f:e965 with SMTP id n1-20020a170902968100b001944c4fe965mr85982plp.0.1673885609142;
        Mon, 16 Jan 2023 08:13:29 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bc2-20020a170902930200b00186a437f4d7sm19537047plb.147.2023.01.16.08.13.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 16 Jan 2023 08:13:28 -0800 (PST)
Message-ID: <d1244b25-9ae6-33b0-e6b7-3e3c463b1224@kernel.dk>
Date:   Mon, 16 Jan 2023 09:13:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 07/14] blk-mq: make blk_mq_commit_rqs a general
 function for all commits
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>,
        Kemeng Shi <shikemeng@huaweicloud.com>
Cc:     dwagner@suse.de, hare@suse.de, ming.lei@redhat.com,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com, jack@suse.cz
References: <20230111130159.3741753-1-shikemeng@huaweicloud.com>
 <20230111130159.3741753-8-shikemeng@huaweicloud.com>
 <20230111054520.GA17158@lst.de>
 <c51cbadb-bfd8-5f26-6bc3-5ad975b5db39@huaweicloud.com>
 <e2ba1495-e9a8-8dfc-4eee-d9a2984bc0d2@huaweicloud.com>
 <20230116160958.GB23434@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230116160958.GB23434@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/16/23 9:09 AM, Christoph Hellwig wrote:
> On Mon, Jan 16, 2023 at 09:07:00AM +0800, Kemeng Shi wrote:
>>>> Why?  I think always having the trace even for the commit case seems
>>>> very useful for making the traces useful.
>>> I think unplug event more likely means that request going to be sent to driver
>>> was plugged and in plug list. And the current code do only trace unplug event
>>> when dispatching requests from plug list. If so, would it be better to add
>>> a new event to trace commit?
>> Hi Christoph, which way do you prefer now? Keep unplug event consistent to
>> trace commit of requests from plug list only or trace all commits with
>> unplug event. Please let me know and I will consider it in next version.
>> Thanks.
> 
> To me always having the trace feels more useful, but let's see if Jens
> has an opinion on it.

Agree, that is probably the saner option.

-- 
Jens Axboe


