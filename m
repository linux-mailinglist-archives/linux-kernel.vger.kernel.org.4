Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94AF46C7D22
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 12:21:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231298AbjCXLVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 07:21:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbjCXLVQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 07:21:16 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D198B22DC4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:21:14 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id o32so943499wms.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 04:21:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679656873;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0xv+mNtTjOwpBHKb8GKtrxehmmp8291b5lSijCZpo2M=;
        b=HuA2P+Axbp378wEn0s9/x4Yo8i3Od1knU145ZeLcEsCgQPLYA8N2ML/M7LUzGAIQkm
         Ep18Pj30tpphoEw1yT09MKR43VxVWb7VsTmY8aeomzhCP1RT6z1SzialPE3n1fTYUWLY
         4b7KhUXiOtpbHgb//g3Q/Bnuu03jkuC0O3KFRHGYoxyP09OZDcoMryVepCsAhwKPGub7
         AgxvExRxeJZ1N7WVgFrU8L1ilPUBBVgmDXQBZR7FMIznSpYNNV2wdssl4z19x0bkIZbq
         gNIpTMFLRnPjVab0dSjU8vQ2Zs4g5jyHHMb2ZRSMVrnT+pPnhkf4nN75qZlq9ITxg+sW
         tOdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679656873;
        h=content-transfer-encoding:subject:cc:to:from:content-language
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=0xv+mNtTjOwpBHKb8GKtrxehmmp8291b5lSijCZpo2M=;
        b=I1EiH9nW8fCmrVfQqBI4SfF0H8tbjLNlY2l59OhmPjHyHSKdWAxZ6WMP1id7wz153Y
         8bLWmcT+8fzIKekoI9SOFhAVsYRcMJnW5JB23qiwfwQqYz2ZJbyEPedk/G6RkPtXTX2b
         gtpgVidnaE0rY/j4XYtXhkXhewVaE8wVKfJuCbgRDC8Cwn9O4mG0idYwSj56uo0LdFK0
         aAVYDyCYaHtVDe5OM4N10QGE0hl0uwjvZmSrhXFTZS5RrZB5bN431ipmw33IuaEafMN1
         lUd6EotBoR03OVx8Vc223jBGm5QoVMcyvCMq7hvkU48eZeuL0H7HOv8/Y/N4bOK9t+5b
         1enw==
X-Gm-Message-State: AO0yUKV1uSjLlB3CRkqD6imdRp2X9waGdqvO1hw2h/waWeZE6NADY13m
        kz29r8Pm5OaQBpJlDHc7PZFQZoD8INU=
X-Google-Smtp-Source: AK7set+vAK+YrCS5/U3GOCqpd6jNW6jOgX7VnHc3aRQBrB3AVpAl5wBs7nZkuiRjcpTKrmpOFveSiQ==
X-Received: by 2002:a1c:f217:0:b0:3ee:5c4c:bdb0 with SMTP id s23-20020a1cf217000000b003ee5c4cbdb0mr2079165wmc.39.1679656873188;
        Fri, 24 Mar 2023 04:21:13 -0700 (PDT)
Received: from [192.168.0.210] (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.googlemail.com with ESMTPSA id w4-20020a05600c474400b003edc9a5f98asm4775443wmo.44.2023.03.24.04.21.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Mar 2023 04:21:12 -0700 (PDT)
Message-ID: <e50ebe1a-73a0-5800-71e3-0ddd366727ac@gmail.com>
Date:   Fri, 24 Mar 2023 11:21:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Content-Language: en-US
From:   "Colin King (gmail)" <colin.i.king@gmail.com>
To:     Jaegeuk Kim <jaegeuk@kernel.org>, Chao Yu <chao@kernel.org>,
        linux-f2fs-devel@lists.sourceforge.net
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: re: f2fs: factor out discard_cmd usage from general rb_tree use
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

static analysis with clang scan build has detected a potential issue 
introduced by the following commit:

commit 7e9775a516ff6c1e73ee2b42ec563cafee38f42f
Author: Jaegeuk Kim <jaegeuk@kernel.org>
Date:   Fri Mar 10 11:12:35 2023 -0800

f2fs: factor out discard_cmd usage from general rb_tree use


The warning is as follows:

fs/f2fs/segment.c:1425:4: warning: Value stored to 'tdc' is never read 
[deadcode.DeadStores]

The while loop in function __update_discard_tree_range is as follows (+ 
my annotations):


         while (1) {
                 struct rb_node *node;
                 struct discard_cmd *tdc = NULL;

### tdc is set to NULL

                 if (prev_dc) {
                         di.lstart = prev_dc->di.lstart + prev_dc->di.len;
                         if (di.lstart < lstart)
                                 di.lstart = lstart;
                         if (di.lstart >= end)
                                 break;

                         if (!next_dc || next_dc->di.lstart > end)
                                 di.len = end - di.lstart;
                         else
                                 di.len = next_dc->di.lstart - di.lstart;
                         di.start = start + di.lstart - lstart;
                 }

                 if (!di.len)
                         goto next;

                 if (prev_dc && prev_dc->state == D_PREP &&
                         prev_dc->bdev == bdev &&
                         __is_discard_back_mergeable(&di, &prev_dc->di,
 
max_discard_blocks)) {
                         prev_dc->di.len += di.len;
                         dcc->undiscard_blks += di.len;
                         __relocate_discard_cmd(dcc, prev_dc);
                         di = prev_dc->di;
                         tdc = prev_dc;

### tdc is set to prev_dc, however, it is not not read any more with th 
introduction of the "goto next"" statement introduced in the commit 
mentioned earlier

                         goto next;
                 }

                 if (next_dc && next_dc->state == D_PREP &&
                         next_dc->bdev == bdev &&
                         __is_discard_front_mergeable(&di, &next_dc->di,
 
max_discard_blocks)) {
                         next_dc->di.lstart = di.lstart;
                         next_dc->di.len += di.len;
                         next_dc->di.start = di.start;
                         dcc->undiscard_blks += di.len;
                         __relocate_discard_cmd(dcc, next_dc);

### tdc is always NULL, there is no path to this code where tdc is ever 
set to a non-NULL value.

                         if (tdc)
                                 __remove_discard_cmd(sbi, tdc);
                         goto next;
                 }

                 __insert_discard_cmd(sbi, bdev, di.lstart, di.start, 
di.len);
  next:
                 prev_dc = next_dc;
                 if (!prev_dc)
                         break;

                 node = rb_next(&prev_dc->rb_node);
                 next_dc = rb_entry_safe(node, struct discard_cmd, rb_node);
         }


