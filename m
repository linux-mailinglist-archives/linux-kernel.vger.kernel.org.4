Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8227C6DD372
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230476AbjDKGw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 02:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230252AbjDKGwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 02:52:43 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61E1340D7
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:52:10 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id d2e1a72fcca58-6343fe70a2aso683158b3a.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Apr 2023 23:52:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google; t=1681195901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KlxuVrTXd7ERz588z7U+eZpNrX8JYOeBVv8I4S7vc10=;
        b=FToH5sNIXgA98Z2/xnoL6eiMqcGn+g4OwC5NmpIX47R/Wh24/AVqhSttBiaHjxcwi9
         Wd/lHvrVCQNYeZjeEEiMOq4pv7l01a6iR9yVvKp3GaHe2moQP2DZuGkYizqbv5iv4jJp
         admwOSz07PguwdAu82mL6e5HZ1Rlj4dKINciI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681195901;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KlxuVrTXd7ERz588z7U+eZpNrX8JYOeBVv8I4S7vc10=;
        b=2zMpa46aawV399oJWiqwbvxLS4TQuBTsyVlTg9S2gkp0rSz7R6ZVjxvpI72mRJZ7kF
         6e8huTpRNZ/hAHp+8q293nO5Vlp6M3yn1y3pEmwniZNDsCJ+AChNoOW8CfVgSVaOlUcC
         DBYx5WOL7uYYJvD2OAN5XGq7w4b4kh2i5G0R3vKl3tcUJ6ltRvUuGPciNphl8fMwTSR6
         iUgo5+foRiB+YdD3Zr5EblqR7uWFMkiUj3kQaBzxZrf1SGHMcbgs77CE0xcBq0ugxViz
         AN4RrFFl9kHYYPnFFzZUL7dbImXHbqjIqU0ZONNDoak18vpacw8PwsM1AFuZ3ILla5Xz
         bi+w==
X-Gm-Message-State: AAQBX9dg38AlGTChLvobqd21LBzP5JSbzaOxkXCXC5k/NeN8Adm+YWH6
        C4OFwk2gtyhAXTg2+EFIWTFNnQ==
X-Google-Smtp-Source: AKy350YQEUV5pUQHBKD8Dgh+Enk+75ndcS0fIIDWKAs5lTVZqtNqneAeD13tp5iU4Z9oxI6dTOybWQ==
X-Received: by 2002:aa7:9e88:0:b0:637:703e:533b with SMTP id p8-20020aa79e88000000b00637703e533bmr6921141pfq.4.1681195900883;
        Mon, 10 Apr 2023 23:51:40 -0700 (PDT)
Received: from ?IPV6:2401:fa00:8f:203:44a9:ac98:7606:2cd0? ([2401:fa00:8f:203:44a9:ac98:7606:2cd0])
        by smtp.gmail.com with ESMTPSA id i16-20020aa78d90000000b0062e00158bf4sm8968739pfr.208.2023.04.10.23.51.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 23:51:40 -0700 (PDT)
Message-ID: <6aafad18-13a2-ef45-48a1-1f094554af31@chromium.org>
Date:   Tue, 11 Apr 2023 15:51:36 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v1] media: vivid: Add webcam parameter for (un)limited
 bandwidth
Content-Language: en-US
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil@xs4all.nl>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Ricardo Ribalda <ribalda@chromium.org>,
        Yunke Cao <yunkec@chromium.org>,
        Tomasz Figa <tfiga@chromium.org>
References: <20230410063356.3894767-1-mstaudt@chromium.org>
 <20230410102350.382f7d02@sal.lan>
From:   Max Staudt <mstaudt@chromium.org>
In-Reply-To: <20230410102350.382f7d02@sal.lan>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thank you Mauro for having a first look!

Questions below.


On 4/10/23 18:23, Mauro Carvalho Chehab wrote:
> IMO, instead of a parameter that just enables/disables the bandwidth
> limit, the best would be to have a parameter specifying the bandwidth
> (with 0 meaning unlimited).
> 
> If not used, vivid would initialize it to dev->webcam_bandwidth_limit,
> so a read operation will show the current limit.
Up until now, the bandwidth limit is a rather arbitrary reduction of two 
interval sizes per frame size.

How would you prefer to define a limited bandwidth in this parameter? 
How would it affect the simulated camera, do you have a suggestion for a 
formula from bandwidth to frame/interval sizes offered?


>> +/* Default: limited webcam bandwidth */
>> +static bool webcam_bandwidth_limit[VIVID_MAX_DEVS] = { [0 ... (VIVID_MAX_DEVS - 1)] = true };
>> +module_param_array(webcam_bandwidth_limit, bool, NULL, 0444);
> 
> I would also use 0666, to allow changing this on runtime.

I guess that's possible, though it would add complexity.

Currently we can ask for two instances, each with a different setting:

   n_devs=2 webcam_bandwidth_limit=1,0

This creates /dev/video0 which is limited, and /dev/video4 which is 
unlimited.

Maybe this already sufficiently covers the case you are looking for, and 
we can keep the complexity low? A real webcam won't suddenly offer new 
frame rates either...



Max

