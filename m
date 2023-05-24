Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E00B70F9A0
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 17:03:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234999AbjEXPDY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 May 2023 11:03:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236382AbjEXPDW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 11:03:22 -0400
Received: from mail-il1-x131.google.com (mail-il1-x131.google.com [IPv6:2607:f8b0:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71634191
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:03:20 -0700 (PDT)
Received: by mail-il1-x131.google.com with SMTP id e9e14a558f8ab-3357e69c49dso70645ab.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 08:03:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1684940599; x=1687532599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GgDKrHLcU2tmKaG5NStKDv/+h6lvDy9SPWrocWEqRKY=;
        b=KbH4KU5/h08dj7t3PcKDEDm1/UReJFYLAuotdxeU7tXw+L3zRabkYBA3/BiKFZ6qGI
         F+gr7jKiGNgNggWdzLjBSu+ilsXCZXOWONG2Kn86u2gb7qD1QKtBHYmpFu6P7boIIbxF
         Ikcp+oCxS1YOq8hwfuzdVPoX0d+TFE5d9+HLvpfoYubx+csuBQlK4vxHr9KiirNkQuvc
         yjhDXcL/i6vHnVwz0il0gJbyfMbbI6KloHYzHtfn/jh5+C9TFsv3L+Je+WxPCKJeD4Xa
         5FGGnwZv1ZsixHpLsBZSgDQfww5jeEUekWIIolhHQKnmz/X1ZKN3WbCjGwog/cXUR0Vv
         eGIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684940599; x=1687532599;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GgDKrHLcU2tmKaG5NStKDv/+h6lvDy9SPWrocWEqRKY=;
        b=XAPpQ3drItlHlEXuwuPAtTIQLgGrnXp7IkyVaJ/wLamz51H3+9VqFxdKCXEPmqFys7
         9QTXdFwlNMNKIBryfgdCsrNxxVmcim7aHJzvojhdXQCNpyyqevRN2WBHh4NVzj8d6RNz
         WGvioOyaZ1m9c0FItHfOpPzyASXBV0mGp1qGx7fNlvOUHTQBSww8YQQX8xVP/MvOVgSt
         MRxFp5foWIvoNyeZAKVSnEJdfFS9/e6eFtL3vYlMAuK/NTbhy+tYsoPlue267wmFK6ej
         NyzutrI0Vfbxij8eGfHA0cCBn6UmkQFCPD33nl7GKGg1MCt4fX56ynZDkQbtr+0IrBVP
         X7EA==
X-Gm-Message-State: AC+VfDxy3sONUHMDN0fCdQmE0IHQB/y3jZeKmU2NWVA1O/jZd839vyaB
        XoqrIhdR1LYZvbqj/h6g8yzJvA==
X-Google-Smtp-Source: ACHHUZ5ssaxrjwm/Xnp0jY+aTTrWQU+36ntdVpV25h3nuBN3qq1X8OGPSHY1YY5Xi3JTKSSDYR1gOQ==
X-Received: by 2002:a92:cd8b:0:b0:332:868a:ea8 with SMTP id r11-20020a92cd8b000000b00332868a0ea8mr10627847ilb.1.1684940599631;
        Wed, 24 May 2023 08:03:19 -0700 (PDT)
Received: from [192.168.1.94] ([96.43.243.2])
        by smtp.gmail.com with ESMTPSA id t14-20020a92c90e000000b0032b54912651sm1073938ilp.5.2023.05.24.08.03.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 24 May 2023 08:03:18 -0700 (PDT)
Message-ID: <7075bfd8-7c52-a778-5651-71ade3cd1f03@kernel.dk>
Date:   Wed, 24 May 2023 09:03:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] md/raid5: fix miscalculation of 'end_sector' in
 raid5_read_one_chunk()
Content-Language: en-US
To:     Yu Kuai <yukuai1@huaweicloud.com>, hch@lst.de, song@kernel.org,
        chaitanya.kulkarni@wdc.com, johannes.thumshirn@wdc.com,
        damien.lemoal@wdc.com
Cc:     linux-raid@vger.kernel.org, linux-kernel@vger.kernel.org,
        yukuai3@huawei.com, yi.zhang@huawei.com, yangerkun@huawei.com
References: <20230524014118.3172781-1-yukuai1@huaweicloud.com>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <20230524014118.3172781-1-yukuai1@huaweicloud.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/23/23 7:41 PM, Yu Kuai wrote:
> From: Yu Kuai <yukuai3@huawei.com>
> 
> 'end_sector' is compared to 'rdev->recovery_offset', which is offset to
> rdev, however, commit e82ed3a4fbb5 ("md/raid6: refactor
> raid5_read_one_chunk") changes the calculation of 'end_sector' to offset
> to the array. Fix this miscalculation.
> 
> Fixes: e82ed3a4fbb5 ("md/raid6: refactor raid5_read_one_chunk")

This needs a stable tag as well, Fixes alone is not enough to guarantee
it ends up in stable.

Song, are you picking this up?

-- 
Jens Axboe


