Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2BB060F979
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 15:42:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234069AbiJ0Nmw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 09:42:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236290AbiJ0Nmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 09:42:49 -0400
Received: from mail-oo1-xc35.google.com (mail-oo1-xc35.google.com [IPv6:2607:f8b0:4864:20::c35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59E9D182C4B;
        Thu, 27 Oct 2022 06:42:43 -0700 (PDT)
Received: by mail-oo1-xc35.google.com with SMTP id v7-20020a4aa507000000b00496e843fdfeso108112ook.7;
        Thu, 27 Oct 2022 06:42:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=z6W8iPhtqNf0mlij4m5bW+fazzgVgRRAtBqf6PWEhmg=;
        b=T4OyztRjkpORsyc3m5+KYfpXaAJEx7dS55/YZXVf9GhcGyFP+YGJnNpI5/yS/Bj7Vx
         +82dq+DUeQ1JPamgSMrUVUxIk4c5nON0uo7en8POpZqjmy6v1GqqZ0QxyZo/y9yHugwX
         vqUp71h7Wg17x1YzoKhJOHch8CQ83+GJWdKqS6adEVhEROvj2WHe6J7OYhmdy7tK3mEi
         NPiQsQET/BMbEqWSCSDQzvbrexnvv0b2CPvaZ2ORf2lxUJXt+XTaNdAZBMBwUsy4LfiX
         fH4hSPrZxjfMnrc0Y9rShmeyY+n5/vTznqZ+vR5bo0z5tCYOLefgr9efIdZUUp9NxSo9
         k/NA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=z6W8iPhtqNf0mlij4m5bW+fazzgVgRRAtBqf6PWEhmg=;
        b=6Yq2zoPD3Icjs0zbPBAJFV1otHE4YZY0pZNxc4Bjs3npRyucmBix0LAPbtMKxkHwqN
         jwylHKnheD9xBcHnFMxB2hhZVNUztRN5boHvjI+wk2Wsm2DIJ4zZ10uiL46VHKvbAdoI
         3/2tiWSDmqzNUhjwqQodjVgZosfFDhfLCIxWopA5mhVKKwcc/Z7RD85tKru4WA2R6pbG
         Q1WDCjUU8SBWwPBDubun2vHdGuLUg/vpYiftisocYZTP8oljANml/i5osev57ubOfONx
         vz6Kz0AIBo3Sr+nYLgRJcbc/5S3y0Gr9SFznJ9W+M6TPlEhOzBIrrAdVzrAhRrXUTkyT
         OVvQ==
X-Gm-Message-State: ACrzQf3ynD97Qu7DLMN3SSCFdKZaEWgjy0qSFdLiavLn0l7JIz+qQ8TS
        uXVuWjZRpck1pYt0NgjOtXmzBDkq5l8=
X-Google-Smtp-Source: AMsMyM6EsoWqLXxFY7D9adCQffkMzr6fGzXbjKo4AM7L8cWrbHc1r7MM6v3VW2G2whThY1OxFNquog==
X-Received: by 2002:a4a:9c2:0:b0:481:134b:fb50 with SMTP id 185-20020a4a09c2000000b00481134bfb50mr12475812ooa.90.1666878162684;
        Thu, 27 Oct 2022 06:42:42 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id cv17-20020a056870c69100b0010c727a3c79sm545230oab.26.2022.10.27.06.42.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Oct 2022 06:42:42 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <e6035c60-29b7-a03e-29cd-77c37f5375e6@roeck-us.net>
Date:   Thu, 27 Oct 2022 06:42:40 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [RESEND v3 1/3] dt-bindings: watchdog: Add compatible for
 MediaTek MT8188
Content-Language: en-US
To:     =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        =?UTF-8?B?UnVueWFuZyBDaGVuICjpmYjmtqbmtIsp?= 
        <Runyang.Chen@mediatek.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "krzk+dt@kernel.org" <krzk+dt@kernel.org>,
        "nfraprado@collabora.com" <nfraprado@collabora.com>
References: <20221026063327.20037-1-Runyang.Chen@mediatek.com>
 <20221026063327.20037-2-Runyang.Chen@mediatek.com>
 <20221026152645.GA2946818@roeck-us.net>
 <e889728c-13e9-37f8-4d1a-e31332a39498@collabora.com>
 <5abd63240a7890895a6de26a52fc24086f1c8ddb.camel@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <5abd63240a7890895a6de26a52fc24086f1c8ddb.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 01:56, Allen-KH Cheng (程冠勳) wrote:
> On Thu, 2022-10-27 at 09:54 +0200, AngeloGioacchino Del Regno wrote:
>> Il 26/10/22 17:26, Guenter Roeck ha scritto:
>> > On Wed, Oct 26, 2022 at 02:33:25PM +0800, Runyang Chen wrote:
>> > > From: Runyang Chen <runyang.chen@mediatek.com>
>> > > 
>> > > Add dt-binding documentation of watchdog for MediaTek MT8188 Soc
>> > > 
>> > > Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
>> > > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> > > Reviewed-by: AngeloGioacchino Del Regno <
>> > > angelogioacchino.delregno@collabora.com>
>> > 
>> > This conflicts with the ongoing yaml conversion of this file
>> > which is still not accepted.
>> > 
>> > 
> https://urldefense.com/v3/__https://patchwork.kernel.org/project/linux-watchdog/patch/20221005113517.70628-4-angelogioacchino.delregno@collabora.com/__;!!CTRNKA9wMg0ARbw!zT39OehD4gnyDKPYwMbLdeyGI_oNOfvWa4HIrcooL3Ax8O7-N-BjXBZAolsCOuLb39fJ7Q$
>> >  
>> > 
>> > Nevertheless, I'll apply this series to my watchdog-next branch
>> > and assume that it will be included in the next version of the
>> > yaml conversion patch.
>> > 
>> > For my and Wim's reference:
>> > 
>> > Reviewed-by: Guenter Roeck <linux@roeck-us.net>
>> > 
>> > Thanks,
>> > Guenter
>> > 
>> 
>> Adding Allen to the Cc's to make him aware of that, as he took over
>> the
>> mtk-wdt yaml conversion.
> 
> Hi Guenter,
> 
> I can send the following version of yaml conversion[1] for conflicts
> after you apply this series. Thanks.
> 
> [1]
> 
> https://patchwork.kernel.org/project/linux-mediatek/patch/20221007093437.12228-6-allen-kh.cheng@mediatek.com/
>

You did not copy the watchdog mailing list with this patch, causing it to get lost
from my queue (even though I had a look at it). If there were other watchdog related
patches in this version of the series, they got lost as well.

Guenter

