Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 17C706D9030
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 09:10:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234972AbjDFHKZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 03:10:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235362AbjDFHKR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 03:10:17 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF15AD1E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 00:09:54 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id t10so146847638edd.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 00:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680764984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yc9Xvq+z5mbuXb3hSjcOx0+2lF1uMWYl+pWLfV4JER0=;
        b=QkzsACok/1Sni8jj0r4LfW0kSqPlKfomfvcLFAqY/8+wPN2iAPUMQDvDsnpzZ2a8dl
         OrbTJ8DnxlvjZPg9tx/bjyMU7hMcYLjtBoYP/11PrtRgfxc496fOqRaL6j+nMjxbqRzc
         an9SU748kO3qMcNuNCBJVQwRCemtYT5umtRg0lxgFfjEbdvNm7lEQkgTkdrJ9ChFNp5L
         C9jtBUE6pmatQA7SBQ0CkGAbj1z04qFguKVND7e8o9aEjTYXC9xzT9xTSSHZjxQDeIoL
         XkyHWRrbpbrUJfjYuF9Jb0CsDTGSELl2YflsC85EDaC3SRBC2UER5idovmntKf26qU5K
         lnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680764984;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yc9Xvq+z5mbuXb3hSjcOx0+2lF1uMWYl+pWLfV4JER0=;
        b=ZAPLdGBLDg00Kopf3S87YjeYLdMhcc7ovwDYugeooxEf5uZqdPMlBNCWYC57/EDmg3
         wYgr5Lk8mI4Xa1dqF2nX1FIUn/7Cc77TguuqGhwjSQ/cEG6PhHErHJCSlIPdDqnvxhSO
         FW86t7JRf5JJ3z+y5s8zVc4fsbSE9f5FyBNwNuyiPmyY8mFqEgzF+pCrOGiQuFYZ0t+j
         3dYNf4Ibf/vvg5X0qS3oCGREqXC1Gq1ZILCczR8HY1A0skD9m1y2kMf/9DSNGsDKc/bE
         sT/rb3xVqsqG85toI03UX6059TJtIwkKI+6xvQHOC1/v1F3w9dVj/4V16R/yHt1MhKcr
         8Dzw==
X-Gm-Message-State: AAQBX9dyGnYje2uHMwxPjKStl8iKlK6kgQpPaBmVhLv2a98h9AUsrHci
        SnkaYB8s054CAzMsZL0Bx6D+QQ==
X-Google-Smtp-Source: AKy350Zp1l1KeFsRGmVCa9OnDanG64NjDJaLJSZDT21j8lyW/hwaEqXRHjxJS3SKJj6dXAYUhstz2w==
X-Received: by 2002:a17:906:209d:b0:947:405a:955f with SMTP id 29-20020a170906209d00b00947405a955fmr5394149ejq.31.1680764984065;
        Thu, 06 Apr 2023 00:09:44 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id q18-20020a1709063d5200b0093237bd4bc3sm401755ejf.116.2023.04.06.00.09.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 00:09:43 -0700 (PDT)
Message-ID: <4c1b8ab9-ab03-639a-78e7-ca75131ecc81@linaro.org>
Date:   Thu, 6 Apr 2023 09:09:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] ASoC: dt-bindings: wm8904: Convert to dtschema
Content-Language: en-US
To:     Daniel Baluta <daniel.baluta@gmail.com>,
        Rob Herring <robh@kernel.org>
Cc:     Saalim Quadri <danascape@gmail.com>, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, daniel.baluta@nxp.com,
        robh+dt@kernel.org, broonie@kernel.org,
        patches@opensource.cirrus.com, alsa-devel@alsa-project.org,
        linux-kernel@vger.kernel.org, lgirdwood@gmail.com
References: <20230405200341.4911-1-danascape@gmail.com>
 <168074344623.1301612.621743725976519280.robh@kernel.org>
 <CAEnQRZBCN6JrjvaJSD5dnuLXOUyx8Y9LOucY_Fwqcf4ZZLuwJg@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAEnQRZBCN6JrjvaJSD5dnuLXOUyx8Y9LOucY_Fwqcf4ZZLuwJg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 08:40, Daniel Baluta wrote:
> On Thu, Apr 6, 2023 at 4:24 AM Rob Herring <robh@kernel.org> wrote:
>>
>>
>> On Thu, 06 Apr 2023 01:33:41 +0530, Saalim Quadri wrote:
>>> Convert the WM8904 audio CODEC bindings to DT schema
>>>
>>> Signed-off-by: Saalim Quadri <danascape@gmail.com>
>>> ---
>>>  .../devicetree/bindings/sound/wlf,wm8904.yaml | 66 +++++++++++++++++++
>>>  .../devicetree/bindings/sound/wm8904.txt      | 33 ----------
>>>  2 files changed, 66 insertions(+), 33 deletions(-)
>>>  create mode 100644 Documentation/devicetree/bindings/sound/wlf,wm8904.yaml
>>>  delete mode 100644 Documentation/devicetree/bindings/sound/wm8904.txt
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings.
>>
> So, these properties are present in some dts files! We need to
> evaluated if they are always expected
> or can be optional.

I assume the DTSes are tested when you submit new DT schema conversion...

Best regards,
Krzysztof

