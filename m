Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3456568C658
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 20:00:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjBFTAd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 14:00:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230234AbjBFTAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 14:00:31 -0500
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com [209.85.208.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD5D422005
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 11:00:29 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id m8so12665632edd.10
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 11:00:29 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:references
         :cc:to:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=uLWxQl0qTtmQEp5+OeXCEZYEFKKOPxU/HC0IrH2S2y8=;
        b=iJRdBUWvi52zSp5Yno1OoCN6+R1BrD38qLULFz7QZViHk6zdVud+y0wV0iTGpWNGcF
         oE7YOL+CfqjKBp0oNA5k8rKFFOXTefTdlMfC/8IGBHLGQAjvY1xc9wbAhB17fnYBwjDa
         CIUzZMJn8dWyv3Ynekp0ye2OhDwCtKvwtauRa9O59CsYOe3KWFKq6o++7xz++KS/4zfn
         2ihv5Aggz6zYqa9Zl0WeWX9tCfuiaeFGkkIl8o/VTg+zCn6R1AOcVZ3YT9QSB0PzCRSo
         ssZKclkJosFyjWxT7yfPiz4lDxJecc9X1HN2MeIMO+vQ9BlDXloOAujbbiFPIyRfeHqj
         1SdQ==
X-Gm-Message-State: AO0yUKUSHxIid2eCxCg954a0MF6t1uQSkX9UK7XkNeCEU5KaA+Le8nR9
        awzFFSVW/yNO5Zg2QrU3KyXP174ZFc0V/t+D
X-Google-Smtp-Source: AK7set9tvE47tkeBRyyzCWiDdjjfpkWRtpTy/dVdsX2XcPLuuM0JHcWKtBQg1m7WPn4yihL/YyeDfQ==
X-Received: by 2002:a50:9516:0:b0:45c:835b:ac64 with SMTP id u22-20020a509516000000b0045c835bac64mr654482eda.31.1675710028368;
        Mon, 06 Feb 2023 11:00:28 -0800 (PST)
Received: from [192.168.3.157] ([81.56.10.57])
        by smtp.gmail.com with ESMTPSA id q22-20020a50aa96000000b004aab66483ddsm1157931edc.70.2023.02.06.11.00.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Feb 2023 11:00:27 -0800 (PST)
Message-ID: <f8edc17d-5f15-b157-e9a7-a240db4713aa@kde.org>
Date:   Mon, 6 Feb 2023 20:00:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH] ALSA: hda/realtek: Enable mute/micmute LEDs on HP
 Elitebook, 645 G9
Content-Language: en-US
To:     Takashi Iwai <tiwai@suse.de>
Cc:     tiwai@suse.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org
References: <4055cb48-e228-8a13-524d-afbb7aaafebe@kde.org>
 <875ycfkzml.wl-tiwai@suse.de>
From:   Elvis Angelaccio <elvis.angelaccio@kde.org>
Organization: KDE
In-Reply-To: <875ycfkzml.wl-tiwai@suse.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks!

Cheers,
Elvis

On 06/02/23 08:43, Takashi Iwai wrote:
> On Sun, 05 Feb 2023 19:56:18 +0100,
> Elvis Angelaccio wrote:
>>
>> The HP Elitebook 645 G9 laptop (with motherboard model 89D2) uses the
>> ALC236 codec and requires the alc236_fixup_hp_mute_led_micmute_vref
>> fixup in order to enable mute/micmute LEDs.
>>
>> Note: the alc236_fixup_hp_gpio_led fixup, which is used by the Elitebook
>> 640 G9, does not work with the 645 G9.
>>
>> Signed-off-by: Elvis Angelaccio <elvis.angelaccio@kde.org>
> 
> Thanks, applied.
> 
> But the table is sorted in SSID, so I rearranged the entry at
> applying.
> 
> 
> Takashi
