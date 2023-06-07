Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A5D1726205
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 16:01:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240561AbjFGOBC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 10:01:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39236 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235683AbjFGOA5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 10:00:57 -0400
Received: from mail-qt1-x82f.google.com (mail-qt1-x82f.google.com [IPv6:2607:f8b0:4864:20::82f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC9451BE3
        for <linux-kernel@vger.kernel.org>; Wed,  7 Jun 2023 07:00:56 -0700 (PDT)
Received: by mail-qt1-x82f.google.com with SMTP id d75a77b69052e-3f8b0649010so6385741cf.0
        for <linux-kernel@vger.kernel.org>; Wed, 07 Jun 2023 07:00:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1686146456; x=1688738456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HOCvM+wCvnJoggN1nEyjs9wZihSgmluqfGP4CTrUN+s=;
        b=CgdiNJqjx99Ix055bKPgZp2ZB5P1ehtbhJYmpidHimvDk/8Rc4m3Z6ztL8UYQcXs90
         4IaySZyiAcsOJAyduxz5Wmin7RCnHfpOMwMiKs3ARwJzpzyVrmALkP2fNe6lb92h0+7h
         r3jw7NaCSbWA68RQdufAWMgKXvJbb7a40gpIHq0IqnySgVWrGvbUxXH7eKB5HdIAyAsz
         vmSyHWY5ug7RfXv173aS7uukm84JxmQU9sco8zs+sMECnhBp9FOzHon+XvUn2QLCLS0o
         mAjZnCeNj7PcUcvaHif/p/v2NsUnod9nLzpNzGoXoXYp1Q1ZDhWB97Bd+jY3AQKQMZFw
         jhDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686146456; x=1688738456;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HOCvM+wCvnJoggN1nEyjs9wZihSgmluqfGP4CTrUN+s=;
        b=eDXMgYgTndVMl+c2hBjrx/VQIaieFd0Asjc/7FqZl6Cihv8HzUEORQUpO2hJdkMAbo
         a2JRIvoJxsyzEpi5P6uPtGSwI7P8Cv7165e7XoYNrS7hJAF0ccQvLVQkCnOGYeolWLmP
         b8lYCCtzR6DFZC9d1pPtILszY923tVghJy1qug9qFC1dFavaszph9iBHQaH6fW0dR/dQ
         g4SrS5lb0zuYbDa/aozrgKpDgp54lGhsIhzIrjP/RJCD2/XSMd7ttavNpPH9mxs8Kg6o
         U7Yskw0Hi8unL5Ob8N2u/7T1xPbjrMgSB68AdT31PQvy/qtUgDWvGtMXGyOPTeG+yMQV
         QmbQ==
X-Gm-Message-State: AC+VfDyMFPXOBJqF1jBOTpN/t1gJed/BTCaL7S9w0JuXmttwnm63qwH1
        nfJvMe0JIDFkEREQgfE/ptK09jApWKnbJJAvm6A=
X-Google-Smtp-Source: ACHHUZ7LkJL/9s7I6RDqotQ+fkxI9CcRf+t35pVZKaawSY+Bnll0wUJGYQbYK7xO+bndn/VpktdaTw==
X-Received: by 2002:a05:622a:1a1c:b0:3f6:a9e9:1e96 with SMTP id f28-20020a05622a1a1c00b003f6a9e91e96mr2069105qtb.2.1686146455907;
        Wed, 07 Jun 2023 07:00:55 -0700 (PDT)
Received: from [192.168.201.244] ([50.234.116.5])
        by smtp.gmail.com with ESMTPSA id w23-20020ac87197000000b003ef13aa5b0bsm6371793qto.82.2023.06.07.07.00.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Jun 2023 07:00:55 -0700 (PDT)
Message-ID: <4e8856e8-9e55-2848-26a8-580a2911db19@kernel.dk>
Date:   Wed, 7 Jun 2023 08:00:53 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] block: fix rootwait=
Content-Language: en-US
To:     Christoph Hellwig <hch@lst.de>
Cc:     linux-kernel@vger.kernel.org, Fabio Estevam <festevam@gmail.com>
References: <20230607135746.92995-1-hch@lst.de>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230607135746.92995-1-hch@lst.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/7/23 7:57 AM, Christoph Hellwig wrote:
> Failures to look up the gendisk must return -ENODEV so that rootwait
> retries the lookup instead of -EINVAL which exits early.
> 
> Fixes: cf056a431215 ("init: improve the name_to_dev_t interface")
> Reported-by: Fabio Estevam <festevam@gmail.com>
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Tested-by: Fabio Estevam <festevam@gmail.com>
> ---
> 
> [Jens, if you need to rebase for any reason it might make sense to fold
>  this into the offending patch]

I have applied it for now, and probably not a high likelihood of rebasing
this late. But if I do, I'll fold it in.

-- 
Jens Axboe


