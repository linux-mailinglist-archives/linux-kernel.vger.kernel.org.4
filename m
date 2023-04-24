Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24EE76D91BA
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 10:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235958AbjDFId6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 04:33:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235419AbjDFId4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 04:33:56 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD32CA1
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 01:33:32 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id q102so36596173pjq.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 01:33:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680770012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=QGq/HKc5p+fcl8bqCho34sjFte/OlqchdCqQAXf81es=;
        b=Ee3AutziMDQ/oJmzOP3/Hymnbhk/Uy5Gy1BUXoVUuZmYeU/nyiZWcG2x3aWiTsPThI
         S7vFSb7eBMSpf6zEhOdh9io9ExkuAB7bmLFp2mYPb6AuMHKSeeAEfqLvuS0PYOHV5CXf
         wmfy3isyeLEUJURdjlzh2atawqt4HuXpPueZwxclZHJuFkBBhQMAgH4pDLj+F3yks5K1
         IKvzO7lo37kB80t7G82q/tTJ+etEbk7lacZMQepacriyPTRmDRcgpGwoxCIjWToAsCq2
         B05DldvPRu182tFJEmxH/M0mExfkZ6YK8cco1VZs+7/eJevseK7Mf0Hj+xh5cJ8zftCO
         O/wA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680770012;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QGq/HKc5p+fcl8bqCho34sjFte/OlqchdCqQAXf81es=;
        b=qASWVNz47b2sU52jEC0J70y9xuntpxSJbXIZ9FNLpYN2ywNo/Q+70UWkvdBJ1hT+IB
         F339tqdoOPf8Nxys9DRKGJldlSrl5B9nO2jYBZgTLkpg5aujdWFmQltX6a3iuLVnxJlG
         gCVhGhU3ScsyhE67MTDiQDA5ImujruMmQrJ5mk+E1vp9+Gv2PUOJldKuyhq95itXuKAS
         j0qoRKjih0V63UlyUrpVgxl7d4rhiBKYk5Bpv6d2raqTVETKMR5D7aK6owC2f0h+hhGN
         0nHIuSDvB6AondRhFEOC2Pfp7fhWbHQSNRBz7TLpV2FDprgY2PUPc4q9IGdprPXgBYsq
         jdUg==
X-Gm-Message-State: AAQBX9cYw+iRnWlDyEAFRX3FgUBclfXESzsnXR1B3P0pyOJvaUHhWvZu
        +F/fKvPjlPO98WjbBgqSjOu1gQ==
X-Google-Smtp-Source: AKy350Z0GNykMKtdPMh1/FNDKsJlh38CtqUNnIJMj2/AQ/3zCMyGD16karvpeZGoHxeEbs8aAQHJcg==
X-Received: by 2002:a17:90b:3846:b0:23f:5247:3334 with SMTP id nl6-20020a17090b384600b0023f52473334mr10196696pjb.19.1680770012274;
        Thu, 06 Apr 2023 01:33:32 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id g5-20020a17090adac500b0023af8a3cf6esm2664937pjx.48.2023.04.06.01.33.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 01:33:32 -0700 (PDT)
Message-ID: <1fe17d13-4b63-93ab-e6b2-3c9d09da208e@bytedance.com>
Date:   Thu, 6 Apr 2023 16:33:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Re: Re: [PATCH v2] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Michal Hocko <mhocko@suse.com>
Cc:     rientjes@google.com, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
References: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
 <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
 <e444e0ca-a2ff-37f2-1f1a-032b9fd63235@bytedance.com>
 <ZC6DKM4LDOVgohpj@dhcp22.suse.cz>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <ZC6DKM4LDOVgohpj@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I see, then let's do this as you said.


On 2023/4/6 16:30, Michal Hocko wrote:
> 
> As I've said, I do not see any major concern having this behavior
> implicit, the behavior makes semantic sense and it is also much more
> likely that the selected oom victim will be a better choice than what we
> do currently. Especially on properly partitioned systems with large
> memory consumers in each partition (cpuset).
> 
> That being said, I would just not add any sysctl at this stage and
> rather document the decision. If we ever encounter usecase(s) which
> would regress based on this change we can introcuce the sysctl later.
> 
