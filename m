Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0746869EB83
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 00:54:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229884AbjBUXyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 18:54:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229736AbjBUXyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 18:54:22 -0500
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9CE3222A13
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:53:53 -0800 (PST)
Received: by mail-pj1-x1030.google.com with SMTP id u10so6913450pjc.5
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 15:53:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HEXjybMjDo4AHQ34Ueszqup9k/yKbxkg1qfk1m5R0ZE=;
        b=rvTtsJ8XsmBJcjdS8IDwz/ZbLtpkNnsYJ1zafYCdvQ7jU3B+G5wSX/q1U/42zP3Spm
         nfiq9MS6PGB6ohcZP9bfR7GC4u3VT3K7cJaqSA0Vn816SmCH/JXhz8SJmp+dH3l2IDoY
         TIHzT58wN+zOAMN25VtOYs9RFXF6F1e5L0op84eI68CpPHR/Ge8ABK/mZ5WkYI/SOmHO
         S4OQJdOT6ze6DmhQ2rCnGUG5hC/8LzEYji/tf0d45ZA0FwxfrUD5zfKXtJ5WiiYPS+FZ
         TioeOFjHCPMqBLN5jfsKb0f0QwS61Fhm64nHpp5ormjcZbznAwsdUn7T0BObBflMRYLF
         V2zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HEXjybMjDo4AHQ34Ueszqup9k/yKbxkg1qfk1m5R0ZE=;
        b=gMD31QmD1KRX8+XJcCnjsXeBrLKwG7KR0XL+L7VzBmQodC+2L4K/2nEJ1L57HlD0nV
         NMj3i59nR1/VmfjGsoOb/6cOJ5qMRSff5KDjD06W92QnvAtVy23ojZ1k8k9Jg+WdzM5y
         8cQNH0rXZHE4kMZv0kRRvXRiILh/iOCxAvPM4KIpXb1Wgm0iAbXndDSPhfRDNcjaw3+V
         g4wHk2iDzpD+8YXYBzX9c3HZwR7JguRwhmSMiKivlbbrlNlcS1qnpg+5V1Bg74q/YcJt
         MFku3i+Bd5+zJtSGcRX5DwFzeHeb37W9/G6yZQJ0RsMWS+rMkea/9lgT984LcvcG8Pat
         1Gig==
X-Gm-Message-State: AO0yUKWkzSl8C2MLhmU8JBDhu1c+1ZPeGqgqycjvX7RskOYtxY1ZBbnl
        GmIDA+jwfeFo8PavkZViDmGUkQ==
X-Google-Smtp-Source: AK7set/T8MwrPRALxKN3YfGPwYAnNZN5efM/qjRCG3W2M8o7zPFH1cnfxv/naJ/bkjRqcbrgU+kbQw==
X-Received: by 2002:a17:903:2291:b0:19a:8202:2dad with SMTP id b17-20020a170903229100b0019a82022dadmr7107391plh.2.1677023632953;
        Tue, 21 Feb 2023 15:53:52 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id ix12-20020a170902f80c00b001990028c0c9sm647885plb.68.2023.02.21.15.53.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Feb 2023 15:53:52 -0800 (PST)
Message-ID: <15f4a519-cc2b-1cad-571a-a36e67d6101f@kernel.dk>
Date:   Tue, 21 Feb 2023 16:53:27 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 1/2] io_uring: Move from hlist to io_wq_work_node
Content-Language: en-US
To:     Breno Leitao <leitao@debian.org>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org
Cc:     leit@meta.com, linux-kernel@vger.kernel.org, gustavold@meta.com
References: <20230221135721.3230763-1-leitao@debian.org>
 <782b4b43-790c-6e89-ea74-aac1fd4ff1e2@gmail.com>
 <b04b7d5d-582f-1b45-efa3-6e951dfc3cbf@debian.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <b04b7d5d-582f-1b45-efa3-6e951dfc3cbf@debian.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 11:38?AM, Breno Leitao wrote:
> Sure. I will remove the assignents in "if" part and maybe replicate what
> we have
> in io_alloc_cache_get(). Something as:
>        if (cache->list.next) {
>                node = cache->list.next;
> 
> Thanks for the review!

Pavel is right in that we generally discourage assignments in if
statements etc. For the above, the usual approach would be:

node = cache->list.next;
if (node) {
	...
}

-- 
Jens Axboe

