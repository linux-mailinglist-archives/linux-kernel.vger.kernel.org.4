Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 287B962ED7C
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 07:09:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229451AbiKRGI6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 01:08:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231768AbiKRGIz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 01:08:55 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAEAF58BFB;
        Thu, 17 Nov 2022 22:08:54 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id k2-20020a17090a4c8200b002187cce2f92so2209343pjh.2;
        Thu, 17 Nov 2022 22:08:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=f1/9CyA/O/ffk/WiLLBbijHh3undgK2iph5RhrshJgM=;
        b=ZGb+G5BgLZYRveyI+o9fJn5GxmvDjIYMmnZqG5Z1fsvqC75MUFvchqEr2FgEPIn+6h
         0cfqfTF+WPWKlHMaDz45TpWWenvEWtrWthl5EbYyK8x2VtxhSj0ub1/2kZ98XyK49B33
         lyVPX3cI1ktc1uiO8KMiAvx6UZWLEwqZl9uZCfpH1glB4SqytvTy8eLOIrKvdINDk7au
         vMslP2yqbuBAkOIVNqyyurv6FTbbdV8SFbv8mezeKHbM6C3JpdmvwjQhur8iFm5iZTd/
         swKJbHYgzOt0OpFQhFo7jE4KpDoW42FMoraIKzEBDSJWJZX2BgSdLKs8D15D4pgmWdVL
         nUMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=f1/9CyA/O/ffk/WiLLBbijHh3undgK2iph5RhrshJgM=;
        b=f0OOb8q1B8LuWidc7fkqQ6KVkJZ+Q+LQ7TLC57jtumC/LepmDq3J/R4v7cl90MNwnB
         YcIUs8in3yXcYC+dJuF5uMxmRnVqfyo8g8TSxnBF9TkwB033sze1evbaloyHbMuyCVqZ
         TcvlMEcdC54DYq9EWIeB0y9Zi8Y6ErV9eDxvvLxpyLfFVx6rBCqcm/KytXU5r9NH9c1G
         QK5FCKAHGSeR+902LzaATGKyhTdv0ygmfvrg7QZIOvpImTKOh526Qtb3A72Y11PoTagG
         i5jp/FWp025BqtQ4mg+P+MBvaIXz/v5SzKwMXhMRIgHD5HysicEBdnlMRMKelb+a57Up
         NKNw==
X-Gm-Message-State: ANoB5pnEJxs69v/RhRNHHpSQFd/kptOY4G81Cr5eBSAXguG4e/t8OqOq
        0Y4YRNdDfu7bgAAZLrW33V0=
X-Google-Smtp-Source: AA0mqf5bBM/zQclPqWbgyWJyKksOjHrLKvrLvP782+r1jZPbC/4yYuW15tHmNp+/2JQ+cJo/YDAhmQ==
X-Received: by 2002:a17:902:b58c:b0:188:64b7:e433 with SMTP id a12-20020a170902b58c00b0018864b7e433mr6193855pls.17.1668751734099;
        Thu, 17 Nov 2022 22:08:54 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:e4c5:c31d:4c68:97a0])
        by smtp.gmail.com with ESMTPSA id jg15-20020a17090326cf00b001868d4600b8sm2556448plb.158.2022.11.17.22.08.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 22:08:53 -0800 (PST)
Date:   Thu, 17 Nov 2022 22:08:50 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     "Lin, Meng-Bo" <linmengbo0689@protonmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Markuss Broks <markuss.broks@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Henrik Rydberg <rydberg@bitmath.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        Nikita Travkin <nikita@trvn.ru>, linux-input@vger.kernel.org,
        devicetree@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [RESNED PATCH 1/3] dt-bindings: input/touchscreen: Add
 compatible for IST3038 and IST30XXB
Message-ID: <Y3chclOgvZSDqRGu@google.com>
References: <20221117191436.87938-1-linmengbo0689@protonmail.com>
 <20221117191436.87938-2-linmengbo0689@protonmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221117191436.87938-2-linmengbo0689@protonmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 07:15:03PM +0000, Lin, Meng-Bo wrote:
> From: Markuss Broks <markuss.broks@gmail.com>
> 
> Imagis IST3038 and IST30XXB are variants (firmware?) of Imagis IST3038 IC,
> add the compatible for them to the IST3038C bindings.
> 
> Signed-off-by: Markuss Broks <markuss.broks@gmail.com>
> [Change from IST3038B to IST3038 and IST30XXB]
> Signed-off-by: Lin, Meng-Bo <linmengbo0689@protonmail.com>
> ---
>  .../devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml  | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> index e3a2b871e50c..85390f6ffe36 100644
> --- a/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> +++ b/Documentation/devicetree/bindings/input/touchscreen/imagis,ist3038c.yaml
> @@ -18,7 +18,9 @@ properties:
>  
>    compatible:
>      enum:
> +      - imagis,ist3038
>        - imagis,ist3038c
> +      - imagis,ist30xxb

I do not believe wildcard compatibles are allowed.

Thanks.

-- 
Dmitry
