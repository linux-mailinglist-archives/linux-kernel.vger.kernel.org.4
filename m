Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 946E95FDB40
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 15:42:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiJMNms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 09:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229967AbiJMNmm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 09:42:42 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C279114DE3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:42:37 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id h12so2061724pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 06:42:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NOLoQjm6lEWHmulfqFpQ7MDS9fPvqNaIDPSIxB0GFo8=;
        b=AvHPQ5/wcBFLkRUYUUmEVMR4gBWtumKwj8eJQTXJ6itkibd81unu/Z4MZdHkHxmlv2
         moQQBzzXt4AybwebklULodcvG7oheLdkbNh4CoEDNi0c1l8rb5fxynNbIshI9zHNWQNj
         KLhmeb+LxE53o8VjCLGoaOvA0ihmkRPh0P1vrfU+pNA9QBOjgFJW4FC+zNUFnm1C8Tld
         2thzHhVW1H5No+n518ILMuXmeOv4ETfBFX/i9kpNFCEC5n9xBh7GScNuVKaRAwVU56hc
         0UZ1CaCCrjsl3aYFT6Z8Fruo3zs4xovnP1oL93Q0oGyVYjeBZr+wBFFFp9UZrgb6va/G
         Wudw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to:subject
         :user-agent:mime-version:date:message-id:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=NOLoQjm6lEWHmulfqFpQ7MDS9fPvqNaIDPSIxB0GFo8=;
        b=fzQHe4QFDLuX/cR5JjZc/IKG/b6mkvayK7/mkkDPsyZqEVgGLfyOiow0XxEjlgTYAC
         Cq67smayB1QoX99UtiuWPK2U8HMM+KtW0UgriC03CEnYGYbNHr92BwKxlj1snur9baGx
         ZkL7/QcDR0ZZIynsTS4euYij1Upj7Z/7sZhvs4l4hBUVBu63TKwzL7iXQYmN0iT9Xd8J
         mjqOpW9dAP+P7iDiuQOl6U6Vifeg44n0gkQqiWsHMMIZlTcpA+WQRRx/+TRJnLlfDbqY
         eS/Mmoz1Bd63otCQQ2NC54IyqJfJJaxUTQ6mzgbRkMJswGfgEIkAWOVmKYnDEg3NUb+e
         4mrQ==
X-Gm-Message-State: ACrzQf1QybM+Y5jhNLvtAitiybtHOjLsxGpByDh7xxwu1YS5YHcNHOFb
        DNQ9P+iSJczM8Ky1H5fgFEqUgQ==
X-Google-Smtp-Source: AMsMyM6FkIPSzrfH5vm5egxoGzAlEomfBe9Ic3Qi2U3S4jqkZ9v4n/W5IbztJfqkilvpnPObUtKyvg==
X-Received: by 2002:a17:90a:bd91:b0:20d:2add:96a4 with SMTP id z17-20020a17090abd9100b0020d2add96a4mr11384510pjr.195.1665668556405;
        Thu, 13 Oct 2022 06:42:36 -0700 (PDT)
Received: from [10.4.223.70] ([139.177.225.240])
        by smtp.gmail.com with ESMTPSA id i66-20020a626d45000000b00562a71d719fsm1974504pfc.155.2022.10.13.06.42.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Oct 2022 06:42:36 -0700 (PDT)
Message-ID: <a401c9a3-026c-9695-d339-24347965cd20@bytedance.com>
Date:   Thu, 13 Oct 2022 21:42:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [External] Re: [RFC] mm: add new syscall pidfd_set_mempolicy()
To:     Michal Hocko <mhocko@suse.com>
Cc:     corbet@lwn.net, akpm@linux-foundation.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, linux-api@vger.kernel.org,
        linux-doc@vger.kernel.org, wuyun.abel@bytedance.com
References: <20221010094842.4123037-1-hezhongkun.hzk@bytedance.com>
 <Y0WEbCqJHjnqsg8n@dhcp22.suse.cz>
 <582cf257-bc0d-c96e-e72e-9164cff4fce1@bytedance.com>
 <Y0aCiYMQ4liL2azT@dhcp22.suse.cz>
 <a0421769-c2b9-d59a-0358-3cc84b2cb2bd@bytedance.com>
 <Y0avztF7QU8P/OoB@dhcp22.suse.cz>
 <e825a27a-646b-9723-f774-947501c04ec2@bytedance.com>
 <Y0f17v1c3aAszlbk@dhcp22.suse.cz>
 <db41c662-19ce-fc1a-21ba-38ecda7d09c8@bytedance.com>
 <Y0gP9i8KZKt4/EcG@dhcp22.suse.cz>
From:   Zhongkun He <hezhongkun.hzk@bytedance.com>
In-Reply-To: <Y0gP9i8KZKt4/EcG@dhcp22.suse.cz>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Thu 13-10-22 20:50:48, Zhongkun He wrote:
>>>> Hi Michal
>>>>
>>>> Could we try to change the MPOL_F_SHARED flag to MPOL_F_STATIC to
>>>> mark static mempolicy which cannot be freed, and mpol_needs_cond_ref
>>>> can use MPOL_F_STATIC to avoid freeing  the static mempolicy.
>>>
>>> Wouldn't it make more sense to get rid of a different treatment and
>>> treat all memory policies the same way?
>>
>> I found a case, not sure if it makes sense. If there is no policy
>> in task->mempolicy, the use of atomic_{inc,dec} can be skiped
>> according  to MPOL_F_STATIC. Atomic_{inc,dec} in hot path may reduces
>> performance.
> 
> I would start with a simple conversion and do any potential
> optimizations on top of that based on actual numbers. Maybe we can
> special case default_policy to avoid reference counting a default (no
> policy case). A simple check for pol == &default_policy should be
> negligible.

Got it, thanks for your reply and suggestions.


