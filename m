Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B0DC68B3A9
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 02:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229540AbjBFBKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Feb 2023 20:10:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjBFBKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Feb 2023 20:10:47 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E7DC10AB1
        for <linux-kernel@vger.kernel.org>; Sun,  5 Feb 2023 17:10:46 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id n2so7308301pfo.3
        for <linux-kernel@vger.kernel.org>; Sun, 05 Feb 2023 17:10:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=X8koHqYtcGKtK9ShE60+AKTtKz4cqfXuzvfRTgSACa0=;
        b=URtug1Wu5FhPZFWn4UEncRpKJEjVT8KGu4Mv2T/cbdiuEEXvj04wSTdZAHBTiaWrM+
         9iFnqE1CZuMQB4xBQSUuXX6r+MfKwKd4JhaYnzKGB/bOfWct7x+TC/+5RbygsDP+MDNs
         rW2SMP+E2frDRFZsfGe1oJqq8C8vAVdo2vWRU4MzIiBw2IzfERP6M2VV4u0H6TaFK092
         gP6sHPQtCI7axgzVW9QiVab7R32SFN/6QIpKpNi9zoifg5aPrafER1lU1emc0Sc9Ej+x
         Cin5a3/xLYEcGRYQGTgSs8Lgnb5psb1RKWIpZZSB5Eg7RQ4CViR6sZ+c5dGtWWMXeXfb
         qjWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X8koHqYtcGKtK9ShE60+AKTtKz4cqfXuzvfRTgSACa0=;
        b=zq7/rjvHZ4ZehHjpZPsIiLYkwKVjrxiRD8ibypalWXp/cpgmxVdPAJm4UyqykF+cck
         WlpWjUweeOdNc314x2ij+cuQ+F6Us3QoNj6WXezsvu/ZKzSw5y8+I2nFKFcQ6fMUOtTR
         4bUCN/WvxVfZkcjrvWD82ITgXomOlSFEN0cmg3D10D0hfgS8dY272Giix5/Lf/ek39xh
         UWNHTUn8BQLsEaYwbLr9zGFz/2PbkETzgSalUIw78J2dFyz66finYfoiWEW3GHL3+1h4
         JMzGN6qgvIwR0TUEwtoQ8f24/sv7vRILB95je9xN+opkm9cAWUBFvR4tYPW1NhZCmyCZ
         hOEw==
X-Gm-Message-State: AO0yUKUj01p0vwXYeaSVBdYSIvMmrluG6mVVtOuFlglm9tBx46cEUpIb
        /1OivASqnRwsLjCoXucYrOSF5blu3cE=
X-Google-Smtp-Source: AK7set8fT3ODZoWF86+1UvsxoUnNGS/nwGtC/D2vrM0qUK8yE/K/FN1lONE6namVd6AjWVKIwnnJCg==
X-Received: by 2002:aa7:8558:0:b0:592:3e51:d881 with SMTP id y24-20020aa78558000000b005923e51d881mr16184226pfn.14.1675645845522;
        Sun, 05 Feb 2023 17:10:45 -0800 (PST)
Received: from localhost ([156.236.96.165])
        by smtp.gmail.com with ESMTPSA id j4-20020aa78004000000b0059242cd5469sm5919068pfi.13.2023.02.05.17.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 05 Feb 2023 17:10:45 -0800 (PST)
Date:   Mon, 6 Feb 2023 09:16:25 +0800
From:   Yue Hu <zbestahu@gmail.com>
To:     Gao Xiang <hsiangkao@linux.alibaba.com>
Cc:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>, huyue2@coolpad.com,
        zhangwen@coolpad.com
Subject: Re: [PATCH 1/6] erofs: get rid of erofs_inode_datablocks()
Message-ID: <20230206091625.00000a70.zbestahu@gmail.com>
In-Reply-To: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
References: <20230204093040.97967-1-hsiangkao@linux.alibaba.com>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; i686-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat,  4 Feb 2023 17:30:35 +0800
Gao Xiang <hsiangkao@linux.alibaba.com> wrote:

> erofs_inode_datablocks() has the only one caller, let's just get
> rid of it entirely.  No logic changes.
> 
> Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>

Reviewed-by: Yue Hu <huyue2@coolpad.com>
