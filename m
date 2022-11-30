Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3598963DCE1
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 19:14:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230314AbiK3SOw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 13:14:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230005AbiK3SNe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 13:13:34 -0500
Received: from mail-oa1-f52.google.com (mail-oa1-f52.google.com [209.85.160.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A75F283E97;
        Wed, 30 Nov 2022 10:13:32 -0800 (PST)
Received: by mail-oa1-f52.google.com with SMTP id 586e51a60fabf-12c8312131fso22006008fac.4;
        Wed, 30 Nov 2022 10:13:32 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lhAn2x63WZZ68iA2xviSqQVQpPqaz48S48picAsw7I0=;
        b=CZ+YvJBXFJlkCxmK35DJZM7omi7JUzVJHKy3FjCyMkyovIadq+gm4mehnqGqw3/Vcm
         6cVH9+UoT4sflCA7gMwFxgTXdK53YEe1U7CYU1MprKsOPGa0DqDW2wKn2uhqwylgTrEf
         FJkt5EzZ38qV+7tMji/s8fhoRZ6qWRxIQ4SlC7yXlpVTAf1Fne3s+hydMUW1VlFJyNzp
         sKS/DCsQc9TMEcVEl5RaZYqNDRYqfGZvfljG5FsiMyuOSSysMqxoTzlREVI2juHmP9gW
         SK3qicxuIcPHSYoXoulHwPF68sdYLJgXPvnOzaEU2Mhwom3j6QgBwERLLCZt6A9JuouM
         pNyg==
X-Gm-Message-State: ANoB5pmN/tKpgGVYQanVhks1BkikprEZKCtlWrgjjzU4JRXP2b0ynUTM
        S5aH70+pyazBP8o6dxiuGQ==
X-Google-Smtp-Source: AA0mqf6raFDKZhDuGHQdIUhYEFvXW5J36XxEkr5d0/apxVs4KAL5KdUum5LGSusaNhZUvpkRMlSBgw==
X-Received: by 2002:a05:6870:f110:b0:13b:7793:444c with SMTP id k16-20020a056870f11000b0013b7793444cmr35151635oac.59.1669832011901;
        Wed, 30 Nov 2022 10:13:31 -0800 (PST)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id v13-20020a4aaecd000000b0049fd5c02d25sm990051oon.12.2022.11.30.10.13.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Nov 2022 10:13:31 -0800 (PST)
Received: (nullmailer pid 2552194 invoked by uid 1000);
        Wed, 30 Nov 2022 18:13:30 -0000
Date:   Wed, 30 Nov 2022 12:13:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Icenowy Zheng <uwu@icenowy.me>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marc Zyngier <maz@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible for
 OpenC906
Message-ID: <20221130181330.GA2544489-robh@kernel.org>
References: <20221121041757.418645-1-uwu@icenowy.me>
 <20221121041757.418645-3-uwu@icenowy.me>
 <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
 <b924d37d716fa8b1fd93102b1d51fac221f43d59.camel@icenowy.me>
 <d0f3ce4f-5676-f5e1-f04f-dd069679b2d3@linaro.org>
 <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <81C2234E-C92D-4F78-8295-7C6DD0A9BBC4@icenowy.me>
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Nov 22, 2022 at 03:41:27PM +0800, Icenowy Zheng wrote:
> 
> 
> 于 2022年11月22日 GMT+08:00 下午3:35:48, Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> 写到:
> >On 22/11/2022 08:18, Icenowy Zheng wrote:
> >> 在 2022-11-21星期一的 11:06 +0100，Krzysztof Kozlowski写道：
> >>> On 21/11/2022 05:17, Icenowy Zheng wrote:
> >>>> T-Head OpenC906 is a open-source-licensed fixed-configuration of
> >>>> C906,
> >>>> which is now public and able to be integrated.
> >>>>
> >>>> Add a compatible for the CLINT shipped as part of OpenC906, which
> >>>> should
> >>>> just be ordinary C9xx CLINT.
> >>>>
> >>>> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> >>>> ---
> >>>>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
> >>>>  1 file changed, 1 insertion(+)
> >>>>
> >>>> diff --git
> >>>> a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >>>> b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >>>> index aada6957216c..86703e995e31 100644
> >>>> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >>>> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> >>>> @@ -35,6 +35,7 @@ properties:
> >>>>            - const: sifive,clint0
> >>>>        - items:
> >>>>            - enum:
> >>>> +              - thead,openc906-clint
> >>>>                - allwinner,sun20i-d1-clint
> >>>
> >>> Add entries sorted alphabetically. This should be squashed with
> >>> previous
> >>> patch.
> >> 
> >> I make it a seperated patch because I think it's a questionable
> >> approach.
> >> 
> >> If you think it's okay, I will just squash it and put it as the second
> >> patch in the next iteration, with adding openc906-plic as the first
> >> one.
> >
> >What is a questionable approach? Why commit msg is not saying this?
> 
> Ah I mentioned it in the cover letter. The problem is just I doubt whether
> binding strings for single SoCs are necessary.

They are.

Unless all the quirks/bugs/features are somehow guaranteed to be exactly 
the same as other SoCs sharing the same compatible string, or there is 
another mechanism to identify the exact version (e.g. a version 
register).

Rob
