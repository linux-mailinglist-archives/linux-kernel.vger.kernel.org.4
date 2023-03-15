Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F3C96BBB72
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 18:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232477AbjCORxW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 13:53:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232547AbjCORxR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 13:53:17 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0745B22CBF
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:53:12 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id b20so12230235pfo.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 10:53:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678902792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Phl8VF4w8DmD63ACWK76eFJT4/Q2JfCIItsfspissxQ=;
        b=djw7yUfvvWLdQrSrLVpKDbcWeFR6bzBsMNXff7qPIlRXgwiZIesBc8lFUzUS5VNi36
         FHJsKXQYzOB0ftKKh+4RAxSrGE1Hit5YsALleFADD0KS6I5WRC/RDgDV/rbj6Vw9eunO
         56Q79+7ZAK3b26QR3+r1cBDslSvY01dihVAb5fMAXrAz44ijMIDBeEirCKL4437DY7+I
         ecvG1+1nxssTHI5FnXRfM7lffRIr9omA1GzsuO/5CkOsmt7fEvELraZ8PYoNLocd5nDI
         MJxh06CyTCw+CfNTUWlX0dqUQ/K6khZU3YCmwDt49rMHu5gQ9hqKr2u3FPvJ8bKObqUN
         iN/g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678902792;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Phl8VF4w8DmD63ACWK76eFJT4/Q2JfCIItsfspissxQ=;
        b=qAI6AZ7i02HmOvaaMCrBFSdLmCsUBOq75Q0uW43Bca5qViiOanuJAB1Ogi4PN8Vl5e
         ryglwFfeg7ze5uxxIy4n5JAkWrVpWjjJt9FPJqcJw5ks5rFWIcO6ViOV9qqhQa9rUoE/
         YPYJyc6EK2FN0VQG6PFroqqF8X1mXa4UqmJ3VrzIqq5d+NQ8oiSuWDmMXis3Rvsg4g7g
         i8T3rKsnVsiAjnGA01GSMpKSTVc+ixzq42syxi7iDRcsSr1hZNsFh4f0MHCNa5WB58r1
         4JYhZtmkPpDsslKJxUHV8dphUcY7w2qAwqZ5AXeQA9fIs4V+32lbkPFLTNM+aclLvWNi
         R/3Q==
X-Gm-Message-State: AO0yUKWBvTpqMJ+HAIRKKxCJZNCJjglfoXdnpzUbwThqhdHDhidTzD8e
        rUbRqZC3LFfYCpJpVbXfSJHPeQ2kztU=
X-Google-Smtp-Source: AK7set+SM+zn4erh1bUIBARawNAVAK8nzQuJtFlFcoaBeUfUK2suB+pA8P+adB1EBT2xhRKGn4AdlQ==
X-Received: by 2002:aa7:9d03:0:b0:622:85e2:fb93 with SMTP id k3-20020aa79d03000000b0062285e2fb93mr544227pfp.15.1678902792181;
        Wed, 15 Mar 2023 10:53:12 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i17-20020aa787d1000000b005897f5436c0sm3836457pfo.118.2023.03.15.10.53.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 10:53:11 -0700 (PDT)
Message-ID: <9d478a5d-a7af-ab9f-a04e-fc40a95bc861@gmail.com>
Date:   Wed, 15 Mar 2023 10:53:06 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] mm: mempool: Optimize the mempool_create_node function
Content-Language: en-US
To:     Li zeming <zeming@nfschina.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20230315191243.3289-1-zeming@nfschina.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230315191243.3289-1-zeming@nfschina.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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

On 3/15/23 12:12, Li zeming wrote:
> The pool pointer variable gets the kzalloc_node function return value
> directly at definition time, which should be more concise.
> 
> Signed-off-by: Li zeming <zeming@nfschina.com>

This looks pretty useless as a change, the generated code is going to be 
the same before/after, it is also not more readable, and it is 
definitively not an optimization in the sense that optimization should 
be used as meaning: the code is more efficient after that change.
-- 
Florian

