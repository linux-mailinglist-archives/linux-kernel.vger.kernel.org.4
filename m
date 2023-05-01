Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C9A56F31B2
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 15:58:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232258AbjEAN6p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 09:58:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34902 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjEAN6m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 09:58:42 -0400
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com [209.85.128.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FB461BC;
        Mon,  1 May 2023 06:58:41 -0700 (PDT)
Received: by mail-wm1-f42.google.com with SMTP id 5b1f17b1804b1-3f1745b7132so3791945e9.1;
        Mon, 01 May 2023 06:58:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682949520; x=1685541520;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=ijQQGKpKGzJkq7hiQ6xNldhpmNiHXpblT5WSwTjdtQ8tekm6mVlL93G2QaYQJop3jc
         Fh3F3BUAr4Kurcoez4PgWXNCqe+119nAWjdYjl46g90zgpn8IK5CQzvm44VkqWia2bx5
         Oi8oUcD3v0xJ+ndHXW9Lu7TYRPIdyIcP6wGyz3FeWn/Dx0B8xCnqnkpgtMh+LlpUMQPS
         /s6xpDLUt0hfaIsygRnFFHVS4RQfQECdEDwoUUCw6EAsI8hZClOzi3F2JZUqzzbTuSOu
         man/LQC/zimAGjI70LhHWKCv/DtVhzG2TW4cwyUa+CggWkefOhewDqGgvBVacKnVSTZ3
         Dxkw==
X-Gm-Message-State: AC+VfDwf50YbWJoHb/rBzt2LAMbxJBlt1+9qlKcGz5fJeS8PEM338No1
        0SZcdzZ08FCGChFovmd3TKw=
X-Google-Smtp-Source: ACHHUZ5fmsGRmunTeUxurbFpwCadLNtuqYQAughrYQ2hG1yAOPYRFXmf0DIBqc2nXwyFjfO8/Ir9zg==
X-Received: by 2002:a05:600c:3d95:b0:3f2:571a:9bce with SMTP id bi21-20020a05600c3d9500b003f2571a9bcemr8430563wmb.4.1682949519978;
        Mon, 01 May 2023 06:58:39 -0700 (PDT)
Received: from [192.168.64.192] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 11-20020a05600c228b00b003f1736fdfedsm32605561wmf.10.2023.05.01.06.58.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 May 2023 06:58:39 -0700 (PDT)
Message-ID: <4e66d227-ca14-667f-faa5-b471886caa1b@grimberg.me>
Date:   Mon, 1 May 2023 16:58:38 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] nvmet: Reorder fields in 'struct nvmet_ns'
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Christoph Hellwig <hch@lst.de>,
        Chaitanya Kulkarni <kch@nvidia.com>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-nvme@lists.infradead.org
References: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <aea924d31f2bd2f740b1ccc6f462905bd6cab763.1682624855.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
