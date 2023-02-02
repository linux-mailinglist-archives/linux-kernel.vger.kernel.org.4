Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C6056880EE
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 16:02:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231391AbjBBPCY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 10:02:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232152AbjBBPCO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 10:02:14 -0500
Received: from mail-ej1-x62f.google.com (mail-ej1-x62f.google.com [IPv6:2a00:1450:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C24C921B9;
        Thu,  2 Feb 2023 07:02:02 -0800 (PST)
Received: by mail-ej1-x62f.google.com with SMTP id mf7so6732106ejc.6;
        Thu, 02 Feb 2023 07:02:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AK8RJ/5wsSk833KBMZzt5YZaWG5BWPXHye5F6n2Sqww=;
        b=Mhc19gRW/scfcgge9UMISxNUN6s69BN9+dQpXO4f8WPvCOP0fizKIUwlK0Pka2BxOf
         Czd0mMZkgubGbwshXF1UU6INhJlqxqBeRzGwO7A8gYkt2cpFpn/sYWbohTFY1pfoKwAN
         VFyw1H4yTeXAlaSJZw+UDTpgsD/j3djB4PktM2dWZkfqRQyIAEjFSH0iqMtOVAznYIIc
         AoadjAtr+boF3612QhsrvvpZoHM3cXJ69fpuL0gdqpXndst5dTg/eVlELnvlS+ibz39f
         dAJ09TFj5Wvo7uVhbVnBCwCBYGwWvnlP18jomteKzZoIFIBKpZxjFrgDfO3gt1ci89LY
         bmqA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:references:cc:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AK8RJ/5wsSk833KBMZzt5YZaWG5BWPXHye5F6n2Sqww=;
        b=N5oCgoveK2WXwcjfneK9V/psDB82arRwXCt+IUPCs8tBNKAy7kwyVYbRIhD2tXiKWe
         P6g+0W+KC8Mgi4UNn+irX2IHrjqPIWlamUDjR8B/+ilpgw9tTDvvEpgVBNPxAydMqFfk
         LGvbNams5NyjzvabNCd8OQZRv3cvCkFxzPiPNnGogdM2vWU64ZrCQM7gu3yHMlM40Pd/
         ovTDdBGeBXcSP8lInDDRepQEv+tBDbwwxvpKyOGDhNd6bvdgNcVnXGo9/s/6wCc/kMpI
         nE7TzaMFbGZjCITaGQBcgvQkJxBXpEb5GE5WlUMQ1+jeGdk6hyO2PiFkbMBrriOYA788
         XthQ==
X-Gm-Message-State: AO0yUKXroZTsCFEIUCOvnlk4y7o4Bv0zykbWkMNY9QWo941KJqJ1fm/b
        qYsFauGJDtZTfldJkmKs/hc=
X-Google-Smtp-Source: AK7set+BWJlS7YlV2HjVqiP/z5s0EhW92x9qVJ1mbI42Mcv0A/Rc3bk2UjxgdPXaUK/o5Tfu+xQCBQ==
X-Received: by 2002:a17:906:1f47:b0:881:277:b77a with SMTP id d7-20020a1709061f4700b008810277b77amr6757235ejk.65.1675350120542;
        Thu, 02 Feb 2023 07:02:00 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id e24-20020a17090681d800b0087bda70d3efsm10161601ejx.118.2023.02.02.07.01.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 07:01:59 -0800 (PST)
Message-ID: <41eafd31-558d-613c-69ef-15230a80db5c@gmail.com>
Date:   Thu, 2 Feb 2023 16:01:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v6 0/6] add support for MT8195 VPPSYS on MMSYS and MUTEX
Content-Language: en-US
From:   Matthias Brugger <matthias.bgg@gmail.com>
To:     Moudy Ho <moudy.ho@mediatek.com>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-clk@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230118032122.29956-1-moudy.ho@mediatek.com>
 <cd82e2a1-dbf4-88ee-f658-f695ae9ef56a@gmail.com>
In-Reply-To: <cd82e2a1-dbf4-88ee-f658-f695ae9ef56a@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/02/2023 13:40, Matthias Brugger wrote:
> Whole series queued for the next merge window.
> 

I encountered some compile errors, so I deleted the whole series, please fix and 
resubmit. Thanks

drivers/soc/mediatek/mtk-mmsys.c: In function 'mtk_mmsys_vpp_rsz_merge_config':
drivers/soc/mediatek/mtk-mmsys.c:261:9: error: too few arguments to function 
'mtk_mmsys_update_bits'
   261 |         mtk_mmsys_update_bits(dev_get_drvdata(dev), reg, ~0, enable);
       |         ^~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mtk-mmsys.c:129:13: note: declared here
   129 | static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, 
u32 mask, u32 val,
       |             ^~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mtk-mmsys.c: In function 'mtk_mmsys_vpp_rsz_dcm_config':
drivers/soc/mediatek/mtk-mmsys.c:270:9: error: too few arguments to function 
'mtk_mmsys_update_bits'
   270 |         mtk_mmsys_update_bits(dev_get_drvdata(dev),
       |         ^~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mtk-mmsys.c:129:13: note: declared here
   129 | static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, 
u32 mask, u32 val,
       |             ^~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mtk-mmsys.c:273:9: error: too few arguments to function 
'mtk_mmsys_update_bits'
   273 |         mtk_mmsys_update_bits(dev_get_drvdata(dev),
       |         ^~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mtk-mmsys.c:129:13: note: declared here
   129 | static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, 
u32 mask, u32 val,
       |             ^~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mtk-mmsys.c:278:9: error: too few arguments to function 
'mtk_mmsys_update_bits'
   278 |         mtk_mmsys_update_bits(dev_get_drvdata(dev),
       |         ^~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mtk-mmsys.c:129:13: note: declared here
   129 | static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, 
u32 mask, u32 val,
       |             ^~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mtk-mmsys.c:281:9: error: too few arguments to function 
'mtk_mmsys_update_bits'
   281 |         mtk_mmsys_update_bits(dev_get_drvdata(dev),
       |         ^~~~~~~~~~~~~~~~~~~~~
drivers/soc/mediatek/mtk-mmsys.c:129:13: note: declared here
   129 | static void mtk_mmsys_update_bits(struct mtk_mmsys *mmsys, u32 offset, 
u32 mask, u32 val,
       |             ^~~~~~~~~~~~~~~~~~~~~

Regards,
Matthias

> Thanks!
> 
> On 18/01/2023 04:21, Moudy Ho wrote:
>> Changes since v5:
>> - Depend on :
>>    [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=713031
>>
>> Changes since v4:
>> - Rebase on linux-next.
>> - Remove MMSYS fallback compatible.
>> - Migrate MT8195 VPPSYS0/1 from clock to mtk-mmsys driver.
>>
>> Changes since v3:
>> - Rebase on linux-next.
>>
>> Changes since v2:
>> - Depend on :
>>    [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
>> - Split dts settings into two patches based on belonging to MMSYS or MUTEX.
>>
>> Changes since v1:
>> - Depend on :
>>    [1] https://patchwork.kernel.org/project/linux-mediatek/list/?series=681097
>> - Add compatible names to VPPSYS0 and VPPSYS1 in MMSYS binding file.
>> - Fix VPPSYS's MMSYS and MUTEX dts to pass the dtsb_check.
>> - Rename mtk_mmsys_merge_config() and mtk_mmsys_rsz_dcm_config() to
>>    mtk_mmsys_vpp_rsz_merge_config() and mtk_mmsys_vpp_rsz_dcm_config().
>> - Clean up mtk_mmsys_vpp_rsz_dcm_config().
>> - Add a comment to mtk_mutex_write_mod() and clean it up for use in more
>>    than 32 mods.
>>
>> Hi,
>>
>> This series add support for MT8195's two VPPSYS(Video Processor Pipe Subsystem),
>> under which there will be corresponding MMSYS and MUTEX settings that
>> need to be configured.
>>
>> Moudy Ho (1):
>>    arm64: dts: mediatek: mt8195: add MUTEX configuration for VPPSYS
>>
>> Roy-CW.Yeh (5):
>>    dt-bindings: soc: mediatek: Add support for MT8195 VPPSYS
>>    arm64: dts: mediatek: mt8195: add MMSYS configuration for VPPSYS
>>    soc: mediatek: mmsys: add config api for RSZ switching and DCM
>>    soc: mediatek: mutex: Add mtk_mutex_set_mod support to set MOD1
>>    soc: mediatek: mutex: support MT8195 VPPSYS
>>
>>   .../bindings/soc/mediatek/mediatek,mutex.yaml |   1 +
>>   arch/arm64/boot/dts/mediatek/mt8195.dtsi      |  26 +++-
>>   drivers/soc/mediatek/mt8195-mmsys.h           |  13 ++
>>   drivers/soc/mediatek/mtk-mmsys.c              |  42 ++++++
>>   drivers/soc/mediatek/mtk-mutex.c              | 135 +++++++++++++++++-
>>   include/linux/soc/mediatek/mtk-mmsys.h        |   4 +
>>   include/linux/soc/mediatek/mtk-mutex.h        |  35 +++++
>>   7 files changed, 245 insertions(+), 11 deletions(-)
>>
