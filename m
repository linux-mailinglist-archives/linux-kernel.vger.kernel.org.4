Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDDE62022E
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 23:15:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231993AbiKGWPN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 17:15:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231172AbiKGWPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 17:15:11 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 569C020191;
        Mon,  7 Nov 2022 14:15:06 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id g7so18695283lfv.5;
        Mon, 07 Nov 2022 14:15:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xzjpq5XPZvUD1SGRN0dO+XiFdKDQrabShm+K+q5Ki74=;
        b=XBd6JY1zQ1jDCiVBcrndeR6XrFo2gkNsWZFCretTY7V6BlBQq3Qq90GaX667+nxIKx
         mqM9y7Syg9ejqJqUSkaorL7zVunEoVLL1GlnrRp7ErsgCt+2qvFXC2jSl/YwoCbbCYe/
         emSbC7Q0XVbDkh2ilajtJYq6lvK1SxUAIlZ+M8V7l0I7ao4/yqMgFhqMFEZFqzfaxu+2
         JjvwifrgsfRObcGwZUDm9HJAzhqajXCLIPd0XC+oc/7vvCclhoHV1Pv4rZIwut0/0tTP
         KKpqVqncp2VSOJgZUMfu272wnsu1zBvLTUQngAZfRAm1nYmcT7z5t8wvmXdbCbvnHyIA
         fxPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xzjpq5XPZvUD1SGRN0dO+XiFdKDQrabShm+K+q5Ki74=;
        b=v7HL6jtprc5g+yyzjjUw+Ny4hdZZUY4ZhKeUM+uQAzaESWHZyVUgWMJOuy0VO9o5pq
         MOaQNn72Yxovp5pvm4qqW/BxgmO3/LI+Vqbgcy6hQyqR5tkJS1CAQ2sQdp5u22WEwlBZ
         tlGXnbedryReg8x8AseuMGEHS7hv3VhYPh32uUPaokDNZf530rbSrfTS2BokzBgRo9EI
         xaNyuaKZQ8fg0vrwmQOtc+ZOBi8eKiDblUn9qPKybCN3BQ64i5EpzzR5DRVqXRdx7MF/
         rw0ha5aShvFFunO9a7CoTppLKLMSRQrxUqVrecZUeJbG6lMcKGYAkmL81b/HyOypeKQx
         sYtg==
X-Gm-Message-State: ACrzQf1rOYmis2ASNYwrHFNuHfM+Z54GsI3vq7LGn3h5dtt07MYyA4Yd
        aQoK1BAxG1qnFwnfgMhRiJdaomFtN+MlYw==
X-Google-Smtp-Source: AMsMyM7VdmDB8EzyWj8i1ytIbkn9jf4VHBv0i//kMsDQbCCPQdGTX839TbiafUUQ96vta+sjCGqQGw==
X-Received: by 2002:ac2:52a3:0:b0:4b1:785c:7a56 with SMTP id r3-20020ac252a3000000b004b1785c7a56mr8745635lfm.187.1667859304550;
        Mon, 07 Nov 2022 14:15:04 -0800 (PST)
Received: from [192.168.0.251] (dsl-hkibng42-56733b-36.dhcp.inet.fi. [86.115.59.36])
        by smtp.gmail.com with ESMTPSA id f8-20020a2ea0c8000000b0025ebaef9570sm1436436ljm.40.2022.11.07.14.15.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 07 Nov 2022 14:15:04 -0800 (PST)
Message-ID: <fb155814-2e95-3f3b-0826-2c9aed8d0a63@gmail.com>
Date:   Tue, 8 Nov 2022 00:15:00 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: linux-next: build failure after merge of the qcom tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andy Gross <agross@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Rayyan Ansari <rayyan@ansari.sh>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
References: <20221108090018.44624610@canb.auug.org.au>
Content-Language: en-US
From:   =?UTF-8?Q?Matti_Lehtim=c3=a4ki?= <matti.lehtimaki@gmail.com>
In-Reply-To: <20221108090018.44624610@canb.auug.org.au>
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

Hi,

This happened because one of the dts patches in the patch series which 
contained "ARM: dts: qcom: msm8226: Add CCI bus" was not applied when 
the other two dts patches were applied qcom tree. The patch number 1 
"ARM: dts: qcom: msm8226: Add MMCC node" in that patch series 
(https://lore.kernel.org/linux-arm-msm/20221002122859.75525-1-matti.lehtimaki@gmail.com/T/#m920039b455ad024249d000332d1f07f9e4c19008) 
is required for that "ARM: dts: qcom: msm8226: Add CCI bus".

-- 
Matti Lehtimäki

On 8.11.2022 0.00, Stephen Rothwell wrote:
> Hi all,
> 
> After merging the qcom tree, today's linux-next build (arm
> multi_v7_defconfig) failed like this:
> 
> arch/arm/boot/dts/qcom-msm8226.dtsi:302.21-327.5: ERROR (phandle_references): /soc/cci@fda0c000: Reference to non-existent node or label "mmcc"
> 
> Caused by commit
> 
>    4ab2f41b0850 ("ARM: dts: qcom: msm8226: Add CCI bus")
> 
> I have used the qcom tree from next-20221107 for today.
> 
