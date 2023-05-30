Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F0EC716F04
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 22:44:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232375AbjE3UoI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 16:44:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbjE3UoG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 16:44:06 -0400
Received: from mail-qk1-x730.google.com (mail-qk1-x730.google.com [IPv6:2607:f8b0:4864:20::730])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E73B8EC
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:44:03 -0700 (PDT)
Received: by mail-qk1-x730.google.com with SMTP id af79cd13be357-75b08ceddd1so572518985a.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 13:44:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=paul-moore.com; s=google; t=1685479443; x=1688071443;
        h=in-reply-to:references:subject:cc:to:from:message-id:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=p3b6DJXDHbh5GF3m9xX7f8I5wETK6FJ7eZD5W780N34=;
        b=H8aFyZm3Qhu8NIYvE1PRPnX288KvaYVZZXkoFuMHVfJqFodJ5I7+uxHp3Gtj0CJTzE
         TbTKl/nZUghbEzPW8yYzymxrBjiFDLmxyuXBxD2KpcFqRaaQqHa4rtJiRWrzND50AGAp
         CvBbnVex8eVuiT3ydy+eknz0OivaSFH3IbQEtM8On+3WtBaqbfQA/5R4asixjaHLD/K9
         w89M6yUQyavCuKSAqrGhpuO6p+BAfVwP945XC9m90O7MRpjTTqY2uNxeVzeudrPtIyJX
         Xmm+Kv5EaYwd9K55z7cfpovLQqtS/Mnc0sj8hHrca9cVOjaYU96qo2z4B4KQ2xBbZEp9
         I1nA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685479443; x=1688071443;
        h=in-reply-to:references:subject:cc:to:from:message-id:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=p3b6DJXDHbh5GF3m9xX7f8I5wETK6FJ7eZD5W780N34=;
        b=H3g565CallwxPSUjvc1dUn5NpBUjnYG9ByPVRd7U+zBEzs215g2sJV96BIkNDoZQ5N
         SBvJEEyjHbCbW3ujGhH8YKdgxcY6sG16k57ywq6z1UHM1SuNb5dlvsxh9NGjLlxh6YEn
         CHkGh5CvYJijwsRv4pf2D/xzdRCKHsNs13oa2UA0UF4eyW1oL9QnqSLUwHVflzbyKolk
         d035yFB3xyG5Kr/jc6s6MY94f2nE6vJu7BmYjdAfx9weT5sOZ9LeaX7pPxXq6FOBbtfv
         FiwMd+Xenn31Z+AtVQoGMHqmvJ23zWBvJ7M2CtcXyhuOqggCeXGi7gGCFmIiV8bcvScT
         iqrg==
X-Gm-Message-State: AC+VfDwX9lYRD0ADjC+DTM1wEO00UwoabV46fhwtjYf4fxz1UQlvYl2c
        h4XNwh03zPx8BNqjAtSnCSbRG1/gFt69p+aW3Q==
X-Google-Smtp-Source: ACHHUZ6f1GRV0UvgvtPovTzxRNuNEYf9LHwcVykqRhwmJG0WLF3q48vPcI++gmwVj4HdFGuZNETV/A==
X-Received: by 2002:a05:620a:8c93:b0:75b:23a0:de93 with SMTP id ra19-20020a05620a8c9300b0075b23a0de93mr3049981qkn.17.1685479442851;
        Tue, 30 May 2023 13:44:02 -0700 (PDT)
Received: from localhost (pool-108-26-161-203.bstnma.fios.verizon.net. [108.26.161.203])
        by smtp.gmail.com with ESMTPSA id j2-20020a05620a146200b00759300a1ef9sm4409270qkl.31.2023.05.30.13.44.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 May 2023 13:44:02 -0700 (PDT)
Date:   Tue, 30 May 2023 16:44:01 -0400
Message-ID: <cdf6d7b33765b8509a6a700175f0fa09.paul@paul-moore.com>
From:   Paul Moore <paul@paul-moore.com>
To:     Xiu Jianfeng <xiujianfeng@huaweicloud.com>,
        stephen.smalley.work@gmail.com, eparis@parisplace.org,
        casey@schaufler-ca.com
Cc:     selinux@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] selinux: cleanup exit_sel_fs() declaration
References: <20230529130018.89391-1-xiujianfeng@huaweicloud.com>
In-Reply-To: <20230529130018.89391-1-xiujianfeng@huaweicloud.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On May 29, 2023 Xiu Jianfeng <xiujianfeng@huaweicloud.com> wrote:
> 
> exit_sel_fs() has been removed since commit f22f9aaf6c3d ("selinux:
> remove the runtime disable functionality").
> 
> Signed-off-by: Xiu Jianfeng <xiujianfeng@huawei.com>
> ---
>  security/selinux/include/security.h | 1 -
>  1 file changed, 1 deletion(-)

Merged into selinux/next, thanks.

--
paul-moore.com
