Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 853EA6091C8
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Oct 2022 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJWIWM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Oct 2022 04:22:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229535AbiJWIWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Oct 2022 04:22:10 -0400
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com [209.85.221.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46FE9647D6
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 01:22:09 -0700 (PDT)
Received: by mail-wr1-f44.google.com with SMTP id bk15so11022634wrb.13
        for <linux-kernel@vger.kernel.org>; Sun, 23 Oct 2022 01:22:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=gmfRqaHn3c578FzfeUoo06kQzbcUIYt0FDutQsSYuf/UtSqW3sJWXZBPgNEOO0WaQl
         r0p6oi2EvW93FCn95dyFOBl8vY1pqO+ymDdYGm3CKGXNrB0Yi7EMHzchWHOMkbDeyI0U
         2115/zSLlyHrtoIhojvi7AWx5meCmjQXDcXwRdkN7ZZUSpueuEK0TVCskV5oIEb/IBlt
         B0AixeOjcjW1V5EHyovpeypW7JfKpdW/C6kQ99lYHe1DsuQvt8vwvHcVxcpAskO3p6mD
         H8JoyK5/phAWE2XVrRQC/0K7XvFpuUDHptVSMPKiYAPPYkWJ7TB1Iw0Wnk4Euc370RRW
         zNfA==
X-Gm-Message-State: ACrzQf3ONqBzTCyMZOdIplU9/laOidk4NGxcNa5DaYt3fQlH+9mHw56r
        jgoyAemYzJQnSGFF+/s9aWU=
X-Google-Smtp-Source: AMsMyM68X5PsBPKNMzR0gTgAo/dRfkj4XW1d7ZOsLfr1huNVWiG+V+jvTBzflTVuoTGafkGEXWWNGQ==
X-Received: by 2002:adf:ec03:0:b0:22e:4d3:bb37 with SMTP id x3-20020adfec03000000b0022e04d3bb37mr17278380wrn.665.1666513327901;
        Sun, 23 Oct 2022 01:22:07 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id 1-20020a1c1901000000b003bf3fe1d0c4sm7459807wmz.22.2022.10.23.01.22.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 23 Oct 2022 01:22:07 -0700 (PDT)
Message-ID: <375f492e-6080-9b6a-a1a9-a552649e2229@grimberg.me>
Date:   Sun, 23 Oct 2022 11:22:06 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] nvmet: use try_cmpxchg in nvmet_update_sq_head
Content-Language: en-US
To:     Uros Bizjak <ubizjak@gmail.com>, linux-nvme@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     Christoph Hellwig <hch@lst.de>, Chaitanya Kulkarni <kch@nvidia.com>
References: <20221020153540.8226-1-ubizjak@gmail.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20221020153540.8226-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
