Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44E3B743F6F
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Jun 2023 18:05:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232804AbjF3QFt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Jun 2023 12:05:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230388AbjF3QFr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Jun 2023 12:05:47 -0400
Received: from mail-io1-xd29.google.com (mail-io1-xd29.google.com [IPv6:2607:f8b0:4864:20::d29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C089BA9
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:05:45 -0700 (PDT)
Received: by mail-io1-xd29.google.com with SMTP id ca18e2360f4ac-7748ca56133so24676239f.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Jun 2023 09:05:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1688141145; x=1690733145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ziU7udbSMUbbWD6WdWUse2LB6xrhtUWIqBeRynGCsik=;
        b=RBzCO5wIRkOWtsfnLQFTCb2IVyVyMOG6Cgjz1OlGsMmo5IYrjycb6t/iILAkV1Unh1
         OfEWG7dHahsPBFpwZTR2/L/HqSZBHP52t/SlNzC/9pB8TQSAWwFuu2n/fecl7qMK66uO
         PBMqINiJds/8FWzdQLWHkgeapFj9eYntFRFLpZ+m9IbvCz7E1O5Pml5B7KSJjUHwBcfg
         +dfVhkZEDa0jcxTZMYh7+e5/s2T2xD7gXi0TSVUw7jB6DEKrNWvqCUqKDn41L45pvJAk
         vK/XP6fjpymiAog4QB5FI7tdbGM2NnmvbUivhDMrwnPVlTtl9z+yLkBGSc/vJM2zIF2H
         x+zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688141145; x=1690733145;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ziU7udbSMUbbWD6WdWUse2LB6xrhtUWIqBeRynGCsik=;
        b=LDl3haPQ5RVc9AiQlyG8wO4Sh3I89ZEimpA/LrMlP+vG5LgoYQZMujyMrQitNR3pax
         nniLnVX32BGcCo2rkmjLuDmKZh3jUKMJvMPPyRSW0W3ehtSs8ba+K7yHK/88ehWEonGo
         496AS50Mqz55/1bHKOCfX+obSAgukfeLIqeKwW71E2bvLBh+59RZ2ilWJpjjTlwtVUHa
         bnV7g2voNMq8w9OScFeJXtYpMo4PT2u+JME/J/PoNktQjQtaPKWgz+LCkjNb6IPvsOnx
         iR+wpOWus+XV0TEw5Fr0nurA/unylooKO35nXmew30dHrJqf8bzwh6UnscLMlX7q+e/k
         BiBw==
X-Gm-Message-State: AC+VfDwKvfoNL8AujHofmyIFYL2FCKG5LAQ1bhGOmKy18HguriXxkm3V
        /k3r33SDv+66nTiEFHyeLjRG3w==
X-Google-Smtp-Source: ACHHUZ76Ofymlhm34XFb34rKtgMlt+vNzniJrH5TSsGc5ozk3JG98tN4+hKciqwUnIJg1Xgew5uBAA==
X-Received: by 2002:a05:6602:4995:b0:783:617c:a8f0 with SMTP id eg21-20020a056602499500b00783617ca8f0mr4285546iob.2.1688141144768;
        Fri, 30 Jun 2023 09:05:44 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id r5-20020a6bd905000000b007836a9ca101sm1874871ioc.22.2023.06.30.09.05.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 30 Jun 2023 09:05:44 -0700 (PDT)
Message-ID: <dc2e8d58-7400-63d6-b76c-7f4f6d29fcb7@kernel.dk>
Date:   Fri, 30 Jun 2023 10:05:42 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [RFC PATCH 03/11] vfs: Use init_kiocb() to initialise new IOCBs
Content-Language: en-US
To:     David Howells <dhowells@redhat.com>
Cc:     Al Viro <viro@zeniv.linux.org.uk>,
        Christoph Hellwig <hch@infradead.org>,
        Matthew Wilcox <willy@infradead.org>, Jan Kara <jack@suse.cz>,
        Jeff Layton <jlayton@kernel.org>,
        David Hildenbrand <david@redhat.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        Hillf Danton <hdanton@sina.com>,
        Christian Brauner <brauner@kernel.org>,
        linux-fsdevel@vger.kernel.org, linux-block@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        Christoph Hellwig <hch@lst.de>,
        Christian Brauner <christian@brauner.io>
References: <36eda01e-502e-b93d-9098-77ed5a16f33c@kernel.dk>
 <20230630152524.661208-1-dhowells@redhat.com>
 <20230630152524.661208-4-dhowells@redhat.com>
 <662384.1688140818@warthog.procyon.org.uk>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <662384.1688140818@warthog.procyon.org.uk>
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

On 6/30/23 10:00?AM, David Howells wrote:
> Jens Axboe <axboe@kernel.dk> wrote:
> 
>> One concern here is that we're using IOCB_WRITE here to tell if
>> sb_start_write() has been done or not, and hence whether
>> kiocb_end_write() needs to be called. You know set it earlier, which
>> means if we get a failure if we need to setup async data, then we know
>> have IOCB_WRITE set at that point even though we did not call
>> sb_start_write().
> 
> Hmmm...  It's set earlier in a number of places anyway -
> __cachefiles_write() for example.

Not sure how that's relevant, that's a private kiocb and not related to
the private one that io_uring uses?

> Btw, can you please put some comments on the IOCB_* constants?  I have
> to guess at what they mean and how they're meant to be used.  Or
> better still, get Christoph to write Documentation/core-api/iocb.rst
> describing the API? ;-)

The ones I have added do have comments, mostly, though it's not a lot of
commentary for sure... Which ones are confusing and need better
comments? Would be happy to do that. I do think the comments belong in
there rather than have a separate doc for the kiocb. Though one thing
that's confusing is the ki_private ownership. You'd think it belongs to
the owner of the kiocb, but nope, it has random uses in iomap and ocfs2
at least.

-- 
Jens Axboe

