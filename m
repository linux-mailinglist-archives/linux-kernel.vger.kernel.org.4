Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997377301FC
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 16:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245351AbjFNOaS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 10:30:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244737AbjFNOaM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 10:30:12 -0400
Received: from mail-io1-xd36.google.com (mail-io1-xd36.google.com [IPv6:2607:f8b0:4864:20::d36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EFA81FC2
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:30:10 -0700 (PDT)
Received: by mail-io1-xd36.google.com with SMTP id ca18e2360f4ac-760dff4b701so64716639f.0
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 07:30:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686753009; x=1689345009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=R0swmYx8w65IN2do5ZhI8uQNOc+u/gPEVWo52H9MmMU=;
        b=tDtX7wA/Va7BPa/trJkBkK6diCamMzggWBU6etwXWEYqpcfWKb7VXTBwRwCAhPDoy9
         viNb9tGPeI9wUJqpkZoESIohcOCo1u6yACZfcd7xt+/umXpznxHsDdalL6xcIOUvvirf
         5Y+IgdOgOSAdguJtVMexzSjDWTyRxGQkS5yjuTYGLys26xKRbJgveFMIpFYmTWvdsjoU
         gFCwnC5PmO8bwsD8Sq2tZqFmPNeiFglVMWEsvI93eCRPSbE2o3VakCfM/sZjHGXqkeaZ
         wFWGoojXs7l8Lm+PX5/oK4s5kd0WkKeVxOXS6RqtePVk9SZTXFHCLBSbR/nxPNtR6xDf
         RSoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686753009; x=1689345009;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=R0swmYx8w65IN2do5ZhI8uQNOc+u/gPEVWo52H9MmMU=;
        b=iXkzVp6c4vyPXax1Ef+4sSm8GzJJZ2lKwuVQync5YUABABqd0qqwDfQ8kRGzu89j++
         jKWzRVCq5lL+yLG/eFIi25pbnexz25oLQ2dxi2X+EScjJWOUMcPf9WrwnM7xw3NIjZ9E
         mZa0Cm/uGLr1DmGGktsqsKMaq1sav3JbfzfPX+Xc2VxR/ydIc7mCz2ZnEnLLPkoqv/Fx
         OZToROwkyqEudDbPx8Vg3fHV6vQMRR5bUZ1/aCk9UT9uudkURE6qKtoCN315TwI3tZnP
         czF6bUxdUN5sohdtdW9v5ooPGp8lwObPSK09G0lVMlwOC2xTYBdzdc7+GhQ7v+D6CB/O
         J8SQ==
X-Gm-Message-State: AC+VfDzIMQ1OriKVPa+f1nVaGP2k7TIsFEyMesucCpKTyUfRUw7N2CBM
        SvwOkEiou9++SDM/YOSBp4pbjiLJKprn7lw96iE=
X-Google-Smtp-Source: ACHHUZ6iz4zUfZv5Mu4cVP29jLWn1A8EmUeZ5ZpkLAGSvXTZf35A5qcx6ZhaKC9MTpODuYZo3kSHtQ==
X-Received: by 2002:a05:6e02:1a2d:b0:33d:c72:4ee with SMTP id g13-20020a056e021a2d00b0033d0c7204eemr11712657ile.1.1686753009580;
        Wed, 14 Jun 2023 07:30:09 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id g3-20020a02c543000000b0040f91a65669sm4807683jaj.21.2023.06.14.07.30.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 07:30:08 -0700 (PDT)
Message-ID: <a71b0135-8b41-19d6-9766-f638cdd36ca6@kernel.dk>
Date:   Wed, 14 Jun 2023 08:30:07 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: Can vhost translate to io_uring?
Content-Language: en-US
To:     michael.christie@oracle.com,
        "Eric W. Biederman" <ebiederm@xmission.com>
Cc:     Oleg Nesterov <oleg@redhat.com>, linux@leemhuis.info,
        nicolas.dichtel@6wind.com, torvalds@linux-foundation.org,
        linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org, mst@redhat.com,
        sgarzare@redhat.com, jasowang@redhat.com, stefanha@redhat.com,
        brauner@kernel.org
References: <20230601183232.8384-1-michael.christie@oracle.com>
 <20230602192254.GD555@redhat.com>
 <87r0qt18qq.fsf_-_@email.froward.int.ebiederm.org>
 <ae250076-7d55-c407-1066-86b37014c69c@oracle.com>
 <20230605151037.GE32275@redhat.com>
 <03c07f48-8922-f563-560c-f0d4cc3e1279@oracle.com>
 <20230606121643.GD7542@redhat.com>
 <39f5913c-e658-e476-0378-62236bb4ed49@oracle.com>
 <20230606193907.GB18866@redhat.com>
 <cfbf1a0d-5d62-366f-f32f-6c63b151489e@oracle.com>
 <87mt12oa25.fsf_-_@email.froward.int.ebiederm.org>
 <f65f9809-7f52-5bb1-7e78-f22b813500c2@oracle.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <f65f9809-7f52-5bb1-7e78-f22b813500c2@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 12:25?AM, michael.christie@oracle.com wrote:
> On 6/14/23 1:02 AM, Eric W. Biederman wrote:
>>
>> I am sad my idea for simplifying things did not work out.
>>
>>
>> Let's try an even bigger idea to reduce maintenance and simplify things.
>>
>> Could vhost depend on io_uring?
>>
>> Could vhost just be a translation layer of existing vhost requests to
>> io_uring requests?
>>
>> At a quick glance it looks like io_uring already supports the
>> functionality that vhost supports (which I think is networking and
>> scsi).
>>
>> If vhost could become a translation layer that would allow removing
>> the vhost worker and PF_USER_WORKER could be removed completely,
>> leaving only PF_IO_WORKER.
>>
>>
>> I suggest this because a significant vhost change is needed because in
> 
> It would be nice if the vhost layer could use the io-wq code as sort of
> generic worker. I can look into what that would take if Jens is ok
> with that type of thing.

Certainly. io-wq is mostly generic, eg it has no understanding of
io_uring internals or commands and structs, and it should be possible to
just setup a struct io_wq and use that.

Obviously might need a bit of refactoring work and exporting of symbols,
io_uring is y/n so we don't export anything. But I think it should all
be minor work, really.

-- 
Jens Axboe

