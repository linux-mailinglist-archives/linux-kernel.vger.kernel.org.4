Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E7161EEF1
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 10:28:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231302AbiKGJ2I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 04:28:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231193AbiKGJ2G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 04:28:06 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43727175A6;
        Mon,  7 Nov 2022 01:28:05 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id z5-20020a17090a8b8500b00210a3a2364fso12402811pjn.0;
        Mon, 07 Nov 2022 01:28:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UZcKgqHz49pJP/FaJaKJrT+9ra+EVje3XERCjXDz3wk=;
        b=RkmcTvtCd42yvH4q6D9F7qGJUZBeQdrx9bh9BsKc465BGcoReGdx27zSBbiiQuINf7
         lfzDEbmTvuXtB0rF3pVQ7IMdtWirO1YlTzB8tvCvX4Md6yFR4Gmx45KSoDVxxaGVwXZ6
         ozR4AuUBy1ch8pPMy1cZllROg+jPCWRROR8voYZGIeYffpt0k+tXSz1eJL2vV/icQJ9Q
         /3wMDiKC0O2FZKdolKNzChaIcF4YGB7n1yvKISp5sExKEF+TrdYZt+YUfKU7e3OPtOM7
         ZjrKjOEiYgi4QZIsKFnMkb2g78MFGowmyhsAq1Vh4CEb3mJoOjvifx32f2JHdHLJ+/TP
         tn+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UZcKgqHz49pJP/FaJaKJrT+9ra+EVje3XERCjXDz3wk=;
        b=Z/7tRuaEup7DEjKg+Zs0Eh3tAm7Tjf7yAoYGZmTjF6sxzLkpoGS1yMm64vo5nZzTt6
         vfGjsg1xaDKLMLqvXyiz9OljVt0iIumcptKyp7Xw39R67Z5ml5ZN8svj03Jb4QEQUBa0
         727ILC2CDjNjXwZA0fUSu7EIo1oNIHOSfmKOZ0YMzBVW0MGNFNS6CeyIZua4o3nYGID3
         eOukyCU04ElAbXCcglwMz+WhTjUG847MohLbd+5SHluV6pZUM8hcDMON+FUTGl98XscP
         2AHp9YJq5j5n+iTAsVU072BfAGUDqmZoF7LAtOBWmTFSNBdS0RdKhlc0kpdwC5X4N9OQ
         JVUA==
X-Gm-Message-State: ACrzQf3noQVAwcH09YRJ7PTIS08xS1v7xajte//L0TsBtmwIP3DMx+dF
        zdBDGgydOtcOouhE3W9y74vmlP7lbEo=
X-Google-Smtp-Source: AMsMyM4XfBmpNy3iMLbkrr3+sigV4fUk0BECn409YM/juyEfsWf1zUgKSpNvhzDNy6uzBI8wE9x6MA==
X-Received: by 2002:a17:90b:1b05:b0:213:dc73:3084 with SMTP id nu5-20020a17090b1b0500b00213dc733084mr40831604pjb.13.1667813284791;
        Mon, 07 Nov 2022 01:28:04 -0800 (PST)
Received: from [192.168.11.9] (KD106167171201.ppp-bb.dion.ne.jp. [106.167.171.201])
        by smtp.gmail.com with ESMTPSA id t11-20020a170902e84b00b00186c41bd213sm4516308plg.177.2022.11.07.01.28.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 01:28:04 -0800 (PST)
Message-ID: <3ecccb89-ccef-5e2f-70fa-c5dce5f2a195@gmail.com>
Date:   Mon, 7 Nov 2022 18:28:01 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org, rcu@vger.kernel.org,
        Akira Yokosawa <akiyks@gmail.com>
References: <20221107050212.GG28461@paulmck-ThinkPad-P17-Gen-1>
Subject: Re: linux-next: build warning after merge of the rcu tree
Content-Language: en-US
From:   Akira Yokosawa <akiyks@gmail.com>
In-Reply-To: <20221107050212.GG28461@paulmck-ThinkPad-P17-Gen-1>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[-Cc: sfr, linux-next, +Cc: rcu]

Hi Paul,

On Sun, 6 Nov 2022 21:02:12 -0800, Paul E. McKenney wrote:
> On Mon, Nov 07, 2022 at 02:26:41PM +1100, Stephen Rothwell wrote:
>> Hi all,
>> 
>> After merging the rcu tree, today's linux-next build (htmldocs)
>> produced this warning:
>> 
>> Documentation/RCU/rcubarrier.rst:205: WARNING: Literal block ends without a blank line; unexpected unindent.
>> 
>> Introduced by commit
>> 
>>   21c2e3909721 ("doc: Update rcubarrier.rst")
> 
> Huh.  I guess that numbered code samples are not supposed to have more
> than nine lines?

No, the problem was that line 10 of the snippet had the same indent
level (ie, no indent) as the line above the snippet and was interpreted
as the end of literal block. 

>                   Ah well, easy to fix by going back to left-justified
> numbers.  I was wondering about that!

Appended is a POC patch (relative to current dev of -rcu tree) making
them right-justified and compatible with sphinx processing.

Hope this helps, Akira

> 
> Apologies for the hassle!
> 
> 							Thanx, Paul

diff --git a/Documentation/RCU/rcubarrier.rst b/Documentation/RCU/rcubarrier.rst
index 5a643e5233d5..9078511ec33d 100644
--- a/Documentation/RCU/rcubarrier.rst
+++ b/Documentation/RCU/rcubarrier.rst
@@ -193,16 +193,16 @@ which point, all earlier RCU callbacks are guaranteed to have completed.
 
 The original code for rcu_barrier() was roughly as follows::
 
- 1   void rcu_barrier(void)
- 2   {
- 3     BUG_ON(in_interrupt());
- 4     /* Take cpucontrol mutex to protect against CPU hotplug */
- 5     mutex_lock(&rcu_barrier_mutex);
- 6     init_completion(&rcu_barrier_completion);
- 7     atomic_set(&rcu_barrier_cpu_count, 1);
- 8     on_each_cpu(rcu_barrier_func, NULL, 0, 1);
- 9     if (atomic_dec_and_test(&rcu_barrier_cpu_count))
- 10       complete(&rcu_barrier_completion);
+  1  void rcu_barrier(void)
+  2  {
+  3    BUG_ON(in_interrupt());
+  4    /* Take cpucontrol mutex to protect against CPU hotplug */
+  5    mutex_lock(&rcu_barrier_mutex);
+  6    init_completion(&rcu_barrier_completion);
+  7    atomic_set(&rcu_barrier_cpu_count, 1);
+  8    on_each_cpu(rcu_barrier_func, NULL, 0, 1);
+  9    if (atomic_dec_and_test(&rcu_barrier_cpu_count))
+ 10      complete(&rcu_barrier_completion);
  11    wait_for_completion(&rcu_barrier_completion);
  12    mutex_unlock(&rcu_barrier_mutex);
  13  }
-- 
