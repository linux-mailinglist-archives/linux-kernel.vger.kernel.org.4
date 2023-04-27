Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27B886F0E94
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 00:52:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344351AbjD0WwJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Apr 2023 18:52:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344105AbjD0WwH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Apr 2023 18:52:07 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00FA52698
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:52:01 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 41be03b00d2f7-524db748169so1190257a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 27 Apr 2023 15:52:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682635921; x=1685227921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TTdHYZiyhUIZRmQ86+NSUVyJw5qozVR7VPPXjKj67Y4=;
        b=JXiF8hOcwzfAHwUQA05RmKlam4Gq9TcWWIHPSYwfF4h8fVYDtA0TZgR32Tv2XUlpFw
         PLXqKZiRDqeLV88nGuUuRJlBxS4y/7RwELvEtywsXIHzJXwbyIk2yrnLSKRZJpy4h01L
         yR2He/tHYADcwZTl5rCm0WqeYG7VAa9VwUBDdxrMSA/RSYl1sW+EouaFmbULzzl/qxZS
         AGDGHCPg/i/xc9ncVV1cRgAgmUu8yX/G15Glocbipoc8kY7EEC1MtaG4NvqVV4PMnOdE
         vhol51SGDucaBp/8XmiXf9dawk7O7uAa+rBBDXNKI9Yksg25dcA3E4a3b9Kooml2Y84Q
         WdNQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682635921; x=1685227921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TTdHYZiyhUIZRmQ86+NSUVyJw5qozVR7VPPXjKj67Y4=;
        b=F3epvjL6X/d+2SvoWHqsc7Fw+bvBXw0sdQkyEVr5rYmZxrXWKofDDbhNZxoHX+K54D
         A93rKyo9HZsVC3tDgHKi9EIDxX+hzt4YbYUtApIUuumCMaSwY21PpCnAEfTaJZJ377RK
         YEeE8Z/Ut21tbkwRXHkSknOOONDphJRLsGTki1RMnjCj+khfYQi/cUkhSfiOUEEyi8+q
         iKL4H+ZXNsgpF+Wq66Bn70mm4BIR/0vGtVCM/z4hInldZoRBAZoZ9mvsa+kmpEk0kl7z
         QH3vdm/x09ZS1OhC42MjbOwz8X67M/vAQNd75YmpCZr9XqA7Lka7Qft0aNv+A9mJBnF5
         AryQ==
X-Gm-Message-State: AC+VfDxhBJsDBxy236Sx8kW0eojqopfisnyao9iAVVN6ycJgX2+giB7E
        UVerLsXYdfkqZvxR05T1q/wVlA==
X-Google-Smtp-Source: ACHHUZ6abgkT7mDxxsZEoKOx5wECXIfK1pUTWL3FPCvuM6eUUIYkUzZIt/mIHvWkr5a9RmBDZpwcdQ==
X-Received: by 2002:a17:902:ea10:b0:1a9:1b4:9fdd with SMTP id s16-20020a170902ea1000b001a901b49fddmr646043plg.2.1682635921395;
        Thu, 27 Apr 2023 15:52:01 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id r21-20020a170902ea5500b001a988a71617sm5380578plg.192.2023.04.27.15.52.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Apr 2023 15:52:00 -0700 (PDT)
Message-ID: <f9b06711-6d3c-2271-b2eb-13ab4e8ec040@kernel.dk>
Date:   Thu, 27 Apr 2023 16:51:59 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/23 1:47 PM, Christophe JAILLET wrote:
> Group some variables based on their sizes to reduce holes.
> On x86_64, this shrinks the size of 'struct nvmet_ns' from 520 to 512
> bytes.
> 
> When such a structure is allocated in nvmet_ns_alloc(), because of the way
> memory allocation works, when 520 bytes were requested, 1024 bytes were
> allocated.
> 
> So, on x86_64, this change saves 512 bytes per allocation.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> More aggressive grouping could be done to be more future proof, but the
> way the struct nvmet_ns is written suggest that some fields should be
> kept together. So keep grouping as-is.

I think you did the right thing, that move doesn't matter and it brings
it to pow-of-2 or less and that is really what matters. So looks fine to
me:

Reviewed-by: Jens Axboe <axboe@kernel.dk>

-- 
Jens Axboe


