Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EA9B6E1330
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 19:08:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230266AbjDMRIv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 13:08:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjDMRIt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 13:08:49 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D4011B4;
        Thu, 13 Apr 2023 10:08:48 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id e7so4836966wrc.12;
        Thu, 13 Apr 2023 10:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681405727; x=1683997727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=vUAnBlFRSGBlwXwSQXAqm7P10EiEl+48o/NRTbPOIwI=;
        b=HWYW8/RVFPxSHRWBcro0ZM0vclYoDzFo9NEifLGdrjORDSE6iDq9AwFwfenSd8GxEt
         rfRXewl/Bk7aKC89XahV+cxJJK05ZfxJY1Dp8BnrMhAPCHXF7I83wXYNTPf2jfmZmVT1
         GkUe8G3rSbx0xGKbSHUu3PI5f7NRRPzrcgUIA30sxCAzFKjb+37KblE4FEkktfMna2ja
         nSI5tXZ/8XawREqOXVtRL81+F26lOMjqD1toA7oWuaBseU9a4dPlQTCmVx9ETv2rL7ub
         EGOqzjQXE46D1peydsH0koKhuHs41ofPDUSD1Z7SIUAqvdyYrS5UTWfMYAfDE7RlNSCW
         632w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681405727; x=1683997727;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vUAnBlFRSGBlwXwSQXAqm7P10EiEl+48o/NRTbPOIwI=;
        b=Nb3s0eivY4JipZIF+kncI+IDPT7N/N5Wy72RATGSIwHbw39GuAd33VNJxnGK6l/OED
         Bu0mAhwjRP89273hoLTjGs/CqWhik3eOzQZSyJ6Ttd9nCRi7iQFH9l4Fan62gAs9yGbe
         VGH3Gc8vsJtNdZqgCt7b28bmX1ngb7ihjeaZNV1LBcSbOQEXBV4leHUDnIW0KmD81Xwb
         UyVi+JHIpeg0PAScGutjYgS6XCHCSmbPcIUQKJgckSMZeb5aZLP6+M1k3Y17Dt34NqPF
         OS0ltApbkqqbiWsOTLS8bYREg25hj1RM3I51CkuQjqY9saQYDYqUJN0ZXMpFdG4wcC6b
         LGTQ==
X-Gm-Message-State: AAQBX9eYqhqywrosyJJJtmwGnMBanm5M84ypf5SnHOGzYiI7fhRTFeqV
        BMQab1dOCrL/5qj6VBNG+C/lq90i5V5ZGg==
X-Google-Smtp-Source: AKy350arxfCCpaVx1w4hHZM1E1HpJLjfl+cRZdLDdeSnQNukXu4TUaQgzkTfOoR3xnpv2XCmUfu/vg==
X-Received: by 2002:a5d:63c4:0:b0:2ef:f9d:6adf with SMTP id c4-20020a5d63c4000000b002ef0f9d6adfmr2154403wrw.35.1681405726957;
        Thu, 13 Apr 2023 10:08:46 -0700 (PDT)
Received: from [192.168.0.32] ([37.222.243.26])
        by smtp.gmail.com with ESMTPSA id u8-20020a5d6ac8000000b002eaac3a9beesm1700208wrw.8.2023.04.13.10.08.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 13 Apr 2023 10:08:45 -0700 (PDT)
Message-ID: <5c1d69c8-d973-fa7b-1f14-c72729ff5594@gmail.com>
Date:   Thu, 13 Apr 2023 19:08:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v1 3/6] soc: mediatek: virt: geniezone: Introduce
 GenieZone hypervisor support
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Yi-De Wu <yi-de.wu@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Yingshiuan Pan <yingshiuan.pan@mediatek.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Jades Shih <jades.shih@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Ivan Tseng <ivan.tseng@mediatek.com>,
        My Chuang <my.chuang@mediatek.com>,
        Shawn Hsiao <shawn.hsiao@mediatek.com>,
        PeiLun Suei <peilun.suei@mediatek.com>,
        Ze-Yu Wang <ze-yu.wang@mediatek.com>,
        Liju Chen <liju-clr.chen@mediatek.com>
References: <20230413090735.4182-1-yi-de.wu@mediatek.com>
 <20230413090735.4182-4-yi-de.wu@mediatek.com>
 <1aa701cc-92ca-71be-0663-df4bfae66c2f@linaro.org>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <1aa701cc-92ca-71be-0663-df4bfae66c2f@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13/04/2023 14:55, Krzysztof Kozlowski wrote:
> On 13/04/2023 11:07, Yi-De Wu wrote:
>> From: "Yingshiuan Pan" <yingshiuan.pan@mediatek.com>
>>
>> GenieZone is MediaTek proprietary hypervisor solution, and it is running
>> in EL2 stand alone as a type-I hypervisor. This patch exports a set of
>> ioctl interfaces for userspace VMM (e.g., crosvm) to operate guest VMs
>> lifecycle (creation, running, and destroy) on GenieZone.
>>
>> Signed-off-by: Yingshiuan Pan <yingshiuan.pan@mediatek.com>
>> Signed-off-by: Yi-De Wu <yi-de.wu@mediatek.com>
>> ---
>>   arch/arm64/include/uapi/asm/gzvm_arch.h       |  79 ++++
>>   drivers/soc/mediatek/Kconfig                  |   2 +
>>   drivers/soc/mediatek/Makefile                 |   1 +
>>   drivers/soc/mediatek/virt/geniezone/Kconfig   |  17 +
> 
> Hypervisor drivers do not go to soc. Stop shoving there everything from
> your downstream. Find appropriate directory, e.g. maybe drivers/virt.

Acked, what is the reason you want to add this to drivers/soc instead of 
drivers/virt?

Regards,
Matthias

> See:
> https://lore.kernel.org/all/20230304010632.2127470-1-quic_eberman@quicinc.com/
> 
> You should follow that discussion as well and be sure that all concerns
> raised for Gunyah are solved also here.
> 
> Best regards,
> Krzysztof
> 
