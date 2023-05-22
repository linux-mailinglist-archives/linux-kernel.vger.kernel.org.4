Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C64EF70B75C
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 10:14:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231947AbjEVIOp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 04:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229729AbjEVIOn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 04:14:43 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.104])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAA25AB;
        Mon, 22 May 2023 01:14:41 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.43:44024.345458232
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.43])
        by 189.cn (HERMES) with SMTP id C5A9F102946;
        Mon, 22 May 2023 16:14:39 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-75648544bd-7vx9t with ESMTP id 007f8fdc7329415ea6894140ca1e23a5 for kernel@xen0n.name;
        Mon, 22 May 2023 16:14:40 CST
X-Transaction-ID: 007f8fdc7329415ea6894140ca1e23a5
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <6957f8b7-5e37-889f-0b48-d2424b891392@189.cn>
Date:   Mon, 22 May 2023 16:14:38 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v14 1/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     WANG Xuerui <kernel@xen0n.name>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sui Jingfeng <suijingfeng@loongson.cn>,
        Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>
Cc:     linaro-mm-sig@lists.linaro.org, loongson-kernel@lists.loongnix.cn,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        Javier Martinez Canillas <javierm@redhat.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Liu Peibao <liupeibao@loongson.cn>, linux-media@vger.kernel.org
References: <20230520105718.325819-1-15330273260@189.cn>
 <20230520105718.325819-2-15330273260@189.cn>
 <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <26fd78b9-c074-8341-c99c-4e3b38cd861a@xen0n.name>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,FROM_LOCAL_DIGITS,
        FROM_LOCAL_HEX,NICE_REPLY_A,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/5/21 20:21, WANG Xuerui wrote:
>> +
>> +      If in doubt, say "N".
>> diff --git a/drivers/gpu/drm/loongson/Makefile 
>> b/drivers/gpu/drm/loongson/Makefile
>> new file mode 100644
>> index 000000000000..9158816ece8e
>> --- /dev/null
>> +++ b/drivers/gpu/drm/loongson/Makefile
>> @@ -0,0 +1,20 @@
>> +# SPDX-License-Identifier: GPL-2.0
>> +
>> +loongson-y := \
>> +    lsdc_benchmark.o \
>> +    lsdc_crtc.o \
>> +    lsdc_debugfs.o \
>> +    lsdc_device.o \
>> +    lsdc_drv.o \
>> +    lsdc_gem.o \
>> +    lsdc_gfxpll.o \
>> +    lsdc_i2c.o \
>> +    lsdc_irq.o \
>> +    lsdc_output_7a1000.o \
>> +    lsdc_output_7a2000.o \
>> +    lsdc_plane.o \
>> +    lsdc_pixpll.o \
>> +    lsdc_probe.o \
>> +    lsdc_ttm.o
>> +
>> +obj-$(CONFIG_DRM_LOONGSON) += loongson.o
>> diff --git a/drivers/gpu/drm/loongson/lsdc_benchmark.c 
>> b/drivers/gpu/drm/loongson/lsdc_benchmark.c
>> new file mode 100644
>> index 000000000000..82961531d84c
>> --- /dev/null
>> +++ b/drivers/gpu/drm/loongson/lsdc_benchmark.c
>> @@ -0,0 +1,133 @@
>> +// SPDX-License-Identifier: GPL-2.0+
>
> Is it GPL-2.0, GPL-2.0-only, or GPL-2.0+? Please make sure all license 
> IDs are consistent. 


I see drm/vkms is also writing the copyrights similar.

with "# SPDX-License-Identifier: GPL-2.0-only" in the Makefile,

while "// SPDX-License-Identifier: GPL-2.0+" in the C source file.

Sorry, I'm stupid, I can't figure out the difference between them.

Personally, I really don't care about this as along as checkpatch.pl 
don't complain.

I respect the maintainers of DRM, they didn't told me to change it.

I assume there is no problem.

