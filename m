Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84DE86D4115
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 11:48:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232222AbjDCJsA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 05:48:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232214AbjDCJrh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 05:47:37 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C16011E97
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 02:47:19 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id h8so114865521ede.8
        for <linux-kernel@vger.kernel.org>; Mon, 03 Apr 2023 02:47:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680515237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=htPk5PXTOqeqOET7dyhcLS5Nxh2cxnK3mpGnQz9jlEw=;
        b=SvoeEbbR8OcfvVqTljRORHpbqaNFE7cu/bdh4a3d3VE4NUnwo1J/oyoAPXZ0a+yBUd
         hIKYw+s6BKEbV0nyzwPXNSkFmbnG6OvxYMeFlUu8hGHeCQjuWipnJzmGn+D0mXZA7nOM
         /Y+FgreAigmNIHhIlvRuWlr3UDh+bYcY3u4ByQaS7QhPfxvqH4hJAZS0IR9nJoqOfiPU
         GZLEPeUrjBKgNAEOt9DNXW8PLIhwOk20YHAJALYC7vLuI5K+qpFmK2ZLZAVYgR4bIwAa
         EhDpTeIbMKoqH9kswhsCWOrMOTkV2nvh1hy+jA9x4KeaKRRkGfWjdQ4iChZRhW1ax7/b
         vGbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680515237;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=htPk5PXTOqeqOET7dyhcLS5Nxh2cxnK3mpGnQz9jlEw=;
        b=kqLIOynDL7dXgVN5M/sXCXf6ePT0/Vto+txJPIUA8A1biWEm6+KGKJSuoMBBF3OgEW
         culbHBrT7oFl6l+mx/RTfcfM1HC8UYqhWSZyayBUiyw//k3ZZxIdwsh0LvSu4FVlKxbQ
         qUmnYkAzBJVOFxLh40j0PtEFDamX4p42hLx9iasTna+nSSa5sV1APWH/MyXfwp1fEa/1
         hFitfBQZzdHoS6GHgBCZzxVANHR0cVjlb8S1EiKsLXjw2WWrZRoLiidii3hSJMl9ahzD
         Q1/fIMkEgRQTGm+k+UYA3pwsMaynI80zL5xjktz8ZCeS2Z2XbZpJMIn/Qa5hQH1GcC1h
         Hn3Q==
X-Gm-Message-State: AAQBX9eQ3AblIBUZYkiRTDczAn/Bar9QWb99YikJf+18CU3NhG0Jze9Z
        gdRoWRmcENi+Z9gM+i0XXtqXPg==
X-Google-Smtp-Source: AKy350aq2/eAtEYHLJ3R4+ZQV7M03sIMNYL9wBr9zDABKJ8ufu9aCsyLHfIX7yY35iys3sUdYSzvjg==
X-Received: by 2002:a17:906:6bd5:b0:930:7ae6:9ebd with SMTP id t21-20020a1709066bd500b009307ae69ebdmr35660301ejs.70.1680515237638;
        Mon, 03 Apr 2023 02:47:17 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:ae90:d80:1069:4805? ([2a02:810d:15c0:828:ae90:d80:1069:4805])
        by smtp.gmail.com with ESMTPSA id la6-20020a170907780600b009351565d1f5sm4285058ejc.52.2023.04.03.02.47.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Apr 2023 02:47:17 -0700 (PDT)
Message-ID: <d0b9d8a2-14ae-8c0d-309b-5f5d60d43a1d@linaro.org>
Date:   Mon, 3 Apr 2023 11:47:16 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v30 0/7] Add MediaTek SoC DRM (vdosys1) support for mt8195
Content-Language: en-US
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, singo.chang@mediatek.com,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Nancy.Lin" <nancy.lin@mediatek.com>,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org, krzysztof.kozlowski+dt@linaro.org,
        clang-built-linux@googlegroups.com,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20230321121859.2355-1-nancy.lin@mediatek.com>
 <17831605-5c9d-9c92-d190-04f91060ace4@collabora.com>
 <CAAOTY_8ZAxVSLnJ1u5snsRgkszV7ixwhjUS2nDimE_Lpj=cUCA@mail.gmail.com>
 <97a5f383-38f5-e8ea-e1d8-489b690e4521@collabora.com>
 <CAAOTY_9_vn-m2jTaaHkFDV+v2-LeaAxtCLNNnOxZq5Httb-TAQ@mail.gmail.com>
 <CAGXv+5FJCuG_zHnaKZ=baNzKAWKLEe3jZnghNAxuGv7i7L6e7Q@mail.gmail.com>
 <CAAOTY_9Dbtubah3ndj9+FeYDh7D42k6-BtHrYMNc=CP6GL6uFA@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAAOTY_9Dbtubah3ndj9+FeYDh7D42k6-BtHrYMNc=CP6GL6uFA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/04/2023 05:30, Chun-Kuang Hu wrote:
> Hi, Chen-yu:
> 
> Chen-Yu Tsai <wenst@chromium.org> 於 2023年3月30日 週四 下午7:05寫道：
>>
>> On Mon, Mar 27, 2023 at 11:17 PM Chun-Kuang Hu <chunkuang.hu@kernel.org> wrote:
>>>
>>> Hi, Angelo:
>>>
>>> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 於
>>> 2023年3月24日 週五 下午4:38寫道：
>>>>
>>>> Il 24/03/23 00:25, Chun-Kuang Hu ha scritto:
>>>>> Hi, Angelo:
>>>>>
>>>>> AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com> 於
>>>>> 2023年3月23日 週四 下午4:58寫道：
>>>>>>
>>>>>> Il 21/03/23 13:18, Nancy.Lin ha scritto:
>>>>>>> The hardware path of vdosys1 with DPTx output need to go through by several modules, such as, OVL_ADAPTOR and MERGE.
>>>>>>>
>>>>>>> Add DRM and these modules support by the patches below:
>>>>>>>
>>>>>>
>>>>>> I've tested v30 again on MT8173, MT8192 and MT8195 based Chromebooks.
>>>>>> Green light from me.
>>>>>
>>>>> I'm curious about how you build code and test on Chromebooks. Do you
>>>>> build in cros environment or pure linux
>>>>> (https://archlinuxarm.org/platforms/armv8/mediatek/acer-chromebook-r13).
>>>>> I've a MT8183 based Chromebook (HP 11a) and I've tried to run a
>>>>> upstream kernel on it. cros is too heavy for me and I doubt I could
>>>>> use it. I've tried the pure linux and could boot up with console, but
>>>>> display does not work. If you use the pure linux environment, could
>>>>> you share how it works?
>>>>>
>>>>
>>>> I haven't tested MT8183 (I don't actually have any 8183 machine in my hands)... but
>>>> yes, I can share my test environment.
>>>>
>>>> I have one MicroSD that I use either in the MicroSD slot of the target machine, or
>>>> in a USB reader; this *single* system is what I boot on *all* Chromebooks that I
>>>> have: one kernel, multiple devicetrees, same Debian-based userspace.
>>>>
>>>> What we have to prepare this bootable media can be found at [1], but beware that
>>>> it currently uses an outdated kernel, so, what I have locally is a symlink to my
>>>> kernel tree.
>>>> You can change/add/remove the devicetree blobs that will get added to the image
>>>> by modifying `chromebook-setup.sh`; before tampering with kernel tree symlink,
>>>> please run that script for the first time, as it will download a cross-compiler,
>>>> a kernel tree (that you will replace for sure) and the (very old) Debian rootfs
>>>> that you can update with `apt-get dist-upgrade` after booting the Chromebook.
>>>>
>>>> If you want to check about possible kernel configuration differences, what I use
>>>> is at [2], so that you can compare.
>>>
>>> Thanks for the information, I would try to compare the kernel config first.
>>
>> Hi CK,
>>
>> Would you consider adding your repo to linux-next? That would let everyone
>> do integration testing, especially automated ones, earlier, before you send
>> your PRs to drm maintainers.
>>
>> You can do so by sending an email to Stephen Rothwell to do so.
> 
> I don't understand what this process is. Does it means that I directly
> upstream patches into linux-next? I prefer that my patches go through
> drm maintainers' tree. Does any document introduce this process?

All maintainers and sub-maintainers trees are supposed to be fed into
linux-next.

https://lore.kernel.org/linux-next/20230327124805.3ca4f3cc@canb.auug.org.au/T/#md226a8e714cc731c2ab4ba5ee7eb43fe21a55009

Documentation/process/howto.rst
Documentation/process/2.Process.rst


Best regards,
Krzysztof

