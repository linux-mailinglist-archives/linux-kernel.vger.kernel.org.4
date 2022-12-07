Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F4F646565
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 00:48:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229728AbiLGXsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Dec 2022 18:48:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbiLGXsk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Dec 2022 18:48:40 -0500
Received: from mail-pl1-f172.google.com (mail-pl1-f172.google.com [209.85.214.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0DF326E0;
        Wed,  7 Dec 2022 15:48:40 -0800 (PST)
Received: by mail-pl1-f172.google.com with SMTP id y4so18568267plb.2;
        Wed, 07 Dec 2022 15:48:40 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o7a+uhOneXeh+M/4xbj/mmiDcvMYDJs8/IOF16FOfOs=;
        b=5Mrh5LbSWWDPCoQe87uIFlIQzI2HgXWqxOzToCWGDANga8re0bpSxcvEJmBV6ZLJUZ
         wJY6kVbWUwrSgJH/jluizC+XXG8HDECydP6n6e+DBxrpwe8TNryWhkG/hhjKoyagpUOG
         UGE36OFeM0rzPbBPvU8VZtZzafaUqAz5yoxx7LzjDssJ80Ky+Loy4qm6x3TU6xvi/z0F
         8Dlt303D+aESkO6hEB9v30ahTNBRFMU4wmsmZIyv+l1VQrKKn4tmI3EhqEGrAW5iMXmI
         TGxuWgmjdlonuIEbTyqdJ/Fv8/W/RokLzLqQxo1XymFY5jrckCHfatLr0n2+jBJuQrEF
         GQpA==
X-Gm-Message-State: ANoB5plxpAtDchntBQOfVJyIY3WzLjx93JANWd1tBq+m0ytQM6gBX7av
        J1XJbFXcLoDfqOpgLAlu+KU=
X-Google-Smtp-Source: AA0mqf5FpIjjhD7YD/kAc4ys9rF55vSHPka+BMSa/hmKy0AybxGAvzTj63v9+xWEgY+GPTef7rq9JQ==
X-Received: by 2002:a17:90b:b06:b0:219:c1fb:5da8 with SMTP id bf6-20020a17090b0b0600b00219c1fb5da8mr19655148pjb.221.1670456919425;
        Wed, 07 Dec 2022 15:48:39 -0800 (PST)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id u2-20020a17090341c200b00174c0dd29f0sm5858470ple.144.2022.12.07.15.48.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 15:48:38 -0800 (PST)
Message-ID: <0abd2e8a-1482-d88a-4d58-cf17ef82c3f6@acm.org>
Date:   Wed, 7 Dec 2022 15:48:36 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v4 3/4] ufs: core: Remove len parameter from
 ufshcd_set_active_icc_lvl
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1669550910-9672-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1669550910-9672-4-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1669550910-9672-4-git-send-email-Arthur.Simchaev@wdc.com>
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

On 11/27/22 04:08, Arthur Simchaev wrote:
> len argument is not used anymore in ufshcd_set_active_icc_lvl function.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
