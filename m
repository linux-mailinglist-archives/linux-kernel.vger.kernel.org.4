Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D8A16DD5E5
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 10:49:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjDKItd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 04:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbjDKItb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 04:49:31 -0400
Received: from 189.cn (ptr.189.cn [183.61.185.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B68C0272A;
        Tue, 11 Apr 2023 01:49:24 -0700 (PDT)
HMM_SOURCE_IP: 10.64.8.41:52050.376874080
HMM_ATTACHE_NUM: 0000
HMM_SOURCE_TYPE: SMTP
Received: from clientip-114.242.206.180 (unknown [10.64.8.41])
        by 189.cn (HERMES) with SMTP id BEB57100208;
        Tue, 11 Apr 2023 16:49:20 +0800 (CST)
Received: from  ([114.242.206.180])
        by gateway-151646-dep-7b48884fd-ljp89 with ESMTP id 1b31214f715b4affa0bb41c4bfa92964 for emil.l.velikov@gmail.com;
        Tue, 11 Apr 2023 16:49:23 CST
X-Transaction-ID: 1b31214f715b4affa0bb41c4bfa92964
X-Real-From: 15330273260@189.cn
X-Receive-IP: 114.242.206.180
X-MEDUSA-Status: 0
Sender: 15330273260@189.cn
Message-ID: <2f024efb-3e9f-8777-9f32-ca1f0e436b40@189.cn>
Date:   Tue, 11 Apr 2023 16:49:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v10 2/2] drm: add kms driver for loongson display
 controller
Content-Language: en-US
To:     Emil Velikov <emil.l.velikov@gmail.com>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        linaro-mm-sig@lists.linaro.org, Li Yi <liyi@loongson.cn>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        nathan@kernel.org, linux-media@vger.kernel.org,
        loongson-kernel@lists.loongnix.cn
References: <20230403171304.2157326-1-suijingfeng@loongson.cn>
 <20230403171304.2157326-3-suijingfeng@loongson.cn>
 <CACvgo53h+X26wngVmxpn3oVb9kbJezTHx61p3rZDR7sw1AQrWQ@mail.gmail.com>
From:   Sui Jingfeng <15330273260@189.cn>
In-Reply-To: <CACvgo53h+X26wngVmxpn3oVb9kbJezTHx61p3rZDR7sw1AQrWQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,FROM_LOCAL_DIGITS,FROM_LOCAL_HEX,NICE_REPLY_A,
        SPF_HELO_PASS,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 2023/4/4 22:10, Emil Velikov wrote:
>> --- /dev/null
>> +++ b/drivers/gpu/drm/loongson/lsdc_drv.c
>> +static const struct lsdc_desc dc_in_ls7a1000 = {
>> +       .chip = CHIP_LS7A1000,
>> +       .num_of_crtc = LSDC_NUM_CRTC,
>> +       .max_pixel_clk = 200000,
>> +       .max_width = 2048,
>> +       .max_height = 2048,
>> +       .num_of_hw_cursor = 1,
>> +       .hw_cursor_w = 32,
>> +       .hw_cursor_h = 32,
>> +       .pitch_align = 256,
>> +       .mc_bits = 40,
>> +       .has_vblank_counter = false,
>> +       .has_scan_pos = true,
>> +       .has_builtin_i2c = true,
>> +       .has_vram = true,
>> +       .has_hpd_reg = false,
>> +       .is_soc = false,
>> +};
>> +
>> +static const struct lsdc_desc dc_in_ls7a2000 = {
>> +       .chip = CHIP_LS7A2000,
>> +       .num_of_crtc = LSDC_NUM_CRTC,
>> +       .max_pixel_clk = 350000,
>> +       .max_width = 4096,
>> +       .max_height = 4096,
>> +       .num_of_hw_cursor = 2,
>> +       .hw_cursor_w = 64,
>> +       .hw_cursor_h = 64,
>> +       .pitch_align = 64,
>> +       .mc_bits = 40, /* support 48, but use 40 for backward compatibility */
>> +       .has_vblank_counter = true,
>> +       .has_scan_pos = true,
>> +       .has_builtin_i2c = true,
>> +       .has_vram = true,
>> +       .has_hpd_reg = true,
>> +       .is_soc = false,
>> +};
>> +
> Roughly a quarter of the above are identical. It might be better to
> drop them for now and re-introduce as needed with future code.
>
My initial intent here is to give a skeleton of our hardware features to 
reviewers,

Not only for gearing the control, but also for easier the reviewing process.

Without this, other part of this patch may looks questionable again.


We  could remove all of the features look up key in the struct lsdc_desc,

leave the .chip member there only.  Hard coded everything else according 
to the chip only.

But the code looks ugly by doing that way. We want weaken the

If loongson SoC is introduced, the identical will decrease.

It's OK,  I could drop as much as possible at next version.

>> +const char *chip_to_str(enum loongson_chip_family chip)
>> +{
>> +       if (chip == CHIP_LS7A2000)
>> +               return "LS7A2000";
>> +
>> +       if (chip == CHIP_LS7A1000)
>> +               return "LS7A1000";
>> +
> If it were me, I would add the name into the lsdc_desc.
>
Agree, this is acceptable. Will be changed at the next version.
