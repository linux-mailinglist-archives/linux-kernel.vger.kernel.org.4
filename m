Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484C7606867
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 20:48:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiJTSsD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 14:48:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230090AbiJTSr6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 14:47:58 -0400
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com [IPv6:2607:f8b0:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4D3520B13F
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:47:54 -0700 (PDT)
Received: by mail-pf1-x42b.google.com with SMTP id i3so363407pfc.11
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 11:47:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=XES49IrsE/SNg2Wiu5FQcJL1HnVmIEJ2XPODG9d1kGs=;
        b=TGOPgfy40MWjEd7IhcI1/ZW6PxJ+EOtNf6zzdZbHKPpf+3R7WFtDhCDtLiFdmN9REE
         D7EiKdWDaucHF/mgXN/rznmUkhCewUtED5WBFM1MYa3eUevu75Fb5U0uigdkyRsb9vKZ
         fAAAYkbVrEQhWKWPp+6hvS6ttYZZZI9IbrHulloOQxkYnB5uKnfgekkeTsl3oDqKlHpu
         otcVRlTtkB0slFRegMp1ezvKn6Edzw4/aPc228rKocalKthJOy/MgEFXKw7vj3yZbsJn
         LS9zdfvUX1Y0DQ+jjQvOrCHAiy5/YfaIJEHZRW/hvApi8kPTZgNC2zQRw/J2A9EXtelD
         cs8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=XES49IrsE/SNg2Wiu5FQcJL1HnVmIEJ2XPODG9d1kGs=;
        b=4IRaHtMdTuHBL/m4nqEgigxGwngw52c9fyyrCZE7PhEu5IHDIaW0eTnqKMdVILum6z
         vvTlfhCCA8tMzvRD0UkbQ5qJyBDjL95w09QbpunCWKrsTgZZsYLabRTRoh6uYXkyQqqZ
         6JEzIb41/gejLci61X/0OF1XsxJMH1gkXEDm+WPEy+GBXCC8dM1ALAh2dqRz9ZPrkon0
         srndK+1JYGtmMjSFALQuFQk5qihxqh7QXW0IJe33bRs98TZ6vHpHHI87P925gNkU2iMy
         9cpeU1ZWzfowX8cRUutRJwKFq4Xzlq4MJDtCB1PEn9UyfQpcb4QNC3Odi8ZhBH13ov2M
         4H7w==
X-Gm-Message-State: ACrzQf03vqJFDDtseDkm1Rc+Ar8I25i0am4GPPEbiB9n6GZ6PXVFXeoT
        TrnuOyxia4A8xeCoOpuCwoy5J9e7jGb/N6jOerg=
X-Google-Smtp-Source: AMsMyM5ebdgIUi5uCKboyyRksMvDQjr91KEFedSkJbNcScR1hzEnwJL775AUWPR+H9D9E6Ry/4kaqDau0rrS8pOuzsc=
X-Received: by 2002:aa7:9dcb:0:b0:565:89a8:c708 with SMTP id
 g11-20020aa79dcb000000b0056589a8c708mr15595214pfq.4.1666291674290; Thu, 20
 Oct 2022 11:47:54 -0700 (PDT)
MIME-Version: 1.0
References: <20221020015122.290097-1-ying.huang@intel.com>
In-Reply-To: <20221020015122.290097-1-ying.huang@intel.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 20 Oct 2022 11:47:41 -0700
Message-ID: <CAHbLzko3sz9wAYidPr7NjMUWYrB0oN1R0MuCHdyDe=FdWRwWUQ@mail.gmail.com>
Subject: Re: [PATCH] memory tier, sysfs: rename attribute "nodes" to "nodelist"
To:     Huang Ying <ying.huang@intel.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
        Alistair Popple <apopple@nvidia.com>,
        Bharata B Rao <bharata@amd.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Jagdish Gediya <jvgediya.oss@gmail.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Michal Hocko <mhocko@kernel.org>,
        Tim Chen <tim.c.chen@intel.com>, Wei Xu <weixugc@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 6:51 PM Huang Ying <ying.huang@intel.com> wrote:
>
> In sysfs, we use attribute name "cpumap" or "cpus" for cpu mask and
> "cpulist" or "cpus_list" for cpu list.  For example, in my system,
>
>  $ cat /sys/devices/system/node/node0/cpumap
>  f,ffffffff
>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus
>  0,00100004
>  $ cat cat /sys/devices/system/node/node0/cpulist
>  0-35
>  $ cat /sys/devices/system/cpu/cpu2/topology/core_cpus_list
>  2,20
>
> It looks reasonable to use "nodemap" for node mask and "nodelist" for
> node list.  So, rename the attribute to follow the naming convention.
>
> Signed-off-by: "Huang, Ying" <ying.huang@intel.com>
> Cc: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> Cc: Alistair Popple <apopple@nvidia.com>
> Cc: Bharata B Rao <bharata@amd.com>
> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Dave Hansen <dave.hansen@intel.com>
> Cc: Davidlohr Bueso <dave@stgolabs.net>
> Cc: Hesham Almatary <hesham.almatary@huawei.com>
> Cc: Jagdish Gediya <jvgediya.oss@gmail.com>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Cc: Michal Hocko <mhocko@kernel.org>
> Cc: Tim Chen <tim.c.chen@intel.com>
> Cc: Wei Xu <weixugc@google.com>
> Cc: Yang Shi <shy828301@gmail.com>
> ---
>  Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers | 4 ++--
>  mm/memory-tiers.c                                      | 8 ++++----
>  2 files changed, 6 insertions(+), 6 deletions(-)

Reviewed-by: Yang Shi <shy828301@gmail.com>

>
> diff --git a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> index 45985e411f13..721a05b90109 100644
> --- a/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> +++ b/Documentation/ABI/testing/sysfs-kernel-mm-memory-tiers
> @@ -10,7 +10,7 @@ Description:  A collection of all the memory tiers allocated.
>
>
>  What:          /sys/devices/virtual/memory_tiering/memory_tierN/
> -               /sys/devices/virtual/memory_tiering/memory_tierN/nodes
> +               /sys/devices/virtual/memory_tiering/memory_tierN/nodelist
>  Date:          August 2022
>  Contact:       Linux memory management mailing list <linux-mm@kvack.org>
>  Description:   Directory with details of a specific memory tier
> @@ -21,5 +21,5 @@ Description:  Directory with details of a specific memory tier
>                 A smaller value of N implies a higher (faster) memory tier in the
>                 hierarchy.
>
> -               nodes: NUMA nodes that are part of this memory tier.
> +               nodelist: NUMA nodes that are part of this memory tier.
>
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index f116b7b6333e..fa8c9d07f9ce 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -131,8 +131,8 @@ static void memory_tier_device_release(struct device *dev)
>         kfree(tier);
>  }
>
> -static ssize_t nodes_show(struct device *dev,
> -                         struct device_attribute *attr, char *buf)
> +static ssize_t nodelist_show(struct device *dev,
> +                            struct device_attribute *attr, char *buf)
>  {
>         int ret;
>         nodemask_t nmask;
> @@ -143,10 +143,10 @@ static ssize_t nodes_show(struct device *dev,
>         mutex_unlock(&memory_tier_lock);
>         return ret;
>  }
> -static DEVICE_ATTR_RO(nodes);
> +static DEVICE_ATTR_RO(nodelist);
>
>  static struct attribute *memtier_dev_attrs[] = {
> -       &dev_attr_nodes.attr,
> +       &dev_attr_nodelist.attr,
>         NULL
>  };
>
> --
> 2.35.1
>
