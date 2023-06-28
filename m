Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EBAA741BF2
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 00:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230496AbjF1Wvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 18:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231146AbjF1WvB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 18:51:01 -0400
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com [209.85.214.180])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E001326B9;
        Wed, 28 Jun 2023 15:50:49 -0700 (PDT)
Received: by mail-pl1-f180.google.com with SMTP id d9443c01a7336-1b6824141b4so319265ad.1;
        Wed, 28 Jun 2023 15:50:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687992649; x=1690584649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=RfqFDtT/eGzqQeEDf95cLreNmgKO2LGGgIvnbhaSmwc=;
        b=YQoyXa4nNfTr3esU8SJWPohfIzpbIzYKLB4gOQ519fXdcPPR70q+N/IMdXkPOvWj0L
         4sQ35qGCtYXkFaIWEhGZ0OwQgvJVXq5RT5NaPP7yENqiQAmFwbzJzzXw967sjgE7ONgL
         I5j7pTLHVqrRCuoTtVJ3NqzPHmWtZkeGQRIg/lLo3V1E3SZTQGamPoJFJy9A/RBZLYC0
         oECop44aUc28wdK0sxxQxgXGQ+e1a+L6jCQfxLjdDw2ZDeKOfTbb2ekdkfq/1oye6F75
         fC5B11CRaulZUcTHdpA1x++4GjrenhihK2nWrxDM2q6Lvds8ibA1a4mxL+fRobdLlGck
         vuVQ==
X-Gm-Message-State: AC+VfDw/2tFsu+3PmARpoU+rixAcHucHiUnXea0ygFeN05xe4MKHiur9
        jZBGhXlFK4yX3QjRM3acox5d9eZ2V/k=
X-Google-Smtp-Source: ACHHUZ6DPO+qpk7VGOE7L1H4AovjX2mXxQC4bqfErUpLkFuXiwxShFN8MVsD0KATlIB8e9sHKBZTbA==
X-Received: by 2002:a17:903:1cf:b0:1b6:a91d:bd1f with SMTP id e15-20020a17090301cf00b001b6a91dbd1fmr3017792plh.6.1687992649105;
        Wed, 28 Jun 2023 15:50:49 -0700 (PDT)
Received: from [192.168.50.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id p12-20020a170902b08c00b001ab061e352bsm8090033plr.195.2023.06.28.15.50.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 28 Jun 2023 15:50:48 -0700 (PDT)
Message-ID: <896abe03-4fcd-003f-1273-209daafc5635@acm.org>
Date:   Wed, 28 Jun 2023 15:50:44 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND v2] ufs: core: Add support for qTimestamp attribute
Content-Language: en-US
To:     Arthur Simchaev <arthur.simchaev@wdc.com>,
        martin.petersen@oracle.com
Cc:     avri.altman@wdc.com, Avi.Shchislowski@wdc.com, beanhuo@micron.com,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230626103320.8737-1-arthur.simchaev@wdc.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20230626103320.8737-1-arthur.simchaev@wdc.com>
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

On 6/26/23 03:33, Arthur Simchaev wrote:
> +/**
> + * struct utp_upiu_query_v4_0 - upiu request buffer structure for
> + * query request >= UFS 4.0 spec.
> + * @opcode: command to perform B-0
> + * @idn: a value that indicates the particular type of data B-1
> + * @index: Index to further identify data B-2
> + * @selector: Index to further identify data B-3
> + * @osf4: spec field B-5
> + * @osf5: spec field B 6,7
> + * @osf6: spec field DW 8,9
> + * @osf7: spec field DW 10,11
> + */
> +struct utp_upiu_query_v4_0 {
> +	__u8 opcode;
> +	__u8 idn;
> +	__u8 index;
> +	__u8 selector;
> +	__u8 osf3;
> +	__u8 osf4;
> +	__be16 osf5;
> +	__be32 osf6;
> +	__be32 osf7;
> +	__be32 reserved;
> +};

Is this structure useful for user space software? If not, please move it 
into another header file.

Thanks,

Bart.
