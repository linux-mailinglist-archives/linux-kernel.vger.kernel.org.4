Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A8C774D964
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 17:00:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233263AbjGJPAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 11:00:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231438AbjGJO77 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 10:59:59 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4005011A
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:59:32 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4fb7b2e3dacso7184517e87.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance.com; s=google; t=1689001170; x=1691593170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=WHR2WMJHyhNBH5ZT3Q1RZDBVx9mfa7kaDZFV2zZ72Ww=;
        b=Le27rs3WECyaK18VKxayFVkBGweMznr5HZ2oGqvoMXtcGJHUZr5T8rvIGsfMEVJ8Ed
         Gxw8bEHkvgkAcj3psTDWLqN/h7P8RlLx4UORMWNXQvC3BFNcRSJsumdlJvaOQTtefnEm
         uB3r35Gj8NEc5VFRY8S3oCp5Evn4lZ2PvrFIVzhlEnx2qeYf3Rhy1Jpz+hDS+PTcB1+d
         ls6Wfs8U6ppK5ORoA1iBP6x7DKtKqf+WqlF64Hyn8kkoJBq8ElwtP+yFYokF1KxYZkMl
         4UNEl4goJfldztpoV+lbI3im7qC4CQ0cwvzP8hwB/0uSUXcqbM8qe+LcOZnx1wHF+wrk
         tpXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1689001170; x=1691593170;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WHR2WMJHyhNBH5ZT3Q1RZDBVx9mfa7kaDZFV2zZ72Ww=;
        b=kn3vS4cVLFRZXSAT4t4qp6p2j2ucgV001p9heeJxeGQO2jp4lIB4QjZK/dkluveT/u
         X1WiClBXLBqTkVjjws9x2VpPKBoW+1NRo5+GW4QWPbFAhQLnAkivxwbphcmUpaq2y4ao
         17VaHtBhCAQJAJI3/QqztkK8J1hf0NlIN3xJITOTQSqREE1Jsp3dXPaeQedkQfyDwcna
         kVZCZgTKPIKKFx+hG1vImrIOQYU3Q/rrSooQkLlG1ZFeToCjhE8Cv7tAO9qtl/tsU0z2
         Ycj1xAK+X7du+oAjzSlOTJaOdHzku89J9QV6oWCNiAqp/g9wP16FNbu2J+WlIlXKPizU
         y1tQ==
X-Gm-Message-State: ABy/qLZPYx3o6W7Jlej4GMu1HK634CRGXITZbugm7BVgx5L1a10PUDhA
        aQAWlftTr8PBNA8qtNh45dwPvnzf40tkXo2g0stLLg==
X-Google-Smtp-Source: APBJJlGiRrXZU17h177ynrv1JY0VYTE8itWE/BdTFgxmRh8eY8Fs8de2BqiUpS4VkSVxQ1MVKxX+X35Zgs+eCQgd6JY=
X-Received: by 2002:ac2:58e4:0:b0:4fb:9772:6639 with SMTP id
 v4-20020ac258e4000000b004fb97726639mr8786868lfo.6.1689001170542; Mon, 10 Jul
 2023 07:59:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230707044707.1169285-1-hezhongkun.hzk@bytedance.com> <ZKvi4ZvhQaIFtSvg@dhcp22.suse.cz>
In-Reply-To: <ZKvi4ZvhQaIFtSvg@dhcp22.suse.cz>
From:   =?UTF-8?B?6LS65Lit5Z2k?= <hezhongkun.hzk@bytedance.com>
Date:   Mon, 10 Jul 2023 22:59:18 +0800
Message-ID: <CACSyD1M9ad6wTeT-jAtAyWz2LztLrRok8bVT56+Xbx-NReRe7g@mail.gmail.com>
Subject: Re: [External] Re: [RFC PATCH 2/2] zram: charge the compressed RAM to
 the page's memcgroup
To:     Michal Hocko <mhocko@suse.com>
Cc:     minchan@kernel.org, senozhatsky@chromium.org, david@redhat.com,
        yosryahmed@google.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>
> AFAICS your obj_cgroup_charge_zram doesn't have gfp argument.
>
> Anyway, memalloc_noreclaim_save is an abuse IMHO (the primary purpose of
> the flag is to prevent recursion into the memory reclaim). Do you really
> can not perform any memory recalim to trigger to free up some memory if
> the memcg is at the hard limit boundary?
>

Got it . I agree, memalloc_noreclaim_save should not be used, but return nomem
directly,which is more clear and satisfies both direct and indirect usage.
