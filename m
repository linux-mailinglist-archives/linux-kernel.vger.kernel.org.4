Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93ED7724CF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 21:24:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238950AbjFFTYf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 15:24:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238464AbjFFTYb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 15:24:31 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1B1C1E6B
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 12:24:29 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8BxqOnrh39k7U0AAA--.579S3;
        Wed, 07 Jun 2023 03:24:27 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8DxbMrrh39k5f8CAA--.3429S3;
        Wed, 07 Jun 2023 03:24:27 +0800 (CST)
Message-ID: <516bcf93-2a57-f87a-49b4-c8977d48b554@loongson.cn>
Date:   Wed, 7 Jun 2023 03:24:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: display/Kconfig: replace leading spaces with
 tab
Content-Language: en-US
To:     Alex Deucher <alexdeucher@gmail.com>
Cc:     Harry Wentland <harry.wentland@amd.com>,
        Leo Li <sunpeng.li@amd.com>,
        Rodrigo Siqueira <Rodrigo.Siqueira@amd.com>,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian Konig <christian.koenig@amd.com>,
        Pan Xinhui <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
References: <20230606133328.148490-1-suijingfeng@loongson.cn>
 <CADnq5_MdNSBJuNrJC2-fRByhEoUqEJmMGATT+OrFvjqA7k4F5Q@mail.gmail.com>
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <CADnq5_MdNSBJuNrJC2-fRByhEoUqEJmMGATT+OrFvjqA7k4F5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8DxbMrrh39k5f8CAA--.3429S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw18XrykZF4fKrW5uFyxXrc_yoW8XFyrp3
        98C3Z09rWUJF1Yy39rA3WfWFy5Ga93JFyUKryDG343Za4DAF1xGrWkKFWYgrZrXFyxAa1r
        ZFZ5WF42v3WqkrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUUBab4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_Gr0_Xr1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr0_Cr1l84ACjcxK6I8E87Iv67AKxVW8JVWxJwA2z4x0Y4vEx4A2jsIEc7CjxVAFwI0_
        Gr0_Gr1UM2AIxVAIcxkEcVAq07x20xvEncxIr21l57IF6xkI12xvs2x26I8E6xACxx1l5I
        8CrVACY4xI64kE6c02F40Ex7xfMcIj6xIIjxv20xvE14v26r1q6rW5McIj6I8E87Iv67AK
        xVW8JVWxJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0VAS07AlzV
        AYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCFs4IE7xkE
        bVWUJVW8JwCFI7km07C267AKxVWUXVWUAwC20s026c02F40E14v26r1j6r18MI8I3I0E74
        80Y4vE14v26r106r1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0
        I7IYx2IY67AKxVW8JVW5JwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Gr0_Cr1lIxAIcVCF04
        k26cxKx2IYs7xG6r1j6r1xMIIF0xvEx4A2jsIE14v26r4j6F4UMIIF0xvEx4A2jsIEc7Cj
        xVAFwI0_Gr0_Gr1UYxBIdaVFxhVjvjDU0xZFpf9x07jFRRiUUUUU=
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks a lot.


On 2023/6/7 03:15, Alex Deucher wrote:
> Applied.  Thanks!
>
> Alex
>
> On Tue, Jun 6, 2023 at 9:33 AM Sui Jingfeng <suijingfeng@loongson.cn> wrote:
>> This patch replace the leading spaces with tab, make them keep aligned with
>> the rest of the config options. No functional change.
>>
>> Signed-off-by: Sui Jingfeng <suijingfeng@loongson.cn>
>> ---
>>   drivers/gpu/drm/amd/display/Kconfig | 17 +++++++----------
>>   1 file changed, 7 insertions(+), 10 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/amd/display/Kconfig b/drivers/gpu/drm/amd/display/Kconfig
>> index 2d8e55e29637..04ccfc70d583 100644
>> --- a/drivers/gpu/drm/amd/display/Kconfig
>> +++ b/drivers/gpu/drm/amd/display/Kconfig
>> @@ -42,16 +42,13 @@ config DEBUG_KERNEL_DC
>>            Choose this option if you want to hit kdgb_break in assert.
>>
>>   config DRM_AMD_SECURE_DISPLAY
>> -        bool "Enable secure display support"
>> -        depends on DEBUG_FS
>> -        depends on DRM_AMD_DC_FP
>> -        help
>> -            Choose this option if you want to
>> -            support secure display
>> -
>> -            This option enables the calculation
>> -            of crc of specific region via debugfs.
>> -            Cooperate with specific DMCU FW.
>> +       bool "Enable secure display support"
>> +       depends on DEBUG_FS
>> +       depends on DRM_AMD_DC_FP
>> +       help
>> +         Choose this option if you want to support secure display
>>
>> +         This option enables the calculation of crc of specific region via
>> +         debugfs. Cooperate with specific DMCU FW.
>>
>>   endmenu
>> --
>> 2.25.1
>>
-- 
Jingfeng

