Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DB995F339F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 18:32:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiJCQcY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 12:32:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59796 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiJCQcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 12:32:21 -0400
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CB441FCC9;
        Mon,  3 Oct 2022 09:32:20 -0700 (PDT)
Received: by mail-pj1-f47.google.com with SMTP id p3-20020a17090a284300b0020a85fa3ffcso4128081pjf.2;
        Mon, 03 Oct 2022 09:32:20 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=omjuBS4wlBWHl/uRLiCtnYldrOiLxqTRz0it0PLR1AM=;
        b=c0lPKrgV+vIidKcQs2FTL+lkCesSSQ7agugNw9h37HQODSboDKuiwgPCdTegQfFSwa
         K2gMwMH8iuRSZpl/Eo/icqoCxmtzQADWGL17bRoeXs/BMJul1/SaQ62bk8YMxRGICBnA
         JL4jLadqydvF/eUNafVrbyeG3HOiQ3R9wHqbPrsavtdjsCbTTG1KCBTPBbqOaYZo/2H8
         UIE4GSdN+mRqtaQIQKymRvyRRmnxKmrEY+c5UaDzfiZO+mAg4kSfcdVKFTL2agGOM26+
         8RR+nZMSl06xcHQ13kdwU/c9iGj3Bbcjwl6nTjSUcblKbOQR05vjhfAOTdMEX+WrgcXa
         BRIg==
X-Gm-Message-State: ACrzQf12+zvgQ+zNzra5TzfnVKRnaWdUFj7fB4iCi6cUa+Iy/y7z+Oxl
        +k0rWa4W3GUM161N03CPnjc=
X-Google-Smtp-Source: AMsMyM5C3YSdSqWKqyJULK1M6Za3XJIPWq2fHsdm4Of+kq/30YZCCKEhdCwo79ngSvUJwJnYU0NfVg==
X-Received: by 2002:a17:90b:2812:b0:205:cdc9:2ccf with SMTP id qb18-20020a17090b281200b00205cdc92ccfmr12508895pjb.97.1664814739688;
        Mon, 03 Oct 2022 09:32:19 -0700 (PDT)
Received: from [192.168.51.14] ([98.51.102.78])
        by smtp.gmail.com with ESMTPSA id y12-20020a63b50c000000b0043941566481sm6814550pge.39.2022.10.03.09.32.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Oct 2022 09:32:18 -0700 (PDT)
Message-ID: <26ee5886-e846-78ad-7b45-1e352aa5ef08@acm.org>
Date:   Mon, 3 Oct 2022 09:32:16 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] scsi: core: Add BLIST_NO_ASK_VPD_SIZE for some VDASD
Content-Language: en-US
To:     Lee Duncan <leeman.duncan@gmail.com>,
        "James E.J. Bottomley" <jejb@linux.ibm.com>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        linux-scsi@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Lee Duncan <lduncan@suse.com>, Martin Wilck <mwilck@suse.com>,
        Hannes Reinecke <hare@suse.de>
References: <20220928181350.9948-1-leeman.duncan@gmail.com>
From:   Bart Van Assche <bvanassche@acm.org>
In-Reply-To: <20220928181350.9948-1-leeman.duncan@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.9 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/28/22 11:13, Lee Duncan wrote:
> Some storage, such as AIX VDASD (virtual storage) and IBM 2076
> (front end) do not like the recent commit:
> 
> commit c92a6b5d6335 ("scsi: core: Query VPD size before getting full page")
> 
> That commit changed getting SCSI VPD pages so that we now read
> just enough of the page to get the actual page size, then read
> the whole page in a second read. The problem is that the above
> mentioned hardware returns zero for the page size, because of
> a firmware error. In such cases, until the firmware is fixed,
> this new black flag says to revert to the original method of
> reading the VPD pages, i.e. try to read as a whole buffer's
> worth on the first try.

Reviewed-by: Bart Van Assche <bvanassche@acm.org>
