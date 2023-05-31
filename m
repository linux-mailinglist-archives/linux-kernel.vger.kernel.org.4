Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CA7771782B
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 09:27:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234641AbjEaH1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 03:27:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234591AbjEaH1c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 03:27:32 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E17CBE5;
        Wed, 31 May 2023 00:27:26 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f60b3f32b4so39009295e9.1;
        Wed, 31 May 2023 00:27:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685518045; x=1688110045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Y4X5Wohwv6l7HU9svLxZYiAxT8tGzCt99NLg9x4sH48=;
        b=P25pgQT4ztxcFXczUNWGPi84IBW6g/Jd+safyXGsj1qyVbTfUqAwQUh05EY1POVK00
         USnZasIvT7j38RpnlHdUc6+WdRdVJ7Hn5Be6yGxWeD4upOozgjPRU0hOO6hpzqloDrBW
         p5U/v4nvimUTATKPslhEh0YfzCyr5nfv0yaMKiY+2Wjk4y2AkWIOxxNlOoc7Cl3XP0/G
         YgEb8bHNFCtAmdj51k/Xam1zavfP2aVGCNHd+tsLEkEKrCBP63N7RkaMrq99CUwZEznx
         4SjaxtXjJHLIUUiK96j9wy2r58lOGyTEGf5pQFpf6aH9cm+e7beTlp+gQ5OrVZyi/5+4
         Kp1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685518045; x=1688110045;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Y4X5Wohwv6l7HU9svLxZYiAxT8tGzCt99NLg9x4sH48=;
        b=g+BTsZJJQa1Yxnp7jrUSYWOOw4KokmySWQNTUMxFbus/mv3x0FVtxR4IhHv9iLz9TC
         SxjNazPWMzaTH1eICaAYXPLZLoE4jk94WIy4CP5ol/QmVHM0aKLJ1CbwljODqjeM6Rwm
         Zmzti/G3qI71KsKF5TzsfeiPmj84HShVZZ2E2FkLXjykSf6AvC1ROMhmBRh8KcedrCH7
         Bjcz+ZprWqhBnAaGzJxVpJBlDy87bZjIKsMAV43hTTFob+JBBSkiwSW5SlHTSVvIBhoo
         cmnRl8omiQ1MwR+rljOHKkCg6jSIln7GDj1Fm+tSa3DEMZxcPv2P6Y/GbP43Myd5iCy6
         XRtA==
X-Gm-Message-State: AC+VfDzPT53jzfsE4uZT3WTS7YpsIxMiQltOUB4e8Zma/5HLel0MxJ0W
        rSZJSwbEIsGV8o/dkaiWhfs=
X-Google-Smtp-Source: ACHHUZ4l8Rpu8ekx4hkNFGccONUxbjH37LBEkRGolmNei00ETECpzfuyFqy5GtAbgRijq28rpDHzfA==
X-Received: by 2002:a1c:c906:0:b0:3f4:2c21:b52c with SMTP id f6-20020a1cc906000000b003f42c21b52cmr3293418wmb.39.1685518045063;
        Wed, 31 May 2023 00:27:25 -0700 (PDT)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id n15-20020a1c720f000000b003f6cf9afc25sm19476238wmc.40.2023.05.31.00.27.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 00:27:23 -0700 (PDT)
Message-ID: <de7389cb-8b38-49c9-4768-ba0ad49993d1@gmail.com>
Date:   Wed, 31 May 2023 09:27:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [RESEND 0/6] media: mediatek: Update video decoder nodes for
 MT8195 and MT8192
Content-Language: en-US, ca-ES, es-ES
To:     Chen-Yu Tsai <wenst@chromium.org>
Cc:     Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-media@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>
References: <20230303013842.23259-1-allen-kh.cheng@mediatek.com>
 <4ebd1c9f-0460-4436-8e17-0e46e88f4828@notapiano>
 <CAGXv+5Hd-8e9QWGQ2MB++xjNH0sRemmQnVnAk=CfE8DBhkYZQw@mail.gmail.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <CAGXv+5Hd-8e9QWGQ2MB++xjNH0sRemmQnVnAk=CfE8DBhkYZQw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 30/05/2023 09:28, Chen-Yu Tsai wrote:
> On Tue, Apr 4, 2023 at 6:19 AM Nícolas F. R. A. Prado
> <nfraprado@collabora.com> wrote:
>>
>> On Fri, Mar 03, 2023 at 09:38:36AM +0800, Allen-KH Cheng wrote:
>>> This series is based on matthias github v6.3-tmp. Since there is a
>>> dependence in the following series, I resend a series for them.
>>>
>>> patchwork.kernel.org/project/linux-mediatek/list/?series=702423
>>> patchwork.kernel.org/project/linux-mediatek/list/?series=702078
>>
>> Hi Matthias,
>>
>> this series has been completely reviewed and tested for a while, and the
>> bindings patches were already picked up by Hans and are on their way to 6.4 [1].
>> So could you please pick the devicetree patches?
> 
> Ping again on this series.
> 
> The device tree patches can be picked up.
> 

Nicolas, Chen, thanks for the ping. It's unfortunate that there are no email 
send by the maintainer to the mailinglist to confirm that the patches got 
accepted. So it's very helpful if you help me on that.

Patches are applied now.
Regards,
Matthias
