Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F7986CB734
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 08:33:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbjC1Gc3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 02:32:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229935AbjC1Gc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 02:32:26 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8337ED7
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:32:24 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id w9so45329821edc.3
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 23:32:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679985143;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=l7Ds9OPbWWvKWNUXw3BzQf8ZpVZp2Ib3MYCGER5HxUc=;
        b=a+xFTb2CPn0Pg13SMJkKxCmJBtfRv/qQmijSrQnlbwpob+J88zOt3YVX1rhhjzOZX/
         SpJ6dIx0WhYI8XFklhKPuK3Qa3EuDWywHT+wAjm7QwubbtVOk0H20dwdDTqU76owU7e1
         DyAm+w4LJ79ONyZzX7l90oLN9qwhHpzZLSJELtrzqSfUD60YiEMa12QExlG9SctV/3My
         JKx6A/YMwUIolb286yEYjshV5hzZsR1xcuqC7OF4NwDE2faCaHLulh6ZFwSCJ+jocUyS
         Ec6c0WdZ0phYbIQmNDwWeIvLnqeTBMnc6Dp3OuWen0+MdDpICAymznx/oo37q1S9wown
         CAlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679985143;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=l7Ds9OPbWWvKWNUXw3BzQf8ZpVZp2Ib3MYCGER5HxUc=;
        b=DQlfMVdbN6DH5I7RLIblpf37ZIFEKOMFXGg/Ywp3fMeNaLke5E6YvywByelxFkBqR4
         og3zHyTQmh4l+Jp7pXtYtQt+jqFerxEkHMpr8SLZAgl+8IQHHotCHae8jTfXaeetIVTn
         yPbhucHUbSXf6MVK2pdpIH0WhgbN9nlqlUcsghNJOMzkzkoY+tHU6NcFg20Ismpdzxbh
         7UAGzkp3v2+JPNxQFfQxU6gWryfvGlN5QeZb7jyMOz1j5ohdQb3uA2By6VfH9sHBo3Gr
         Gqp7kJQkfjVSXg6Zpd4uAF1sf/uaU7zdss3GVu5Tk9VyJgUtCX45tNV0CtuOXh8ywfg4
         yFew==
X-Gm-Message-State: AO0yUKUJlgar9ZMnLhk1+mQixpqtXruU7P8+IJCWL8eS4JvBXffC0Ipz
        SYEGHviTMw99rZ5Wa9uMGrsDWePAK9KNKLivoLE=
X-Google-Smtp-Source: AK7set/HTa4U3ix2pfhSUqdWxXnVuo8wE9wAajGZPZ5fhRrBHDzCVoYnG03Bu8vw05CkbzRDqObKaQ==
X-Received: by 2002:a17:907:2bc7:b0:8ab:b03d:a34f with SMTP id gv7-20020a1709072bc700b008abb03da34fmr21018711ejc.12.1679985143046;
        Mon, 27 Mar 2023 23:32:23 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9e92:dca6:241d:71b6? ([2a02:810d:15c0:828:9e92:dca6:241d:71b6])
        by smtp.gmail.com with ESMTPSA id f22-20020a170906825600b00925ce7c7705sm14843911ejx.162.2023.03.27.23.32.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Mar 2023 23:32:22 -0700 (PDT)
Message-ID: <4fcb67bf-aa12-61c3-ca30-3fb11eaba67a@linaro.org>
Date:   Tue, 28 Mar 2023 08:32:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: mips: lantiq: Document Lantiq SoC dt
 bindings
Content-Language: en-US
To:     Aleksander Bajkowski <olek2@wp.pl>, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-mips@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230326122942.870990-1-olek2@wp.pl>
 <3871e958-79aa-2b4c-3300-270a2eb8f8e8@linaro.org>
 <b3e0502b-61d0-430e-8832-dbbec69035a5@wp.pl>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <b3e0502b-61d0-430e-8832-dbbec69035a5@wp.pl>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/03/2023 23:21, Aleksander Bajkowski wrote:
>>> +properties:
>>> +  $nodename:
>>> +    const: "/"
>>> +  compatible:
>>> +    oneOf:
>>> +      - description: Boards with Lantiq Amazon-SE SoC
>>> +        items:
>>> +          - const: lantiq,ase
>> This does not look like proper board compatible. Boards have almost
>> always minimum two compatibles - one for SoC and one for board. With
>> commit msg this just adds to confusion...
>>
> 
> The added dt-binding contains only the SoC part. The compatible strings
> for individual boards will be added later together with the dts files. Before
> sending the dts files I want to document current bindings and clear
> checkpach warnings about undocumented strings.

Which is incomplete and inaccurate documentation. Instead, document
proper, full compatibles.

Best regards,
Krzysztof

