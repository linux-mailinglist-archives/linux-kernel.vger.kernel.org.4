Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CE35EC337
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 14:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231720AbiI0Mrn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 08:47:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231664AbiI0Mrk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 08:47:40 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 53E8214AD4E;
        Tue, 27 Sep 2022 05:47:39 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id c24so8992947plo.3;
        Tue, 27 Sep 2022 05:47:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=pBPln+b11pq6NascSrYAWIVzDopDTO1UFjPzgrUQKiU=;
        b=dJYA1qVFTrls30OQhZaf3veaeALUiSfODWissTCXJezDmECLyxXfMoMtPTKL82hmDl
         CrY6ytwy/jDetYrcOjo8oh2R4w87KPpX0S8ieGQrExm9deA8j2D84WHnBurDxagSQwTs
         DoTYCFwcu7S/oSxPTBEGnBsmhapvcE0mFgFAyN9rjChRNfHXN/l6TuFOTiDMzABvepcv
         hnWCabnHdS8vWVePDkd9KiopAEP8K4muZ57yMrWh5wI7MQHaC1tlRjZEiWv1hC4h+gVr
         8WkVxsSWF/MhLffJvVt87uRNs0p91upP+ijU/v6xnNf6JSFPJbT/fBgIFHwZn+i3+osB
         785w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=pBPln+b11pq6NascSrYAWIVzDopDTO1UFjPzgrUQKiU=;
        b=A/KLWGoeuQnHi0FrLXyPBXYdbUYgVxPYOdwdU1M4a2mY1q/33twH5XnbwXxvapTrKf
         k7H36Th8EYH8NV/d29+UrG02MU9PJZfPeunsMfxqe9d7hfViUGeA0PbVHaFyg3f34K9Y
         jXACJVGY3evPUyG5ikhpGhf4Q8w4eViQRytV0tMYKIclBkgIdgFDKmQWgnLpnIFq8g1F
         U9xj2UY3e+7lchJ+7QKpxKfFRSm8XnYw/vP+jSzTT3egcw5tFdcS8UjGWJQVrfuq60e2
         sWkm9JGPvMpX9efEDN2FQ+qKTV4HuwKaRUf4SDGbMS8NBGOe4VBWM+if8ixHu9lqDp8R
         I7zg==
X-Gm-Message-State: ACrzQf2LKFQDR1QQ4ydDNqn7PrS1m48KVEaFGe9b7QxDrNvjgnxV8Knt
        SkFiHHPQQcOi+ybF4lFAJcM=
X-Google-Smtp-Source: AMsMyM45TDWdowkKlqaKWi3nqCyFhYbG6rzaPO2UM9Ls9eGYUdjA7maMKvPcHkNJGLNxBEqgd3oiSg==
X-Received: by 2002:a17:902:e212:b0:178:5c:8248 with SMTP id u18-20020a170902e21200b00178005c8248mr27898484plb.102.1664282858901;
        Tue, 27 Sep 2022 05:47:38 -0700 (PDT)
Received: from [192.168.43.80] (subs28-116-206-12-58.three.co.id. [116.206.12.58])
        by smtp.gmail.com with ESMTPSA id h16-20020a17090aea9000b00200aff02e90sm1358102pjz.18.2022.09.27.05.47.36
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 27 Sep 2022 05:47:38 -0700 (PDT)
Message-ID: <8821ae25-eb20-b673-6d57-fb2cc03d9726@gmail.com>
Date:   Tue, 27 Sep 2022 19:47:34 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [PATCH] of: device: fix repeated words in comments
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>
Cc:     Jilin Yuan <yuanjilin@cdjrlc.com>, frowand.list@gmail.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20220918094915.19567-1-yuanjilin@cdjrlc.com>
 <20220926185852.GA2581083-robh@kernel.org> <YzJaIolrTarQ4Qdn@debian.me>
 <CAL_JsqKb595eUCL6k6yjGm=wn9AbcyvcKiD71jEw0M_y=+UVsA@mail.gmail.com>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <CAL_JsqKb595eUCL6k6yjGm=wn9AbcyvcKiD71jEw0M_y=+UVsA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/27/22 19:29, Rob Herring wrote:
>> Hi Rob,
>>
>> Some reviewers sent comments for similar patches from @cdjrlc.com
>> people (including myself at [1]), with some of them requesting changes.
>> However, there are never any responses to these reviews from @cdjrlc.com
>> people, just like ZTE developers sending through cgel.zte ignored
>> review comments [2] (try searching `f:"cdjrlc.com" AND s:"Re:"`, it returns
>> nothing for now).
> 
> I can't decide whether to fix it correctly myself or leave it to see
> how many times I can get the same patch. :)
> 

Hi Rob,

I'm not talking about whether this patch should be picked up or not, but
rather I'm pointing out the ignoring review behavior of @cdjrlc.com people.

Thanks.

-- 
An old man doll... just what I always wanted! - Clara
