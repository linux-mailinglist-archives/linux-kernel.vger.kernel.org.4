Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A68C6613D16
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 19:07:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229853AbiJaSHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 14:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230088AbiJaSHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 14:07:22 -0400
Received: from mail-qk1-x72f.google.com (mail-qk1-x72f.google.com [IPv6:2607:f8b0:4864:20::72f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6BB63140E1
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:06:04 -0700 (PDT)
Received: by mail-qk1-x72f.google.com with SMTP id k2so2534452qkk.7
        for <linux-kernel@vger.kernel.org>; Mon, 31 Oct 2022 11:06:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=78KPfhfKGtzpVGcIl/WQmrQFxWHRNHbPQ80eSHDTJPo=;
        b=TldePd4mj4CYUNGoLKrHXsvH4BwV8ltPCNNYDFHx8XlqWSdT8UNfO/1IPpSkc4PFW0
         oCg+M9AhO4RlyTJulYBT2ecLOmVhvmoYlhCoFaDM7QRZZjbvCaIT+rI0jdBy5XlXRb4E
         i449IvKU2H2VOLBTgXa39PghC0ujUhDuXfUsY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=78KPfhfKGtzpVGcIl/WQmrQFxWHRNHbPQ80eSHDTJPo=;
        b=KPGOJCUqHTIHMlR+KpA/NPx+oKmfqqKAvT/YsTCrCB/o0xQQ+HF7+fIcmsTNCjK1Ap
         znNIZ0A+TbBEmBBVHZQFocZyagRca0Z0LDqwwma4yVkEdpfXAh9TNPc9iSlvd93J+tZs
         iGlCbo95sBybkd5gJ8hdD44SgG87/+FlCCw6FgS5Tt7HpIN/HwJiXF9Tz3LZj+DJP5pd
         SO/3iCgtLzfAHkoEfi2iaAvBOB7IexAgc8qijkNZVK1wNnu5JtoBgXk+9d5KZHIu8zzh
         1CJjzqQ254zONLTTA4JyNi/t8o0aSUo6aJn0nMEARIgKsZPZuiDnKjFaeyMutD/t8Sdg
         QhFw==
X-Gm-Message-State: ACrzQf2YnCS4pggRKd75CFHtX50lL95254qZ8pRWFF2pWC+NleSrqupL
        qqJV56AWknv7BWsKQtelmgciOw==
X-Google-Smtp-Source: AMsMyM5PQn3zfC+DI5K/43ZM1nZ68AColPlYGVhrjBVhnPvG/bmR1eaYL+B5glx07pex4Yufqki/CA==
X-Received: by 2002:a05:620a:4246:b0:6d3:e126:447a with SMTP id w6-20020a05620a424600b006d3e126447amr10381971qko.604.1667239563295;
        Mon, 31 Oct 2022 11:06:03 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id d14-20020ac851ce000000b003996aa171b9sm3892514qtn.97.2022.10.31.11.06.00
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 31 Oct 2022 11:06:01 -0700 (PDT)
Subject: Re: [PATCH 05/20] arm64: dts: Update cache properties for broadcom
To:     Pierre Gondois <pierre.gondois@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     Rob.Herring@arm.com, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20221031091938.531810-1-pierre.gondois@arm.com>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <a885301e-9105-83d1-13aa-8620b100d7a9@broadcom.com>
Date:   Mon, 31 Oct 2022 11:05:59 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20221031091938.531810-1-pierre.gondois@arm.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="000000000000f30e5a05ec58754f"
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--000000000000f30e5a05ec58754f
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit



On 10/31/2022 02:19 AM, Pierre Gondois wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes
> 
> The recently added init_of_cache_level() function checks
> these properties. Add them if missing.
> 
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>   arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi   | 1 +
>   arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi    | 1 +
>   arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi   | 1 +
>   arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi   | 1 +
>   arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi    | 1 +
>   arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi    | 1 +
>   arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi    | 1 +
>   arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi    | 1 +
>   arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi | 4 ++++
>   9 files changed, 12 insertions(+)
> 
> diff --git a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
> index 967d2cd3c3ce..5035a3cc90e0 100644
> --- a/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcm4908/bcm4908.dtsi
> @@ -63,6 +63,7 @@ cpu3: cpu@3 {
>   
>   		l2: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
> index 3d016c2ce675..d5bc31980f03 100644
> --- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm4912.dtsi
> @@ -51,6 +51,7 @@ B53_3: cpu@3 {
>   
>   		L2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
> index 04de96bd0a03..6f805266d3c9 100644
> --- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63146.dtsi
> @@ -35,6 +35,7 @@ B53_1: cpu@1 {
>   
>   		L2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
> index 13629702f70b..b982249b80a2 100644
> --- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm63158.dtsi
> @@ -51,6 +51,7 @@ B53_3: cpu@3 {
>   
>   		L2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
> index c3e6197be808..a996d436e977 100644
> --- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6813.dtsi
> @@ -51,6 +51,7 @@ B53_3: cpu@3 {
>   
>   		L2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
> index 0bce6497219f..62c530d4b103 100644
> --- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6856.dtsi
> @@ -35,6 +35,7 @@ B53_1: cpu@1 {
>   
>   		L2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
> index 29a880c6c858..ba3d5a98ccbc 100644
> --- a/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/bcmbca/bcm6858.dtsi
> @@ -50,6 +50,7 @@ B53_3: cpu@3 {
>   		};
>   		L2_0: l2-cache0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
> index fda97c47f4e9..18cdbc20f03f 100644
> --- a/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/northstar2/ns2.dtsi
> @@ -79,6 +79,7 @@ A57_3: cpu@3 {
>   
>   		CLUSTER0_L2: l2-cache@0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> diff --git a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> index 8f8c25e51194..e05901abe957 100644
> --- a/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> +++ b/arch/arm64/boot/dts/broadcom/stingray/stingray.dtsi
> @@ -108,18 +108,22 @@ cpu@301 {
>   
>   		CLUSTER0_L2: l2-cache@0 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   
>   		CLUSTER1_L2: l2-cache@100 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   
>   		CLUSTER2_L2: l2-cache@200 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   
>   		CLUSTER3_L2: l2-cache@300 {
>   			compatible = "cache";
> +			cache-level = <2>;
>   		};
>   	};
>   
> 

Acked-by: William Zhang <william.zhang@broadcom.com>

Thanks Pierre!

--000000000000f30e5a05ec58754f
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
YDZuuBJwnyCzevMoPtVYPharioL5H3BRnQi8YoTXH7/uRo33dewYFm474yFjwwnt82TFtveVZkVq
6h4WIQ4wTcwFfET8zMkELnGzS5SHCl8sPD+lNxxJ1JDZYwIDAQABo4IB2zCCAdcwDgYDVR0PAQH/
BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3VyZS5nbG9i
YWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEGCCsGAQUF
BzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWduMmNhMjAy
MDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93d3cuZ2xv
YmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6hjhodHRw
Oi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNybDAlBgNV
HREEHjAcgRp3aWxsaWFtLnpoYW5nQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggrBgEFBQcDBDAf
BgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUq65GzwZxydFHjjYEU/9h
xHhPWlwwDQYJKoZIhvcNAQELBQADggEBAA2hGG3JPAdGPH0ZdohGUCIVjKz+U+EFuIDbS6A/5jqX
VhYAxZlzj7tSjUIM7G7IhyfqPC46GKJ/4x+Amz1Z6YxNGy71L68kYD6hIbBcA5AM42QBUufly6Oa
/ppSz3WoflVyFFQ5YXniZ+eU+2/cdnYZg4aVUnFjimOF5o3NfMLzOkhQNxbaDjFUfUYD8hKmU6v4
0vUBj8KZ9Gi1LIagLKUREn8jku0lcLsRbnJ5Ey5ScajC/FESPyYWasOW8j8/1EoJksmhbYGKNS6C
urb/KlmDGfVrIRYDbL0ckhGQIP5c6L+kSQZ2sHnQK0e0WgIaZYxaPYeY5u0GLCOze+3vyRMxggJt
MIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52LXNhMTEwLwYD
VQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwxuh2XG3FXRL1W
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEIK/lnzehJPcm13wDrB0SVtCpol+G
tXp9/bWGqFUlO3jsMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MTAzMTE4MDYwM1owaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQBZ6efvoZ6c28Mz8e0GxxOpHcv/Y3BMqktEfoJLcEZumevx
z4yZpk/RJtvg7F/kbq4UQjbEh+zYQHDU/lTZ561svKQPWcHjKSNrtlAfeXAvKrJbuk6Q/4LaTvX/
obeUAIELPm1seXi2DcsarMQM339YSZojLzKR/qJZ+91PZG4OD2Lc1iKufncq3r7B8DvTeYVcl1cH
9hVvp/Q8PP/TQ/JzXJUhkFM4P9hooYPEVqXT0Blqm8nJNoKiSPvpnm80LMq8p52tezrFTjpXNNu5
hkmjMkZAxyK3z1vCLcLruyFr5w2r6Gj5LuQpCWB1fTRN4DPE4p+GZaq7N2ifuEIwy3OZ
--000000000000f30e5a05ec58754f--
