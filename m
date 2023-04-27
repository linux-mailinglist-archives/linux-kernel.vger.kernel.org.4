Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 67C276EFE83
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Apr 2023 02:26:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242800AbjD0A0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 20:26:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242131AbjD0A0Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 20:26:16 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8DBA170D
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:26:13 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-1a6b17d6387so14753365ad.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Apr 2023 17:26:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20221208.gappssmtp.com; s=20221208; t=1682555173; x=1685147173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pC2f2ABxJOBHxHgnHqmtKjhUQyVzc3KlW6W3GSz/0Gg=;
        b=JvCktqP24nhhgrDUAxwg16uA1NBPZy3Mg0Cb5U3uDHaGUIg1ugG9k6j2L7lH6XONlg
         n1aig0vjz6Xsix8DILe8SLqaGygX9Ad1MT+cEmrXlErk4iwVMfZYFYv2U8quUSq2miNJ
         pzOCdjf6hLVIgAWxLU4LVBPSMGQ/UpiHQXRHiXPX1UwYjWO05gcYsMA0V3xhjRfipeOD
         7DDhUV20tJMdehtYy/mRudeD92Z4A+HJRS00zhFe+rC9++Fzz94FVjkl3iCNrUh1FPGt
         Wc2ISVsiTOJ0Pi+6FZYw3t30wJc7DuIWUeuJfkYcOoNfSnNtndrVOwntBtVTF+8Ba8QB
         0eww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682555173; x=1685147173;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pC2f2ABxJOBHxHgnHqmtKjhUQyVzc3KlW6W3GSz/0Gg=;
        b=A0UJlkRWH0zZehHDAhX/mmMYOiHn40I4DLZlYmXJME5hhUvwsZ6WQnrkxhGxo1wT0W
         UkkqPHmV22xuLU0LQiA1Mfjr14o+pS71JzYFSTfons0hhVer2Xa1WIoJcKXJE8wb7Bxj
         Nzxm5ZTO/SQGY/HIVCZZgLZx5BZverthNs8bHwRu34k1aDurcvy4goZb05QLrvTxVSKf
         XtEfQ6usqcSeIf8pxz5yL/1b+HDE8/vgoFHbLl9VJNVfbu3g/Z1RImkVh2VNGI2XoPkH
         Bk3ap13BXgLeeKv5S+jTL3p/ToUB7tDUNHFennXc19Tr2WkAQ8HrR6aBHN0YUBLO5aVH
         h+eg==
X-Gm-Message-State: AC+VfDxFHWcp4wxyv4zLnqh6sPu7vd8ie2kRRr3gYAgtcuoQQ6uhgUvX
        3QyOBAY81+dwbfHv6AFJUtOqWA==
X-Google-Smtp-Source: ACHHUZ7w/ClANr9wDAfe00y57HJ/0zZxhfkQ8IjHDwnNXp9jcpHLmRdlpBDc/fXziYIoxdo2+12VuQ==
X-Received: by 2002:a17:903:2304:b0:19a:a815:2877 with SMTP id d4-20020a170903230400b0019aa8152877mr669560plh.6.1682555173265;
        Wed, 26 Apr 2023 17:26:13 -0700 (PDT)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id bf9-20020a170902b90900b001a245b49731sm10433474plb.128.2023.04.26.17.26.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 26 Apr 2023 17:26:12 -0700 (PDT)
Message-ID: <0a57896e-3f61-7761-f03d-e47f0c21be7e@kernel.dk>
Date:   Wed, 26 Apr 2023 18:26:11 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 0/3] blk-integrity: drop integrity_kobj from gendisk
To:     =?UTF-8?Q?Thomas_Wei=c3=9fschuh?= <linux@weissschuh.net>,
        "Martin K. Petersen" <martin.petersen@oracle.com>,
        Christoph Hellwig <hch@infradead.org>
Cc:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <20230309-kobj_release-gendisk_integrity-v3-0-ceccb4493c46@weissschuh.net>
 <yq1v8ivtzrn.fsf@ca-mkp.ca.oracle.com>
 <862c1901-ee6e-44e5-8906-4bb1c3893372@t-8ch.de>
Content-Language: en-US
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <862c1901-ee6e-44e5-8906-4bb1c3893372@t-8ch.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/26/23 5:12?PM, Thomas Wei?schuh wrote:
> Hi Martin, Christoph, Jens,
> 
> On 2023-03-20 07:56:58-0400, Martin K. Petersen wrote:
>>> The embedded member integrity_kobj member of struct gendisk violates
>>> the assumption of the driver core that only one struct kobject should
>>> be embedded into another object and then manages its lifetime.
>>>
>>> As the integrity_kobj is only used to hold a few sysfs attributes it
>>> can be replaced by direct device_attributes and removed.
>>
>> Looks good to me and passed a quick test on a couple of systems. Thanks
>> for cleaning this up!
>>
>> Reviewed-by: Martin K. Petersen <martin.petersen@oracle.com>
> 
> Am I getting some part of the process for block/ wrong?

Sorry, I missed this series. I'll queue it up for 6.4.

> It seems my patches for the block subsystem are having a hard time
> getting merged.
> 
> * https://lore.kernel.org/all/20221110052438.2188-1-linux@weissschuh.net/

This one is missing nbd review. It's unfortunately not uncommon to need
to re-ping on something like this, if you don't get a timely review.
This is not specific to this patch, just in general. Things get missed.

> * this series
> * https://lore.kernel.org/all/20230419-const-partition-v2-0-817b58f85cd1@weissschuh.net/

This one is just a week old, and coming into the merge window. Generally
takes longer at that time, as it's late for that merge window, and folks
are busy with getting things ready. If nothing happens on this one, I'd
suggest resending past -rc1 when folks are more ready to review and
queue things up for the next release.

-- 
Jens Axboe

