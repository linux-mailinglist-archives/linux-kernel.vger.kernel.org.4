Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 841485BEBC2
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 19:19:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229482AbiITRTq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 13:19:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiITRTf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 13:19:35 -0400
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com [209.85.215.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1335C287;
        Tue, 20 Sep 2022 10:19:30 -0700 (PDT)
Received: by mail-pg1-f174.google.com with SMTP id t70so3326078pgc.5;
        Tue, 20 Sep 2022 10:19:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=gBfZj7XIlX/J504CoNlivd7WwPervkF1S3JmG+E95eE=;
        b=qecGXkrd31eQAyJ/DkFYYAyuzkBP+euDV0Ut6O1MyPHDsRm+FBriem23F7ZTxVfUTN
         RSyYie5LoEynETIz4pHGLeaGKCVH6VJV0JaY7hfeMmhr9EPDxj5cNZO1URyeprGz5fZx
         oNh3Sbx+x5DdlyvW4cKXQpa1DaLQw8m6hZu0GHlr5dMsPfgd3p17ffLQ6dgAq5B6Og5b
         83efieNk7kSNLPDfcEaToYb+N3PbCvWozHSe2OXgYbUNEpkBd4FLgQ4HrZfq1iOWeQcG
         cNfSZXBtf3XAE5NQSeuVJOiMg2+sqkcdyPerOjHz+hIlnj4qOT62mxqnnNtWcXdGHJwF
         PpLg==
X-Gm-Message-State: ACrzQf3wqZuAvWKyv5Jwd1vK4E95qodx9TBh+24GAlxV4XzgOfbpUhGS
        q2i5aXkzeEbkYROl80OTcPw=
X-Google-Smtp-Source: AMsMyM7604f73NTFDxf4v00wgC7gSDl7mvlw2FFl0xOqAEuxNubjhH69fbccsrKvdUKHKZE4xXDFEg==
X-Received: by 2002:a05:6a00:2350:b0:541:b5bf:2774 with SMTP id j16-20020a056a00235000b00541b5bf2774mr23978438pfj.28.1663694369177;
        Tue, 20 Sep 2022 10:19:29 -0700 (PDT)
Received: from ?IPV6:2620:15c:211:201:c7e0:1691:74c9:2e9? ([2620:15c:211:201:c7e0:1691:74c9:2e9])
        by smtp.gmail.com with ESMTPSA id l19-20020a170902f69300b00176b3c9693esm109186plg.299.2022.09.20.10.19.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Sep 2022 10:19:28 -0700 (PDT)
Message-ID: <db36f36f-d321-b848-dfd2-9bb693e68dfb@acm.org>
Date:   Tue, 20 Sep 2022 10:19:26 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] scsi: ufs: Remove redundant function definitions from
 ufshcd.h
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1663575664-27358-1-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1663575664-27358-1-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/19/22 01:21, Arthur Simchaev wrote:
> This patch removes Query-Request API functions declaration from
> from include/ufs/ufshcd.h. Those declarations belongs solely to
> ufs core privet header.
            ^^^^^^
            private?
