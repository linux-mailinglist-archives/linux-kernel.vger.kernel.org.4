Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D4BC6207AB
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 04:44:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232910AbiKHDoH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 22:44:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbiKHDoF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 22:44:05 -0500
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E34723178
        for <linux-kernel@vger.kernel.org>; Mon,  7 Nov 2022 19:44:04 -0800 (PST)
Received: by mail-pg1-x533.google.com with SMTP id e129so12302252pgc.9
        for <linux-kernel@vger.kernel.org>; Mon, 07 Nov 2022 19:44:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wMCLCyI3hZtXF/+wItazbuWkV+QYGcAifqVubozLyYk=;
        b=BnmvNHqflPwI9phHciUytWQTJwsRTtkj1KxnJYIX5lR5H5tIpZirFCGFhlecvSdaDQ
         DtNJd08ijF3C1W3zc3VN9aJaMrIEpro5RWUC45o+ZQZFcs4gQ8kShX9aalf5RbJgCl/s
         dgTEZ7rbSs5OE6D4MrtYd+bZ+gyHLRtlJ45JzINtF2XxIeQt0Gi5UA2+6+1uVq0HNwrm
         6KBuzMyYgAJpAl//WRopmWM+zVE3X9yNG9jpe8ptmHh/oAPhAa4VlKpOfteUekT60v8/
         XkquNNQ92Xc3QTDieBy3hpF+rUv/flI4Wk2n/iPbJ+Diut741TTUzDB+VBXkAIaGQAe/
         RzEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=wMCLCyI3hZtXF/+wItazbuWkV+QYGcAifqVubozLyYk=;
        b=VfHiGFZoL5hNx/CInEW2piSBHI5s4wzk56MgnVuuJX//gX13SLHxbDMP7Z5Iu1rZfK
         ww8ovXUHqeBNuMdy8Y4okmIlUiuxyU/dk30v29DO6312Mt08V7ZN+Zq7txCDJ5t3YNEo
         kXBU4oap1sKij7i4doGZqtoWaTb015qTUiY6gFVR9MWomygpzPi0PVlFldgN+bjwf8p9
         SRvNS1N5o1W66IUkzuwnpqW33MXqlGAoni1FJ5z77lUV+liRRk3SXZAT4QbP61JYHafG
         dZaQERdcRohLuaiPeLLXkw8QGzC8stx+1eAJuD99cXrcc66+fi6R5Xkj5lsUyXlUOgm4
         otwQ==
X-Gm-Message-State: ACrzQf3Se+XxmSwZPGdztHmW2hQMRmwpzYunBPZXXiw299vQoZL/lXrZ
        Q05mvi27hQjyZZf8gKtBe+TjjA==
X-Google-Smtp-Source: AMsMyM64W3vwEqO4HBVkCyFiuyZ8dDJNvWAYn7dEYV00PWb7kBu4s9Z7y7BjOmJa7I//9YQ9IICJ8g==
X-Received: by 2002:a05:6a00:a15:b0:56e:9b2b:60dd with SMTP id p21-20020a056a000a1500b0056e9b2b60ddmr19672290pfh.35.1667879044094;
        Mon, 07 Nov 2022 19:44:04 -0800 (PST)
Received: from [10.255.232.252] ([139.177.225.243])
        by smtp.gmail.com with ESMTPSA id b10-20020a17090a12ca00b0020dda7efe61sm6934662pjg.5.2022.11.07.19.44.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 19:44:03 -0800 (PST)
Message-ID: <0689cf4d-adaa-c783-98e8-ffbe73291ae1@bytedance.com>
Date:   Tue, 8 Nov 2022 11:43:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.4.2
Subject: Re: [RESEND PATCH v3] iommu/iova: Optimize alloc_iova with
 rbtree_augmented
To:     Robin Murphy <robin.murphy@arm.com>, joro@8bytes.org,
        will@kernel.org
Cc:     wangjie125@huawei.com, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org, haifeng.zhao@linux.intel.com,
        john.garry@huawei.com
References: <20220922183114.15135-1-zhangpeng.00@bytedance.com>
 <4a1d000e-e051-5972-bacc-d785ceeed879@arm.com>
From:   Peng Zhang <zhangpeng.00@bytedance.com>
In-Reply-To: <4a1d000e-e051-5972-bacc-d785ceeed879@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> https://lore.kernel.org/linux-iommu/2b0ca6254dd0102bf559b2a73e9b51da089afbe3.1663764627.git.robin.murphy@arm.com/
I don't think this method solves the problem, because sometimes it's 
just that the allocation is very slow, it's not that it can't be allocated.

This is a test of the performance improvement of the network card by 
this patch:
https://lore.kernel.org/lkml/42909903-5b6c-efe8-9ed3-3ac012f1a421@huawei.com/
At least this optimization makes sense.

The only downside of this optimization is that it is more complex, if 
you think it is difficult to maintain it, I can help maintain it.

Thanks,
Peng.

