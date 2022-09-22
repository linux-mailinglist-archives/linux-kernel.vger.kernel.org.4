Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A33F5E5BD5
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 09:08:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230189AbiIVHIM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 03:08:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIVHIJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 03:08:09 -0400
Received: from mail-wm1-f49.google.com (mail-wm1-f49.google.com [209.85.128.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 881ABB72B5
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:08:07 -0700 (PDT)
Received: by mail-wm1-f49.google.com with SMTP id d12-20020a05600c3acc00b003b4c12e47f3so698997wms.4
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 00:08:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=nWpDQmZNg8zKVk12QskQ7NNS05C4fI/JmZBKLdKyu8Q=;
        b=1xB8Wxn4sr6m9EGBte2hwgDVaWfdsgPzxFk8PgZUj8vVciA2bScm//poiOFMEKyju2
         Y6eo+iU9FggyDSudFsIl7jB9nFmNG9WdHdZngYIf7FUWwJuO3v0JsI+a2kkIYYYIHWJX
         hz3NbV/f7gh8FOzqIm1iN5RTcZZDiWeKVOAuU5QbvqNN0oYlQEzgv5g5jmc3aMD1jGD3
         5DfUvdEl8foVOLARpQsznDxDgMmf4/0i8HLwcIjjU/1R2TsaNsqfc5nTjD1uImg7SN8k
         /xtvzFkh47k4cq/qVAmaqlKq1M8yD3WDDPUZa0JlRAb9zB0pX79QeZ50deiPfWJZmEpI
         DatQ==
X-Gm-Message-State: ACrzQf0WW2U9lC2X4dyRduVhAE6j9Nnk6aNnyzCADdJL1cu2+zkEepAB
        p7820qEFY94HaLElvST+W4MqzmXF8Mk=
X-Google-Smtp-Source: AMsMyM530FO/8mVaChDTJdndSiGt3YHF3QItRCZ+6Uj0jpAuNAIzlAAQPHmarxm9mjXEVjNE9hxTeQ==
X-Received: by 2002:a05:600c:6025:b0:3b4:8c0c:f3c9 with SMTP id az37-20020a05600c602500b003b48c0cf3c9mr8067924wmb.206.1663830485925;
        Thu, 22 Sep 2022 00:08:05 -0700 (PDT)
Received: from [192.168.64.53] (bzq-219-42-90.isdn.bezeqint.net. [62.219.42.90])
        by smtp.gmail.com with ESMTPSA id x8-20020adfdcc8000000b0022a2dbc80fdsm4355131wrm.10.2022.09.22.00.08.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 22 Sep 2022 00:08:05 -0700 (PDT)
Message-ID: <aaf0642a-77ae-0b02-6e68-50aebb746355@grimberg.me>
Date:   Thu, 22 Sep 2022 10:08:03 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] nvmet-tcp: remove nvmet_tcp_finish_cmd
Content-Language: en-US
To:     zhenwei pi <pizhenwei@bytedance.com>, hch@lst.de
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220922070616.41918-1-pizhenwei@bytedance.com>
From:   Sagi Grimberg <sagi@grimberg.me>
In-Reply-To: <20220922070616.41918-1-pizhenwei@bytedance.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS,TVD_SPACE_RATIO autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Reviewed-by: Sagi Grimberg <sagi@grimberg.me>
