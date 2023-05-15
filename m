Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E89A1703DE9
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 21:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244907AbjEOTzp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 15:55:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52686 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240321AbjEOTzm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 15:55:42 -0400
Received: from mail-il1-x133.google.com (mail-il1-x133.google.com [IPv6:2607:f8b0:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76D5C100EB
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:55:41 -0700 (PDT)
Received: by mail-il1-x133.google.com with SMTP id e9e14a558f8ab-334d0f0d537so3850525ab.0
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 12:55:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684180541; x=1686772541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eP6gErIx4YH4NGO5e9TOO4EyxDdPvqOfbtAqJSgrrUw=;
        b=BCWyQw0mDG8PUE2P9cmJlB519vHPXHbntbFnNnbkKzNif9qWqrBfTQbKPKN7qmBca6
         dP4FZxbQD4m2WdjZWqcwzj3viM7yPrEGIB92FmyQxFtHR7oAb7uhqpEy9CM/JPp1bMNY
         xyWNRZmN2rK6BjAB1a3uXYmyBjanEC22eb+/b2K1Yosr+j70fmB4bAiaCylRWFnZLISt
         dk5NsKcFoL5JwEf7MIFopajKeA9S/gmSkyGl7+r0XSNwbWuzxSDL/q4vkdgUN6FMqupO
         Pp9QcJdfKZZc9z89NXYBLn27oRLDK8Vo4zZUhRbhVpClZVj+dY7g4IXQIOT5XvKNneDE
         BiSQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684180541; x=1686772541;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eP6gErIx4YH4NGO5e9TOO4EyxDdPvqOfbtAqJSgrrUw=;
        b=mI2wq278DlUxWnntz+cQR6bFQmyv64nasA5blyI9w2VGSppk4dGAK6iYnXmqSuQ9VB
         dCcsYLD/aLVNrZGXF5Wi1EJkVzvwEc9xK+8T94VX7+UYxG254n1hDJ9zDZOu9OM9TO4G
         19az+4ckZa3TEx1sJt++aDQMRxfBjI8lp9wpN3uUkj0/gK1G2qfwq8eKaA1V6WL9eJ87
         rhUXvfT6rR+A2cP/OuJDtLtwDdbET8LGaXk8pDtiZSKMrJthvgO0N39zopPrWmL611+k
         JaHhVZfUVwqDzHr7W55U0I+cH0JIpiDmcFnQDaORaHhGyXOhLz7VZKE/oskC5rFPtmXl
         9ifg==
X-Gm-Message-State: AC+VfDzaBKrCjx0LdgaWgDNCdJAtjXvafrb9KIRXYa6hpDzbLnQUsNET
        iUnAnJR5VWsh0J2zQhl3sqrZQQ==
X-Google-Smtp-Source: ACHHUZ5rJ2De8akBony3bYEhb8qsybCB8JhJ6D24MoOXnAHLUN1yyk7C43ZDv6xNI1JKHjcHFiEipQ==
X-Received: by 2002:a6b:b2c7:0:b0:76c:6fa4:4df4 with SMTP id b190-20020a6bb2c7000000b0076c6fa44df4mr336763iof.2.1684180540777;
        Mon, 15 May 2023 12:55:40 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id q3-20020a027b03000000b0041672c963b3sm6021255jac.50.2023.05.15.12.55.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 May 2023 12:55:39 -0700 (PDT)
Message-ID: <c44effe6-029e-4ccb-ce97-2ca5d5099c05@kernel.dk>
Date:   Mon, 15 May 2023 13:55:38 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 4/6] io_uring: rsrc: delegate VMA file-backed check to
 GUP
Content-Language: en-US
To:     Lorenzo Stoakes <lstoakes@gmail.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Pavel Begunkov <asml.silence@gmail.com>,
        io-uring@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>,
        John Hubbard <jhubbard@nvidia.com>
References: <cover.1684097001.git.lstoakes@gmail.com>
 <642128d50f5423b3331e3108f8faf6b8ac0d957e.1684097002.git.lstoakes@gmail.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <642128d50f5423b3331e3108f8faf6b8ac0d957e.1684097002.git.lstoakes@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/14/23 3:26 PM, Lorenzo Stoakes wrote:
> Now that the GUP explicitly checks FOLL_LONGTERM pin_user_pages() for
> broken file-backed mappings in "mm/gup: disallow FOLL_LONGTERM GUP-nonfast
> writing to file-backed mappings", there is no need to explicitly check VMAs
> for this condition, so simply remove this logic from io_uring altogether.

Don't have the prerequisite patch handy (not in mainline yet), but if it
just moves the check, then:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


