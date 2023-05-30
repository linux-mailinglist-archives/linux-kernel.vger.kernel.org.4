Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD001717229
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:59:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233077AbjE3X7E (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:59:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjE3X7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:59:02 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EF5AA;
        Tue, 30 May 2023 16:59:01 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-256712e2be3so2721435a91.2;
        Tue, 30 May 2023 16:59:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685491140; x=1688083140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AyLYtQEocJut+YbQMppatVpiZoEfM4IEva+yQLKoQgY=;
        b=hBmsZAs91gEUB5tqtPMCNyVe0Cearix2tq8FMyxsSJ/iJjzsD+rF6x8Dtt+0uaX0jL
         Di0pCBh/qQzAPB1n5bx4DPimUUOntZU0QNwtSyVw9KAhhnU/klW72AeDCEvlv9r73cyC
         5wY1fKcI+0II1HWpvW098W//nGI01QR576Y5ANGGQyJ5ke2nBWHesu9L075lnd2GGArA
         rd8d9Yt2dzax7gJlqqh+YtCv83phfb/CNqICsRLj+8XVnjhdXblNaRfTharPp9Sl4fRv
         Xz38F0ihHNreaaC6z8qMbYnGIcwgji17iFIdIjn5HQ/x376USsLE+63sFsrZt8wi+RMd
         NkYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685491140; x=1688083140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AyLYtQEocJut+YbQMppatVpiZoEfM4IEva+yQLKoQgY=;
        b=A2roLxODIs0JJgDpga5ctSwSTAOyLnfv4l/Vv2xigE22763Th747s6q++XTJ6UU7Q6
         T27o5LJ/4TPCvTtBOSowoo9b1QyzvNsAf+54JI02MuFzhiTE2ar/VCoMzuWKHTr1xMv2
         EsFIquYl/XRpR7RdnP77jqq70hAQTS2DRk3L8K2jb4kCRMw8FSaOhiRqrfR6RbGOmQvW
         0qYYN6sAuMCDDhB7NIoDnB7QZwGO+pEMxVr97Bjdku9sClWZWXP3DMEZBvTIiVAwuHBz
         FkIGarEod6GZlgCSN0f8gppQl7zzeruMbVFRjND0neocxD0hXgnQHt5qGzJwkjHRA6d7
         NJTA==
X-Gm-Message-State: AC+VfDziuwtU+wZN9sqxCTWDPjfe/OykudH+Jdq3Z3ezjNiZnkXuGJMr
        CaTdVtRAJy2OnJWHwirOAws=
X-Google-Smtp-Source: ACHHUZ47Zm9YzAl5ayUCbwcJFjkaPyyE2BXWmp5Z67ZX1jS+IzwK+7QsB4Y22Dg5j1HRICKm3Dk6Gw==
X-Received: by 2002:a17:90a:9f96:b0:255:5d65:3a86 with SMTP id o22-20020a17090a9f9600b002555d653a86mr4036130pjp.8.1685491140437;
        Tue, 30 May 2023 16:59:00 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id s17-20020a170902989100b001a245b49731sm7112444plp.128.2023.05.30.16.58.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 16:59:00 -0700 (PDT)
Message-ID: <4cf3b389-fd01-d8ce-0dc4-369efbeb8d6e@gmail.com>
Date:   Tue, 30 May 2023 16:58:59 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 3/3] scsi: ufs: ufs-mediatek: Add MCQ support for MTK
 platform
Content-Language: en-US
To:     Po-Wen Kao <powen.kao@mediatek.com>, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Stanley Chu <stanley.chu@mediatek.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     wsd_upstream@mediatek.com, peter.wang@mediatek.com,
        alice.chao@mediatek.com, naomi.chu@mediatek.com,
        chun-hung.wu@mediatek.com, cc.chou@mediatek.com,
        eddie.huang@mediatek.com
References: <20230530023227.16653-1-powen.kao@mediatek.com>
 <20230530023227.16653-4-powen.kao@mediatek.com>
From:   Bart Van Assche <bart.vanassche@gmail.com>
In-Reply-To: <20230530023227.16653-4-powen.kao@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/29/23 19:32, Po-Wen Kao wrote:
> Changes
> - Implement vops and setup irq
> - Fix pm flow under mcq mode

Please use the regular style for patch descriptions and use full 
sentences instead of a bullet list.

Thanks,

Bart.
