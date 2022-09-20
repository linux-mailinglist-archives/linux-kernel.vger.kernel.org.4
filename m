Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90F5A5BE86E
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 16:17:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231613AbiITORa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 10:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231737AbiITORG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 10:17:06 -0400
Received: from mail-io1-xd33.google.com (mail-io1-xd33.google.com [IPv6:2607:f8b0:4864:20::d33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4905F18B12
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:14:40 -0700 (PDT)
Received: by mail-io1-xd33.google.com with SMTP id y141so2352107iof.5
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 07:14:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=/yot0ov3usmKB3Zy+wkJUKPk22BQTuylnVUMZmxsCR4=;
        b=lIXZTwlaHIbQQ9hNPvRV7HuGvm5RDJYX8qcUeX22OX83N0tkw9Xt13KdlC/anWINwm
         GSdQCjuqFlnjXmK6d3quFgRZ7vkpgfhPiFdng2KG0u9ylgvfBvqMepItjYQ2ivjERQGp
         8lbIhTvYiKoy9hpyPK3TjnPUEnO2JyjF2hhVOdKkuSRa0+4ZtVIZ0cplD7cmpKuDl69T
         uqT78PPAKOllkkBpBIUzKAmALjQnSnksHUYVyAn5ydOljMtwsZEGwWrugEhmfOR/ZRxs
         gaLDLph39qi7lQQj9HHR0xjlCHEUwJZ+rHe2pgOisLfuPgHb7r7OhEJ2DUDpVDTh2sgy
         kqTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=/yot0ov3usmKB3Zy+wkJUKPk22BQTuylnVUMZmxsCR4=;
        b=advTgSgAgr4ZiJt77zG5RdD/GJ6yjjeL9OeHClBUau98RAk09M7yJPx9d1uHoIgqjy
         naTvLqxi2ZR8l7pDgWHioRs7znI7i5YPr7i97VnR2VUZlViqs7xtjOXZWWqc23njeR6r
         qW27AvPQs7G8Dbswo2N7C2fOAmjxehnnObIPQdHdEMtoZYQONa0/J1iizpvgKDVEJFfo
         Faeg5rmAOHa35t2UF9UCL9S2nnQjQkAYVv2rjyNDhZgl51W7o5p9LM2lb/RXlAbmAZdb
         aivqaLoSsfc4XfzZCl2xLJFjkPm/SqHg8aEF/UXjY2bkQNZCqWCiJPhRslwMjIMQ5Q+e
         M2jQ==
X-Gm-Message-State: ACrzQf2cEHOdEMDVPN9LL056kcDmAAtN6jNkBM53/4XZu4HPmL/eEYXn
        e2zTlujHdlzTHrHpCPanyb8IG5ZWxSXFXQ==
X-Google-Smtp-Source: AMsMyM4Fm0kTiShfxuAAb97HY9gCdOOBLEjpM6ZrfDeefAteWrULruA4zXYQ/fIChp4JLiLJB3BlqQ==
X-Received: by 2002:a5d:9902:0:b0:6a2:f72d:4b21 with SMTP id x2-20020a5d9902000000b006a2f72d4b21mr5956574iol.113.1663683273188;
        Tue, 20 Sep 2022 07:14:33 -0700 (PDT)
Received: from [192.168.1.94] ([207.135.234.126])
        by smtp.gmail.com with ESMTPSA id w16-20020a056e0213f000b002f5cd533b31sm125125ilj.0.2022.09.20.07.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 07:14:32 -0700 (PDT)
Message-ID: <9594af4b-eb16-0a51-9a4a-e21bbce3317d@kernel.dk>
Date:   Tue, 20 Sep 2022 08:14:30 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: regression caused by block: freeze the queue earlier in
 del_gendisk
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     Thorsten Leemhuis <regressions@leemhuis.info>,
        Dusty Mabe <dusty@dustymabe.com>,
        Ming Lei <ming.lei@redhat.com>, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-raid@vger.kernel.org,
        "regressions@lists.linux.dev" <regressions@lists.linux.dev>
References: <017845ae-fbae-70f6-5f9e-29aff2742b8c@dustymabe.com>
 <YxBZ4BBjxvAkvI2A@T590> <20220907073324.GB23826@lst.de>
 <Yxr4SD4d0rZ9TZik@T590> <20220912071618.GA4971@lst.de>
 <Yx/jLTknQm9VeHi4@T590> <95cbd47d-46ed-850e-7d4f-851b35d03069@dustymabe.com>
 <f2c28043-59e6-0aee-b8bf-df38525ee899@leemhuis.info>
 <d39e9149-fcb6-1f7c-4c19-234e74f286f8@kernel.dk>
 <20220920141217.GA12560@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20220920141217.GA12560@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/20/22 8:12 AM, Christoph Hellwig wrote:
> On Tue, Sep 20, 2022 at 08:05:06AM -0600, Jens Axboe wrote:
>> Christoph and I discussed this one last week, and he has a plan to try
>> a flag approach. Christoph, did you get a chance to bang that out? Would
>> be nice to get this one wrapped up.
> 
> I gave up on that as it will be far too much change so late in
> the cycle and sent you the revert yesterday.

Gotcha, haven't made it all the way through the emails of the morning yet.
I'll queue it up.

-- 
Jens Axboe


