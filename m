Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 423A571186D
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 22:49:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241722AbjEYUtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 16:49:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231495AbjEYUtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 16:49:03 -0400
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F1097
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:49:02 -0700 (PDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-1ae51b07338so286725ad.0
        for <linux-kernel@vger.kernel.org>; Thu, 25 May 2023 13:49:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685047741; x=1687639741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=whxtKs3zY5o7lOi2M0b4sH5ZglTh45UXMdseNgG74N4=;
        b=fwgTrAqHvHwj8d6TliW8P0im5qW7xToIJciZwg7zsD6c9SsrC9Ua5Dl406Iz1IoowO
         APk6FBcL1gETui+h/pga+YZrFmbwW0yhyXtG5jlnyihzKAaPNT/wakbg3MkbmDepLAIt
         2BiX54GvC+Bp89+bqKaH3dl+InPwUfdckjzUJGtZ9v/jjA4SyWVkqPwvdTbjSGm0sXkx
         aYcE6W2I48fK81kVGcIb1DSsmNyAiaPKHZZOmQris4Us154GRkDAw+C1PRKngn6j5lnx
         LD4wKwiinNtnosSSe3RT9ARsHien9Z364BGIl/zHBPQqb8iO987F5DAhU/aIM9NNHT04
         0dSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685047741; x=1687639741;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=whxtKs3zY5o7lOi2M0b4sH5ZglTh45UXMdseNgG74N4=;
        b=JZ5PMNcmM7vRlOF0Djk/qo8/Sj4uSZY4oOB5C+9lrCxh/mn40Wyq4RG1b3RYw6juU0
         sxPxW00ZyFMRUIehTjrXWWECXMu4Vy9Xb1DOQUBu3/rBceyJ6u/U1+PL1d1ACaMWrOZk
         nKpMzPEIwjsPwlRrhhnDi2UgwV5m1I1JpbOZz4TGVTYZ7QwCgZoDcHVgb/MdPfdL9PvV
         lf+udZHINAYKqh/kcZWio7sAV8TdRjkzu+ZiX3FybCpqnPaHUeFSlq94MrDhRPqoaslS
         NfUDWNV7oYApIEGT1y1QdIoe+22XKzousYJF+6aj8fnp5W4udN9tY/3wJorigb8g3Bmi
         kC2g==
X-Gm-Message-State: AC+VfDy3LzV0G6ndkk7zS2akeT39CKj9QpPU+u8VTjGumhGO1f/najNH
        LYoRwBbBAoP9OXoGKUMYomNNNATTTqg=
X-Google-Smtp-Source: ACHHUZ69en0/ergUcd5CNjvdbgxTaLec/X39lTbyzeXU2xRUBZ9ZfBCp387RvaitJUyqBtPdeqWKHQ==
X-Received: by 2002:a17:902:a704:b0:1b0:ebd:c52e with SMTP id w4-20020a170902a70400b001b00ebdc52emr162855plq.48.1685047741265;
        Thu, 25 May 2023 13:49:01 -0700 (PDT)
Received: from localhost (2603-800c-1a02-1bae-a7fa-157f-969a-4cde.res6.spectrum.com. [2603:800c:1a02:1bae:a7fa:157f:969a:4cde])
        by smtp.gmail.com with ESMTPSA id u16-20020a170902e5d000b001a260b5319bsm1817918plf.91.2023.05.25.13.49.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 May 2023 13:49:00 -0700 (PDT)
Sender: Tejun Heo <htejun@gmail.com>
Date:   Thu, 25 May 2023 10:48:59 -1000
From:   Tejun Heo <tj@kernel.org>
To:     Zqiang <qiang.zhang1211@gmail.com>
Cc:     jiangshanlai@gmail.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] workqueue: Do not set CPU_INTENSIVE worker flags with
 wq_cpu_intensive_thresh_us=0
Message-ID: <ZG_JuzyP_1FHIC6L@slm.duckdns.org>
References: <20230525040038.12346-1-qiang.zhang1211@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230525040038.12346-1-qiang.zhang1211@gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

I rewrote the patch description and separated it out into a separate if
statement for readability. Applied to wq/for-6.5.

Thanks.

From 18c8ae813156a6855f026de80fffb91e1a28ab3d Mon Sep 17 00:00:00 2001
From: Zqiang <qiang.zhang1211@gmail.com>
Date: Thu, 25 May 2023 12:00:38 +0800
Subject: [PATCH] workqueue: Disable per-cpu CPU hog detection when
 wq_cpu_intensive_thresh_us is 0

If workqueue.cpu_intensive_thresh_us is set to 0, the detection mechanism
for CPU-hogging per-cpu work item will keep triggering spuriously:

  workqueue: process_srcu hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
  workqueue: gc_worker hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
  workqueue: gc_worker hogged CPU for >0us 8 times, consider switching to WQ_UNBOUND
  workqueue: wait_rcu_exp_gp hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
  workqueue: kfree_rcu_monitor hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND
  workqueue: kfree_rcu_monitor hogged CPU for >0us 8 times, consider switching to WQ_UNBOUND
  workqueue: reg_todo hogged CPU for >0us 4 times, consider switching to WQ_UNBOUND

This commit therefore disables the CPU-hog detection mechanism when
workqueue.cpu_intensive_thresh_us is set to 0.

tj: Patch description updated and the condition check on
    cpu_intensive_thresh_us separated into a separate if statement for
    readability.

Signed-off-by: Zqiang <qiang.zhang1211@gmail.com>

Can you please use your full name as in "FIRST_NAME LAST_NAME <EMAIL>" when
signing-off patches in the future?

Thanks.

--
tejun
