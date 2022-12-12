Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A003764A6CE
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 19:19:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiLLSTG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 13:19:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbiLLSSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 13:18:32 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA54564FA
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:17:48 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id k88-20020a17090a4ce100b00219d0b857bcso776067pjh.1
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 10:17:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+XfBCuHWgnrIe/5OMSe2eafxHk9m0+iUqWGzU1q4pcw=;
        b=tRLnMlGNbWqak0IhpZeIcaT92eR/QSxIDiaqE7ut2xpn8x9+vjHmhT0arBBvb3owLE
         XLFb8uyJ5gcIHd62g5lqR1vStvTJ/8APasZq12//rN5aAo8OHi0kKzbHnDkI9ZW7Br8q
         /KY1oyvtGX9i5qkqfLYm0fsPYxgZwaG7UIvUoivMeGYgnew+3BVWI3bJ/rQl8U70ooKu
         FN7+/1ixBRhws5N8Jmoqdxdp10SpKHL1pUg72pDYNz5vsIdQGDN+4vyOhYGGLc7ZaKpV
         uaPkzgdgXgIEM6pwS0pDiAj1RnE4PXoVhKRVb7uMWWP2IZD3s6+nfw7/bVJA/pFVeqOt
         HQfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+XfBCuHWgnrIe/5OMSe2eafxHk9m0+iUqWGzU1q4pcw=;
        b=tJg8Zj5ei63kuBSDA3cY7pEtNOAClGRR7uYsxmlAtYn3oyw3Cbx0gdECcX8sxyZ+P6
         7miCW68kx7ljDYJPHAAQZpLr+Sh72y3YzWYJTteKGvFTgZ1b6XPVKLf9MKT5dBUlsTyI
         LltY7W/m4+fyicbPlc3RdAKMjmv+ErWVkxDwXP8aXK6CeY5vA0pzV4CDUFxgnvS9+/r2
         hDiHzQPsU2GRysy/0btBt0RTzCfGLKvLuBDR2f4czRhe0OsaktcMnCUxy3zrBqpnELc2
         9TA1nukSjSFGWoQehHgnEgO/6Ci7qtAKimwvZZGv+oP0Ij4YjojfLS4oxsg6QMDq4nRN
         Q/hQ==
X-Gm-Message-State: ANoB5plQgpZcI/zcCIv7aaZ3P065VRqCCScY40Fnya9jQZSbnxFeEM4G
        8bruhhiUDTJxEApYRLezwTjOKM0q2fhDrvolT1CmXw==
X-Google-Smtp-Source: AA0mqf49NCkD8G3vHLdJs+G80XOK9ewfS0ZTS5V4bZllHeoQUxrz4XOJZhVR5mt2uNfGOQx4qqFHvtagC3cYqvbstKE=
X-Received: by 2002:a17:90b:118e:b0:219:d5a6:400 with SMTP id
 gk14-20020a17090b118e00b00219d5a60400mr20573025pjb.44.1670869067972; Mon, 12
 Dec 2022 10:17:47 -0800 (PST)
MIME-Version: 1.0
References: <Y4r/iuqyLG4MOK4d@chenyu5-mobl1> <3A5DA66F-4330-4FC4-9229-998CF98F663E@joelfernandes.org>
 <Y42uH5fglluWYOm7@chenyu5-mobl1> <CAKfTPtA61DDk-VbNDvAycp8Et5fTwaOS=Q3559rBF7QDHDpJfQ@mail.gmail.com>
 <CABk29Nuc+VVOpAwFsbBo+OppayszebT29Hadc8qK-xeyZpY6NQ@mail.gmail.com>
 <Y5CiN010QAwklahh@chenyu5-mobl1> <e0b20fe3-6528-41ca-f53f-d78e76cd122a@huawei.com>
 <Y5c7oTIRIQYYkdW1@chenyu5-mobl1>
In-Reply-To: <Y5c7oTIRIQYYkdW1@chenyu5-mobl1>
From:   Josh Don <joshdon@google.com>
Date:   Mon, 12 Dec 2022 10:17:35 -0800
Message-ID: <CABk29NvsBbqop20Z8-mdnZpto+Znc_+93OK9dsVMcimsSOf1xQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] sched/fair: Introduce short duration task check
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Yicong Yang <yangyicong@huawei.com>, yangyicong@hisilicon.com,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Honglei Wang <wanghonglei@didichuxing.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Tim Chen <tim.c.chen@intel.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Juri Lelli <juri.lelli@redhat.com>,
        Rik van Riel <riel@surriel.com>,
        Aaron Lu <aaron.lu@intel.com>,
        Abel Wu <wuyun.abel@bytedance.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        Ingo Molnar <mingo@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>,
        Hillf Danton <hdanton@sina.com>,
        Len Brown <len.brown@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Tianchen Ding <dtcccc@linux.alibaba.com>,
        linux-kernel@vger.kernel.org
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

> BTW, I've changed the threshold to (sysctl_sched_min_granularity / 8) in my next
> version, as this is the value that fit my previous test case and also not to break
> the case Josh mentioned.

Do you mean a hardcoded value of some number of micros, or literally
sched_min_granularity / 8? I don't think the latter is necessary, and
indeed can lead to weirdness if min_gran is too small or too large. I
don't think the concept of what a short duration task is should
expand/contract with min_gran.

Best,
Josh
