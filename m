Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEDDC5B6BE9
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 12:47:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231707AbiIMKru (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 06:47:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231731AbiIMKrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 06:47:43 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48AA35F13E
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:47:41 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id h8so13133171wrf.3
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 03:47:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=1vy5STKK7f2y0rHKknJzg204tlai8/pL9+x/aTilWa4=;
        b=y8QCjmtDE47p1BAtUXGN2yQIZAcmaJ61+b7F9i515kKieNrhrgZTikmvyl/ZZr91E8
         GNrxgDg0CdYHIHlAMueh2s0tzvenU1I51AtqOyKeRuVd3uhXMIYjwaQQjUm9vpzEze53
         EERNxUrk0yi/nwKNFPxIp4sePzGMl9VtUKRDxAsahptVMKMM2qWs9q4swesa+E2128O7
         j39WBrwgBg3rNB+MbEU0n3PGR2ZPiz56MehEPiDwJL/ewwfJT3mcrqYhkrWt8Io78VVK
         N4Gu+SRUmj6lhh/Vk35jIzMn7lOgPA+OyG1z6dtIPhGLw9Rl4ZyFa4MftUZSVg+jRfjF
         zAtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=1vy5STKK7f2y0rHKknJzg204tlai8/pL9+x/aTilWa4=;
        b=7PPVBDP+n4SeExSnrcd3QXxoxZUQSfS8lGNEuAH2cd7MwpVAQA/PP6ucle80LNyEdm
         RNZEJgoKn7iqpzCxlrjmti+EIYMwJ020EMTqITRhupOFuj2bNp/7uPDaBPgnBzuqvYgM
         AIdjmE+pzvTzj5mGImZ3Pa7vdXFz9Qk7M22iSGXNzHhGalv4tVJ+jhjfP50Uk34l4jK1
         qhCO7+BIDASomPteeEYA/KT1Xa4ZBz7WKFtt81Wpj7UR7qv5HUmkphVezHCZT63pyEfg
         06yPYP4Q8RFy+CVOHlT7jB4SsM5D8/ojy5qY4FUluY+1aCg9yvr84MMmRibHGCdJwVJc
         h8MA==
X-Gm-Message-State: ACgBeo1+/W1F2xDutuUVPNwetPA+XOoyTq5h/5Vwy0hfWWfDrcdZw140
        V5ExoF5NGOGZIiNiebTgPqSnyQ==
X-Google-Smtp-Source: AA6agR6RNyW1z8wsPDHR+Ec99QlY1hPpXtYXHddNwCA4ZFovERfZatAC3wk48ltJhAjQzzIsHRfrzg==
X-Received: by 2002:adf:fc02:0:b0:22a:43e8:d205 with SMTP id i2-20020adffc02000000b0022a43e8d205mr10522868wrr.420.1663066059775;
        Tue, 13 Sep 2022 03:47:39 -0700 (PDT)
Received: from [10.119.22.201] ([89.101.193.70])
        by smtp.gmail.com with ESMTPSA id n17-20020a5d4c51000000b0021eed2414c9sm10387270wrt.40.2022.09.13.03.47.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Sep 2022 03:47:39 -0700 (PDT)
Message-ID: <c6d4fb3e-9907-cda2-90d8-cfa21e8ebd41@linaro.org>
Date:   Tue, 13 Sep 2022 12:47:38 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH V3 0/2] clk: imx: introduce fsl,always-on-clocks
Content-Language: en-US
To:     Marco Felsch <m.felsch@pengutronix.de>,
        "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
References: <20220913092136.1706263-1-peng.fan@oss.nxp.com>
 <20220913102957.sir37bsdr5sayxal@pengutronix.de>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220913102957.sir37bsdr5sayxal@pengutronix.de>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/09/2022 12:29, Marco Felsch wrote:
> Hi Peng,
> 
> On 22-09-13, Peng Fan (OSS) wrote:
>> From: Peng Fan <peng.fan@nxp.com>
>>
>> V3:
>>  Rename to fsl,always-on-clocks 
>>
>> V2:
>>  Use protected-clocks
>>  https://lore.kernel.org/all/20220816130327.2987710-1-peng.fan@oss.nxp.com/
>>
>> V1:
>>  Use fsl,protected-clocks
>>  https://lore.kernel.org/all/20220815033632.1687854-1-peng.fan@oss.nxp.com/
>>
>> There are two cases that I wanna this property could serve:
>> Virtualization: root cell linux run in parallel with inmate cell
>> AMP: M7/4 runs in parallel with A53
>>
>> The major case is:
>> Jailhouse hypervisor only support partition, so devices are partitioned.
>> But there is only CCM module that provides clock, the CCM is handled by
>> root cell linux, need make sure the root cell linux not shutdown the
>> clocks using by inmate cell.
>>
>> I was thinking whether need to provide a rate entry to ask root cell
>> configure the clk rate for inmate cell. But NXP downstream not have it,
>> see https://source.codeaurora.org/external/imx/linux-imx/tree/drivers/clk/imx/clk-imx8mp.c?h=lf-5.15.y#n690
>> So just leave the property as uint32-array.
> 
> Can you please check my recent proposal? I recently stumbled over such
> an issue on the mx8mm-evk as well but with the 32k clock provided by the
> pmic. Unfortunately I forgot to add you to the to list, I will change
> that. If that proposal will fix your problem, I would like to go the
> generic way.
> 
> https://patchwork.kernel.org/project/linux-clk/list/?series=676522

Your proposal does not change bindings. You cannot introduce new
properties without documenting them in the bindings.

Unless you documented them somewhere, but this is no reflected in
Patchwork at all.


Best regards,
Krzysztof
