Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74EA765BF94
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 13:05:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233266AbjACMDu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 07:03:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237290AbjACMDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 07:03:40 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 18DCD300
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 04:03:39 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id n1so31585265ljg.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 04:03:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9rT7p/vx+MXGNP4uFxVvfXIdM9LVnEjrbHlhST8QvhU=;
        b=N0wtRI5Af5ePJfvRaOrcvvyHACrD4YZ6FvGAj8BuwC4id3dynTiTiI5xwV3j/S2mwu
         ehTCrfe/PsNhzwTwcfiggOhAe9+bfgWBbTGWkPn63pYQPnHU0GivxYQYt3H22uJHhlp0
         2JtxmsKpO+5egl8bF4oj7Oqg72MwxmYW4RqD7gpcILEopkmWHoHlUA9UlPrCklqqv7LW
         jJgJTYstYpvBdZJVnDClMySH2f4HDhJThSqScDRC3zPcXrvS3BLRua1KWRhe5BDKxJRe
         vt2uDUWgJwKvX1BFFnv308GDP8htr0vX4GDSR2DkBWe0WH10MhFuXCJR1sWttksPABqZ
         3aKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9rT7p/vx+MXGNP4uFxVvfXIdM9LVnEjrbHlhST8QvhU=;
        b=7fFz4JGJyUG0vI6nrsDNPdczkSaVFEZ6Lul4rRtjaB01+6zFbyWhQISRKQ5EwGEFqD
         f0szi4KO7Y4+r0W56w03Ok4yrVKWt+fut+cr3k3qnhM4+tEoqxl+49C+ioc+3XYTh8eO
         GHI5EsHgIrLN4Hq/rBFs5W2MTWbZ0nAWU5VHEew4vQ1lXE58iY2fvJ2/xi45KhPT7zNa
         6LElSVa6Sp7XDq5NGxZepX/jL30pVpjJXfvXsh5fPZGy7AEBnr+hC3APTUwt9bdHRxFa
         RVN8wtpT0sud1+NvnBP7GXXgr3GiF9AJHEbAeB3jtBMVzRQFgU/KW1AW0PkGjc0E/fAV
         ukrQ==
X-Gm-Message-State: AFqh2koOJbtX7vYbqMteL30E2RRLpyQQHokMXS7gj4r7jH3SuqkB+MEe
        t9Mb9Ybnw9z8PAlt/XqWhS08Sw==
X-Google-Smtp-Source: AMrXdXvpRXhCDQG9SS+pfrdZSp+RSL+QX1mijkuFUF7kNQnHYnUKDBWnrTvxl0eqe1twf/9gjkOngA==
X-Received: by 2002:a2e:80d7:0:b0:27f:d11c:3c78 with SMTP id r23-20020a2e80d7000000b0027fd11c3c78mr5538873ljg.36.1672747417478;
        Tue, 03 Jan 2023 04:03:37 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p10-20020a2eb98a000000b0027fecbaf044sm575294ljp.84.2023.01.03.04.03.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 04:03:37 -0800 (PST)
Message-ID: <abfddd5f-1491-0696-548d-2faec4568302@linaro.org>
Date:   Tue, 3 Jan 2023 13:03:35 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH V8 5/5] ASoC: dt-bindings: Add schema for "awinic,aw883xx"
Content-Language: en-US
To:     wangweidong.a@awinic.com
Cc:     alsa-devel@alsa-project.org, broonie@kernel.org,
        cezary.rojewski@intel.com, ckeepax@opensource.cirrus.com,
        devicetree@vger.kernel.org, duanyibo@awinic.com,
        flatmax@flatmax.com, james.schulman@cirrus.com,
        krzysztof.kozlowski+dt@linaro.org, lgirdwood@gmail.com,
        linux-kernel@vger.kernel.org, liweilei@awinic.com, perex@perex.cz,
        pierre-louis.bossart@linux.intel.com, povik+lin@cutebit.org,
        rf@opensource.cirrus.com, robh+dt@kernel.org, shumingf@realtek.com,
        srinivas.kandagatla@linaro.org, stephan@gerhold.net, steve@sk2.org,
        tanureal@opensource.cirrus.com, tiwai@suse.com,
        yijiangtao@awinic.com, zhaolei@awinic.com, zhuning0077@gmail.com
References: <aa0de3c8-d783-f8cc-42a9-7988acd6ab87@linaro.org>
 <20230103112703.382153-1-wangweidong.a@awinic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103112703.382153-1-wangweidong.a@awinic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 12:27, wangweidong.a@awinic.com wrote:
> Hi Krzysztof
> 
> On 30/12/2022 10:34, wangweidong.a@awinic.com wrote:
>>> From: Weidong Wang <wangweidong.a@awinic.com>
>>>
>>> Add a DT schema for describing Awinic AW883xx audio amplifiers. They are
>>> controlled using I2C.
>>>
>>> Signed-off-by: Weidong Wang <wangweidong.a@awinic.com>
>>> ---
>>>  .../bindings/sound/awinic,aw883xx.yaml        | 49 +++++++++++++++++++
>>>  1 file changed, 49 insertions(+)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
>>>
>>> diff --git a/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
>>> new file mode 100644
>>> index 000000000000..b677427ebcd1
>>> --- /dev/null
>>> +++ b/Documentation/devicetree/bindings/sound/awinic,aw883xx.yaml
>>> @@ -0,0 +1,49 @@
>>> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> +%YAML 1.2
>>> +---
>>> +$id: http://devicetree.org/schemas/sound/awinic,aw883xx.yaml#
>>> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> +
>>> +title: Awinic AW883xx Smart Audio Amplifier
>>> +
>>> +maintainers:
>>> +  - Stephan Weidong Wang <wangweidong.a@awinic.com>
>>> +
>>> +description:
>>> +  The Awinic AW883XX is an I2S/TDM input, high efficiency
>>> +  digital Smart K audio amplifier with an integrated 10.25V
>>> +  smart boost convert.
>>> +
>>> +allOf:
>>> +  - $ref: dai-common.yaml#
>>> +
>>> +properties:
>>> +  compatible:
>>> +    const: awinic,aw883xx
> 
>> Now the question what does "xx" stand for? I cannot find such product on
>> awinic website:
>> https://www.awinic.com/En/Index/queryAll/wd/aw883xx.html
> 
> xx represents our company's aw88394 and aw88395 chips,Aw88395 chips can be found on 
> https://www.awinic.com/cn/detail/index/catid/229/id/48/title/AW88395CSR.html
> The aw88394 chip will be available on the website in the near future.

OK, then it has to be changed. Wildcards are not allowed in compatibles,
so please use a specific compatible (oneOf for a case specific
compatible alone and for a case of two compatibles with fallback;
assuming the fallback is applicable to others).


Best regards,
Krzysztof

