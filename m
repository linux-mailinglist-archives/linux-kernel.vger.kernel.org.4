Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1191474D4C1
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:47:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230433AbjGJLrD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:47:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjGJLrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:47:02 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BFF3BB
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:47:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1688989619; x=1720525619;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=w4dV9H7pVRIxcuMaxlX5D7urUgvVv34X8a5DfkzUas0=;
  b=GKqYzjh9sjHYIui09Jbn0W4Y9NnCEQVOSKtGB6spwCS8hfoJ493ayNaL
   tRamP6ZJgRJlwmAQHw106pmQCN8uk9M648q3tM+Lmapr5EGW9dmvgTGpr
   R9m6CFDal3EXQltJM2xpWe5MZguwb0aiZ7ADZCOH77o9lOWB4ryeX1xl9
   P4r9SNhLvDHiHa8xCFyQxBgLRxj/bGj79mBLKT4xuJyV+RpPgfvLgYndt
   AAHxY2SxaukdqY2dnUsmT9cWNRStXeGQJLRqD0Lm6O7yiwxMHGmNjAwGh
   cLwMiiNGI4IGYo4dLqZDMX9ceI8vlGQP6Cv8SHrOXbd7wJ846m1Rv/FOo
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="366895492"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="366895492"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 04:46:58 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10766"; a="834244024"
X-IronPort-AV: E=Sophos;i="6.01,194,1684825200"; 
   d="scan'208";a="834244024"
Received: from stoicaan-mobl.ger.corp.intel.com (HELO localhost) ([10.252.52.170])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Jul 2023 04:46:57 -0700
From:   Jani Nikula <jani.nikula@linux.intel.com>
To:     suijingfeng <suijingfeng@loongson.cn>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>
Cc:     loongson-kernel@lists.loongnix.cn,
        Dan Carpenter <dan.carpenter@linaro.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org
Subject: Re: [PATCH] drm/loongson: Remove a useless check in
 cursor_plane_atomic_async_check()
In-Reply-To: <8182fecd-d290-293a-d963-ddbea79dbf03@loongson.cn>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
References: <20230710102411.257970-1-suijingfeng@loongson.cn>
 <6c7bbce7-5521-b868-019f-bce26f309730@suse.de>
 <8182fecd-d290-293a-d963-ddbea79dbf03@loongson.cn>
Date:   Mon, 10 Jul 2023 14:46:54 +0300
Message-ID: <87r0pghtu9.fsf@intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 10 Jul 2023, suijingfeng <suijingfeng@loongson.cn> wrote:
> On 2023/7/10 18:39, Thomas Zimmermann wrote:
>> but that driver is not yet in our tree?
>>
>
> I already applied(push) drm/loongson driver to drm-misc-next branch,
>
> What do you means that by "not yet in our tree", linux kernel side?
>
> Am I missing something ?

Hmm, indeed there's commit f39db26c5428 ("drm: Add kms driver for
loongson display controller")... but it only has one Acked-by from
Thomas that I can't find on any lists, and zero Reviewed-by.

Usually, the bigger the change, the more acks/reviews you need. Did
Thomas really ack this to be merged without recorder reviews? :o


BR,
Jani.


-- 
Jani Nikula, Intel Open Source Graphics Center
