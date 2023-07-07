Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0492874B363
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 16:55:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232966AbjGGOzj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 10:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232730AbjGGOzg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 10:55:36 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 764B21FE2;
        Fri,  7 Jul 2023 07:55:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=O1NoqMhtAQJgT4QBfdt5+/2ZYFc7QVgY2GbwxuDpmuI=; b=WJhiu6Xcy+tUuNmUW+DBF0De7C
        tqlkA6+PN4TYzPKf3sK4o3ZshV5sx1+Mft30BFOssBA3inUI64oQSqNzFUKGR0u6myH2cHfK4aIJd
        3NXOhZim72Qlp4KCd4bWCp+z1KBRAeCxPYAC9AhsHpiPAlezoZzYIOETtiyYe4GaPsOvxgQY1vo2V
        EXqv/Dhry+HOSFNqyzMK28YUSMgultU+HCRMEM8EKFVKSXlxPSINnEHa0qQ1DuGq4WivRG60hk8G8
        JOXZW/FKcTuz7xvZN/icDCyKyyQ7FYm2167cPBzziuNAV2kgozdTZ2ZNRZ9LnZ0fqfnSaCifNW1Gb
        QEiyTxXQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1qHmrX-004wEc-2r;
        Fri, 07 Jul 2023 14:55:11 +0000
Message-ID: <b4173c39-0d6e-a02b-df2f-4f9eb6a1453d@infradead.org>
Date:   Fri, 7 Jul 2023 07:55:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH -next] apparmor: Fix some kernel-doc comments
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, john.johansen@canonical.com
Cc:     paul@paul-moore.com, jmorris@namei.org, serge@hallyn.com,
        apparmor@lists.ubuntu.com, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230707080737.49899-1-yang.lee@linux.alibaba.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <20230707080737.49899-1-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 7/7/23 01:07, Yang Li wrote:
> Use colons to separate parameter names from their specific meanings.
> silencethe warnings:
> 
> security/apparmor/resource.c:111: warning: Function parameter or member 'label' not described in 'aa_task_setrlimit'
> security/apparmor/resource.c:111: warning: Function parameter or member 'task' not described in 'aa_task_setrlimit'
> security/apparmor/resource.c:111: warning: Function parameter or member 'resource' not described in 'aa_task_setrlimit'
> security/apparmor/resource.c:111: warning: Function parameter or member 'new_rlim' not described in 'aa_task_setrlimit'
> 
> Signed-off-by: Yang Li <yang.lee@linux.alibaba.com>

Reviewed-by: Randy Dunlap <rdunlap@infradead.org>

Thanks.

> ---
>  security/apparmor/resource.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/security/apparmor/resource.c b/security/apparmor/resource.c
> index e85948164896..2bebc5d9e741 100644
> --- a/security/apparmor/resource.c
> +++ b/security/apparmor/resource.c
> @@ -97,10 +97,10 @@ static int profile_setrlimit(struct aa_profile *profile, unsigned int resource,
>  
>  /**
>   * aa_task_setrlimit - test permission to set an rlimit
> - * @label - label confining the task  (NOT NULL)
> - * @task - task the resource is being set on
> - * @resource - the resource being set
> - * @new_rlim - the new resource limit  (NOT NULL)
> + * @label: label confining the task  (NOT NULL)
> + * @task: task the resource is being set on
> + * @resource: the resource being set
> + * @new_rlim: the new resource limit  (NOT NULL)
>   *
>   * Control raising the processes hard limit.
>   *

-- 
~Randy
