Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F9C96DF7A7
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 15:49:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231223AbjDLNtZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 09:49:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229701AbjDLNtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 09:49:23 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3AF4F1705
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:49:22 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso2413742wmo.0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 06:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1681307360; x=1683899360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Bb6P2byqyLNvxYx5mpnu/HADSn0CeAL5J6+dhakFGrg=;
        b=P+Olpx6A3/vNNZTdwI1G9eweBEoTH2LcwW2usLoVzpvOgrv5iZZ+KFMS27g/J/nfqZ
         reVa1Zx0lcjz6/7AlgdAny5ttEg1/A8/XSCvh2l7OO2rKzCVgRxHBPkkemKIOni+lCny
         1THlxhFeo2QlJMDkwR0f/NFAEgK1tfH/W+ftLtUkhnUkFrRnyqeBhWwbh6g6ZChXZS8s
         HI7sgOh5GakN3NTsu2jN1Z8PWH55G04Rj6Whp8gqyK4cGvTzgM+FgKSZT5UUCB/Ye6W7
         BWa3lO6jD0+wwjP/KXSgknZEQUIMW5tR2eS+YesJAdlkZt8k8+BlQiVYPZ8zhiccPFSJ
         vCwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681307360; x=1683899360;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Bb6P2byqyLNvxYx5mpnu/HADSn0CeAL5J6+dhakFGrg=;
        b=pyBsjkCsn5hXRCr3ZwYOCXujhAdsOFbEmp32w5gyXAdYcGtvraB+HB/po2i6G0tiaT
         0H9TBzj7vAdckIJWV+NepKbOdKBeyFDRBJn6o+zKnT5wPhSjX+wb9QTBYm5a8J6KqGp/
         8pWH+9EkbKV4Ail/ysIakg6y0sEj3aDjIfvjb09c3TQSMPDFyQLpkpA8LyZgW8roAtoG
         isz6tx0KwoQceoQqIDw4QcWKIqUD15L+qdxK7/PklNsgwwiUdgfNPfHJG74DnaS3FTiN
         Qf7pavHYZ+RfLknN9yxtPY9ED2UlK79Qq+B4JkkNRYQRAWl7gJmtYR9HG3u71u/CNnKv
         a/tQ==
X-Gm-Message-State: AAQBX9e/EUPHnkG/NepZ++aH9nOs7rqi80C9tTAIbkfZ2vZTwxgcyoHu
        r+AqqjW3c0SW+Rq/QOvdTA2FuA==
X-Google-Smtp-Source: AKy350Z5xFXV56UaJrsLbPCn9vUe4kX4KLRpXMruYqeY/5IcZ7js+EzGemp3jS4cE2erPI4Z/lM59A==
X-Received: by 2002:a7b:c7d4:0:b0:3ef:68d5:9573 with SMTP id z20-20020a7bc7d4000000b003ef68d59573mr4733356wmk.19.1681307360680;
        Wed, 12 Apr 2023 06:49:20 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id o24-20020a05600c379800b003edd1c44b57sm2451789wmr.27.2023.04.12.06.49.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 06:49:20 -0700 (PDT)
Message-ID: <de6bd3f0-5e54-7f03-f01a-4095aaf87dd7@baylibre.com>
Date:   Wed, 12 Apr 2023 15:49:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH -next 2/3] drm/mediatek: Use
 devm_platform_ioremap_resource()
Content-Language: en-US
To:     Yang Li <yang.lee@linux.alibaba.com>, airlied@gmail.com
Cc:     daniel@ffwll.ch, matthias.bgg@gmail.com, chunkuang.hu@kernel.org,
        p.zabel@pengutronix.de, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230412064635.41315-1-yang.lee@linux.alibaba.com>
 <20230412064635.41315-2-yang.lee@linux.alibaba.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230412064635.41315-2-yang.lee@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 08:46, Yang Li wrote:
> Remove variable 'res' and convert platform_get_resource(),
> devm_ioremap_resource() to a single call to
> devm_platform_ioremap_resource(), as this is exactly what this function
> does.
> 
> Signed-off-by: Yang Li<yang.lee@linux.alibaba.com>

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

