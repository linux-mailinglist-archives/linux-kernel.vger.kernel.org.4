Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7EF2464A818
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 20:26:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233193AbiLLT02 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 14:26:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233064AbiLLT0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 14:26:25 -0500
Received: from mail-qt1-f170.google.com (mail-qt1-f170.google.com [209.85.160.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A29760F3;
        Mon, 12 Dec 2022 11:26:24 -0800 (PST)
Received: by mail-qt1-f170.google.com with SMTP id g7so9890528qts.1;
        Mon, 12 Dec 2022 11:26:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ganqT8s5LbKBKr62aWsnooDmNqV0jAvQAAX4wfTefY4=;
        b=ehBbrMfb+KBVKJfZDtxaNBl6rm/knZqGoh47+3cuKzTSyAjAXPpQGDaikfYCmU8tDp
         Oj4SptU7eofN2K7M66k4I4tQY+hi2qy7GXyi6iHEy7v3IzNoQMCXHglP22cgsnFR2BkX
         aVyEMHnIRHJLaUecRcSMgOl2LRjwtOzXAFRpSKvdzKTcbmabrkagAPJoJ6OO6poK0RJc
         3cEY9omu2FFIcTHKskip3Ff0vqW+je6KPs8XDnMXj37+qhmjFodAm68xOUINWtyTtp1c
         R7WQA4qD2JXgnHRpkSAMCPQS0DkM8tv8ClK3bGiLhWpUCBJNpXLRWASACQ/MPaFyOoZk
         +0VA==
X-Gm-Message-State: ANoB5pkHq47ebTtkrZ6Kgsn+9DT52q/no8dOQsXX2DwjiOlMLNXu8bcB
        06UWdhMGnKRhYXAEwdfOjXk=
X-Google-Smtp-Source: AA0mqf78RZFFgJ9lVfj9pDPp1HBzQxXtDo+CVffejxhjEkoC1hK7lH3BRDFtMyyULj2TtfKg/8FDKw==
X-Received: by 2002:ac8:74d9:0:b0:3a7:eb36:5cb1 with SMTP id j25-20020ac874d9000000b003a7eb365cb1mr23842977qtr.36.1670873183404;
        Mon, 12 Dec 2022 11:26:23 -0800 (PST)
Received: from [172.22.37.189] (rrcs-76-81-102-5.west.biz.rr.com. [76.81.102.5])
        by smtp.gmail.com with ESMTPSA id t7-20020ac86a07000000b003a569a0afcasm6165295qtr.66.2022.12.12.11.26.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Dec 2022 11:26:22 -0800 (PST)
Message-ID: <0340ff7f-291f-7041-f75e-4ab8b59785a7@acm.org>
Date:   Mon, 12 Dec 2022 11:26:20 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH v5 4/4] ufs: core: Remove ufshcd_map_desc_id_to_length
 function
Content-Language: en-US
To:     Arthur Simchaev <Arthur.Simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     beanhuo@micron.com, linux-scsi@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1670763911-8695-1-git-send-email-Arthur.Simchaev@wdc.com>
 <1670763911-8695-5-git-send-email-Arthur.Simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <1670763911-8695-5-git-send-email-Arthur.Simchaev@wdc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/11/22 05:05, Arthur Simchaev wrote:
> There shouldn't be any restriction of the descriptor size
> (not the descriptor id for that matter) up to QUERY_DESC_MAX_SIZE.
> According to the spec, the caller can use any descriptor size,
> and it is up to the device to return the actual size.
> Therefore there shouldn't be any sizes hardcoded in the kernel,
> nor any need to cache it, hence ufshcd_map_desc_id_to_length function is
> redundant. Always read the descriptors with QUERY_DESC_MAX_SIZE size.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>

