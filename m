Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70EF65B3A2
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 15:58:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232906AbjABO6I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 09:58:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjABO6G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 09:58:06 -0500
Received: from mail-oi1-x234.google.com (mail-oi1-x234.google.com [IPv6:2607:f8b0:4864:20::234])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4300263F7
        for <linux-kernel@vger.kernel.org>; Mon,  2 Jan 2023 06:58:05 -0800 (PST)
Received: by mail-oi1-x234.google.com with SMTP id o66so25103665oia.6
        for <linux-kernel@vger.kernel.org>; Mon, 02 Jan 2023 06:58:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kali.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s9p0FL090tcn9uNjUKtunfgcZRh/fsCJDY+TAZOItmw=;
        b=fXVkVmfkyFQlMITqEeKVgwhR8nwLCwIpHs/CJrRIrPjp9LFRUXVXj59Dv1U/315+WK
         ZUnqyyhsfZfTOmmRYAsuAEe/q0YbMFYM8ZMQuETG7OuTKOXgELxYx8T9FvPSSZk/cBDP
         pTZkqu9XdzPJpxcrOMbxyz8gIRZLImPs6J5vDSWPkxvJOCh7WiM0eM1RoeySE5TwRMRE
         wuaqGF7I8GbF/86nM3i3HHfq9w49ULkA2f6rM4SHIDqNpU9sapli+TEyfVAWP0fvBX33
         KH6JISK+UVtdLwZssDFAI2J1RjsvN+0lZC6PvvudezRDf7iYPKqeg/DLQ+4hCXUuwV3M
         pTqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s9p0FL090tcn9uNjUKtunfgcZRh/fsCJDY+TAZOItmw=;
        b=bmelOddzkR9TPBRECFy6HWWE9bIi2LhIvJVRBqEN0VlOjIe2NLnQ4gQQi+vhz/MKPu
         reSHyRA98CWqEAkSuFsqG1Bp8n6nuI5T2wWde1/wCXEq5HWoiiiK0Kfn1bZuxNVniUa1
         HGFEEdMJA7KHqLntuAvnt7b6OT9Uu11C/PWgMgHtmqIc/BsqtBt/7dIdx83AdYhG7k3K
         +st9uYt910sm7uHz8UgU5mGTKDf3GXg7CBdSbZM2PJuepPBIMDF/BZ+xQQjXqIfi5NKp
         4nM0TA6VyHiPU+otXrjvgkZscRt1P1xTTtOCByjwqU8y67v5RGD6bQLf/4Ds5rg5sd8y
         7EMA==
X-Gm-Message-State: AFqh2kquiBUC9PduYvhPfVIfG6NSOxjsib++6BchnZhBrKsu7JyYx7MT
        SFmWRLRa/MpNhRdw5rK8u2pZJymCA25VFvBSi8w=
X-Google-Smtp-Source: AMrXdXtqm14v47morVxx5TFp3Tkpo5i142SpySDVJeOKXdlF3CpehSpmGH/GMiFeMiafiiW5ql4Ytg==
X-Received: by 2002:aca:a896:0:b0:35e:a6cf:6023 with SMTP id r144-20020acaa896000000b0035ea6cf6023mr17797072oie.46.1672671484556;
        Mon, 02 Jan 2023 06:58:04 -0800 (PST)
Received: from [192.168.11.24] (23-118-233-243.lightspeed.snantx.sbcglobal.net. [23.118.233.243])
        by smtp.gmail.com with ESMTPSA id db6-20020a0568306b0600b00683e4084740sm9807805otb.10.2023.01.02.06.58.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 02 Jan 2023 06:58:04 -0800 (PST)
Message-ID: <145f7d4c-9ff6-2673-6504-564b6f13cf00@kali.org>
Date:   Mon, 2 Jan 2023 08:58:02 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.0
Subject: Re: [PATCH 1/2] drm/panel-edp: fix name for IVO product id 854b
Content-Language: en-US
To:     Johan Hovold <johan@kernel.org>
Cc:     Abel Vesa <abel.vesa@linaro.org>,
        Douglas Anderson <dianders@chromium.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20221231142721.338643-1-abel.vesa@linaro.org>
 <CAKXuJqjiEpxnX_E=HGqEaX91YA7XUmUoaK0NQqXHJCUkcqUPoQ@mail.gmail.com>
 <Y7KUFMjnra22YGlv@hovoldconsulting.com>
From:   Steev Klimaszewski <steev@kali.org>
In-Reply-To: <Y7KUFMjnra22YGlv@hovoldconsulting.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 1/2/23 2:21 AM, Johan Hovold wrote:
> On Sun, Jan 01, 2023 at 10:58:42PM -0600, Steev Klimaszewski wrote:
>> On Sat, Dec 31, 2022 at 8:27 AM Abel Vesa <abel.vesa@linaro.org> wrote:
>>> The actual name is R133NW4K-R0.
>>>
>>> Fixes: 0f9fa5f58c784 ("drm/panel-edp: add IVO M133NW4J-R3 panel entry")
>>> Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
>>> ---
>>>
>>> Assuming the information from here is correct:
>>> https://raw.githubusercontent.com/linuxhw/EDID/master/DigitalDisplay.md
>>>
>>>   drivers/gpu/drm/panel/panel-edp.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
>>> index 5cb8dc2ebe18..ef70928c3ccb 100644
>>> --- a/drivers/gpu/drm/panel/panel-edp.c
>>> +++ b/drivers/gpu/drm/panel/panel-edp.c
>>> @@ -1891,7 +1891,7 @@ static const struct edp_panel_entry edp_panels[] = {
>>>          EDP_PANEL_ENTRY('C', 'M', 'N', 0x1247, &delay_200_500_e80_d50, "N120ACA-EA1"),
>>>
>>>          EDP_PANEL_ENTRY('I', 'V', 'O', 0x057d, &delay_200_500_e200, "R140NWF5 RH"),
>>> -       EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "M133NW4J-R3"),
>>> +       EDP_PANEL_ENTRY('I', 'V', 'O', 0x854b, &delay_200_500_p2e100, "R133NW4K-R0"),
>>>
>>>          EDP_PANEL_ENTRY('K', 'D', 'B', 0x0624, &kingdisplay_kd116n21_30nv_a010.delay, "116N21-30NV-A010"),
>>>          EDP_PANEL_ENTRY('K', 'D', 'B', 0x1120, &delay_200_500_e80_d50, "116N29-30NK-C007"),
>>> --
>>> 2.34.1
>>>
>> Thanks for this - when I was looking for the panel, I simply went with
>> what I found on panel-look.
> Did you check what string your panel reports? For example, using
> something like:
>
> 	# strings /sys/class/drm/card0-eDP-1/edid
> 	...
> 	B133UAN02.1
>
> Johan

Hi Johan,

At the time, I did not, and I do not know why I didn't.

I am showing

"R133NW4K R0"

-- steev


