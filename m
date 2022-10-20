Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0D7605617
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 05:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiJTDs6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 23:48:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJTDsz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 23:48:55 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE221911ED
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:48:54 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id g8-20020a17090a128800b0020c79f987ceso2116049pja.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 20:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=B380SWXebweddYWftA/qmfI+PBISJKmsY//1dGFA34Y=;
        b=BrcYjOt+lNbt807LHYSocYLkoCaQNb83vMwI/1ctLUHaxHhLhyKv9Ij1+8ks4RneKJ
         J/g8aXjdp3XQ3Etk5c068Ho2u5JmBVPCPpmDcNWojCbnWxaRiBCFlbGvIo2E4zJ4tHH5
         ZlTIi0qeIkj7ox9z/VSBhzUptUrnzvGCna5JpAEc1IA3WqmUccttjWVOjUkaUxy6vrt0
         n7acSvKhjQs3ihYdWCpf+YU3A0mxgqyv/kGusUeBG+sycELh0aDyOS1pwKmbb5JtMSZj
         DjUjjgLLeiuKHjPPnYTXOIJ+vHwFS30pDK7J6Fg9sQHpCCWVOoOXDAcnGgFb9fvzrKuj
         czMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=B380SWXebweddYWftA/qmfI+PBISJKmsY//1dGFA34Y=;
        b=iCazglxhbB+ySikIvTvlKun21KEGvcsyrd8Oy+sqePfNswIqpLZZRMSLCiFB+lMnLD
         wXYX1BhPhfw5tEk3VehWra7mw4cUcVLW+CVy1QFoKXOChnnjcKT/XT2jb5BXYZz821yx
         X+meaxvtGuwNwsUA6fjbSb4djp38wFh1twc89A23OWYAClIQPVINTggF2wkaHMiTSU3a
         GV5DraTHDv2eXn1bETExdu46ik7im0ss2zB8gyWxhpPvapAYuTh/kVc/+dGgQIu040cr
         yMHB37mcJiPKbxypIHlxHVi10qhgOKRbg2uIIxFy101+aj3gegoBnhGFyYCZ2PQ8VY6O
         U6aw==
X-Gm-Message-State: ACrzQf3UCphOsH3c8egeNqeXgcSDX/s4y51MFo7gaLJracp94Gtd/5gO
        Ev1YVa/ZkAmGJMLc4Sk2KEfGRulUnVbXgPkjiAFBWg==
X-Google-Smtp-Source: AMsMyM6A31FdFe4Ict2geH7wrxfgdUz7KrLM3nmEIPCNt/BBVnzE9MQUlNTc6j6lJqsIUZHjriQPE4vhPXmq5heIgZE=
X-Received: by 2002:a17:90b:1c82:b0:1ee:eb41:b141 with SMTP id
 oo2-20020a17090b1c8200b001eeeb41b141mr14026932pjb.143.1666237733772; Wed, 19
 Oct 2022 20:48:53 -0700 (PDT)
MIME-Version: 1.0
References: <20221020015122.290097-1-ying.huang@intel.com>
In-Reply-To: <20221020015122.290097-1-ying.huang@intel.com>
From:   Wei Xu <weixugc@google.com>
Date:   Wed, 19 Oct 2022 20:48:41 -0700
Message-ID: <CAAPL-u9M+TfSVX-__SyicDURywn6b163WqmdRNhc0yr6ScdFYA@mail.gmail.com>
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
        Tim Chen <tim.c.chen@intel.com>, Yang Shi <shy828301@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Acked-by: Wei Xu <weixugc@google.com>

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
