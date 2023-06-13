Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD7372E8E5
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:59:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231222AbjFMQ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38328 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230259AbjFMQ7V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:59:21 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26815183
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 09:59:19 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35DDYKjc010243;
        Tue, 13 Jun 2023 18:59:05 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=r0/BP0SDZNjkyzInU6CzpWLDgV0h4tEoifbUZlb3LzE=;
 b=FBU9KIAkX28BTurj/w0o9lsSy8md2VqnSLhfF4+Zm8vUD+s/naTceoMmtgtRlvWUPych
 uCL1L3uRaJz/KtjS1WER2XHePCgpsrPuW2f2j2bOWeU2VwgPRutre2726IIB9F51+c0R
 KIN9fWQlpWhluS1UXrcLBQexazjpZArVSU2WV6mNrvmWFRfbO69FhEY71vibEi6tTVP3
 BKwCDqFXabSM1748+StBeE2ejhJajeFw25rWk3uIaKRo1DLfxzl48jWLESYXF3Nbc8SO
 ffRR9p81AxOzudCt+xI2DSUmqQ0fHnFZwXdcrqTgEi0KJKM2GlHQOtzUE1SPDGYZ+htU +A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r6sf31416-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 13 Jun 2023 18:59:05 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE70710002A;
        Tue, 13 Jun 2023 18:59:04 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E38CA245504;
        Tue, 13 Jun 2023 18:59:04 +0200 (CEST)
Received: from [10.48.1.204] (10.48.1.204) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 13 Jun
 2023 18:59:04 +0200
Message-ID: <4b5d8872-64bc-34b0-c329-71aea734022a@foss.st.com>
Date:   Tue, 13 Jun 2023 18:59:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v3 4/4] drm/stm: add an option to change FB bpp
Content-Language: en-US
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        Michael Nazzareno Trimarchi <michael@amarulasolutions.com>
CC:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        <dri-devel@lists.freedesktop.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230609062050.2107143-1-dario.binacchi@amarulasolutions.com>
 <20230609062050.2107143-5-dario.binacchi@amarulasolutions.com>
 <376dc16d-8896-0a47-b8dd-3f919c1e50bf@foss.st.com>
 <CAOf5uwmpAZeO=w-+cQNfy4VHS80NK-_HpDv5koZfTB8cRHOECQ@mail.gmail.com>
 <0da03538-fac6-385d-d74f-f7657eca542b@foss.st.com>
From:   Philippe CORNU <philippe.cornu@foss.st.com>
In-Reply-To: <0da03538-fac6-385d-d74f-f7657eca542b@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.48.1.204]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-13_19,2023-06-12_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/13/23 17:26, Raphael Gallais-Pou wrote:
> 
> On 6/13/23 16:52, Michael Nazzareno Trimarchi wrote:
>> Hi
>>
>> On Tue, Jun 13, 2023 at 4:41 PM Philippe CORNU
>> <philippe.cornu@foss.st.com> wrote:
>>>
>>>
>>> On 6/9/23 08:20, Dario Binacchi wrote:
>>>> Boards that use the STM32F{4,7} series have limited amounts of RAM. The
>>>> added parameter allows users to size, within certain limits, the memory
>>>> footprint required by the framebuffer.
>>>>
>>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>>>
>>>> ---
>>>>
>>>> Changes in v3:
>>>> - drop [4/6] dt-bindings: display: simple: add Rocktech RK043FN48H
>>>>     Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next):
>>>>     https://cgit.freedesktop.org/drm/drm-misc/commit/?id=c42a37a27c777d63961dd634a30f7c887949491a
>>>> - drop [5/6] drm/panel: simple: add support for Rocktech RK043FN48H panel
>>>>     Applied to https://anongit.freedesktop.org/git/drm/drm-misc.git (drm-misc-next)
>>>>     https://cgit.freedesktop.org/drm/drm-misc/commit/?id=13cdd12a9f934158f4ec817cf048fcb4384aa9dc
>>>>
>>>>    drivers/gpu/drm/stm/drv.c | 8 +++++++-
>>>>    1 file changed, 7 insertions(+), 1 deletion(-)
>>>>
>>>> diff --git a/drivers/gpu/drm/stm/drv.c b/drivers/gpu/drm/stm/drv.c
>>>> index 422220df7d8c..65be2b442a6a 100644
>>>> --- a/drivers/gpu/drm/stm/drv.c
>>>> +++ b/drivers/gpu/drm/stm/drv.c
>>>> @@ -30,6 +30,11 @@
>>>>    #define STM_MAX_FB_WIDTH    2048
>>>>    #define STM_MAX_FB_HEIGHT   2048 /* same as width to handle orientation */
>>>>
>>>> +static uint stm_bpp = 16;
>>>> +
>>>> +MODULE_PARM_DESC(bpp, "bits-per-pixel (default: 16)");
>>>> +module_param_named(bpp, stm_bpp, uint, 0644);
>>>> +
>>>>    static const struct drm_mode_config_funcs drv_mode_config_funcs = {
>>>>        .fb_create = drm_gem_fb_create,
>>>>        .atomic_check = drm_atomic_helper_check,
>>>> @@ -93,6 +98,7 @@ static int drv_load(struct drm_device *ddev)
>>>>        ddev->mode_config.min_height = 0;
>>>>        ddev->mode_config.max_width = STM_MAX_FB_WIDTH;
>>>>        ddev->mode_config.max_height = STM_MAX_FB_HEIGHT;
>>>> +     ddev->mode_config.preferred_depth = stm_bpp;
>>>>        ddev->mode_config.funcs = &drv_mode_config_funcs;
>>>>        ddev->mode_config.normalize_zpos = true;
>>>>
>>>> @@ -203,7 +209,7 @@ static int stm_drm_platform_probe(struct platform_device *pdev)
>>>>        if (ret)
>>>>                goto err_put;
>>>>
>>>> -     drm_fbdev_dma_setup(ddev, 16);
>>>> +     drm_fbdev_dma_setup(ddev, stm_bpp);
>>>>
>>>>        return 0;
>>>>
>>> Acked-by: Philippe Cornu <philippe.cornu@foss.st.com>
>>> Many thanks,
>>> Philippe :-)
>>>
>> According to the latest review on usb patchset: "Please do not add new
>> module parameters, this is not the 1990's anymore.
>> We have per-device settings everywhere, this makes that impossible.
>> Just use a DT value, if it is wrong, then fix the DT value!  No need to
>> have the kernel override it, that's not what DT files are for."
> 
> 
> I actually am conflicted about this idea, but I still think that here the best
> option would be to put a device-tree property.
> 
> In which context here the module parameters could be used ? I think a module
> parameter would be quite troublesome for userspace applications in that case.
> 
> 
> Raphaël
> 
>>
>> I think it makes more sense to have dts parameters. Should maybe apply here too
>>
>> Michael

Hi Raphaël & Michael,

Many thanks for your comments.

Dario's usage of this stm driver is STM32 MCUs (STM32F4 & F7...) where, 
sometimes, old userland fbdev-based applications are used, and I imagine 
it is maybe "easier" to use a module parameter (through the kernel 
command line or whatever...) in these use cases (even if using dt is 
always better and not that complex).

Moreover, as I did not find any drm drivers with drm_fbdev_dma_setup() 
using a dt property "as example" (but always hard-coded value), then I 
decided to not block this proposal :)

Thanks to your feedback, I am reconsidering my position. And sorry 
Dario, hope you understand it will take more time for reviewing your patch.

Does anyone have an opinion to share on this point?

Many thanks,
Philippe :-)

