Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 145EE6D8B05
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 01:17:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233331AbjDEXR1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 19:17:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231906AbjDEXRZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 19:17:25 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DF606A45
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 16:17:24 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id kq3so35842748plb.13
        for <linux-kernel@vger.kernel.org>; Wed, 05 Apr 2023 16:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680736644; x=1683328644;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=PDzgTcPpeDzPZmNkPQBXcTLrsDlwbvUKWbaA0gDoJUI=;
        b=FA/i5tIsA2TyBUZl/mohObwLBcCEWph5/toLXCLH/HMFb4nOmn2/ptwjytnLFDVU+b
         sZkbdyF2aClqiI3rgyqkCVnm8fPFhkzlMVbbsuIlYWVeYr5d6LKdM2pmiiYNqsjitVI2
         MBXITOhFwfz/IJ6Idq87lmdJk7L2ZgEVE4o6CA0820G/ZBznbBKibQk6Ja3Wfc+DvHsy
         Hk/OzEmyKBapnFLpBC60jZFv9WZs/jgoRSw2EveGlp0UluJBZStUGW07QJ1G+GrtZXVO
         ff/RTZoA3z5eSkMSack2kynYDuFcV03lF4mqowCe9FRVuzE0Puq62xpztpf9T0pM075L
         7YFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680736644; x=1683328644;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=PDzgTcPpeDzPZmNkPQBXcTLrsDlwbvUKWbaA0gDoJUI=;
        b=HPwkbyVFQSsGHL0cOAdL4hBkMLhxgCQSED8ehjoctgcNO7tznF3LiwPgf0MhFjiGBX
         X1DeyMGo0LDh8gv8qQ/Y3TYvr4NDVpnSNx1EHPKNaBiOWixpPEWRfs+XLZV8dupNH+7o
         6XFEwjzvvjrx4dU/CBEowG+sl3LBDcSrpmjXfIfYMZx//YNKE/Lqmg9sSr+DTV4sHk3p
         9dNt3juGE90zQlf8gO4ve+Ca6fy8YucZUIVrKqvClcrt5uBuZqrK8tq9iIcEVRn3Yh20
         ANDneIWFFxJLpj0Z9nQL/wveaJ/lLTPy1V/X9LGXx5rHW4eIZUJBmrrFq2Qg8AZ2OpVh
         Z6Jw==
X-Gm-Message-State: AAQBX9fwAOmhUsCPtgSks69EdQKMD+kVHqEkhhkZtq2iBunEM+rnLKx6
        POCj2eRVuVtOCaItoyVwrFs=
X-Google-Smtp-Source: AKy350ZZ3PAoIxgkCqj/uzJqfDtq+TiJc0UUUejDnRB0U97K/u3fpiCAOoJu2oY3ROKMuxwohPnfcg==
X-Received: by 2002:a17:90b:224f:b0:23c:ffbf:859e with SMTP id hk15-20020a17090b224f00b0023cffbf859emr8417356pjb.35.1680736643704;
        Wed, 05 Apr 2023 16:17:23 -0700 (PDT)
Received: from [172.30.1.1] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id c12-20020a17090ab28c00b002340d317f3esm1872087pjr.52.2023.04.05.16.17.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Apr 2023 16:17:23 -0700 (PDT)
Message-ID: <9c9ca17a-7211-633d-7072-44992ab6852e@gmail.com>
Date:   Thu, 6 Apr 2023 08:17:19 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v1 00/14] extcon: Core cleanups and documentation fixes
To:     Bumwoo Lee <bw365.lee@samsung.com>,
        'Andy Shevchenko' <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org
Cc:     'MyungJoo Ham' <myungjoo.ham@samsung.com>,
        'Chanwoo Choi' <cw00.choi@samsung.com>
References: <20230322144005.40368-1-andriy.shevchenko@linux.intel.com>
 <CGME20230330101146epcas1p2240da3a618b18cea96735bbd6fe3f322@epcas1p2.samsung.com>
 <ZCVgWX2t1fpGzZX9@smile.fi.intel.com>
 <010e01d9636a$8f23edc0$ad6bc940$@samsung.com>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <010e01d9636a$8f23edc0$ad6bc940$@samsung.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 23. 3. 31. 09:48, Bumwoo Lee wrote:
> Hi Andy Shevchenko
>> -----Original Message-----
>> From: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
>> Sent: Thursday, March 30, 2023 7:12 PM
>> To: Bumwoo Lee <bw365.lee@samsung.com>; linux-kernel@vger.kernel.org
>> Cc: MyungJoo Ham <myungjoo.ham@samsung.com>; Chanwoo Choi
>> <cw00.choi@samsung.com>
>> Subject: Re: [PATCH v1 00/14] extcon: Core cleanups and documentation
>> fixes
>>
>> On Wed, Mar 22, 2023 at 04:39:51PM +0200, Andy Shevchenko wrote:
>>> A few fixes to the documentation and some cleanups against extcon core
>>> module.
>>
>> Anything I should do with the series?
>> Any comments on it?
>>
>> --
>> With Best Regards,
>> Andy Shevchenko
>>
> 
> Looks fine to me.
> 
> Acked-by: Bumwoo Lee <bw365.lee@samsung.com>
> 
> MR. Chanwoo, Would you please take a look at this patch series.
> 

Actually, Acked tag will be replied by Maintainer or the driver owner.
If you want to review the mailing list patch, I think that Reviewed-by tag is proper.

Unfortunately, I could not see the any review comment from you even if this patchset
have the some review contents. Also you didn't review the any patches of extcon before.

I'm always welcome for many reviewers in order to improve the linux kernel.
But, in this case, I'm not sure that you are reviewing this patchset.

So that I'm sorry that I cannot take your acked-tag. 

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

