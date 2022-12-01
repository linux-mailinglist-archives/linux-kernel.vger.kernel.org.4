Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E073D63EB4E
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 09:41:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229676AbiLAIli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 03:41:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbiLAIlf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 03:41:35 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8CA865BB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Dec 2022 00:41:33 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id q7so1064436ljp.9
        for <linux-kernel@vger.kernel.org>; Thu, 01 Dec 2022 00:41:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=8rfgJ9QknK0MbQgAWzuzypV2KA7EE9D4Q3QePGfyw50=;
        b=pLqeTL9I8Ynl8+m01CI3TXOD5Clc683rk/kTgYPB10lPttqq5wrYZX5fy6uMB5bcIL
         Q9Cb+uuHbCU29BY7VnV5c9c69dyrKJiOnX4lfdoiwJzkpBzuhjQ/nxNKBjj0pVGuLdQ7
         6seh9XDNhhFvBwvrnGxskhFy6Y+sC0oSkhj4BgVTNukF3vRb0uDCjqcvJNHfkR58Nkky
         kxxc8DZAtnzYvLyEHkISrnL58ujEEXgprNI/o3vEHSLOl1hfgc3FdMLTIeeLbjk0gR4C
         pIRFGfV2eTjEDvpiUBihngsh3eLZddfnQzMcMFidHqGQFE7ZMGKPR7JyGXSUaZGt65jX
         b/Vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=8rfgJ9QknK0MbQgAWzuzypV2KA7EE9D4Q3QePGfyw50=;
        b=MJweUp0nrtQpZ6rMBfjQkZbjUJ0XJ/kvQfSySzaPu3itxf1KGgyhPGdtErVApR0+CB
         nlHLJE+d7p9w1H/xzeOwSYCqnvneWFMi2aEo5gexGIA7MDefgiyFinP9Ohr3+srOIlt7
         zDbN1WrSoJom9SDXmRAc6Hm27TBcCikmKE5Cy5Y6LnumIqBYMmLSOzPJUmtvNQ9HYC8z
         3/4vVR5QzPLofGia+JbkqQajEHcK7XMcHosMVxP+QHBA8qirUnGYpn4MxDMXHwf8GgKe
         aUJobq8dj558Yw8ofMX17F5oALQMeGX/tT4UT2QW8DCJTRtQnAbHsNijD49hiqTcCG0q
         sriA==
X-Gm-Message-State: ANoB5pkXScVd3M/d7WakHO7lk6KE6pu1GcAB1kcWx1IeXLrHbPFXtbuk
        0ish3VYyawA3CfBsmUDB4E4=
X-Google-Smtp-Source: AA0mqf7ITWlTk3AHP9k4F31qto94qdeue5OQdSgwjEJSBqfseuIyGBBoGz2T5XLny7Dg0nkeIcHEmQ==
X-Received: by 2002:a2e:7e0a:0:b0:277:6f0:5239 with SMTP id z10-20020a2e7e0a000000b0027706f05239mr15945498ljc.186.1669884092070;
        Thu, 01 Dec 2022 00:41:32 -0800 (PST)
Received: from ?IPV6:2001:14ba:16f3:4a00::b? (dc75zzyyyyyyyyyyyyygt-3.rev.dnainternet.fi. [2001:14ba:16f3:4a00::b])
        by smtp.gmail.com with ESMTPSA id t27-20020ac2549b000000b0049a4862966fsm568047lfk.146.2022.12.01.00.41.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 00:41:31 -0800 (PST)
Message-ID: <2e4f97e9-a8e7-8afc-612d-a9d2c2e47ce6@gmail.com>
Date:   Thu, 1 Dec 2022 10:41:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: [PATCH RESEND2 v4 2/2] drm/meson: dw-hdmi: Use
 devm_regulator_*get_enable*()
To:     neil.armstrong@linaro.org,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        dri-devel@lists.freedesktop.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <cover.1669799805.git.mazziesaccount@gmail.com>
 <df0096b5aea2a18d1540cde379c5abf589ccd7c4.1669799805.git.mazziesaccount@gmail.com>
 <7b7a7e34-af6a-cb09-e094-e42e45f45b8b@linaro.org>
Content-Language: en-US
From:   Matti Vaittinen <mazziesaccount@gmail.com>
In-Reply-To: <7b7a7e34-af6a-cb09-e094-e42e45f45b8b@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/1/22 10:38, Neil Armstrong wrote:
> On 30/11/2022 10:23, Matti Vaittinen wrote:
>> Simplify using the devm_regulator_get_enable_optional(). Also drop the
>> now unused struct member 'hdmi_supply'.
>>
>> Signed-off-by: Matti Vaittinen <mazziesaccount@gmail.com>
>> Martin Blumenstingl <martin.blumenstingl@googlemail.com>
> 
> Missing Acked-by, I'll add it while applying.

Oh, well spotted. I should've been more careful.. Sorry and thanks for 
sorting it out!

--Matti

-- 
Matti Vaittinen
Linux kernel developer at ROHM Semiconductors
Oulu Finland

~~ When things go utterly wrong vim users can always type :help! ~~

