Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CC4E6F56E1
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 13:06:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229806AbjECLGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 07:06:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229577AbjECLGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 07:06:03 -0400
Received: from mail-wr1-x431.google.com (mail-wr1-x431.google.com [IPv6:2a00:1450:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4A6E1FDB
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 04:06:00 -0700 (PDT)
Received: by mail-wr1-x431.google.com with SMTP id ffacd0b85a97d-3062db220a3so2299721f8f.0
        for <linux-kernel@vger.kernel.org>; Wed, 03 May 2023 04:06:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linbit-com.20221208.gappssmtp.com; s=20221208; t=1683111959; x=1685703959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=zC1Gta3a1KlJpbjr0dHCub5GbkSXMMiO3N0auJSFEi4=;
        b=5WhYU1zjMzb3TRHB1ZMk7kLTS0gKNrQH6Y+bzmvOp+q02IjV9kk6xvjBSHRbTeiBU8
         9C9b40A8nGaZpu2kkWZINs88/ff/9yp228wkRX/6hdH3/mwpUMV10573pUulpY5gv7FA
         Xngnq88/iEOCk/UJA/wG0paP+7OyXCfo6DnTpibkGHznrTuCvdpgd1pOuDxkT8KkmOgq
         wK1Jxilbjc7JXsXzsTMDBAxC/SAG0N5epLX/RGX+H9VnewcAQiusg7zsjvxTN8o//g9s
         JTGRX2Hv0PF2oN5CkRkOyFGt95YQw0e96Gi5jnY7FQzfRE+iG1P4csBYqMzx1kqubBWe
         2kgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683111959; x=1685703959;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zC1Gta3a1KlJpbjr0dHCub5GbkSXMMiO3N0auJSFEi4=;
        b=Y/OSD9lnSH8mE1EpNlp9vrI3fGBObPrAwB48mSD5luBisxf7jMRkj3/M5k3nWdSJUC
         dk7ZFKwjZffLYW/NgBzy3TxLhJAoPJAJlYbXOtdQxHu9YeuFbwz3uW/772KH2VAwPHMj
         BIVvTXJD3vBWNw6hFuVr11v0icmiZI5HhTKXtJmHY4zu4uRVT199aFbFwEW3aJrTUm8t
         KJx0vmRGXELYuZGbU0bxLuJEcRvpAZlnenquLqMm8L4z4AJoMuv/HYdnXY8scNdjk/+t
         riS+i4NZqeVQl1WVo5iuNNFwEdQ6ndxLVWQRoMt5jucc0Q5pH+DkAITPZQzY9wbKGglP
         kdSA==
X-Gm-Message-State: AC+VfDzGPp8eHKoKt+ep6o79WNtvoNBxrVhJVpdjhRPv6DkbTjEA0M9k
        CHfGWL5xhgzP/vtkXCxy3giZeQ==
X-Google-Smtp-Source: ACHHUZ7zkhTIpzWubzYVvlBwUFu5dNo6evewdVN6u2chVe57/nTRHxWkzD+fPR2/AIMcjUnNBk+8cQ==
X-Received: by 2002:adf:e2cc:0:b0:305:ed26:8576 with SMTP id d12-20020adfe2cc000000b00305ed268576mr9968284wrj.9.1683111959225;
        Wed, 03 May 2023 04:05:59 -0700 (PDT)
Received: from [192.168.178.55] (h082218028181.host.wavenet.at. [82.218.28.181])
        by smtp.gmail.com with ESMTPSA id o2-20020a5d58c2000000b002fe522117fdsm33440960wrf.36.2023.05.03.04.05.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 03 May 2023 04:05:58 -0700 (PDT)
Message-ID: <b1568ca5-4daf-f6b5-7861-4881aa46e578@linbit.com>
Date:   Wed, 3 May 2023 13:05:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] drbd: do not set REQ_PREFLUSH when submitting barrier
To:     Christoph Hellwig <hch@infradead.org>
Cc:     Jens Axboe <axboe@kernel.dk>, drbd-dev@lists.linbit.com,
        linux-kernel@vger.kernel.org,
        Lars Ellenberg <lars.ellenberg@linbit.com>,
        Philipp Reisner <philipp.reisner@linbit.com>,
        linux-block@vger.kernel.org, Thomas Voegtle <tv@lio96.de>
References: <20230502092922.175857-1-christoph.boehmwalder@linbit.com>
 <ZFHgefWofVt24tRl@infradead.org>
Content-Language: en-US
From:   =?UTF-8?Q?Christoph_B=c3=b6hmwalder?= 
        <christoph.boehmwalder@linbit.com>
In-Reply-To: <ZFHgefWofVt24tRl@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Am 03.05.23 um 06:18 schrieb Christoph Hellwig:
> On Tue, May 02, 2023 at 11:29:22AM +0200, Christoph Böhmwalder wrote:
>>  	struct bio *bio = bio_alloc(device->ldev->backing_bdev, 0,
>> -				    REQ_OP_FLUSH | REQ_PREFLUSH, GFP_NOIO);
>> +				    REQ_OP_FLUSH, GFP_NOIO);
> 
> This isn't going to work.  flush bios are (somewhat confusingly)

Indeed...

> implemented as writes with no data and the preflush flag.  So this
> should be:
> 
> 	REQ_OP_WRITE | REQ_PREFLUSH.
> 
> and it looks like whatever flushing this does hasn't wroked for a long
> time.

Thanks for the hint. I'll prepare a v2 today.

-- 
Christoph Böhmwalder
LINBIT | Keeping the Digital World Running
DRBD HA —  Disaster Recovery — Software defined Storage
