Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D80B65B55B
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 17:53:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236453AbjABQxk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 11:53:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233439AbjABQxi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 11:53:38 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C311E1C
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 08:53:37 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id jn22so29999549plb.13
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 08:53:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=T/cxfl/LR9GgO9ZvS/ZvJXYf6jxwd1F3cUMP6lmAYpI=;
        b=mmntdGgr7TfOTVqLvYs4G7k/SpKn+gpvtuPloVB2LEPAIA+WeUZgVv1UjLHQFhAj6O
         aQG7pGbwezQRE2dvn/5uJuKj3TNPdQz9AvtTKU1+w/2xP2EX+l+22ByQGP8K8rF7Bohc
         KXSzXT3cCYHoRTiyB89cG7QRHYY94dWjERbfKCB1t9VnhudXvC7ZAwcSI/9T0M44wjwi
         Ky1fjOjgleVLQxUHdP7DUpxdtqnzCvEXDa7Lk7YRrH5id+eeKzA+C3CCna96yQX8hEVQ
         m+9m4uReFdr62USHq4yMpdQRaQadH8nWpCDquQ+OGt7CZdDW/z/zoF17/hK/lblsTiQa
         9f+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=T/cxfl/LR9GgO9ZvS/ZvJXYf6jxwd1F3cUMP6lmAYpI=;
        b=cvy9NDXoVZo7zwmcqfZCPa6+wCJ1XWrOrq1ROzIh3q42KCT18JqsEzRxV3b2VwQ1bM
         urbUEnuzAUn6a/FnTQj9483P4nR2u9IZsoshfMiXpIoS3if24OcbmLKGmQcliRNNi5Bv
         fJ2G2qVmD6mNiglahB2T7iLF4L6eHB/NujBhgX8H12AdWgLK5lB7F8GEJA1DX9hTuOlX
         cHSmVvokcX/NUlUiv91YV98QBwP4BBDfV3obvHZKC5z2oaVMQTgvHQmmUndq/jx+YGnU
         J3P7Gh1IgBUXoJJ5QCKdO18wTjnQGHnyUueeSdrHd5ePSqOUZLH1EMhsjD/J00tvaXfh
         vD8w==
X-Gm-Message-State: AFqh2kqNZC1r2KZK8VvyOd+gtSnvJTrBigLuQrAwTeJowW6kirvfgbtj
        OtRXU5TrOuUoNzL4iwGZSGqnZA==
X-Google-Smtp-Source: AMrXdXuDyzl3mRGjAOUDPdqwWXpAqM8HKZ629fDDGtE4QLCE/aeGvJpusjDyAqhHyPpCbS6gvzZQkw==
X-Received: by 2002:a05:6a21:398b:b0:ab:9997:8ee2 with SMTP id ad11-20020a056a21398b00b000ab99978ee2mr12332900pzc.6.1672678416492;
        Mon, 02 Jan 2023 08:53:36 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id v63-20020a626142000000b005828071bf7asm1924910pfb.22.2023.01.02.08.53.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 08:53:35 -0800 (PST)
Message-ID: <9a01e386-0fb5-b074-a7b1-7e4bcf1ca204@kernel.dk>
Date:   Mon, 2 Jan 2023 09:53:34 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH V13 0/8] block, bfq: extend bfq to support multi-actuator
 drives
Content-Language: en-US
To:     Paolo Valente <paolo.valente@linaro.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        arie.vanderhoeven@seagate.com, rory.c.chen@seagate.com,
        glen.valante@linaro.org, damien.lemoal@opensource.wdc.com
References: <20221229203707.68458-1-paolo.valente@linaro.org>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20221229203707.68458-1-paolo.valente@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/29/22 1:36 PM, Paolo Valente wrote:
> Hi,
> here is the V13, it differs from V12 in that it applies the
> recommendation by Damien in [2].

This doesn't apply to current master. Can you send one that
does?

-- 
Jens Axboe


