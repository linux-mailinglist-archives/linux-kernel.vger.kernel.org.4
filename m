Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9B9569FBFE
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 20:23:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232461AbjBVTXQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 14:23:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229907AbjBVTXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 14:23:14 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E53069EE1;
        Wed, 22 Feb 2023 11:23:13 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id d1-20020a17090a3b0100b00229ca6a4636so10240593pjc.0;
        Wed, 22 Feb 2023 11:23:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/+MihbsfqNGbC8V1xZOT+sAmGSmrwYI74wB0NYPcrY4=;
        b=fgYbRBRouct5e35X/XBZCKpGh+JCXlFLESgc2L0lObjuiPt48EkY+XTx8CEeZYGplk
         jPqiT77bsTikevGF8OG6yDpc5gghp6FrKp5tL3k+fA8aqqluCdTEyGSBCUVudJorCzcL
         CA/YjM0LPdaRA/sn1aFPEMYAW35RG1RXOJeQdAbu2R4kSXy9DwC5Rxv0xNycLmMB0jB/
         uz8dqanVZJ0Fd6FdlLbKlraLYGaW0HP1CWqIKn0nmiWzOklEJpMMWxlZnhkOkJy+PsR6
         14C5nf+RqD0XKBkY4qv9QPY/jpTRqGDlW2mbUKD0OG3ByJoVNB+MrEG37blWg36kCu3q
         9kUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/+MihbsfqNGbC8V1xZOT+sAmGSmrwYI74wB0NYPcrY4=;
        b=TGB9xoKiQosWUYLx3WTaqQPo748cdU1rWHUPqRisgXbA/e1k6SB508FxrGC54UIte7
         JmdXXjAVeO9GgvGkKLnS6vKkRSzVvksmJwPjRQeFG4yhU17qSzGav/+8bOUBp3Pn/hkq
         qyLbYQx/oQoLRCt5DvMPWz71PbtshtsOIZkVHpic7R5XnVYjM+zWiBCFm02bKSHDHL3V
         O4zT7oV1iPZEj0PsvMOi84JkLfGf/AulvaJ3hGUdmGlgXYDOmUYi/9I1ALenGukOGLO3
         urpTyoz8Wo+DA3LXkZ+kNj/qNZpnqX+mJ1KX9MEmTCpeOK/0tTPjarza+y3LG7QlI6et
         yjrw==
X-Gm-Message-State: AO0yUKVmHhHWhLLIokYMvfqNOm6XtsKL2+tNG/WYGpNCI3dzE5Wig2Il
        FWnqYyJOLyEwWksEIlteRl4=
X-Google-Smtp-Source: AK7set/0gigFPfWa6WnvSP0ECmk5QxKjVdXFrdckGdG+TDf0jf0PALdCxm+gyHLawinpwHxOF+3Oyw==
X-Received: by 2002:a17:90b:164f:b0:234:6df2:3b4e with SMTP id il15-20020a17090b164f00b002346df23b4emr10335522pjb.6.1677093793145;
        Wed, 22 Feb 2023 11:23:13 -0800 (PST)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id i6-20020a17090a138600b0022be36be19asm4875234pja.53.2023.02.22.11.23.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 22 Feb 2023 11:23:12 -0800 (PST)
Message-ID: <57d37b74-a295-373c-16d4-644c4fa14e86@gmail.com>
Date:   Wed, 22 Feb 2023 11:23:06 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v2 03/16] thermal: Remove debug or error messages in
 get_temp() ops
Content-Language: en-US
To:     Daniel Lezcano <daniel.lezcano@linaro.org>, rafael@kernel.org
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Amit Kucheria <amitk@kernel.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Markus Mayer <mmayer@broadcom.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Heiko Stuebner <heiko@sntech.de>,
        "moderated list:BROADCOM BCM7XXX ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Rockchip SoC support" 
        <linux-rockchip@lists.infradead.org>
References: <20230221180710.2781027-1-daniel.lezcano@linaro.org>
 <20230221180710.2781027-4-daniel.lezcano@linaro.org>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <20230221180710.2781027-4-daniel.lezcano@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/21/23 10:06, Daniel Lezcano wrote:
> Some get_temp() ops implementation are showing an error or a debug
> message if the reading of the sensor fails.
> 
> The debug message is already displayed from the call site of this
> ops. So we can remove it.
> 
> On the other side, the error should not be displayed because in
> production that can raise tons of messages.
> 
> Finally, some drivers are showing a debug message with the
> temperature, this is also accessible through the trace from the core
> code in the temperature_update() function.
> 
> Another benefit is the dev_* messages are accessing the thermal zone
> device field from the structure, so we encapsulate even more the code
> by preventing these accesses.
> 
> Remove those messages.
> 
> Signed-off-by: Daniel Lezcano <daniel.lezcano@linaro.org>
> Reviewed-by: Miquel Raynal <miquel.raynal@bootlin.com> #Armada

Acked-by: Florian Fainelli <f.fainelli@gmail.com> #brcmstb_thermal.c
-- 
Florian

