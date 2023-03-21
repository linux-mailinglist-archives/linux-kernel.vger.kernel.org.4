Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD9216C3A38
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 20:17:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230010AbjCUTRB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229808AbjCUTQ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 15:16:59 -0400
Received: from mail-io1-xd30.google.com (mail-io1-xd30.google.com [IPv6:2607:f8b0:4864:20::d30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0A5A4B82B
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:16:32 -0700 (PDT)
Received: by mail-io1-xd30.google.com with SMTP id d14so4548032ion.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 12:16:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1679426171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=68/H4+xam4m5wiaqKB4DLi8WxDgUwxT+IYkB5YBtOss=;
        b=Ch1bBNzmPQDbcLE1jy3YVa3GAf/t+fX97A2iSqvCLkaA7DQ1JECTOviq+QK2Zdpmxm
         97Utmb+f1Hb4NYius8BS1RYAYgMs2/4lHJ0/Yl7mTSaCJFNIFSaLgUiF6KxW8vAev61A
         MQfXTYGvQQ9b8gksZsjgy4w3Td4EcJlZsChRFgcf6K+QzlXkjlMFDY0Jbu9T28kh2weH
         +D41OHGXmcRcY92LAbzAn/T2qhxWyP+St10u+wBB17QWAdp5cdRHDAqssvtsGVlzAfJr
         2KJ1N8C4rCLx3pgXw6RteEqmXV7iDytshITlAZ6eKb0KuCInFjbC7Rto3Gx7mY+jq5rD
         HyaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679426171;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=68/H4+xam4m5wiaqKB4DLi8WxDgUwxT+IYkB5YBtOss=;
        b=QXJKPa7zuLoh8wFjV/DZxWGeroKSdlgOK5bHkGNb2OlpxVTtZO2YBUOQMLUu2BmSy2
         Mtdmv+DwfjAFzAK0zvWhLdDr8BMojYj0o35jJRVmAZRMHeJ4yWuwaeu80iDSkqREZGSM
         CmbRfCTTR3KlnsJZp28rDaEY2ahjugxZRn7PfLp26i9e1/CQf4ebPgICgDF8eTcw9pOX
         tqyJkX1f2VmNdrY+3rEE0yb3nCNWQmCQDee1RDl1DmW8mUAB55x3yzhnomZlxViTG/Aw
         6sjM+UhvdLJqC478GDv9xUXCLiUHLbM4CiMsUBEzp3y1u50sgchUqqRBuDzVecnF8XB3
         qWoQ==
X-Gm-Message-State: AO0yUKUJnutYax397Y4dlTmA7nqe73DaZYBXzfR4QRHR6le8Nc0XAvqg
        utfPD3stBXAIwwKEjGZDQY2+jA==
X-Google-Smtp-Source: AK7set+VXE0JqlJu/khih18+jA1dIbHsYYvLTbg2wtKzlalWn4L4Eqgy+q/HxDA9auS9TdmUks2B5w==
X-Received: by 2002:a6b:2ac2:0:b0:740:7d21:d96f with SMTP id q185-20020a6b2ac2000000b007407d21d96fmr2122857ioq.1.1679426171077;
        Tue, 21 Mar 2023 12:16:11 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id s10-20020a6bdc0a000000b0074e7960e70dsm45058ioc.51.2023.03.21.12.16.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Mar 2023 12:16:10 -0700 (PDT)
Message-ID: <8d532de2-bf3a-dee4-1cad-e11714e914d0@kernel.dk>
Date:   Tue, 21 Mar 2023 13:16:08 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [GIT PULL] keys: Miscellaneous fixes/changes
Content-Language: en-US
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        David Howells <dhowells@redhat.com>
Cc:     Jarkko Sakkinen <jarkko@kernel.org>,
        Bharath SM <bharathsm@microsoft.com>,
        Shyam Prasad N <nspmangalore@gmail.com>,
        Steve French <smfrench@gmail.com>,
        Robbie Harwood <rharwood@redhat.com>,
        Eric Biederman <ebiederm@xmission.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        keyrings@vger.kernel.org, linux-cifs@vger.kernel.org,
        linux-crypto@vger.kernel.org, kexec@lists.infradead.org,
        linux-fsdevel@vger.kernel.org, linux-kernel@vger.kernel.org
References: <2851036.1679417029@warthog.procyon.org.uk>
 <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <CAHk-=wh1b0r+5SnwWedx=J4aZhRif1HLN_moxEG9Jzy23S6QUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/21/23 12:48?PM, Linus Torvalds wrote:
> On Tue, Mar 21, 2023 at 9:43?AM David Howells <dhowells@redhat.com> wrote:
>>
>>  (1) Fix request_key() so that it doesn't cache a looked up key on the
>>      current thread if that thread is a kernel thread.  The cache is
>>      cleared during notify_resume - but that doesn't happen in kernel
>>      threads.  This is causing cifs DNS keys to be un-invalidateable.
> 
> I've pulled this, but I'd like people to look a bit more at this.
> 
> The issue with TIF_NOTIFY_RESUME is that it is only done on return to
> user space.
> 
> And these days, PF_KTHREAD isn't the only case that never returns to
> user space. PF_IO_WORKER has the exact same behaviour.
> 
> Now, to counteract this, as of this merge window (and marked for
> stable) IO threads do a fake "return to user mode" handling in
> io_run_task_work(), and so I think we're all good, but I'd like people
> to at least think about this.

I haven't seen the patch yet as it hasn't been pushed, but can imagine
what it looks like. It may make sense to add some debug check for
PF_KTHREAD having TIF_NOTIFY_RESUME set, or task_work pending for that
matter, as that is generally not workable without doing something to
handle it explicitly.

For PF_IO_WORKER, with the commit you mentioned, those threads should
deal with TIF_NOTIFY_RESUME just fine. Until something else gets added
that is also run from exit_to_user_mode...

-- 
Jens Axboe

