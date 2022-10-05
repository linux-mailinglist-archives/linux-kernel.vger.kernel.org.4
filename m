Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 641585F544B
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 14:19:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230042AbiJEMTM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 08:19:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbiJEMTK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 08:19:10 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DBAA4AD58
        for <linux-kernel@vger.kernel.org>; Wed,  5 Oct 2022 05:19:09 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id 78so15092174pgb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Oct 2022 05:19:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=Kch95tHHe8y0dIqkTVplEFHJb/ntNCXtwkxDszyYdcA=;
        b=qa9Xxrj8Khk7MeFieImHaceH75MPZZe87Zof7eaXtUpnMY/1CSnGMku/XOPUyReJZH
         acmkdT9DjZp3f47I5AAtO+N6JghZLByO4VOBpZZWjBdAHWX2teizcZKnOQCVhczUldqY
         vxA4dNJEkE0rFePanxfk7bBEjVoG3jB1/lLISsgamfpLBAvLNHOm5FrHGtP4Vx8v7D9k
         5aGLpTrWnpN5JfhITIsYHKHUjnDqDEsKZr2mp/mzZ+zxgd2T0wjUC/rMuGi7VWC7zbTU
         McLADrx0jdxLo6Q30lSGObCzYW5afDMoYvovGwQs5SaK8GHOBEzVBDCoW7PgPJ8r8ayr
         IS5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=Kch95tHHe8y0dIqkTVplEFHJb/ntNCXtwkxDszyYdcA=;
        b=tSLjb3vUR3NLua+eoskNmAlc2cT7u3OOabr4Wu3abRLWs65TQxvRUC/adA7hpYHsAz
         6S0e5s5lxLEacjBihcMg8NipYBy2MdtGHGVNAywP1xXpOX6n2AhCZHi85eUZ1oEp5GOw
         7FFg9jQSYaYVOSMHkzNdJUU/xY/onVZvZXxFAKRCVfWW/XikpuHNwzwszoW2QgoY/1kG
         +WbHb1sn5/r5nHFZfzsGdPyL2WNaWck4fJzUzZtmqHbfI7BPwt5eNi29EDKgtqucdJWG
         /JmA9ESL6W8CTCAy81T2b+NfSf3FZiuA3H0GjYNnIE2+TmfZLqfXtZ6jxWWjfBzZ/SY5
         Y4SA==
X-Gm-Message-State: ACrzQf0aWOqOp9iI4sFM9F9Pk2vCAYSXl/mCgDp5MDgSBILju1Bi6bhS
        h7OeX5qoxtKQXI54jPexq5oVESvEBPSGJw==
X-Google-Smtp-Source: AMsMyM4MRlFjL3Z/LGK71aFd/IwfHhTGKouTQN3w7MTh+a/6Qf4G1a386Nl5Kzzozog4KF/dCBZ60g==
X-Received: by 2002:a05:6a00:c82:b0:561:ad4a:ca0d with SMTP id a2-20020a056a000c8200b00561ad4aca0dmr10889958pfv.50.1664972348547;
        Wed, 05 Oct 2022 05:19:08 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id y23-20020a17090264d700b00176e2fa216csm10523961pli.52.2022.10.05.05.19.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Oct 2022 05:19:07 -0700 (PDT)
Message-ID: <3dcff83c-3ddf-b068-270b-f886de8eba7f@kernel.dk>
Date:   Wed, 5 Oct 2022 06:19:06 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: linux-next: build warning after merge of the block tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221005181734.08b2f1d9@canb.auug.org.au>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221005181734.08b2f1d9@canb.auug.org.au>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/5/22 1:17 AM, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the block tree, today's linux-next build (htmldocs)
> produced this warning:
> 
> include/linux/skbuff.h:1051: warning: Function parameter or member 'scm_io_uring' not described in 'sk_buff'
> 
> Introduced by commit
> 
>   0dd99edbfae7 ("io_uring/af_unix: defer registered files gc to io_uring release")

Thanks, fixed.

-- 
Jens Axboe


