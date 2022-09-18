Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5B25BBDDD
	for <lists+linux-kernel@lfdr.de>; Sun, 18 Sep 2022 14:54:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229650AbiIRMx4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 18 Sep 2022 08:53:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229633AbiIRMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 18 Sep 2022 08:53:53 -0400
Received: from mail-ej1-x629.google.com (mail-ej1-x629.google.com [IPv6:2a00:1450:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDE4424975
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 05:53:51 -0700 (PDT)
Received: by mail-ej1-x629.google.com with SMTP id l14so58806265eja.7
        for <linux-kernel@vger.kernel.org>; Sun, 18 Sep 2022 05:53:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=colorfullife-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=SKbV4mKu73VuNVhI6M2LnjoCEeDVwapxGXXk0hJK72A=;
        b=hV99jqFA22d1stSPIYXXgvzHWcel2GEqsbeq4BhConbSE5mTOzF+3xlTYLreDCdzxG
         XSm4GFjqsgiBt6MdTtu/2bi9mmZSxpz6ZYe2bzc0Fyc+CBwhh+j+1zwgyjr9esh1nDMi
         eyBf0iOkyGw8ysWe104/TMzgGsfkiv5hpGr3ZSFMranOWu4amLO5dwAfXvUDJ3l8qNsL
         uTTmn5Kq8x43B6/46Vja1NRQefsKldJF3h5TMxjriKkaAZh0ialpdk3KpLnhZlcMYzAr
         pyGLA3eksF+plpo6ZBQhneTWU5q/Tgo/195LpX8LIN5dH2XhJZtrtAe8WPV1XiGMVfzK
         ooVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=SKbV4mKu73VuNVhI6M2LnjoCEeDVwapxGXXk0hJK72A=;
        b=5IJBIg4siMb+4NToKWR7pdxO3bgdNbj1qTcPoiHdeCQSDod5qVa/j9ZYyTsv2MjU+1
         OH5s4QSSkKkwo8xNEQLDwifGaclS+zNemWqTC9k+Zau+SeFnOHGFtUoYCRJRgC0W+wG6
         d7TSkqtI0K9GU4ydYlGBRCTrK0BASmuk2PSIRA/oXpBcokAZbLengT6kEfsNhnPMXY0V
         DSoSl1pc953ZtO/D/vRSa96awq2r4LuKjAEkfq8HTS225RkJ0l7WFfLgmKpZQ1Pb/yhm
         7h5WPwir6BFrq0a4gNdsjV4JbxI4Pi9zLNCVQBSIzqGx3Y+vlkUqEMUZJMUjcZInMXLV
         xLNQ==
X-Gm-Message-State: ACrzQf0/jDEMrt/IIAtrd5sDBFeGhcHbmgD/kmbXSaWW27QUwmSuZVhI
        h5p9q4pEBcIzFgXlphVJzIivLw==
X-Google-Smtp-Source: AMsMyM5p9fT6KbixCtDQelPo6TexlnkeLzgg0KUT3L5ZYXpyMzuHG4brcM9ThyTJoBHM8JmB+XDFHQ==
X-Received: by 2002:a17:907:7e94:b0:77a:c48b:c80 with SMTP id qb20-20020a1709077e9400b0077ac48b0c80mr9096922ejc.690.1663505630489;
        Sun, 18 Sep 2022 05:53:50 -0700 (PDT)
Received: from ?IPV6:2003:d9:9726:8300:b088:c09:537d:ce99? (p200300d997268300b0880c09537dce99.dip0.t-ipconnect.de. [2003:d9:9726:8300:b088:c09:537d:ce99])
        by smtp.googlemail.com with ESMTPSA id 2-20020a170906210200b00715a02874acsm13955267ejt.35.2022.09.18.05.53.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 18 Sep 2022 05:53:49 -0700 (PDT)
Message-ID: <aadf6c7e-dea8-4dff-1815-cca9c2c2da9e@colorfullife.com>
Date:   Sun, 18 Sep 2022 14:53:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v6 2/2] ipc/msg: mitigate the lock contention with percpu
 counter
Content-Language: en-US
To:     Jiebin Sun <jiebin.sun@intel.com>, akpm@linux-foundation.org,
        vasily.averin@linux.dev, shakeelb@google.com, dennis@kernel.org,
        tj@kernel.org, cl@linux.com, ebiederm@xmission.com,
        legion@kernel.org, alexander.mikhalitsyn@virtuozzo.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Cc:     tim.c.chen@intel.com, feng.tang@intel.com, ying.huang@intel.com,
        tianyou.li@intel.com, wangyang.guo@intel.com,
        Tim Chen <tim.c.chen@linux.intel.com>
References: <20220902152243.479592-1-jiebin.sun@intel.com>
 <20220913192538.3023708-1-jiebin.sun@intel.com>
 <20220913192538.3023708-3-jiebin.sun@intel.com>
From:   Manfred Spraul <manfred@colorfullife.com>
In-Reply-To: <20220913192538.3023708-3-jiebin.sun@intel.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jiebin,

On 9/13/22 21:25, Jiebin Sun wrote:
> The msg_bytes and msg_hdrs atomic counters are frequently
> updated when IPC msg queue is in heavy use, causing heavy
> cache bounce and overhead. Change them to percpu_counter
> greatly improve the performance. Since there is one percpu
> struct per namespace, additional memory cost is minimal.
> Reading of the count done in msgctl call, which is infrequent.
> So the need to sum up the counts in each CPU is infrequent.
>
> Apply the patch and test the pts/stress-ng-1.4.0
> -- system v message passing (160 threads).
>
> Score gain: 3.99x
>
> CPU: ICX 8380 x 2 sockets
> Core number: 40 x 2 physical cores
> Benchmark: pts/stress-ng-1.4.0
> -- system v message passing (160 threads)
>
> Signed-off-by: Jiebin Sun <jiebin.sun@intel.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
Reviewed-by: Manfred Spraul <manfred@colorfullif.com>
> @@ -495,17 +496,18 @@ static int msgctl_info(struct ipc_namespace *ns, int msqid,
>   	msginfo->msgssz = MSGSSZ;
>   	msginfo->msgseg = MSGSEG;
>   	down_read(&msg_ids(ns).rwsem);
> -	if (cmd == MSG_INFO) {
> +	if (cmd == MSG_INFO)
>   		msginfo->msgpool = msg_ids(ns).in_use;
> -		msginfo->msgmap = atomic_read(&ns->msg_hdrs);
> -		msginfo->msgtql = atomic_read(&ns->msg_bytes);
> +	max_idx = ipc_get_maxidx(&msg_ids(ns));
> +	up_read(&msg_ids(ns).rwsem);
> +	if (cmd == MSG_INFO) {
> +		msginfo->msgmap = percpu_counter_sum(&ns->percpu_msg_hdrs);
> +		msginfo->msgtql = percpu_counter_sum(&ns->percpu_msg_bytes);

Not caused by your change, it just now becomes obvious:

msginfo->msgmap and ->msgtql are type int, i.e. signed 32-bit, and the 
actual counters are 64-bit.
This can overflow - and I think the code should handle this. Just clamp 
the values to INT_MAX.

-- 

     Manfred


