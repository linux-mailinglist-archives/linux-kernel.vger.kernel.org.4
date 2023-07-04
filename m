Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A19E7747548
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 17:28:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231478AbjGDP13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 11:27:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231694AbjGDP1W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 11:27:22 -0400
Received: from mail-pg1-f180.google.com (mail-pg1-f180.google.com [209.85.215.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 730411AA;
        Tue,  4 Jul 2023 08:27:21 -0700 (PDT)
Received: by mail-pg1-f180.google.com with SMTP id 41be03b00d2f7-55b5a3915f5so2763290a12.0;
        Tue, 04 Jul 2023 08:27:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688484441; x=1691076441;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dBHybsETmQhR4EOdGU54nBMdz7E2WSrdp2Kj9VKU2vA=;
        b=Mn4ahNLuXWAyKdQL40r6Dyvy+zrQdSgv1RJbFjyShK/rpkvkmVvfT+5wMLZGIC+Qoc
         9DMG1Hu/vfR//U4Bl7WEeNSEc9gwa2w7J3oVOBoVIxl/9UGfCJsZ1e7+i69FMVcCB7HN
         DPn9CtxPfZKYLPGrPDHTO9kmK0yk6rXMxlFkGqUJHX3uxLq02qQyx48JoXZPq5mXyxqv
         9PoSrekVb4W4EMG5o9ONdJT6OEJNyOJbNnThTWvzXZ/epq/qHWX9xCKvse9l/abQb4/H
         qdYk8UccUiOOaMAGMQ8aqhYVkMNsJJYVDOHMVFY9hDV8kitDLRjIZ1eP9Sg6P5jhZoFp
         3nAw==
X-Gm-Message-State: ABy/qLb6U5VB8a2ruQoKyskpGkHXCQ0RQiINHDEdFNmY0kxswM7lke3G
        O6wIjjxsGIov66zMzi0okjI=
X-Google-Smtp-Source: APBJJlH540wVvniNrmM3OfeMzR4O20DskguGHzSe2eDGyMcTNqmXYKVUUoBwmt+Ihp+QZbSThUMrKg==
X-Received: by 2002:a05:6a20:9190:b0:12e:61a1:a298 with SMTP id v16-20020a056a20919000b0012e61a1a298mr5844347pzd.20.1688484440749;
        Tue, 04 Jul 2023 08:27:20 -0700 (PDT)
Received: from [192.168.3.219] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id v7-20020a1709029a0700b001b7fd27144dsm15578679plp.40.2023.07.04.08.27.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 08:27:20 -0700 (PDT)
Message-ID: <8fd68b78-3d77-2534-01c7-7c8c7cde2e86@acm.org>
Date:   Tue, 4 Jul 2023 08:27:18 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v1] drivers: scsi: remove duplicate logical judgments
Content-Language: en-US
To:     Minjie Du <duminjie@vivo.com>, jejb@linux.ibm.com,
        martin.petersen@oracle.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     opensource.kernel@vivo.com
References: <20230704073752.5498-1-duminjie@vivo.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230704073752.5498-1-duminjie@vivo.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/4/23 00:37, Minjie Du wrote:
> Please check this.

Without feedback from someone who has access to the datasheet this patch 
probably should not be applied. The repeated inb() calls may be on purpose.

Thanks,

Bart.
