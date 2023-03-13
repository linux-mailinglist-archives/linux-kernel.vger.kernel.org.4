Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9BDB6B6CF7
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 02:05:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229722AbjCMBFO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Mar 2023 21:05:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35224 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229618AbjCMBFM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Mar 2023 21:05:12 -0400
Received: from mailgw.kylinos.cn (mailgw.kylinos.cn [124.126.103.232])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0052E814
        for <linux-kernel@vger.kernel.org>; Sun, 12 Mar 2023 18:05:10 -0700 (PDT)
X-UUID: 5d474a64498641cdba043aa07568a6fc-20230313
X-CID-UNFAMILIAR: 1
X-CID-O-RULE: Release_Ham
X-CID-RULE: Release_HamU
X-CID-O-INFO: VERSION:1.1.20,REQID:3981b3c5-5dcb-4ca8-b8be-32d1c492d406,IP:5,U
        RL:0,TC:0,Content:-5,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_Ham,ACTION
        :release,TS:4
X-CID-INFO: VERSION:1.1.20,REQID:3981b3c5-5dcb-4ca8-b8be-32d1c492d406,IP:5,URL
        :0,TC:0,Content:-5,EDM:0,RT:0,SF:4,FILE:0,BULK:0,RULE:Release_HamU,ACTION:
        release,TS:4
X-CID-META: VersionHash:25b5999,CLOUDID:29b52028-564d-42d9-9875-7c868ee415ec,B
        ulkID:2303102321273592KAR8,BulkQuantity:4,Recheck:0,SF:23|16|19|42|102,TC:
        nil,Content:0,EDM:-3,IP:-2,URL:1,File:nil,Bulk:40,QS:nil,BEC:nil,COL:0,OSI
        :0,OSA:0,AV:0
X-CID-BVR: 0
X-UUID: 5d474a64498641cdba043aa07568a6fc-20230313
X-User: lizhenneng@kylinos.cn
Received: from [172.20.124.41] [(116.128.244.169)] by mailgw
        (envelope-from <lizhenneng@kylinos.cn>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES128-GCM-SHA256 128/128)
        with ESMTP id 1932184781; Mon, 13 Mar 2023 09:05:00 +0800
Message-ID: <ff8eb2c4-c567-2765-effb-d26d55b32af7@kylinos.cn>
Date:   Mon, 13 Mar 2023 09:04:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] drm/amdgpu: resove reboot exception for si oland
To:     "Chen, Guchun" <Guchun.Chen@amd.com>,
        "Deucher, Alexander" <Alexander.Deucher@amd.com>
Cc:     David Airlie <airlied@linux.ie>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "dri-devel@lists.freedesktop.org" <dri-devel@lists.freedesktop.org>,
        "amd-gfx@lists.freedesktop.org" <amd-gfx@lists.freedesktop.org>,
        Daniel Vetter <daniel@ffwll.ch>,
        "Koenig, Christian" <Christian.Koenig@amd.com>
References: <20230310074000.2078124-1-lizhenneng@kylinos.cn>
 <DM5PR12MB2469FEB1E81CA99C51E7DAF0F1BA9@DM5PR12MB2469.namprd12.prod.outlook.com>
From:   =?UTF-8?B?5p2O55yf6IO9?= <lizhenneng@kylinos.cn>
In-Reply-To: <DM5PR12MB2469FEB1E81CA99C51E7DAF0F1BA9@DM5PR12MB2469.namprd12.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This bug is first reported here:

https://lore.kernel.org/lkml/1a620e7c-5b71-3d16-001a-0d79b292aca7@amd.com/

I modify the patch accroding mail list's discusstion,   and I do reboot 
test for tens of thousands of times about 10 machines on arm64,  there's 
no bug reported.

在 2023/3/10 16:18, Chen, Guchun 写道:
>> -----Original Message-----
>> From: amd-gfx <amd-gfx-bounces@lists.freedesktop.org> On Behalf Of
>> Zhenneng Li
>> Sent: Friday, March 10, 2023 3:40 PM
>> To: Deucher, Alexander <Alexander.Deucher@amd.com>
>> Cc: David Airlie <airlied@linux.ie>; Pan, Xinhui <Xinhui.Pan@amd.com>;
>> linux-kernel@vger.kernel.org; dri-devel@lists.freedesktop.org; Zhenneng Li
>> <lizhenneng@kylinos.cn>; amd-gfx@lists.freedesktop.org; Daniel Vetter
>> <daniel@ffwll.ch>; Koenig, Christian <Christian.Koenig@amd.com>
>> Subject: [PATCH] drm/amdgpu: resove reboot exception for si oland
>>
>> During reboot test on arm64 platform, it may failure on boot.
>>
>> The error message are as follows:
>> [    6.996395][ 7] [  T295] [drm:amdgpu_device_ip_late_init [amdgpu]]
>> *ERROR*
>> 			    late_init of IP block <si_dpm> failed -22
>> [    7.006919][ 7] [  T295] amdgpu 0000:04:00.0: amdgpu_device_ip_late_init
>> failed
>> [    7.014224][ 7] [  T295] amdgpu 0000:04:00.0: Fatal error during GPU init
>> ---
>>   drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c | 3 ---
>>   1 file changed, 3 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> index d6d9e3b1b2c0..dee51c757ac0 100644
>> --- a/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> +++ b/drivers/gpu/drm/amd/pm/legacy-dpm/si_dpm.c
>> @@ -7632,9 +7632,6 @@ static int si_dpm_late_init(void *handle)
>>   	if (!adev->pm.dpm_enabled)
>>   		return 0;
>>
>> -	ret = si_set_temperature_range(adev);
>> -	if (ret)
>> -		return ret;
> si_set_temperature_range should be platform agnostic. Can you please elaborate more?
>
> Regards,
> Guchun
>
>>   #if 0 //TODO ?
>>   	si_dpm_powergate_uvd(adev, true);
>>   #endif
>> --
>> 2.25.1
