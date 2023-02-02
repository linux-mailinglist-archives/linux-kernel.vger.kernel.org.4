Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44C5A687CB2
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 12:52:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjBBLwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 06:52:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229929AbjBBLw3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 06:52:29 -0500
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00F7463855;
        Thu,  2 Feb 2023 03:52:28 -0800 (PST)
Received: by mail-wr1-x42a.google.com with SMTP id m7so1450892wru.8;
        Thu, 02 Feb 2023 03:52:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=F0y8ikm0/uriJSrqR7napvMGotKjya5U7k4Py4klJVM=;
        b=k4Y1r2IHPtKLh0AA9EYiXCpQj9K9hbGt2ZIfW8wYGCDjCxQn+BKftGq1bCqmuT/l1i
         Uo8LpaGBMm9FVzMCcxVGikiThovS85InR6NaYjQPn+xo6s86o8KAMSCR+ujIVX3r5Udp
         mjSjJro1leJAitZa+LK+5uQwIS9HTIEGoi3IL6L7KtdTUZYEvTlZLZGso16mQgbGgPPs
         sPcuOBZ2EiBGoGr3CvHA1mEjOxXemEpWcvQ9inm1ToDUDVcVD9Kh+RDOEklW/bOSn00N
         fcHb6WaTpKTR9hrcsUE2DxL+CbvrhPcxaFbr62e9vkz3c3lPicBSwDfNZTRgoOJM7kAM
         oz5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=F0y8ikm0/uriJSrqR7napvMGotKjya5U7k4Py4klJVM=;
        b=uOS9qn3EawHCHeGSWMLUJQn2s7gBSqItxta/2mc47jKxR+RYRhrrvlkDakjE4/SMjT
         lmvKRwcIh/xK+J4ZinRjUFD8QcDtcYvWr+3jkZRyGP4ntko8UM2faqKmLPcIJKIhIGuP
         glPTjTfNNiVWN1Dy1NBmj+oeZ+iTWFI8lWZQVfzYz8/UjLhWKSoYbvF859ii7VZLZxGI
         i4KApxVlEFDvpJx2sxLnH1y6E49BED08QmfyPcV6p6fKHk7cRMkE3XFMsxFbQJ9ER7ga
         DQfjVtuRAwfhZp0e35rDZ1hCV5eiE56XQriiHyjWrm14ASsb59E04qLH0fqb6munjLdG
         DZUA==
X-Gm-Message-State: AO0yUKXwmm6SxJipdFxeXYlHJZasGElonWEaIXQoGXI+NmQ/5DNvb2IY
        CZ8JNctILrY5euCJkR4McG4=
X-Google-Smtp-Source: AK7set9kleGI9cl0RhP3cDudtg26Ip2ps3NNEmSBY5Glzqw4jyllNyvlkx+BwH5dsmHf735GgWGxQw==
X-Received: by 2002:a05:6000:789:b0:2bf:cb91:a40a with SMTP id bu9-20020a056000078900b002bfcb91a40amr5828501wrb.46.1675338747445;
        Thu, 02 Feb 2023 03:52:27 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id i14-20020a0560001ace00b002c3be49ef94sm2151632wry.52.2023.02.02.03.52.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 03:52:26 -0800 (PST)
Message-ID: <4f6f8801-9101-482e-6f3f-bc011df42259@gmail.com>
Date:   Thu, 2 Feb 2023 12:52:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] arm64: dts: mediatek: mt8195: Fix vdosys* compatible
 strings
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        =?UTF-8?Q?N=c3=adcolas_F_=2e_R_=2e_A_=2e_Prado?= 
        <nfraprado@collabora.com>, soc@kernel.org
References: <20230202104014.2931517-1-wenst@chromium.org>
 <4b5bb022-eb5d-2ed1-2123-eb9e502299dc@collabora.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <4b5bb022-eb5d-2ed1-2123-eb9e502299dc@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/02/2023 12:42, AngeloGioacchino Del Regno wrote:
> Il 02/02/23 11:40, Chen-Yu Tsai ha scritto:
>> When vdosys1 was initially added, it was incorrectly assumed to be
>> compatible with vdosys0, and thus both had the same mt8195-mmsys
>> compatible attached.
>>
>> This has since been corrected in commit b237efd47df7 ("dt-bindings:
>> arm: mediatek: mmsys: change compatible for MT8195") and commit
>> 82219cfbef18 ("dt-bindings: arm: mediatek: mmsys: add vdosys1 compatible
>> for MT8195"). The device tree needs to be fixed as well, otherwise
>> the vdosys1 block fails to work, and causes its dependent power domain
>> controller to not work either.
>>
>> Change the compatible string of vdosys1 to "mediatek,mt8195-vdosys1".
>> While at it, also add the new "mediatek,mt8195-vdosys0" compatible to
>> vdosys0.
>>
>> Fixes: 6aa5b46d1755 ("arm64: dts: mt8195: Add vdosys and vppsys clock nodes")
>> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 

Acked-by: Matthias Brugger <matthias.bgg@gmail.com>

Arnd, Olof, will you take it directly or shall I provide a pull request once 
-rc1 is out?

Regards,
Matthias

>> ---
>>
>> Since we are at -rc6 and Matthias already sent out pull requests, I've
>> CC-ed soc@ so that this may be picked up directly on top of them. This
>> should be merged for -next.
>>
>> Thanks
>>
> 
