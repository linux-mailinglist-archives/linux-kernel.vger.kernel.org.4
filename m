Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D37DD6F8DF0
	for <lists+linux-kernel@lfdr.de>; Sat,  6 May 2023 04:22:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229926AbjEFCWD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 22:22:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229649AbjEFCWB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 22:22:01 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 693645BBF;
        Fri,  5 May 2023 19:22:00 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id d9443c01a7336-1aae5c2423dso23935245ad.3;
        Fri, 05 May 2023 19:22:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683339720; x=1685931720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+FxmBS7vEJe0OVAA86LRv6d0E9ry7bbdeZBgxQdXBzQ=;
        b=a/mMHM6bkbRka4DJw8dmRS67IB4IYDi9APMMCfUbNLTVHPJxts6AyKMB0KPil1+pPQ
         BLLQCOYVf2AlrPRxYBX/Mi/Cc6A5chFuacfqZv1qtCJPCdnWwiy0xrbp1cz6Wf4EC8T6
         eHgQjlI/ZeK16qLQbEajbThyBXZFqX/PnkHb01Ctr0XMqL46u9XPQQP7j0jwnGmI51XD
         bkILdJQmyzNZVV8w/tWamUrnigpFlackGhEGabuV4uOvHcuHaFU8EKkh5uSlk8F8O009
         uTnYchGFcPFsv0GYnEzyO/rucJO1pgbvN0iH7PQa7Nx4YyDkHRoiKS2b4pEej0SRRz3E
         T87g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683339720; x=1685931720;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+FxmBS7vEJe0OVAA86LRv6d0E9ry7bbdeZBgxQdXBzQ=;
        b=CJmRdARuMTEhO4LeVVauPvt7j562hZWGW2I7b2gNI3ArwbMTdovNs3c68wKM3mtumR
         Vvl5AjZKAwAItDzuOwS0MBHjqZthJy7azPiD5Pa9OUWmcRkainZTTi6AU3BkIDNvu+Tp
         342MFogNfytyTLChK5ooF/p9eka/2v1JEhJ3wE20fOuwoS49X6Kl1yrHWICUQOdOTV/2
         zE0KMdbRTXzpPM7r4n8weRhIICk9EgyEIfNSKtJkRGoOHmydD8IHEoe9X7YrQRE2IIX+
         m02eYqWwVdlfAsRgVv6uqkW8ZWulZYB6iJtlipiHEDd/tcwWy11r35XrbdhId94OE2cz
         KOHA==
X-Gm-Message-State: AC+VfDzjqyuA4VhUcnmpGzmCKYdN863IBW2hLMs/CZUpe0VcA15teGFF
        BnlhTuy482nZIHLkSICNBC4gCkp/IZoZ8w==
X-Google-Smtp-Source: ACHHUZ44ar1a/lCGZfPX03Vc9Q5AlYWOIMXh+tJx1xkSRn6+Q37HVXsuWb2aXf7zP1UH8PcxZm4eTg==
X-Received: by 2002:a17:902:d4c1:b0:1a5:167f:620f with SMTP id o1-20020a170902d4c100b001a5167f620fmr2714178plg.15.1683339719750;
        Fri, 05 May 2023 19:21:59 -0700 (PDT)
Received: from [192.168.43.80] (subs02-180-214-232-14.three.co.id. [180.214.232.14])
        by smtp.gmail.com with ESMTPSA id x15-20020a170902820f00b001aaefe48b93sm2372304pln.295.2023.05.05.19.21.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 May 2023 19:21:59 -0700 (PDT)
Message-ID: <8f5aee17-510c-ed1b-c854-e6dc00c7095a@gmail.com>
Date:   Sat, 6 May 2023 09:21:49 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/3] MAINTAINERS: Drop DC395x list and site
To:     Dan Carpenter <dan.carpenter@linaro.org>
Cc:     Linux SCSI <linux-scsi@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Kernel Janitors <kernel-janitors@vger.kernel.org>,
        Oliver Neukum <oliver@neukum.org>,
        Ali Akcaagac <aliakc@web.de>,
        Jamie Lenehan <lenehan@twibble.org>,
        Jonathan Corbet <corbet@lwn.net>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>
References: <20230505082704.16228-1-bagasdotme@gmail.com>
 <20230505082704.16228-2-bagasdotme@gmail.com>
 <b86a4837-3c31-4bf4-aff3-67abd7a4f5f2@kili.mountain>
Content-Language: en-US
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <b86a4837-3c31-4bf4-aff3-67abd7a4f5f2@kili.mountain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/5/23 16:16, Dan Carpenter wrote:
> Other people do this too, but is there really any reason to include
> the linux-scsi@vger.kernel.org list?  drivers/scsi/ will already
> include it.
> 

I prefer to be explicit in this case.

-- 
An old man doll... just what I always wanted! - Clara

