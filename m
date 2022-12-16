Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6434D64EB8E
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 13:44:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230096AbiLPMox (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 07:44:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiLPMov (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 07:44:51 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC978E03D
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 04:44:49 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id m5-20020a7bca45000000b003d2fbab35c6so1656007wml.4
        for <linux-kernel@vger.kernel.org>; Fri, 16 Dec 2022 04:44:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IAQQ3pjeu16iAJS3DIOcQ+yHj7Z/fdaC+NVk/MDrr2k=;
        b=M426POcIu7wkJDhee8+64cJssKw+ZP0ux+/qnKNeoAMJPm1YAvG4DWYpu4w63ClMPH
         f+uLUSArWkMK0BGPca20UoobK4oXIQU+/9RuMtCGnx3WeUykBy/ht5hZxm1y7Wo49jw6
         8qPbexnSZgR5GKuv36bzuXSZYDvYEjDBzVQON7HuHSoJdy5+rtJiz0vySZZV5tMaSaFo
         mSsOMYRwqZ6ptfd0khlNG2rjG5YPDqL2AWiNuBwJRalOnOOTD/xtmEuKOHNaz0LftfTa
         oIKkzt/aDloQuagZxB6J7llRzOUxIj8UOguxlBtK5QFsXZukwji7ufjSP5ZQk6jb4IHS
         fCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IAQQ3pjeu16iAJS3DIOcQ+yHj7Z/fdaC+NVk/MDrr2k=;
        b=jbsqUcDySp/+uA3jBuKR5d63iBrZuU3LlWbZBhzgMCn7ozsnnBFkn15/KG72y/smu6
         MFcJDcTzAJ1LfBK/Ti9hAjukPMOw0bzQtwyGZnYVIlQKUQ9yvhhmIL3VIDmzGpTlbU58
         A3ICyLFQdrUK0XNkCbMJROBou4ClI+RW+E7DtMv57QlxB0D6iPY3/lvoru5CcRx6nbWE
         BxYDQukW0HBCCO/mbdM6q9LhXcVfUFVvZSx8U/dZLIbauEs+s5o5rJZWS/gNKLBPqXvt
         Wwf8YXQ2wp5Z6y8s8dZf2nWI68BZvYoYK3jYmOWUNx2aSmfBwS6UpmdAbQZsAZGUfvH2
         w+9g==
X-Gm-Message-State: AFqh2kq18Q0wf3o7KHNxMl0NFpGjWTMuDLjnLgy0FkboOHn2CsCM+dLj
        kO9Y0DTeO3EO0esmWjeFZL8=
X-Google-Smtp-Source: AMrXdXuglu/S7SP1eM5iCTQQTRFAEsdGBqkOEGFFEGJ7tR9Vq9sJQFZOFJCRLHoBA1a8vzkt80221w==
X-Received: by 2002:a05:600c:1f0f:b0:3d3:49db:d84 with SMTP id bd15-20020a05600c1f0f00b003d349db0d84mr93144wmb.20.1671194688373;
        Fri, 16 Dec 2022 04:44:48 -0800 (PST)
Received: from [192.168.1.132] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id q1-20020a1c4301000000b003d04e4ed873sm9722265wma.22.2022.12.16.04.44.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Dec 2022 04:44:47 -0800 (PST)
Message-ID: <9440d5c0-ddd0-37be-75d4-14713044ac64@gmail.com>
Date:   Fri, 16 Dec 2022 13:44:46 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH v1] soc: mediatek: mtk-pm-domains: Allow mt8186 ADSP
 default power on
Content-Language: en-US
To:     =?UTF-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
Cc:     "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>
References: <20221012075434.30009-1-tinghan.shen@mediatek.com>
 <ce1c6a1a-9183-e56d-6757-947f5fc8133d@gmail.com>
 <d4856589cdbb8ba31d5139604abffa4a06c5c73b.camel@mediatek.com>
 <ece0356f5e184e87a6d5e1fc5ca7fa1a3d203c13.camel@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <ece0356f5e184e87a6d5e1fc5ca7fa1a3d203c13.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 02/12/2022 12:13, TingHan Shen (沈廷翰) wrote:
> Hi Matthias,
> 
> On Wed, 2022-11-23 at 18:40 +0800, TingHan Shen wrote:
>> On Wed, 2022-11-23 at 11:20 +0100, Matthias Brugger wrote:
>> > 
>> > On 12/10/2022 09:54, Tinghan Shen wrote:
>> > > In the use case of configuring the access permissions of the ADSP core,
>> > > the mt8186 SoC ADSP power will be switched on in the bootloader because
>> > > the permission control registers are located in the ADSP subsys.
>> > > 
>> > > Signed-off-by: Tinghan Shen <tinghan.shen@mediatek.com>
>> > 
>> > Do we need a fixes tag here?
>> > My bet is:
>> > Fixes: 88590cbc1703 ("soc: mediatek: pm-domains: Add support for mt8186")
>> > 
>> > Or is this not yet a problem but needed to be able to implement access 
>> > permission configuration in the ADSP driver?
>> > 
>> > Regards,
>> > Matthias
>> 
>> This patch is needed to fix a warning when implementing the ADSP access permission configuration in preloader.
>> 
>> [    0.334154] mtk-power-controller 10006000.syscon:power-controller: /soc/syscon@10006000/power-controller/power-domain@18/power-domain@19/power-domain@20: A default off power domain has been
>> ON
>> [    0.334246] ------------[ cut here ]------------
>> [    0.334252] top_adsp_bus already disabled
>> [    0.334274] WARNING: CPU: 5 PID: 113 at drivers/clk/clk.c:969 clk_core_disable+0x90/0xb0
>> 
>> If not for this case, the pm-domain works fine.
>> 
>> 
>> Best regards,
>> TingHan
> 
> gentle ping for this.
> from above descriptions, should I add the fixes tag to this patch?
> 

No that's not needed in this case. Applied now.

Matthias
