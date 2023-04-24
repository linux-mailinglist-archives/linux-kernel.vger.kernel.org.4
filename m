Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B68926D8DD9
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 05:07:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234400AbjDFDGi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 23:06:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235288AbjDFDEt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 23:04:49 -0400
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9E593E6
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 20:04:47 -0700 (PDT)
Received: by mail-pj1-x102f.google.com with SMTP id q102so36015074pjq.3
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 20:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1680750287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=I6yh5TVA4X0pNlhI29hqbF1nPgXkZ+EttVkjMKTBPRM=;
        b=H/G3HG3/REfnaZRUDzKbPBsB6d2/809SMnmKvLg15G3GN0Ij5mz2N8PBDS/CJiWpPJ
         89wOAYBeD7KnaF+3S0NNJHXNaZPDrnHv4r/zIcEaf//rUurbeUMP3hBr7EIEhFezKuTO
         eDl2NQJSyX/tddla5wTvSkFaz6vgr6MZo60gPnUC73rNWoXKer0HW3RX0YjZDarngYnt
         iyk9A5SkZK8nobOFokMCZuqnaZc0RhUlL1lMQIeA7dALyNL/bM4rrYekQbhx0Uqf5R46
         N/0wSvk+f68cZPPJ20bvxGlqhXh2gfWGw1vH9b/aUblowF5EbS9a+XLy4QyakngwOuRO
         zJIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680750287;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=I6yh5TVA4X0pNlhI29hqbF1nPgXkZ+EttVkjMKTBPRM=;
        b=Wp9tacIGK9zmcPD7IvM0z4RG5+mwF7ihmDyA5nc4lPpKLeoHUZZPGuGFEkNfLxuSLw
         IM4DEBBG11Neydylc4TGWAsLht0fE/Co1remMoPk84qePWfUkGKa4A4LvgreWhxhcFZ0
         8A1H5fmpEGTVomP5QvwXycEemqAhD9/MrAKuj5cboFoag762xTRXcQ85RHksAPKOJ2NB
         titpJ5YAPqPTFyuPuJvPW7U5Y59Lg03B8fthfIh8wVV0EQbKVbgNZxxopsaP9w2HERbb
         h5fqa4zwnAJcbWMq+LL097C3S9e7ZBrqLxOeaG5EqzGvaGPDtq8AxMhCh1rtEwQ+v5qW
         VDDQ==
X-Gm-Message-State: AAQBX9dMfS5HXQxhPkuVBgXIucTK5t3hJVipiXn7k83GDTLdCOe6XOcv
        IPtNq1ORYSwRjkp1Z/pa2BH80Q==
X-Google-Smtp-Source: AKy350bE4izuVTZUJG7qu52uh7NJ4PxeQjWyjg8teir4uQzevbdger9SZCgHPIL+xwJosjxMLaae3g==
X-Received: by 2002:a17:90b:1649:b0:23f:dd27:169e with SMTP id il9-20020a17090b164900b0023fdd27169emr9247636pjb.17.1680750287283;
        Wed, 05 Apr 2023 20:04:47 -0700 (PDT)
Received: from [10.2.117.253] ([61.213.176.13])
        by smtp.gmail.com with ESMTPSA id c10-20020a17090abf0a00b00240015b837fsm4891739pjs.2.2023.04.05.20.04.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 20:04:46 -0700 (PDT)
Message-ID: <88d1fd6b-f98e-c682-5e94-4725a9055f0c@bytedance.com>
Date:   Thu, 6 Apr 2023 11:04:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.9.0
Subject: Re: Re: [PATCH v2] mm: oom: introduce cpuset oom
Content-Language: en-US
To:     Waiman Long <longman@redhat.com>, Michal Hocko <mhocko@suse.com>
Cc:     rientjes@google.com, linux-kernel@vger.kernel.org,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org,
        rientjes@google.com, linux-kernel@vger.kernel.org,
        Waiman Long <longman@redhat.com>,
        Zefan Li <lizefan.x@bytedance.com>, cgroups@vger.kernel.org
References: <20230404115509.14299-1-ligang.bdlg@bytedance.com>
 <ZCw0sR6IqYa5Es7Q@dhcp22.suse.cz>
 <342c1967-8a68-275c-042e-765d5993157c@redhat.com>
From:   Gang Li <ligang.bdlg@bytedance.com>
In-Reply-To: <342c1967-8a68-275c-042e-765d5993157c@redhat.com>
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


On 2023/4/4 22:31, Michal Hocko wrote:
 > [CC cpuset people]
 >
 >
 > This should go into more details about the usecase, testing and ideally
 > also spend couple of words about how CONSTRAINT_CPUSET is actually
 > implemented because this is not really immediately obvious. An example
 > of before/after behavior would have been really nice as well.
 >
 > You should also go into much more details about how oom victims are
 > actually evaluated.
 >
 > As this is a userspace visible change it should also be documented
 > somewhere  in Documentation.
 >
 > I am not really familiar with cpusets internals so I cannot really judge
 > cpuset_cgroup_scan_tasks implementation.
 >
 > The oom report should be explicit about this being CPUSET specific oom
 > handling so unexpected behavior could be nailed down to this change so I
 > do not see a major concern from the oom POV. Nevertheless it would be
 > still good to consider whether this should be an opt-in behavior. I
 > personally do not see a major problem because most cpuset deployments I
 > have seen tend to be well partitioned so the new behavior makes more
 > sense.
 >

On 2023/4/5 01:24, Waiman Long wrote:
 >
 > You will also need to take cpuset_rwsem to make sure that cpusets are
 > stable. BTW, the cpuset_cgroup_scan_tasks() name is kind of redundant. I
 > will suggest you just name it as cpuset_scan_tasks(). Please also add a
 > doctext comment about its purpose and how it should be used.


Thank you all. I will make the following changes and send v3.

1. Provide more details about the use case, testing, and implementation 
of CONSTRAINT_CPUSET, including an example of before/after behavior.

2. Provide more details about how OOM victims are evaluated.

3. Document the userspace visible change in Documentation.

4. Add an option /proc/sys/vm/oom_in_cpuset for cpuset oom.

5. Rename cpuset_cgroup_scan_tasks() to cpuset_scan_tasks() and add a 
doctext comment about its purpose and how it should be used.

6. Take cpuset_rwsem to ensure that cpusets are stable.


