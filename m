Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD9E0690285
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 09:54:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjBIIxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 03:53:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229550AbjBIIxw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 03:53:52 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A50053E5E
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 00:53:51 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id l21-20020a05600c1d1500b003dfe462b7e4so3761235wms.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Feb 2023 00:53:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l5y/lhUdrwmVTQsjBWST0jsa/VEAXBndCCvJ3Ss9nl0=;
        b=jJ8GHpG5opwaKmvBVdBJ8hjVp1FujZRP8vtZjQaozd3gMS3i3CfMTWWn5G764k9WsO
         t26wh+lFnsmUMhAoq4xGic2R37rcMU0tcU2Gwj7IUKFx1LrZsh3ln1irfnILVVfBMCG2
         9ehqdSIkA5phIg2zWzAbNkievBhA7QMEtO9nK0NRa098B/HGMrQAM/5Kk5Dmp2F+TcV9
         gjzGIN8TwfuiV24Yl/rwVvNVbF0kbkLxefbn39qe/vBPMjFHrM/n0Xgdr8h765s0q++a
         /FE27shEXZvVgGHw1BPfH6wvkImKaH+8brQSWF6qzyCvBNjI2v+QpJW883RmAIjx1bsF
         HP8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l5y/lhUdrwmVTQsjBWST0jsa/VEAXBndCCvJ3Ss9nl0=;
        b=SrVfUkZ2fwFxHyGjhDkyfE2X7vD/aDDgi00zV/YInm6YcpnjzrWVxjtz25rOpkp5Xk
         n1CKiiOZro8/+adu7sYO0wA9eSpxV75+ehhGIIMZaGAgUO7zECiJQJJaIjyxaxpDsZzj
         Y+0bJcKn79tw+FSE2rWMZ815pELfVTXhm55t3sKqP9Xhk0TY3TYyd/+raWqr+ZPGWcj7
         DrKdC9psIPX7cB7r7cgWpvXRo+coFZkSZlGhiv4SNpPRQXdz/C+NADHOMMZhInCORlZ6
         ia+fBpjaUSP4usuLrxcvPdbIxjoOQPuT7sUu/vKeD+Bmo8C/IZbS/e/iUchVWQ5GJHFf
         /xCg==
X-Gm-Message-State: AO0yUKXgKbLGuD4iUWm++zEhgmgnZNdXjOQAEJHJbU2A8KbpLXoIfPO8
        ttLdhm29Iq73VbGMlrrUg1pylQ==
X-Google-Smtp-Source: AK7set942EB9Jb29ks+FpmiTWa1FyKDdc2GHg0NYJV+La/gDtKTu6Gdj9I8FuRlj2RlpihjeGBhQWg==
X-Received: by 2002:a05:600c:331a:b0:3dd:f286:5ae9 with SMTP id q26-20020a05600c331a00b003ddf2865ae9mr9399968wmp.9.1675932829783;
        Thu, 09 Feb 2023 00:53:49 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id q3-20020a1ce903000000b003dfdeb57027sm4274596wmc.38.2023.02.09.00.53.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Feb 2023 00:53:49 -0800 (PST)
Message-ID: <9b20bdb2-64e0-4888-e8df-fdf1b021c445@linaro.org>
Date:   Thu, 9 Feb 2023 09:53:47 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 4/4] ASoC: cs35l41: Document CS35l41 shared boost
Content-Language: en-US
To:     Lucas Tanure <lucas.tanure@collabora.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        Charles Keepax <ckeepax@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>
Cc:     alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        patches@opensource.cirrus.com, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230209083726.1337150-1-lucas.tanure@collabora.com>
 <20230209083726.1337150-5-lucas.tanure@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230209083726.1337150-5-lucas.tanure@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/02/2023 09:37, Lucas Tanure wrote:
> Describe the properties used for shared boost configuration.
> Based on David Rhodes shared boost patches.

No improvements in subject, I asked twice for it. What does the command,
I gave you, print?

> 
With fixed subject:

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

