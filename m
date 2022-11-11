Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2FD4962566B
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 10:17:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233194AbiKKJRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 04:17:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233108AbiKKJRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 04:17:32 -0500
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89DB5C18;
        Fri, 11 Nov 2022 01:17:31 -0800 (PST)
Received: by mail-wr1-x429.google.com with SMTP id l14so5668974wrw.2;
        Fri, 11 Nov 2022 01:17:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=W/ebyNNdcssi3hRRYLWpmNEf5xWYN6pzQQIYvDfsfC0=;
        b=qB5rci9QMrKNx876F44YgKr3R228CBhLq9v3pbCwJc6tBdSVts7vh42/c4ZMxGiZgU
         jgjCfPMbKLRruHboDGI616o2VvVtcMZvEWRC9N8fX/ZyRMyq0+O4obDGn5xrnsqrIhq1
         NPHu9oISiqsywzGBKOTzIm631IKK2fwM3sgRhvs2W6lTsvJe+sg42I8Yyzs4tHI8prRW
         My070S3eIN2kiRBRO1x79gFnoLJXChcxAdeWJxYyJ85VvXHZJMkSkKxnMx6qY/rCJ6Ig
         nLQoPH64AbanLHHPC/pKYCaH6H2zAsupzYr7G+fMe3JTj9GG2ddz62vT33uvqzSbXPfq
         KR4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:from:references:cc:to
         :content-language:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=W/ebyNNdcssi3hRRYLWpmNEf5xWYN6pzQQIYvDfsfC0=;
        b=NkhF++HyrV6quMa883kzxbwIzKrEMFKBlqf6GebpXwRem96a4UgfUheZLTCfOxAkS7
         qAM/G9+1iJ9fPT6Ue4E20Ub56XU93fgS+vqvs9S55xDb+F8vc/8FIf1WGm64zTMERlJK
         gPbHYxkcbWgsDQhoK7kuMPQL5JIc2OTpKKVYc+ORh20xAUMZibFYjlYPifMiq1eL51WC
         wxM31DoXomv7rbZfyraYWg+xqTPFnivNBRB9BpS4wTUuAWBis36Geae7Vp1aG7kDqRA6
         ymG58mCDPSecbWRlS2Ki2OS5KKKPi74c9F6YR3YoxjHai6GBA7oDlRVB4lM4L5bR5StT
         +yMg==
X-Gm-Message-State: ANoB5pmRBE89t4l6IGJJdLqANU1HN/LCvKsfgJkQ3qtlMrm04LPG9ayG
        YvqBbvGGa2PDJ+Dud2DVJY0=
X-Google-Smtp-Source: AA0mqf4mn3Vis0rrN5zFsq6rDmS+s0zkcStXU1hOp+ETfbY9sTiViasujU9Aebr+C2Vt5S6xmmK25Q==
X-Received: by 2002:a5d:4ec3:0:b0:22e:3180:f75a with SMTP id s3-20020a5d4ec3000000b0022e3180f75amr672361wrv.340.1668158250141;
        Fri, 11 Nov 2022 01:17:30 -0800 (PST)
Received: from [192.168.1.131] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id b15-20020adff24f000000b002345cb2723esm1390242wrp.17.2022.11.11.01.17.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 01:17:28 -0800 (PST)
Message-ID: <a34fd2d5-b7ed-2fea-7a6c-acc7659cb001@gmail.com>
Date:   Fri, 11 Nov 2022 10:17:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Content-Language: en-US
To:     Frank Wunderlich <frank-w@public-files.de>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Frank Wunderlich <linux@fw-web.de>
References: <20221106085034.12582-1-linux@fw-web.de>
 <trinity-e9c6aa94-6656-4d9c-9d9b-90ede6c8e6fc-1668099812662@3c-app-gmx-bs29>
From:   Matthias Brugger <matthias.bgg@gmail.com>
Subject: Re: Aw: [RFC v3 00/11] Add BananaPi R3
In-Reply-To: <trinity-e9c6aa94-6656-4d9c-9d9b-90ede6c8e6fc-1668099812662@3c-app-gmx-bs29>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 10/11/2022 18:03, Frank Wunderlich wrote:
> Hi Rob,
> 
> can you please take Patches 1+3 of v1 into your tree?
> due to reordering in my tree i missed them in this version
> 
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=685798
> 

They should go through the subsystem maintainers trees. I'd advise to resend, 
dropping the RFC prefix and add the corresponding maintainers.

Regards,
Matthias

> pcie-bindings are here:
> 
> https://patchwork.kernel.org/project/linux-mediatek/list/?series=690172
> 
> i found 1 error in bpi-r3 dts (properties from sfp1 not plural) which i will fix in next version and will drop
> the compile comment in dt overlays.
> 
> also i've found this commit:
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/robh/linux.git/commit/?h=dt/next&id=363547d2191cbc32ca954ba75d72908712398ff2
> 
> so maybe i need to rename my overlay dts files to dtso?
> 
> maybe the others can be applied (at least the mt7986 nodes)?
> 
> regards Frank
