Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EAC225FE662
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 02:41:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229724AbiJNAlN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 20:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJNAlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 20:41:10 -0400
Received: from mail-qk1-x734.google.com (mail-qk1-x734.google.com [IPv6:2607:f8b0:4864:20::734])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 079B0186D76
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:41:05 -0700 (PDT)
Received: by mail-qk1-x734.google.com with SMTP id 8so1582479qka.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 17:41:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:from:to:cc:subject:date:message-id:reply-to;
        bh=6hFp5tysAlAF4Lnf3vqpAVe0dIBxYdWJGwR/tuoTIDg=;
        b=M+c5y5QNzb8ODDXcvIlixUKeQgoJm+zMKiYNDenQnry+cTQQvjVGytF2kHdToBN8EG
         fPtAstFu5wNV5eKdGwUK5fwaTp+EdpXVqKfm1z7LpMSVsueC+IsPsUKdRWzKq27S8T/7
         wZLWZdzU49Ty4clQlHPH36F7Rn7Fqr6r04Dxg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:mime-version:user-agent:date:message-id:from:references
         :cc:to:subject:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6hFp5tysAlAF4Lnf3vqpAVe0dIBxYdWJGwR/tuoTIDg=;
        b=zl01d4ZyM9ZzFgleRIev1WuE9NWkxBagjN//WEJ+/983KFrApb3jY5RWnRXU8yq/w5
         ij2FVL2Be5qehNQ8J69xJowjU+/JNgA04le93Ku6coiT38B/qB+dIOeiumYk1XL0hH2H
         PzJKXL2+p7/LW3tAMMlRT6j5D/ngSPbw4Af4kmrASUr2huNO1eF4n8xmo/YwCmAtCImQ
         JVPif02brcmENDruq9mfh7kqLBJoWznsE00iGwJaJBHHWSdjqOlUnrlp3KU3LUK1LwfY
         C5BJ32GiEagj3XqkCiBTwcblEa1AEhtmmjNhOynMzOp3uymgDVJKUgnqUVeBZ+ZeH7Sa
         KN3g==
X-Gm-Message-State: ACrzQf070zIn9j4K2zfS6D5jhzL+rSkdiRsxU4LvGGuW701Gd3hoBVyO
        mpoj8cMPF354T4i6wv0Cl1T0IA==
X-Google-Smtp-Source: AMsMyM4FIcqkAhpmfqXQqy+D/jQfc1ZY4EAdY9zVTKz71SYns5y3Tly1aLlAInzakPC21L65pXfxkQ==
X-Received: by 2002:a05:620a:131b:b0:6ec:bce7:99a9 with SMTP id o27-20020a05620a131b00b006ecbce799a9mr2103436qkj.84.1665708065012;
        Thu, 13 Oct 2022 17:41:05 -0700 (PDT)
Received: from bcacpedev-irv-3.lvn.broadcom.net ([192.19.161.250])
        by smtp.gmail.com with ESMTPSA id fg25-20020a05622a581900b00399edda03dfsm1022574qtb.67.2022.10.13.17.41.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Oct 2022 17:41:03 -0700 (PDT)
Subject: Re: [PATCH] MAINTAINERS: git://github -> https://github.com for
 broadcom
To:     Palmer Dabbelt <palmer@rivosinc.com>, anand.gore@broadcom.com,
        kursad.oney@broadcom.com, f.fainelli@gmail.com,
        linux-arm-kernel@lists.infradead.org,
        linux-rpi-kernel@lists.infradead.org, linux-mips@vger.kernel.org,
        rjui@broadcom.com, sbranden@broadcom.com, rafal@milecki.pl,
        linux-pm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>
References: <20221013214639.31074-1-palmer@rivosinc.com>
From:   William Zhang <william.zhang@broadcom.com>
Message-ID: <4272edff-a2e5-2b50-5bc9-50b9a2224c50@broadcom.com>
Date:   Thu, 13 Oct 2022 17:41:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.4.0
MIME-Version: 1.0
In-Reply-To: <20221013214639.31074-1-palmer@rivosinc.com>
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="00000000000088a4b705eaf3e16f"
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--00000000000088a4b705eaf3e16f
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit

Hi Palmer,

On 10/13/2022 02:46 PM, Palmer Dabbelt wrote:
> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
> 
> Reported-by: Conor Dooley <conor.dooley@microchip.com>
> Link: https://github.blog/2021-09-01-improving-git-protocol-security-github/
> Signed-off-by: Palmer Dabbelt <palmer@rivosinc.com>
> ---
> I've split these up by github username so folks can take them
> independently, as some of these repos have been renamed at github and
> thus need more than just a sed to fix them.
> ---
>   MAINTAINERS | 14 +++++++-------
>   1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index f552f839dd32..3699b2256dc2 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -3951,7 +3951,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> -T:	git git://github.com/broadcom/stblinux.git
> +T:	git https://github.com/broadcom/stblinux.git
>   F:	Documentation/devicetree/bindings/arm/bcm/brcm,bcmbca.yaml
>   F:	arch/arm64/boot/dts/broadcom/bcmbca/*
>   N:	bcmbca
> @@ -3976,7 +3976,7 @@ R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> -T:	git git://github.com/broadcom/stblinux.git
> +T:	git https://github.com/broadcom/stblinux.git
>   F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>   F:	drivers/pci/controller/pcie-brcmstb.c
>   F:	drivers/staging/vc04_services
> @@ -3990,7 +3990,7 @@ M:	Ray Jui <rjui@broadcom.com>
>   M:	Scott Branden <sbranden@broadcom.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   S:	Maintained
> -T:	git git://github.com/broadcom/mach-bcm
> +T:	git https://github.com/broadcom/mach-bcm
>   F:	arch/arm/mach-bcm/
>   N:	bcm281*
>   N:	bcm113*
> @@ -4055,7 +4055,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> -T:	git git://github.com/broadcom/stblinux.git
> +T:	git https://github.com/broadcom/stblinux.git
>   F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
>   F:	arch/arm/boot/dts/bcm7*.dts*
>   F:	arch/arm/include/asm/hardware/cache-b15-rac.h
> @@ -4087,7 +4087,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	linux-mips@vger.kernel.org
>   S:	Maintained
> -T:	git git://github.com/broadcom/stblinux.git
> +T:	git https://github.com/broadcom/stblinux.git
>   F:	arch/mips/bmips/*
>   F:	arch/mips/boot/dts/brcm/bcm*.dts*
>   F:	arch/mips/include/asm/mach-bmips/*
> @@ -4226,7 +4226,7 @@ M:	Scott Branden <sbranden@broadcom.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
>   S:	Maintained
> -T:	git git://github.com/broadcom/stblinux.git
> +T:	git https://github.com/broadcom/stblinux.git
>   F:	arch/arm64/boot/dts/broadcom/northstar2/*
>   F:	arch/arm64/boot/dts/broadcom/stingray/*
>   F:	drivers/clk/bcm/clk-ns*
> @@ -4296,7 +4296,7 @@ M:	Florian Fainelli <f.fainelli@gmail.com>
>   R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
>   L:	linux-pm@vger.kernel.org
>   S:	Maintained
> -T:	git git://github.com/broadcom/stblinux.git
> +T:	git https://github.com/broadcom/stblinux.git
>   F:	drivers/soc/bcm/bcm63xx/bcm-pmb.c
>   F:	include/dt-bindings/soc/bcm-pmb.h
>   
> 

Acked-by: William Zhang <william.zhang@broadcom.com>

--00000000000088a4b705eaf3e16f
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
JOEwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEID4n5VXwTvxCS7LRp2wlrpS1Gqn2
Lz2HzdP27k8kmllRMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTIy
MTAxNDAwNDEwNVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZIAWUDBAEWMAsG
CWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEHMAsGCWCGSAFl
AwQCATANBgkqhkiG9w0BAQEFAASCAQAjkdS2uwVcRbz+UjhYAYEyBOOdnHq2AowKOpRaKfyB3UUo
pYO+mlp+ZkC7qdTmspjHQ+rmJGkp7Bm8Xkzc1/ZnErU5auo83B95gOpuL/PusyOmLr63ZOHAPmai
sYcKG6//X9RkUfqVHWKv3rtuevJfiXWXcYBhug5WWJpBQGHrTrfbbbncqijn2TYjkk3ODFvZIe+m
I1OnKws1U9PqMe4PPsElZnr0Sm8sj8TN3EPrLfdq/UNJthh/Fk9mguCatRFSnvn7rgU3WRy0Rjl7
eBs/Wgj1rg5kNKg6kVaZGi0m7tjsoxTCr16dIoDBfex0zf4zk5oU0XQkNCLrKqzJ5g1/
--00000000000088a4b705eaf3e16f--
