Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A96B85E705D
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 01:56:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229905AbiIVX4P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 19:56:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58124 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229677AbiIVX4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 19:56:13 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D637AFAC0;
        Thu, 22 Sep 2022 16:56:12 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id w13so10293329plp.1;
        Thu, 22 Sep 2022 16:56:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=W2+hY5lHfF8Yuo41plQsF/0eXxPmqJupnSDFH4YELL4=;
        b=mVRR4aZJ5g4MCHjpo4FP5u3OBVgKIEPrZtKX2L4xHqoi0Ur2e63hq9FvaowJAy7kWQ
         jnLqufVdqloRtEM+eYE+y4MOmy1+dlo0RxtVgdSUtMYtItd7lvscp7aYAEb47cyJ/I/1
         DQvHNO0UiANbq0iEnjs4IxBjshM9X6dIabZUBo5Dq/aLikTSROX1hPYeifO/3WDC6BJt
         kCU6S0fvjPo971XxYN1fxa9zWRBfND/X2dnCvrDbYttpqbr1WwMlat196gZ2bSVl2oTy
         QGTyKPJcpYyigGfVHnJreSBnJjusNmuayjmchvndoSWQlJ2wlXoy9G7+9WhBLlhtort3
         j63Q==
X-Gm-Message-State: ACrzQf2m0wEP9Ai1snI8wqYcWcASikRsfSNlPmbcwCqVXcibtKQn/2QC
        IdBzIyd2FJOKkzol2FHy1gg=
X-Google-Smtp-Source: AMsMyM7DnGl8Usys7cprZQSwOFa/NlnQp69DKqLnRIqNLOSTU/oMTFEKEH4OrfofFw1WRmQVRwtsKg==
X-Received: by 2002:a17:902:d58f:b0:179:b756:6f5e with SMTP id k15-20020a170902d58f00b00179b7566f5emr4818263plh.1.1663890971926;
        Thu, 22 Sep 2022 16:56:11 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u10-20020a170903124a00b001782a0d3eeasm4698194plh.115.2022.09.22.16.56.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 16:56:10 -0700 (PDT)
Message-ID: <8fd1d8b1-9f43-eb03-4a7f-187723d1c483@acm.org>
Date:   Thu, 22 Sep 2022 16:56:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.1
Subject: Re: Please further explain Linux's "zoned storage" roadmap [was: Re:
 [PATCH v14 00/13] support zoned block devices with non-power-of-2 zone sizes]
Content-Language: en-US
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Pankaj Raghav <p.raghav@samsung.com>
Cc:     agk@redhat.com, snitzer@kernel.org, axboe@kernel.dk, hch@lst.de,
        pankydev8@gmail.com, gost.dev@samsung.com,
        linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, dm-devel@redhat.com,
        Johannes.Thumshirn@wdc.com, jaegeuk@kernel.org,
        matias.bjorling@wdc.com
References: <CGME20220920091120eucas1p2c82c18f552d6298d24547cba2f70b7fc@eucas1p2.samsung.com>
 <20220920091119.115879-1-p.raghav@samsung.com> <YytJhEywBhqcr7MX@redhat.com>
 <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <7dd9dbc0-b08b-fa47-5452-d448d86ca56b@opensource.wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/21/22 16:55, Damien Le Moal wrote:
> But again, that all depends on if Pankaj patch series is accepted, that
> is, on everybody accepting that we lift the power-of-2 zone size constraint.

The companies that are busy with implementing zoned storage for UFS 
devices are asking for kernel support for non-power-of-2 zone sizes.

Thanks,

Bart.
