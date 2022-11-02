Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54EA5616607
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 16:24:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbiKBPYr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 11:24:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38310 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbiKBPYn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 11:24:43 -0400
Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 743DA2198;
        Wed,  2 Nov 2022 08:24:41 -0700 (PDT)
Received: by mail-pl1-f175.google.com with SMTP id u6so16879734plq.12;
        Wed, 02 Nov 2022 08:24:41 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y6owPkDy93z6wC8f3H0K525TdW4UnwvIg/U69eNerUk=;
        b=AuFUbkm/0IrddHc3hZvxuNyBc+rg9tn2gXKc2O4sJiCpZ/gtjZM6gyB9BckfnUlgj+
         JCK2JksEYJ5k5esE3e+llA/bXQzrRSCgSleJcihjsgHPiOvMf3lLVg8JiFXLOunpNHm2
         ncTl5nwSWP1M02xfSERW1MpcwAPljUmeiTTr70YCU8kll2avonLyP85jRghrf5F3T1hG
         NrnCigeTXzkk5pbNL6GQ6aM2qO7CLt7KipAbUHn52o3jSUcgxX070LieC2vPD5M/xdij
         gH1d0QlRferetR7fhiT5BbXZ1BSeceIO9iP7s07msEV2yANXWJCYZBoxUta/xsZ/Lqou
         xJ4A==
X-Gm-Message-State: ACrzQf3wlr7hBix2MajSs7VgXQu1ujCiWQu6PotpGy2TJZ6S/AzvNeCo
        N3ROfjP+MRvY/WcUBOGbNEA=
X-Google-Smtp-Source: AMsMyM4taNBnHj3yVsBhn54Sd7IX1xg8AD63314AnysJ6GLl6NE137UVGKqUb6fuQH7kVtS0dFB8eg==
X-Received: by 2002:a17:90a:a017:b0:213:ad3:4d1a with SMTP id q23-20020a17090aa01700b002130ad34d1amr43272148pjp.120.1667402680732;
        Wed, 02 Nov 2022 08:24:40 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id e129-20020a621e87000000b0056164b52bd8sm8617076pfe.32.2022.11.02.08.24.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 02 Nov 2022 08:24:39 -0700 (PDT)
Message-ID: <3bd04b49-1345-65e4-34b2-9fe559b0da43@acm.org>
Date:   Wed, 2 Nov 2022 08:24:38 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.0
Subject: Re: [RESEND PATCH 0/4] Implement File-Based optimization
 functionality
Content-Language: en-US
To:     Jiaming Li <lijiaming3@xiaomi.corp-partner.google.com>,
        alim.akhtar@samsung.com, avri.altman@wdc.com
Cc:     linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org,
        lijiaming3 <lijiaming3@xiaomi.com>,
        Christoph Hellwig <hch@lst.de>
References: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20221102053058.21021-1-lijiaming3@xiaomi.corp-partner.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/1/22 22:30, Jiaming Li wrote:
> From: lijiaming3 <lijiaming3@xiaomi.com>

Hi Jiaming,

...@...corp-partner.google.com email addresses must NOT be used for 
communication on open source mailing lists. Please use your Xiaomi.com 
e-mail address for communication on open source mailing lists.

Bart.

