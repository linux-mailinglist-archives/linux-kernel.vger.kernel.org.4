Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 753FE6C4E11
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 15:42:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231661AbjCVOmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231654AbjCVOly (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 10:41:54 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96CFC64B34;
        Wed, 22 Mar 2023 07:41:28 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id t15so17318925wrz.7;
        Wed, 22 Mar 2023 07:41:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679496087;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Ml/8rgHxnh/Rcizr/HTKMeYH4wxYvAVSv7sbApQZNB8=;
        b=XtAadWtr79aVV3gfVOVZS5A7aLvnPaZTy8EJEW+i7VzFaja/BFTha8SWE9A5XVQGky
         /06tFDul6XXHZNW0UXWggE9j/BrfU9CFumViSPVXEglGdEhf3Xn06+4HLUObE1Ak19Lh
         oYMLYyDEddYkJ0l6/9d6UQRanmmR56HdSjjzuVHvcAcyKvuCzk3Cq3AWOlqE3nRJMPe3
         yTBQ/BIlAqulEWcs2oyeGL89UxCrmJ3mTYMw6DkjLip3s1AX+Lp45E0dVOh4oZ9QodpH
         lwk/bIWJ+f7s1iDG4iB/9twuAISYsmVOaQKTjsOdMghMsyNcfiJsdmWoJK6d9xL1HHOb
         dNXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679496087;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Ml/8rgHxnh/Rcizr/HTKMeYH4wxYvAVSv7sbApQZNB8=;
        b=pPcl/VL2Br2hqNtcwf+pnD/gCm/r7ojXmbguECesZDfyJsUBh1fRg+tBzmsFjm7Qbk
         BCraq5k81Nl5cVvJt5CwQlX5GEJmHoiQYoMzac2xHyfXi9sjrHprUfuUugLgf+j+lahu
         7+fJrtUIKc9l1U1K7IzkgNIN4ugGZN4J7Owv5ex2sOrGKQoiem/pdPqzfXedbqHJPGIm
         R0VKLUTcvuc1FFbj+m4Xk70VMhSsBnHAskGC0JfZo0fWabs3YfSLAdwQYckXm8DPHeXD
         8SxAxEtS3G7kHLgKsBBASz5hPgjjZjwp/+3VTzrTNjFyIOqyrRfmA5wnImOY6OJXRgq2
         DIzg==
X-Gm-Message-State: AAQBX9dVWFHh1xyWfmSM0jNCRbtg7ZzPBXv5F3svzrySc4thuuFawvUj
        d+UcUCZBJHkLEINszCKbR5M=
X-Google-Smtp-Source: AKy350awk2lLLkW6dcFjDzGAIqtfddOFvqewsAvecdc1km7DwkYiRTaHdnj8Boip9ea1915tUxvCvA==
X-Received: by 2002:adf:f043:0:b0:2c7:70d:cc36 with SMTP id t3-20020adff043000000b002c7070dcc36mr69865wro.5.1679496086739;
        Wed, 22 Mar 2023 07:41:26 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id v7-20020a5d4b07000000b002c56af32e8csm13896207wrq.35.2023.03.22.07.41.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Mar 2023 07:41:26 -0700 (PDT)
Message-ID: <ed1f9faf-cb4f-9ff1-ab6b-813035a051bd@gmail.com>
Date:   Wed, 22 Mar 2023 15:41:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v11 3/3] arm64: dts: mediatek: Initial mt8365-evk support
Content-Language: en-US
To:     Kevin Hilman <khilman@kernel.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-serial@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        angelogioacchino.delregno@collabora.com,
        gregkh@linuxfoundation.org, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, maz@kernel.org, tglx@linutronix.de
References: <20230309213501.794764-1-bero@baylibre.com>
 <20230309213501.794764-4-bero@baylibre.com> <7h8rfqwf5u.fsf@baylibre.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <7h8rfqwf5u.fsf@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 21/03/2023 11:51, Kevin Hilman wrote:
> Bernhard Rosenkränzer <bero@baylibre.com> writes:
> 
>> From: Fabien Parent <fparent@baylibre.com>
>>
>> This adds minimal support for the Mediatek 8365 SOC and the EVK reference
>> board, allowing the board to boot to initramfs with serial port I/O.
>>
>> Signed-off-by: Fabien Parent <fparent@baylibre.com>
>> [bero@baylibre.com: Removed parts depending on drivers that aren't upstream yet, cleanups, add CPU cache layout, add systimer, fix GIC]
>> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
>> [aouledameur@baylibre.com: Fix systimer properties]
>> Signed-off-by: Amjad Ouled-Ameur <aouledameur@baylibre.com>
>> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
>> Tested-by: Kevin Hilman <khilman@baylibre.com>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> Tested (again) and things are working well.  This is the last patch
> remaining to be merged.  As soon as this lands in linux-next, I'll add
> this board to my KernelCI lab.
> 

Applied now, thanks for testing. This should show up in linux-next in the next 
couple of days.

Regards,
Matthias
