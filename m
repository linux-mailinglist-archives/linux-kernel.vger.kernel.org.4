Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E3B126D3285
	for <lists+linux-kernel@lfdr.de>; Sat,  1 Apr 2023 18:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229972AbjDAQJB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 1 Apr 2023 12:09:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbjDAQI7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 1 Apr 2023 12:08:59 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836A71C1FE
        for <linux-kernel@vger.kernel.org>; Sat,  1 Apr 2023 09:08:56 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id o2so24218522plg.4
        for <linux-kernel@vger.kernel.org>; Sat, 01 Apr 2023 09:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112; t=1680365336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5uy0AySR44SMpzMw4hbs5IlA7/AcPPsiW/cVS76XHpQ=;
        b=CBF+xYe+7B2ke/96B6q02HXLhLLY4fGKBoXzY2wPIEKnNyjgoMc/nJ8n3DId+6bWsO
         kkOr3fuzBFvDvjTXQjrJVXESQiQ4fSgsIjqaRtVRphh/NF0wjas3Bro7u6m+bny3kEzu
         dykn1+hM/q884OhKeXRC7/g7Prl20NRhmaafuk7w5AHgUKTO8GsGgdJBjT/Qw9h486ws
         mCHPY3Lrc916TCjYx837ovC4QnKyfyrHwVbauyyDk6EAhn8MEdld0TjgT1Rd1gdDwN/R
         SgNqxcIqGYlv72P7nC4I9q+GtX5SoXeKGTN1FJ+ND2JNq9dh0yVACUo7SpmYSrgXi6Nr
         byuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680365336;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5uy0AySR44SMpzMw4hbs5IlA7/AcPPsiW/cVS76XHpQ=;
        b=lDhnLqgaNR0do91O5tqgc/lQbn2ZsJIOLI+UGq7zyv44GkGy9YsFtx80F26U8hg0E6
         LRxG/Us1OlWh01Df9tBCMQ358CRvQfFFUrR6MrSAxdV+yyBxRl56Ri6SoglJuOaXQIYB
         lM2DTriWPlH1zKgt2R8QZWBU0NPnxOTmKfKbBbc35pwQOz0F2vpZhfLou1D4WNEDLmVT
         B/5xHsTuq9FBTEU/SjhK+wv3sBriNU4iTDCczmmk0BhQvwI9bGnCDq3rphkvL2jV7x2Z
         d/lEumYeNa1JCLpsb2qeZq5p9EVu6xdfrXFxiPtODAOcbbW3w5AvN9pdsVUDm2fnuqiq
         r7gA==
X-Gm-Message-State: AAQBX9coKIg0mARlL1d3R8V0PGXrl6Zpt8Yf32dk4eBycIVEu3986TUU
        5JxhxTc/5c4kixDMQtR+uKy/Ow==
X-Google-Smtp-Source: AKy350ZNOUsFV9j/xzSnf1+xpXcvIkZsgRIu3isxDNKEOxSw5DeINlj7T+t8EgjWhBsGUhSswe79DA==
X-Received: by 2002:a17:902:e54c:b0:1a2:1a52:14b3 with SMTP id n12-20020a170902e54c00b001a21a5214b3mr10247483plf.4.1680365335992;
        Sat, 01 Apr 2023 09:08:55 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v129-20020a632f87000000b00476d1385265sm3280801pgv.25.2023.04.01.09.08.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 01 Apr 2023 09:08:55 -0700 (PDT)
Message-ID: <1a55abad-bf4c-606a-2217-22447bfd343b@kernel.dk>
Date:   Sat, 1 Apr 2023 10:08:54 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 0/2] USB: Fixes for handling ITER_UBUF
To:     Sandeep Dhavale <dhavale@google.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Keith Busch <kbusch@kernel.org>
Cc:     kernel-team@android.com, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230401060509.3608259-1-dhavale@google.com>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230401060509.3608259-1-dhavale@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=3.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/1/23 12:05?AM, Sandeep Dhavale wrote:
> Since the commit 1e23db450cff ("io_uring: use iter_ubuf for single range
> imports") .read_iter() can be called with iov type ITER_UBUF.
> In such case dup_iter() will correctly dup but it will not allocate
> any memory. But callers ffs_epfile_read_iter and ep_read_iter treat
> this as a failure.
> 
> Following patches address this by checking if iter_is_ubuf().
> Without the fix, async IOs from io_uring will be returned with -ENOMEM.

Looks fine to me. The dup_iter() interface is somewhat unfortunate, as
it doesn't return an error pointer. Hence NULL can be failed or success,
depending on the type. Looks like cifs is the only other user of
dup_iter(), and that checks the type first. You could do something like
that too in the gadget code. Or we could fix the API... And it is kind
of silly calling into dup_iter() when you don't need it. But for now,
this will probably suffice:

Acked-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe

