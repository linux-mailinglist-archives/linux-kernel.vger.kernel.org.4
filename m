Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 426395FA0CC
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 16:59:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiJJO7N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 10:59:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230011AbiJJO7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 10:59:02 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 958A33ED5D;
        Mon, 10 Oct 2022 07:58:59 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id d13so460742qko.5;
        Mon, 10 Oct 2022 07:58:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DdMsETWHOSqGIQCrG8wpn1jB4vnsTdM3+A71vvrxY5c=;
        b=Ah5PMwUr/0M4N37/AicCYt479YVoh/WHJrsYHrVACcmV03OTDr2nKDAG1jdLpWQ6Je
         YCbDWJmWyWELcy+0Xt1y1FnujIm7cdSVwKEZRel95pbBW3rtCVc+Pe3iUi1dalhWLUEN
         A7tkfhLGC6JFfg4gp4Rg9GGdFUMUMz5y8gNpmD1/8AtZ5KbO26q74YmZa6aXst+Ok8er
         lqbn0UNdhsk8JxBKPo3kVrchBBWRmWDqizC5jFqp6WGmsQl/hks70QnlEFRr1OPL7MO0
         myK5rp/k98eM+DxvSoYQSDOCOIcCdpnCO54l39koUf9qVDxCvNxf94b/wumczicvnp+7
         VRrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=DdMsETWHOSqGIQCrG8wpn1jB4vnsTdM3+A71vvrxY5c=;
        b=YGhHt5JxB50p5bV3ryjaJMOr3vjf4fipmLWi23bbhoynKHHwb7hwMoWIQb8azEOJ7X
         LxiGRHypHV6BsZyfJVmMlbv/jjoic71Zdm1uBcSBIrpq35Zw+MbAbu5QD2uKs3aUfrEP
         uQVXcxzsOCGRfifVo6wFmTBxBwWuw9eTRbfY1R3nOzNvBDBuzp2akqMvEMNwTsyXzXgr
         eiGccc/z1L6jSBg84biZIlu9CNKu8OAedSGLlz03N13byBvwSKdJLViyrxRPDtqH3mxz
         1omiSSJPHdSMIqk5p0xJDJsUwm7L4iatfaYpZMElHKZRKZeffZ5R2ZvAdGrJUa0FYnvy
         FDHw==
X-Gm-Message-State: ACrzQf0xlM1J4jBJqLtq5sSfVIjRTXDyTFReSfrSn5KJ4deaAusbeRAq
        beZliSFD/wUY/jUYilLqVdc=
X-Google-Smtp-Source: AMsMyM43rUm4tMS+pbXLrND/ukuGEbz0hADaqfX6lruS+MIsaMIjOgEc6mIbyQcILiRfyA8KC2fWlw==
X-Received: by 2002:a05:620a:135b:b0:6ed:3816:f872 with SMTP id c27-20020a05620a135b00b006ed3816f872mr2770718qkl.305.1665413938452;
        Mon, 10 Oct 2022 07:58:58 -0700 (PDT)
Received: from [192.168.1.3] (ip72-194-116-95.oc.oc.cox.net. [72.194.116.95])
        by smtp.gmail.com with ESMTPSA id dm26-20020a05620a1d5a00b006ed99931456sm1767282qkb.88.2022.10.10.07.58.56
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Oct 2022 07:58:57 -0700 (PDT)
Message-ID: <f0706380-94f9-ed7d-1033-8da51aab6b01@gmail.com>
Date:   Mon, 10 Oct 2022 07:58:55 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.2
Subject: Re: [PATCH] usb: bdc: change state when port disconnected
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>, justinpopo6@gmail.com
Cc:     alcooperx@gmail.com, balbi@kernel.org, linux-usb@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        bcm-kernel-feedback-list@broadcom.com, justin.chen@broadcom.com,
        f.fainelli@gmail.com
References: <1664997235-18198-1-git-send-email-justinpopo6@gmail.com>
 <Y0Gax8SUoq59hdoF@kroah.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <Y0Gax8SUoq59hdoF@kroah.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/8/2022 8:44 AM, Greg KH wrote:
> On Wed, Oct 05, 2022 at 12:13:55PM -0700, justinpopo6@gmail.com wrote:
>> From: Justin Chen <justinpopo6@gmail.com>
>>
>> When port is connected and then disconnected, the state stays as
>> configured. Which is incorrect as the port is no longer configured,
>> but in a not attached state.
>>
>> Signed-off-by: Justin Chen <justinpopo6@gmail.com>
>> ---
>>   drivers/usb/gadget/udc/bdc/bdc_udc.c | 1 +
>>   1 file changed, 1 insertion(+)
> 
> What commit id does this fix?  Should it go to older kernels?  If so,
> how far back?

This would be:

Fixes: efed421a94e6 ("usb: gadget: Add UDC driver for Broadcom USB3.0 
device controller IP BDC")

that issue was present since the driver was included in Linux with the 
commit above, we did not really consider it to be a serious enough bug, 
but I suppose it would not hurt to affix the said Fixes tag.
-- 
Florian
