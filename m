Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A33E6E87F2
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 04:25:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232679AbjDTCZg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 22:25:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjDTCZe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 22:25:34 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6CCD448A
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:25:30 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1a66e7a52d3so5367655ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 19:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shopee.com; s=shopee.com; t=1681957530; x=1684549530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qmy+jBwJo69IAuqlIjVIi7s1lnogGEvDlj2OElYYveU=;
        b=M4E2eRRF3SMb7pNc58yrI6ZJ2rONGD8LHiNjS2WcfpEjOxouvSautngPJHn4Q9+6f1
         JnkRQJS5gv2RGYk40S0fEyjdbjDCTxSZsr9ehB+YBHhHtsJWrZMWG/QuHqXtcolnoHhC
         pC2h53mJ2j0O7SpwGrT1Wp/b8uYz+tfHZo5zTTlY0EzVsJjI0ffCrhGLW260n18h6fBS
         abb1rxQZs1lf9i0d/HU87A9qghYSv21nOPiX/yb8491iKBMAoi/yIOKe0KIpHOdJsSF8
         tVyW+MAtzIXZAtwDRe+tXWubEgxnq1WIiqn2uOniSRtj4BWDQQo+W/FXUW0UkRDVC8tV
         l/2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681957530; x=1684549530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=qmy+jBwJo69IAuqlIjVIi7s1lnogGEvDlj2OElYYveU=;
        b=Xw6FeySCccbpigLc3Xpyk0hjEzEJNf67lN8upjuHH/Rg9K7fQ2fg2X9RF8JCkJAfDq
         yxGHhN9TKZxixMdTPCwH4F5PQ0vfgJnlIM/AvD3pzlq1xuJkygv2nVLlpNPlMcXUVQf9
         S5Mb3XtMh86t3tpSu5aVmVvVE/RjZxZbV6D80gFDQiQOqp+gyDgN39VvHgqf/Hcvtadt
         Cj6M7UGXLXQ+sEC4HnP2yqywpBFKOhYdjpU6t5xDMW93sb2vs9pXud0btfDcyxxWQpEG
         pabR5kDVnqrxxDYKysJQU0yXN42+45SgN3veYlO8vrLZTwzlNsKtxvEZPcK4p5k//YuW
         QdKg==
X-Gm-Message-State: AAQBX9dN4DGq2Xlw1wf9fkzEEusPbmYefmMTYcg1Osge6Zk2pohjORgy
        Byfih91RGq2eGasjCaMYSnmYlg==
X-Google-Smtp-Source: AKy350ZpZrm9aGRn3Ysob9PqD+nra+TtZ6/sQUy6vavIQAgKouSQzwxJznARhZ08enJkxSjofM0qIQ==
X-Received: by 2002:a17:902:f312:b0:19e:b6b0:6b3 with SMTP id c18-20020a170902f31200b0019eb6b006b3mr6410637ple.15.1681957530268;
        Wed, 19 Apr 2023 19:25:30 -0700 (PDT)
Received: from [10.54.24.141] ([143.92.118.3])
        by smtp.gmail.com with ESMTPSA id j12-20020a170902690c00b001a6a6169d45sm116749plk.168.2023.04.19.19.25.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 19 Apr 2023 19:25:29 -0700 (PDT)
Message-ID: <9fb84281-19ce-8a39-b87b-fcadf9d265d1@shopee.com>
Date:   Thu, 20 Apr 2023 10:25:25 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.1
Subject: Re: [PATCH] mm, vmpressure: remove redundant check in vmpressure()
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     mhocko@suse.com, hannes@cmpxchg.org, roman.gushchin@linux.dev,
        shakeelb@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <20230419092007.186938-1-haifeng.xu@shopee.com>
 <20230419130311.587b7273eca2512c07b32bd0@linux-foundation.org>
From:   Haifeng Xu <haifeng.xu@shopee.com>
In-Reply-To: <20230419130311.587b7273eca2512c07b32bd0@linux-foundation.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2023/4/20 04:03, Andrew Morton wrote:
> On Wed, 19 Apr 2023 09:20:07 +0000 Haifeng Xu <haifeng.xu@shopee.com> wrote:
> 
>> There are three places, vmpressure_prio(), shrink_node_memcgs() and
>> shrink_node(), which invoke vmpressure(). But only shrink_node_memcgs()
>> sets tree to false and the memcg used in it is not NULL, so we don't
>> check it again in vmpressure().
>>
>> ...
>>
>> --- a/mm/vmpressure.c
>> +++ b/mm/vmpressure.c
>> @@ -284,7 +284,7 @@ void vmpressure(gfp_t gfp, struct mem_cgroup *memcg, bool tree,
>>  		enum vmpressure_levels level;
>>  
>>  		/* For now, no users for root-level efficiency */
>> -		if (!memcg || mem_cgroup_is_root(memcg))
>> +		if (mem_cgroup_is_root(memcg))
>>  			return;
>>  
>>  		spin_lock(&vmpr->sr_lock);
> 
> try_to_free_pages()->
>   do_try_to_free_pages()->
>     vmpressure_prio()-> 
>       vmpressure()->
>         crash
> 
> what am I missing here?
> 
> 

vmpressure_prio() set tree to true, so the crash won't happen.

> It does appear that vmpressure() could be simplified with
> 
> 	if (!memcg)
> 		memcg = root_mem_cgroup;
> 
> so the test you identified goes away and the memcg_to_vmpressure() call
> becomes simpler.  But that's such a small change it doesn't seem worth
> the effort.

memcg_to_vmpressure() has taken this case that the memcg is NULL into account and 
we do not need to change it.

The test I identified is in the branch that the tree is set to false. In this branch,
memcg can never be NULL because only shrink_node_memcgs() will step into it.
