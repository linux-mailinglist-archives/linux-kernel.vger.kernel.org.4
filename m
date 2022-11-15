Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6E5F629280
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 08:35:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232312AbiKOHfh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 02:35:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231966AbiKOHfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 02:35:32 -0500
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5F4E65B2;
        Mon, 14 Nov 2022 23:35:27 -0800 (PST)
Received: by mail-pl1-x62d.google.com with SMTP id b21so12387420plc.9;
        Mon, 14 Nov 2022 23:35:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=nnMVi0OBBT8B9lLKo4PxxDOhksXvtuMX1YZVM1HxTMs=;
        b=YaIonodup6DSuDeM4MzZ7M6fMzi8x59lXwRwP4SVS4WmsvxpEtOB/N+MJk0yWjYk7Y
         nHytr//UzEfkhug9h+QQLxNEj8WlbXNqEIyKRhjGjQmuL5LYgl2q6I9VzkmaG4sxXeE9
         h3FbNBKa5SOJz1VEE3F/VXO5jld/71DlPglPSaw2eKYKi/EuXJ9q5TpffX5gjpFvTknf
         ECCLoKwEmyAiTr2LT44pPx48M9T/gT9cVdj7jW6DqZODgujqqPXIdDbXPkQJxUxYxIv/
         LCQSY+1kZOD7T7uCsKdL5hktJYWo/asxQ/KzKuRt5PBbwWVdEdLof5ej0y/0TV+YimP+
         vGsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nnMVi0OBBT8B9lLKo4PxxDOhksXvtuMX1YZVM1HxTMs=;
        b=m2Lyb+9H0Yu6NvevpAG0TJLbUOL0L+jSyEdMGHeFBD7bXTFQ8dwrOaS2FZ4RhCZgkj
         pe7FQSu3AHL0F20+ZczdzgwLD+lWZE2y4XElCvEfID+q6D21TEVrpJ13OdmrpZYGPFyJ
         0Plh8cXAsIaoRNJ5sZlza8opU4gfbqfjKamIWVsQHWo1iAHjfm/plvIDozefLwc6mdbt
         CVyJx/FZ9IMwgVXPrAbAX36eUdtR+wuHdcHhbOK+LFoRzfBDxbmCxW7ERsC86juesDtV
         6Vg8T58cem+Wv0oseJhNDxrxIk6ZDUkcigW7KPoSK6aAiCnTpsFF9Iip40x07m1dNufy
         9fJA==
X-Gm-Message-State: ANoB5pnUXiSpMC7ViDx15OfjW8GxuabhhW5mpcy8vEEh2S1b3BZEphCQ
        sQxgXoR5kgZGigmjlBaiT5qVZc4tTxdYaA==
X-Google-Smtp-Source: AA0mqf4grdEN4O8XTlELm99qpeqMpnYLVd0a1Pg1gOLorFA5ScnFuuDACbNP2fwflz9mPlM3DH/K3g==
X-Received: by 2002:a17:902:e013:b0:184:cb7e:ba36 with SMTP id o19-20020a170902e01300b00184cb7eba36mr2861310plo.57.1668497727427;
        Mon, 14 Nov 2022 23:35:27 -0800 (PST)
Received: from [192.168.43.80] (subs02-180-214-232-13.three.co.id. [180.214.232.13])
        by smtp.gmail.com with ESMTPSA id l2-20020a635702000000b0046ec057243asm6955722pgb.12.2022.11.14.23.35.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 14 Nov 2022 23:35:27 -0800 (PST)
Message-ID: <3a00467c-7f78-e2ba-33d6-06caf523a183@gmail.com>
Date:   Tue, 15 Nov 2022 14:35:19 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH v13 2/2] Documentation: Add document for UltraSoc SMB
 drivers
To:     hejunhao <hejunhao3@huawei.com>
Cc:     mathieu.poirier@linaro.org, suzuki.poulose@arm.com,
        mike.leach@linaro.org, leo.yan@linaro.org,
        jonathan.cameron@huawei.com, john.garry@huawei.com,
        coresight@lists.linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        lpieralisi@kernel.org, linuxarm@huawei.com, yangyicong@huawei.com,
        liuqi115@huawei.com, f.fangjian@huawei.com,
        prime.zeng@hisilicon.com
References: <20221114090316.63157-1-hejunhao3@huawei.com>
 <20221114090316.63157-3-hejunhao3@huawei.com> <Y3JJSfVoatl5yKlm@debian.me>
 <a6adaeec-182c-140d-9925-45f659b4eef2@huawei.com>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <a6adaeec-182c-140d-9925-45f659b4eef2@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/15/22 14:33, hejunhao wrote:
> Hi Bagas,
> 
> will apply the fix  in next version.
> Thank you very much.
> 

Please don't top-post, reply inline with appropriate context instead.
I had to trim all the below context as a result.

-- 
An old man doll... just what I always wanted! - Clara

