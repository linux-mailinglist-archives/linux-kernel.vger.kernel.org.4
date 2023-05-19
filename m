Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E6A0670A112
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 22:55:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231190AbjESUzG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 16:55:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231716AbjESUyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 16:54:54 -0400
Received: from mail-qt1-x82e.google.com (mail-qt1-x82e.google.com [IPv6:2607:f8b0:4864:20::82e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6A9310F3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:48 -0700 (PDT)
Received: by mail-qt1-x82e.google.com with SMTP id d75a77b69052e-3f42b4da6e5so18279701cf.2
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 13:54:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1684529688; x=1687121688;
        h=in-reply-to:references:subject:to:from:message-id:date:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WT/C0XPR1/vAySbbcWPHa11OWVLeot7aGDtepqZ5u+E=;
        b=H6YvfWvKJWZorG0TGO/SFWtxWLxVj1bafOZSvZU2dPh/hje7Sxt6uCKeHTNljZzHXd
         kxIXT3/IePjbf7kXU/sv9SE0GN9PJjL97jqFeHH594y+RiTSY1CsvrUvgiDhmC9LJdzP
         CPUawAbRkVkk+qYJ7LpPaltw6wcRKXjgt3Q6sc297JUnfUOGmI22V/JinUKgnma6bmZq
         ratDkmaLnMk7dw4G6u4IWFcKYPX+WqlzqUF+IQF0Ng/aE7ADWI+BhyzVNxRmjH2Z4HMM
         JcWi8cbQ5j7y04kdBz+g95om1JzoevLGBycUMBT9x+H3NWak7dg0ntpqv9G/1Eu2lc+W
         7mqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684529688; x=1687121688;
        h=in-reply-to:references:subject:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WT/C0XPR1/vAySbbcWPHa11OWVLeot7aGDtepqZ5u+E=;
        b=KkFSCpbTHrM+r3eY3C3yBqSBVQVkw/2dbR9q7pHbkkhaoE9jptWlTSLEyo6xjl7C2v
         7OWK0aHbKCS1DkYkcMDH4EUz/zrSaFfnkAaYrjx/JKE0G8UHA4IZU5Y67HlDG6C8Y260
         gXHAbSuFgbj6NDNH0VTXmTKnWJ/QYonx9SN0OzluO2m3AjOo3qXwzS2VycMi4HPbytpt
         dwpHwWsEvxxik7yY6/j+N8AjMflKWQmc8socLyXEEYfkSmfUBLRrjX6YOpYkgUvWKzJw
         n2qwJWn67aGJvVMzopeYYL98yC+9D61ZZ5C0kZUbQH9C3lCZnN21Jp5LJnpdJf0TfAs+
         sjjw==
X-Gm-Message-State: AC+VfDz/ySS6o8UuhfzJgVcwQlSN5DvDjVNxpgJrrQSU1FOSRU6HR5wt
        Uutty8u1HzoRRgllAWSEQRu1
X-Google-Smtp-Source: ACHHUZ4Eb9+VnEO3olqncqK/5kIuTihkBSrRY2ybG2/tnS/lpVpz98AMcdon7Pa4MB98bZw8MRhYEg==
X-Received: by 2002:a05:622a:510:b0:3e4:e641:6b1f with SMTP id l16-20020a05622a051000b003e4e6416b1fmr6106651qtx.55.1684529681813;
        Fri, 19 May 2023 13:54:41 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id w24-20020a05620a149800b0074de8d07052sm1372238qkj.47.2023.05.19.13.54.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 May 2023 13:54:41 -0700 (PDT)
Date:   Fri, 19 May 2023 16:54:41 -0400
Message-ID: <e9edf9db340cbf753fce43772abdef4e.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Eiichi Tsukata <eiichi.tsukata@nutanix.com>, eparis@redhat.com,
        linux-kernel@vger.kernel.org, audit@vger.kernel.org
Subject: Re: [PATCH v2 5/5] audit: do not use exclusive wait in audit_receive()
References: <20230511052116.19452-6-eiichi.tsukata@nutanix.com>
In-Reply-To: <20230511052116.19452-6-eiichi.tsukata@nutanix.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 11, 2023 Eiichi Tsukata <eiichi.tsukata@nutanix.com> wrote:
> 
> kauditd thread issues wake_up() before it goes to sleep. The wake_up()
> call wakes up only one process as waiter side uses exclusive wait.
> This can be problematic when there are multiple processes (one is in
> audit_receive() and others are in audit_log_start()) waiting on
> audit_backlog_wait queue.
> 
> For example, if there are two processes waiting:
> 
>   Process (A): in audit_receive()
>   Process (B): in audit_log_start()
> 
> And (A) is at the head of the wait queue. Then kauditd's wake_up() only
> wakes up (A) leaving (B) as it is even if @audit_queue is drained. As a
> result, (B) can be blocked for up to backlog_wait_time.
> 
> To prevent the issue, use non-exclusive wait in audit_receive() so that
> kauditd can wake up all waiters in audit_receive().
> 
> Fixes: 8f110f530635 ("audit: ensure userspace is penalized the same as the kernel when under pressure")
> Signed-off-by: Eiichi Tsukata <eiichi.tsukata@nutanix.com>
> ---
>  kernel/audit.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)

This was also discussed in the last patchset.

--
paul-moore.com
