Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A75272542D
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 08:31:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234983AbjFGGbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Jun 2023 02:31:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231970AbjFGGbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Jun 2023 02:31:33 -0400
Received: from mail.loongson.cn (mail.loongson.cn [114.242.206.163])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CCFECAA
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 23:31:31 -0700 (PDT)
Received: from loongson.cn (unknown [10.20.42.43])
        by gateway (Coremail) with SMTP id _____8Bxb+tCJIBkyAsAAA--.216S3;
        Wed, 07 Jun 2023 14:31:30 +0800 (CST)
Received: from [10.20.42.43] (unknown [10.20.42.43])
        by localhost.localdomain (Coremail) with SMTP id AQAAf8AxfcpCJIBkwfEDAA--.5820S3;
        Wed, 07 Jun 2023 14:31:30 +0800 (CST)
Message-ID: <85b7bf66-840b-c6de-a7e3-be1f49953464@loongson.cn>
Date:   Wed, 7 Jun 2023 14:31:29 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] drm/amdgpu: display/Kconfig: replace leading spaces with
 tab
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
Content-Language: en-US
From:   Sui Jingfeng <suijingfeng@loongson.cn>
Organization: Loongson
In-Reply-To: <CADnq5_MdNSBJuNrJC2-fRByhEoUqEJmMGATT+OrFvjqA7k4F5Q@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-CM-TRANSID: AQAAf8AxfcpCJIBkwfEDAA--.5820S3
X-CM-SenderInfo: xvxlyxpqjiv03j6o00pqjv00gofq/
X-Coremail-Antispam: 1Uk129KBj93XoW7Cw1rZr1DZF1UWry8tw1xXrc_yoW8WF1kp3
        y5C3Z09rWUJF15K3y7Aa4rWFy5Jan3JFy8GryDG343Za4DAF12grZ5KFWYgrZrXFyxAa1r
        ZFZ5WF47Z3WqkrgCm3ZEXasCq-sJn29KB7ZKAUJUUUU5529EdanIXcx71UUUUU7KY7ZEXa
        sCq-sGcSsGvfJ3Ic02F40EFcxC0VAKzVAqx4xG6I80ebIjqfuFe4nvWSU5nxnvy29KBjDU
        0xBIdaVrnRJUUU9lb4IE77IF4wAFF20E14v26r1j6r4UM7CY07I20VC2zVCF04k26cxKx2
        IYs7xG6rWj6s0DM7CIcVAFz4kK6r1Y6r17M28lY4IEw2IIxxk0rwA2F7IY1VAKz4vEj48v
        e4kI8wA2z4x0Y4vE2Ix0cI8IcVAFwI0_tr0E3s1l84ACjcxK6xIIjxv20xvEc7CjxVAFwI
        0_Gr1j6F4UJwA2z4x0Y4vEx4A2jsIE14v26r4UJVWxJr1l84ACjcxK6I8E87Iv6xkF7I0E
        14v26r4UJVWxJr1le2I262IYc4CY6c8Ij28IcVAaY2xG8wAqjxCEc2xF0cIa020Ex4CE44
        I27wAqx4xG64xvF2IEw4CE5I8CrVC2j2WlYx0E2Ix0cI8IcVAFwI0_Jrv_JF1lYx0Ex4A2
        jsIE14v26F4j6r4UJwAm72CE4IkC6x0Yz7v_Jr0_Gr1lF7xvr2IY64vIr41lc7I2V7IY0V
        AS07AlzVAYIcxG8wCY1x0262kKe7AKxVWUAVWUtwCF04k20xvY0x0EwIxGrwCFx2IqxVCF
        s4IE7xkEbVWUJVW8JwC20s026c02F40E14v26r1j6r18MI8I3I0E7480Y4vE14v26r106r
        1rMI8E67AF67kF1VAFwI0_Jw0_GFylIxkGc2Ij64vIr41lIxAIcVC0I7IYx2IY67AKxVWU
        JVWUCwCI42IY6xIIjxv20xvEc7CjxVAFwI0_Jr0_Gr1lIxAIcVCF04k26cxKx2IYs7xG6r
        1j6r1xMIIF0xvEx4A2jsIE14v26F4j6r4UJwCI42IY6I8E87Iv6xkF7I0E14v26r4j6r4U
        JbIYCTnIWIevJa73UjIFyTuYvjxU74lkUUUUU
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/6/7 03:15, Alex Deucher wrote:
> Applied.  Thanks!

Where is the official branch of drm/amdgpu, I can't find it on the internet.

Sorry for asking this silly question.

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

