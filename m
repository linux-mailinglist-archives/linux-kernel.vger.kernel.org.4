Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A39BE6A1AD5
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Feb 2023 12:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbjBXLAf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 06:00:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjBXK76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 05:59:58 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D880025297
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:59:29 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id az36so1552867wmb.1
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 02:59:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gtukSA39Wi90XWdmVY6UvzBxv9KPhp2uRrC15iYduW8=;
        b=uL3hKxHp/QXQ6xxqZpfnK+ZdbFhkCtPTiyzqk/+yYqbn+VoDSiH8G17tejFKbj0sQG
         Sqxqsv9U29FgWliM0iUNMh8QMmfe7m9DuuPiMK+L6JA6+dosaBHnELPLJ2E4SDNYp5gZ
         Xh7I/W1eiRMc05fMDssPr1aqjVcNe51ksM4D8K/aP0aCFZpLtR/DJsBTgf7AKmhSp1N7
         RIqDEE3o7M9Bh0aAutn7Od3daPvzZws+YrkZbEnoHN1k8ZV+BoPZTiN6i9qvldYxjFYH
         8NIg61DZWB4NzDiw720CKy3j2CypXHe7yEz/z9iJt5d8PppT+7utXZjQNKjdbIeTL2p9
         FFzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gtukSA39Wi90XWdmVY6UvzBxv9KPhp2uRrC15iYduW8=;
        b=G89GzuggCg4kfQXz+FjZfw6hgqGnf78Migdx6DfTL8fKfbDm2a1BycBB7WKZuuwsZz
         BCo9s5kSjFmU5HpuIaUheq1iTGyNTh8Nw47X7QikH+u8ppfOAiDz3efp6oTdCJuMAxhG
         3A378gZMvMzQdmcxhnoDFNojwPeQzbVWaTbp/Q6zFC1efUrykNZwM35yPeB/ChsQ7xtG
         XSug5wNDmHnkbqkk2R+5uB+hb7wTUtybnLDRr38Q9EOj+1e3OFqVKGyU00rlFYllYsMh
         tInzj1N1fN6yTMuGimaPYNGMo/rWuqO5P9DbvAziSpB7irbJoW3hS9k/dJy/W+uRkIST
         VmMQ==
X-Gm-Message-State: AO0yUKWzKKCG61QgebZDPWyNYXNyhIRBEbfo7PBKblfJ2fRyoF2dVGBA
        gHlwa1VNQb876hwoY+Ejns1zoA==
X-Google-Smtp-Source: AK7set+6qCrCJhJWKul9+wwk0Sl1OQr5LMWEah+GmhryU62cpZOQqYSLbs7n6/2LMzNjVIRdKwXcvQ==
X-Received: by 2002:a05:600c:600f:b0:3dc:4316:52be with SMTP id az15-20020a05600c600f00b003dc431652bemr13299778wmb.10.1677236368402;
        Fri, 24 Feb 2023 02:59:28 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id k8-20020a05600c1c8800b003dec22de1b1sm2601864wms.10.2023.02.24.02.59.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 24 Feb 2023 02:59:28 -0800 (PST)
Message-ID: <0827a05c-117d-3d4c-2e3a-f8d80e256ca0@linaro.org>
Date:   Fri, 24 Feb 2023 11:59:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/4] ASoC: dt-bindings: wlf,wm8524: Add a property to
 specify power up sequency time
Content-Language: en-US
To:     Chancel Liu <chancel.liu@nxp.com>, Mark Brown <broonie@kernel.org>
Cc:     "lgirdwood@gmail.com" <lgirdwood@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "perex@perex.cz" <perex@perex.cz>,
        "tiwai@suse.com" <tiwai@suse.com>,
        "ckeepax@opensource.cirrus.com" <ckeepax@opensource.cirrus.com>,
        "patches@opensource.cirrus.com" <patches@opensource.cirrus.com>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
References: <20230222113945.3390672-1-chancel.liu@nxp.com>
 <20230222113945.3390672-2-chancel.liu@nxp.com>
 <Y/YPkgOreByREmOz@sirena.org.uk>
 <VI1PR04MB4222996DB8494FD14A1D5FCEE3A89@VI1PR04MB4222.eurprd04.prod.outlook.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <VI1PR04MB4222996DB8494FD14A1D5FCEE3A89@VI1PR04MB4222.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/02/2023 11:56, Chancel Liu wrote:
>> On Wed, Feb 22, 2023 at 07:39:43PM +0800, Chancel Liu wrote:
>>> This property specifies power up to audio out time. It's necessary
>>> beacause this device has to wait some time before ready to output
>>> audio after MCLK, BCLK and MUTE=1 are enabled. For more details about
>>> the timing constraints, please refer to WTN0302 on
>>> https://www.cirrus.com/products/wm8524/
>>
>> According to that the delay is a property of MCLK and the sample rate rather
>> than a per board constant, it shouldn't be in DT but rather the driver should
>> figure out the required delay on each startup.
> 
> I can't agree with you more. From the power up to audio out timing table in
> WTN0302, the delay depends on sample rate and MCLK. Driver should calculate it
> rather than read it from DT. However as I mentioned in my last email, values in
> the table seem not accurate for all systems. It's a kind of compromise to get
> the value from DT. Do other codecs have a similar situation?

DT is for hardware properties, not for software compromises.


Best regards,
Krzysztof

