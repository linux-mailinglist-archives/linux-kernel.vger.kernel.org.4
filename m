Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBC9A7067AB
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 14:11:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231245AbjEQMLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 08:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231441AbjEQMLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 08:11:16 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F39841BD6
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:10:56 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-965ddb2093bso101709166b.2
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 05:10:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684325455; x=1686917455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+x6r3IIUPaVfdz3ckKR69Gh4SRffmi8bAzNAdga+kH0=;
        b=g9etghIHULCUB5dLxvJ867ni22v5bCYCdoHbs+DHlwS66SJjBW5h7N5hnJACC7xdcm
         oif1L9aQWpC9bfHCdUIJVSpOhVowIGH/TFZIIa7/O2pR35+r+wQrj2ilGNc0jHS19Wm5
         Lqk1IX0mzDhzMRvvT6l4s77LLORWTQGaHgfGkL+VrShqkREhmpSvQm1fQzeizgYsagRQ
         22byKxMp0MXFU96dSZbJN44zE6+BBFABZ8iyHlMvsnzdY/M1C9iNT73Ds0eS47Po1u6e
         UAxKmcFiweXIxbWjOU5Xn1ta8e71jReRseXdXSEJvyjY76YkRPUtM1e3ZLU0krEo3wtm
         9q5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684325455; x=1686917455;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+x6r3IIUPaVfdz3ckKR69Gh4SRffmi8bAzNAdga+kH0=;
        b=DkHpU7v2H3yvudK+SJ7GMevZ938W4MFc6A07c2BOrcdJ8jhW3hIAF1aBVEeFssnfdt
         ePCKBHk0v4vLxxJlVZQRqQNVh/ajTNVV6/RXSW7hF5/R8OvqClKwDM7LvhAgeB0UtJFU
         2ejqmxOSnj0SNTaanssItn7oX03BQ9Z+FnVqnFhbrBkmfQ8zfoPsMc9P4P0h0X/lR7oE
         FubUUY4g8qNBkHGj2JXX6e+OMJ9OWScUqBZQK4rxKm7ha8MROFaEg354yXpSEQ5SlCOj
         B620DUsj9h+vFMnOKlypTmQs4DQZJelfU66r3jx54iO1ZxOKNdBHxmLi16Q3OO9i6J3P
         dDJQ==
X-Gm-Message-State: AC+VfDxg2/x3akzc+pOTaXJ750tNwM0dkVWF1CF/x4CI0IWV6X+1I0uP
        rvJiLG6jcbO1EtfyUjwTAlkMbQ==
X-Google-Smtp-Source: ACHHUZ5kJAHtQFVwaq6UYaLFeEGlGPVUQsVabhMawGDHhcH+hCEfMqxeOyXdxc5r0x4KUUUR/Ht05A==
X-Received: by 2002:a17:907:3e88:b0:94a:6f0d:38a4 with SMTP id hs8-20020a1709073e8800b0094a6f0d38a4mr2901502ejc.7.1684325455446;
        Wed, 17 May 2023 05:10:55 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c9ff:4c84:dd21:568d? ([2a02:810d:15c0:828:c9ff:4c84:dd21:568d])
        by smtp.gmail.com with ESMTPSA id jl21-20020a17090775d500b00965b5540ad7sm12488962ejc.17.2023.05.17.05.10.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 05:10:54 -0700 (PDT)
Message-ID: <41c72642-7d46-d7d1-d49a-6bef685f934c@linaro.org>
Date:   Wed, 17 May 2023 14:10:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] arm64: dts: microchip: add missing cache properties
To:     Steen Hegelund <steen.hegelund@microchip.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230421223155.115339-1-krzysztof.kozlowski@linaro.org>
 <151169f7-dcdb-47f1-9616-67c3c388a233@linaro.org>
 <7772a5981d9a3d46056a53997162d1d75d22a701.camel@microchip.com>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <7772a5981d9a3d46056a53997162d1d75d22a701.camel@microchip.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 17/05/2023 13:38, Steen Hegelund wrote:
> Hi Krzysztof,
> 
> I would love to do that, but I am not familiar with the procedure, so maybe you
> could help me out?

Hm, there is no dedicated maintainer for Microchip ARM64 platforms? I
mean one which actually handles the patches?

It looks like it, because my recent changes were going through me. This
also means that maybe several other changes got ignored. For example:

https://lore.kernel.org/all/20230221105039.316819-2-robert.marko@sartura.hr/

https://lore.kernel.org/all/20220420194600.3416282-1-michael@walle.cc/

and others here:
https://lore.kernel.org/all/?q=dfn%3Aarch%2Farm64%2Fboot%2Fdts%2Fmicrochip%2F



> 
> This is my understanding of what I need to do:
> 
> Clone the upstream repo listed in MAINTAINERS:
> 
> git clone git@github.com:microchip-ung/linux-upstream.git
> cd linux-upstream
> git checkout sparx5-next
> 
> Fetch the latest mainline tag from upstream:
> 
> git fetch git://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git tag\
>  v6.4-rc2 --no-tags
> 
> Rebase the current branch on top of that tag:
> 
> git rebase v6.4-rc2
> 
> Use b4 to fetch and apply the mail thread patch series:
> 
> b4 shazam -tsl 20230421223155.115339-1-krzysztof.kozlowski@linaro.org

You should collect some more patches... For one patch it is probably too
much effort. I can take it instead.

> 
> Tag the current work for inclusion in the next kernel version with a decription:
> 
> git tag -s sparx5-dt-6.5

git tag -a -s sparx5-dt-6.5

Because you need to provide some explanation. Take a look at examples
from other sub-arch maintainers what to write in the tag:

https://lore.kernel.org/soc/20230410170233.5931-1-andersson@kernel.org/T/#u

https://lore.kernel.org/soc/20230405080438.156805-1-krzysztof.kozlowski@linaro.org/T/

> 
> Push work that to the public repo:
> 
> git push origin sparx5-dt-6.5
> 
> Create a pull request (to stdout) to be included in an email to the maintainers:
> 
> git request-pull v6.4-rc2 origin sparx5-dt-6.5
> 
> Send this PR to the maintainers and CC co-maintainers.
> 
> Is this the correct procedure?
> Who should I send the PR email to (is there a list somewhere)?

Yes, it's correct with few nits I mentioned.

You send it to arm@, soc@, Olof and Arnd. Addresses are in examples above.

I will be preparing today the pull with various cleanups for arm-soc, so
I will take the patch if you do not mind.

For future (and all previous patches), please think what do you
(you=Microchip) want to do with it. If you do not handle the patches,
then someone should or the platform should be marked as "Odd fixes".

Best regards,
Krzysztof

