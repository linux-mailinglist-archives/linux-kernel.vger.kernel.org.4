Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B3F55F9E5F
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 14:08:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232103AbiJJMIr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 08:08:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiJJMIo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 08:08:44 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44FA161706
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:08:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id d24so10207558pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 05:08:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FwPMwCgbi/FbAd9r1+fUWWjocTEXzlErLf/J4KoA6Pw=;
        b=D3fg/uc7O/MeJ7dpIE5CVLx02YbILU+5RamhHoy2B6Q2HH0R0s4CgnZXprAsun6ROi
         /VdDCXReoNG6k7t5xllDH9bqMHmXIDDWhpRG5/4BQfk45l4yhlUSjUMP09fbcnTa1tXI
         /SNzpnHpGcxgqaNws4pgacDVBDmUPtlNci0Mw//ZvMRz5gEoDe6x4Fiqf47opl3hLpvD
         bXUUywZ+kJZjS4afh9HE2HSx1TCRAFuBdPduKLXdaA0pACBHvYh/WjWmYsMLJPhBmfY7
         oQ0qef9HRNuBo/EEgaYcs2jVYeKquu7PO1zz4AU0rrbpowBAaGQfG8tKnrQ5FO8YJjLV
         aIYQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FwPMwCgbi/FbAd9r1+fUWWjocTEXzlErLf/J4KoA6Pw=;
        b=efMnH+Yx8wzM6leV6mJ9eOv1ZFNmLssI3pZlDGuP90KgpOcq9/hMAQdg8doTJitzzZ
         Ya3kzd1qDoO8a420XfLzwD8NTenzJ6CNc37/x1AOQRyPkceviLZofkOhKUXC+tojTG+V
         9pyzS6QXTDIfIYdS38SxS87Jyra5o02quDgOFb4Rk+HTRSrX7G7ukaM8mHi9FWueS5aX
         COT5sjkM8ubMopU9BzgGqSXRsMsL/ccC34HV81azh9sXdOO2MWtgBXQII5E4KzC1Ba1w
         MGEE0V+1vYtqzzGc43Xv1T6XyVfjY4eHPWIqDZaKhZGsTTz2yErfRSbaEaA7SNO/0llh
         a2Ig==
X-Gm-Message-State: ACrzQf0KEtuE9qL8LaMRPrLLRhqeRRS4yyEeo5r6mauY3Ysas5tQrrZ4
        xuZ3P7s7Bg108xyTxRdXcC8=
X-Google-Smtp-Source: AMsMyM4vLi3GcSqeCddr3ROeQF4vbYLLY8389qsb0JZqfTBvEc8m0hNlQIYxla2uh+gtchudzHZ84Q==
X-Received: by 2002:a17:902:f650:b0:172:8ee1:7f40 with SMTP id m16-20020a170902f65000b001728ee17f40mr19161423plg.101.1665403722671;
        Mon, 10 Oct 2022 05:08:42 -0700 (PDT)
Received: from localhost.localdomain ([193.203.214.57])
        by smtp.gmail.com with ESMTPSA id h11-20020a17090a130b00b00208c58d5a0esm9037177pja.40.2022.10.10.05.08.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 10 Oct 2022 05:08:41 -0700 (PDT)
From:   xu xin <xu.xin.sc@gmail.com>
X-Google-Original-From: xu xin <xu.xin16@zte.com.cn>
To:     imbrenda@linux.ibm.com
Cc:     akpm@linux-foundation.org, david@redhat.com,
        jiang.xuexin@zte.com.cn, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, ran.xiaokai@zte.com.cn, xu.xin.sc@gmail.com,
        xu.xin16@zte.com.cn, yang.yang29@zte.com.cn
Subject: Re: [PATCH v2 0/5] ksm: support tracking KSM-placed zero-pages
Date:   Mon, 10 Oct 2022 12:08:34 +0000
Message-Id: <20221010120834.318840-1-xu.xin16@zte.com.cn>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221010112413.219dc989@p-imbrenda>
References: <20221010112413.219dc989@p-imbrenda>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello, Thanks for your reply.

>
>why are you trying so hard to fix something that is not broken?

Actually, it breaks the definition of unmerge, though it's usually not a big
problem.
>
>can't you just avoid using use_zero_pages?

use_zero_pages is good, not just because of cache colouring as described in doc,
but also because use_zero_pages can accelerate merging empty pages when there
are plenty of empty pages (full of zeros) as the time of page-by-page comparision
(unstable_tree_search_insert) is saved.

>
>why is it so important to know how many zero pages have been merged?
>and why do you want to unmerge them?

Zero pages may be the most common merged pages in actual environment(not only VM but
also including other application like containers). Sometimes customers (app developers)
are very interested in how many non-zero-pages are actually merged in their apps.

>
>the important thing is that the sysadmin knows how much memory would be
>needed to do the unmerge, and that information is already there.
>

I think it's about chicken-and-egg problem.


Anyway, thanks for your reply.

