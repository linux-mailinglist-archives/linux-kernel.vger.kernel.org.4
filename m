Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 563A0705B54
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 01:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbjEPX2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 19:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229456AbjEPX2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 19:28:22 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8312D5E
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:28:20 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id 6a1803df08f44-6238200c584so764796d6.3
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 16:28:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=broadcom.com; s=google; t=1684279699; x=1686871699;
        h=mime-version:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to;
        bh=FtPfD9ExEFxFi1hWs9ibqo40KA2OASbEAUanONhrIPI=;
        b=cLwpdBzd8SZOIKgVjJRLISzX4lRq0/SW7cURqvBNvLUbaQqiNn7/RvDJE1ExhQeLrr
         F2lVG+Gkj7ptjw1G/YQBR63wxzZom85C1Tvz1ZJ+dzRo3EanspiCPztYtSNbkawi9Yeb
         dQJy7hxkHp2aAvr6GmU4hBUZBEPsx4O0feXNo=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684279699; x=1686871699;
        h=mime-version:message-id:date:subject:cc:to:from:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FtPfD9ExEFxFi1hWs9ibqo40KA2OASbEAUanONhrIPI=;
        b=JKBfMcISygISTMmF2DnDhrmGW+Dl34bU5sUk8257+BfUpgXt8TA+aRTHv3YSNV0UJM
         ZI+3nTX5468QrWory7PXAHLsD4ZYxIwc37dHTt6DKSsjmrX3eHeE4Q1CT4jMBmyC3L/r
         8Gij1PRcXQqt7/8SeKwGwAARjQHFBLrCEkgl34R0EjahMOA7SuLROMCqVBexhk0Q2zit
         25se7/X+S9IvTPIfVFs297snvjhKDjpr0mtBGGMOxBH1kqvqNQ+6XWHgiPmv6EwiK9NX
         PokFPDykt63alZ5HUAwyd5f1qqjYVsEFaOVXDfpjKNZZVGUG83m4eJYAG+o+vBCyfAwv
         VIkA==
X-Gm-Message-State: AC+VfDxsAL/EVnojk2nWczPpbwEVYBkVvFhsa2n7F6Ftm/bsadhgiaXv
        8mEpXObjEK6JiYjZkgVp6QnEKZItlM2TE7aBCVvl19j54BiEvtKTYs95CFaQysYz8N+mZAqxzd+
        2IwESUurVBefHZ5eeC79DcfX1swLEE/gG0SoiYKq60aUQ95oGVRj0Q82eBXEmUb1A9+/VDyUkr6
        3HwZfsa0BVHPjT2I4ULA==
X-Google-Smtp-Source: ACHHUZ4sHhC468dw4b343RpyoHMyaU9XRDHtUVNad5E/xBp3kROBJIRbq02FblVZy2g/iHsWY6WFtA==
X-Received: by 2002:ad4:5cce:0:b0:5fe:dffc:fefa with SMTP id iu14-20020ad45cce000000b005fedffcfefamr59915478qvb.41.1684279698987;
        Tue, 16 May 2023 16:28:18 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id m5-20020a0c9d05000000b005ef442226bbsm5960126qvf.8.2023.05.16.16.28.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 May 2023 16:28:18 -0700 (PDT)
From:   Florian Fainelli <florian.fainelli@broadcom.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-arm-kernel@lists.infradead.org,
        bcm-kernel-feedback-list@broadcom.com,
        Florian Fainelli <florian.fainelli@broadcom.com>
Subject: [PATCH] MAINTAINERS: Replace my email address
Date:   Tue, 16 May 2023 16:28:05 -0700
Message-Id: <20230516232806.2922593-1-florian.fainelli@broadcom.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha-256;
        boundary="0000000000002f6daa05fbd7ed3e"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--0000000000002f6daa05fbd7ed3e
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Switch to the corporate email address for Broadcom related entries.

Signed-off-by: Florian Fainelli <florian.fainelli@broadcom.com>
---
All,

I intend to take this via the new Broadcom ARM SoC pull request to
minimize the risk of conflicts with changes to these entries that might
be queued up. Thanks!

 MAINTAINERS | 28 ++++++++++++++--------------
 1 file changed, 14 insertions(+), 14 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e2fd64c2ebdc..58af49115b98 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -3896,7 +3896,7 @@ S:	Supported
 F:	drivers/net/ethernet/broadcom/b44.*
 
 BROADCOM B53/SF2 ETHERNET SWITCH DRIVER
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 L:	netdev@vger.kernel.org
 L:	openwrt-devel@lists.openwrt.org (subscribers-only)
 S:	Supported
@@ -3907,7 +3907,7 @@ F:	include/linux/dsa/brcm.h
 F:	include/linux/platform_data/b53.h
 
 BROADCOM BCM2711/BCM2835 ARM ARCHITECTURE
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-rpi-kernel@lists.infradead.org (moderated for non-subscribers)
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -3921,7 +3921,7 @@ N:	bcm283*
 N:	raspberrypi
 
 BROADCOM BCM281XX/BCM11XXX/BCM216XX ARM ARCHITECTURE
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 M:	Ray Jui <rjui@broadcom.com>
 M:	Scott Branden <sbranden@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
@@ -3960,7 +3960,7 @@ F:	Documentation/devicetree/bindings/pinctrl/brcm,bcm4908-pinctrl.yaml
 F:	drivers/pinctrl/bcm/pinctrl-bcm4908.c
 
 BROADCOM BCM5301X ARM ARCHITECTURE
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 M:	Hauke Mehrtens <hauke@hauke-m.de>
 M:	Rafał Miłecki <zajec5@gmail.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
@@ -3972,7 +3972,7 @@ F:	arch/arm/boot/dts/bcm953012*
 F:	arch/arm/mach-bcm/bcm_5301x.c
 
 BROADCOM BCM53573 ARM ARCHITECTURE
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 M:	Rafał Miłecki <rafal@milecki.pl>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -3987,7 +3987,7 @@ S:	Maintained
 F:	drivers/usb/gadget/udc/bcm63xx_udc.*
 
 BROADCOM BCM7XXX ARM ARCHITECTURE
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
 S:	Maintained
@@ -4007,7 +4007,7 @@ BROADCOM BCMBCA ARM ARCHITECTURE
 M:	William Zhang <william.zhang@broadcom.com>
 M:	Anand Gore <anand.gore@broadcom.com>
 M:	Kursad Oney <kursad.oney@broadcom.com>
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 M:	Rafał Miłecki <rafal@milecki.pl>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-arm-kernel@lists.infradead.org (moderated for non-subscribers)
@@ -4048,7 +4048,7 @@ S:	Maintained
 F:	drivers/cpufreq/bmips-cpufreq.c
 
 BROADCOM BMIPS MIPS ARCHITECTURE
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-mips@vger.kernel.org
 S:	Maintained
@@ -4116,7 +4116,7 @@ F:	drivers/net/wireless/broadcom/brcm80211/
 
 BROADCOM BRCMSTB GPIO DRIVER
 M:	Doug Berger <opendmb@gmail.com>
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 S:	Supported
 F:	Documentation/devicetree/bindings/gpio/brcm,brcmstb-gpio.yaml
@@ -4175,7 +4175,7 @@ F:	drivers/spi/spi-bcm63xx-hsspi.c
 F:	drivers/spi/spi-bcmbca-hsspi.c
 
 BROADCOM ETHERNET PHY DRIVERS
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
@@ -4186,7 +4186,7 @@ F:	include/linux/brcmphy.h
 
 BROADCOM GENET ETHERNET DRIVER
 M:	Doug Berger <opendmb@gmail.com>
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
@@ -4270,7 +4270,7 @@ F:	drivers/firmware/broadcom/*
 
 BROADCOM PMB (POWER MANAGEMENT BUS) DRIVER
 M:	Rafał Miłecki <rafal@milecki.pl>
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pm@vger.kernel.org
 S:	Maintained
@@ -4330,7 +4330,7 @@ F:	include/linux/platform_data/brcmnand.h
 BROADCOM STB PCIE DRIVER
 M:	Jim Quinlan <jim2101024@gmail.com>
 M:	Nicolas Saenz Julienne <nsaenz@kernel.org>
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	linux-pci@vger.kernel.org
 S:	Maintained
@@ -4338,7 +4338,7 @@ F:	Documentation/devicetree/bindings/pci/brcm,stb-pcie.yaml
 F:	drivers/pci/controller/pcie-brcmstb.c
 
 BROADCOM SYSTEMPORT ETHERNET DRIVER
-M:	Florian Fainelli <f.fainelli@gmail.com>
+M:	Florian Fainelli <florian.fainelli@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
 L:	netdev@vger.kernel.org
 S:	Supported
-- 
2.34.1


--0000000000002f6daa05fbd7ed3e
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

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
riBJ/K1AFUjRAjFhGV64l++td7dkmnq/X8ET75ti+w1s4FRpFqkD2m7pg5NxdsZphYIXAgMBAAGj
QjBAMA4GA1UdDwEB/wQEAwIBBjAPBgNVHRMBAf8EBTADAQH/MB0GA1UdDgQWBBSP8Et/qC5FJK5N
UPpjmove4t0bvDANBgkqhkiG9w0BAQsFAAOCAQEAS0DbwFCq/sgM7/eWVEVJu5YACUGssxOGhigH
M8pr5nS5ugAtrqQK0/Xx8Q+Kv3NnSoPHRHt44K9ubG8DKY4zOUXDjuS5V2yq/BKW7FPGLeQkbLmU
Y/vcU2hnVj6DuM81IcPJaP7O2sJTqsyQiunwXUaMld16WCgaLx3ezQA3QY/tRG3XUyiXfvNnBB4V
14qWtNPeTCekTBtzc3b0F5nCH3oO4y0IrQocLP88q1UOD5F+NuvDV0m+4S4tfGCLw0FREyOdzvcy
a5QBqJnnLDMfOjsl0oZAzjsshnjJYS8Uuu7bVW/fhO4FCU29KNhyztNiUGUe65KXgzHZs7XKR1g/
XzCCBVgwggRAoAMCAQICDBP8P9hKRVySg3Qv5DANBgkqhkiG9w0BAQsFADBbMQswCQYDVQQGEwJC
RTEZMBcGA1UEChMQR2xvYmFsU2lnbiBudi1zYTExMC8GA1UEAxMoR2xvYmFsU2lnbiBHQ0MgUjMg
UGVyc29uYWxTaWduIDIgQ0EgMjAyMDAeFw0yMjA5MTAxMjE4MTFaFw0yNTA5MTAxMjE4MTFaMIGW
MQswCQYDVQQGEwJJTjESMBAGA1UECBMJS2FybmF0YWthMRIwEAYDVQQHEwlCYW5nYWxvcmUxFjAU
BgNVBAoTDUJyb2FkY29tIEluYy4xGTAXBgNVBAMTEEZsb3JpYW4gRmFpbmVsbGkxLDAqBgkqhkiG
9w0BCQEWHWZsb3JpYW4uZmFpbmVsbGlAYnJvYWRjb20uY29tMIIBIjANBgkqhkiG9w0BAQEFAAOC
AQ8AMIIBCgKCAQEA+oi3jMmHltY4LMUy8Up5+1zjd1iSgUBXhwCJLj1GJQF+GwP8InemBbk5rjlC
UwbQDeIlOfb8xGqHoQFGSW8p9V1XUw+cthISLkycex0AJ09ufePshLZygRLREU0H4ecNPMejxCte
KdtB4COST4uhBkUCo9BSy1gkl8DJ8j/BQ1KNUx6oYe0CntRag+EnHv9TM9BeXBBLfmMRnWNhvOSk
nSmRX0J3d9/G2A3FIC6WY2XnLW7eAZCQPa1Tz3n2B5BGOxwqhwKLGLNu2SRCPHwOdD6e0drURF7/
Vax85/EqkVnFNlfxtZhS0ugx5gn2pta7bTdBm1IG4TX+A3B1G57rVwIDAQABo4IB3jCCAdowDgYD
VR0PAQH/BAQDAgWgMIGjBggrBgEFBQcBAQSBljCBkzBOBggrBgEFBQcwAoZCaHR0cDovL3NlY3Vy
ZS5nbG9iYWxzaWduLmNvbS9jYWNlcnQvZ3NnY2NyM3BlcnNvbmFsc2lnbjJjYTIwMjAuY3J0MEEG
CCsGAQUFBzABhjVodHRwOi8vb2NzcC5nbG9iYWxzaWduLmNvbS9nc2djY3IzcGVyc29uYWxzaWdu
MmNhMjAyMDBNBgNVHSAERjBEMEIGCisGAQQBoDIBKAowNDAyBggrBgEFBQcCARYmaHR0cHM6Ly93
d3cuZ2xvYmFsc2lnbi5jb20vcmVwb3NpdG9yeS8wCQYDVR0TBAIwADBJBgNVHR8EQjBAMD6gPKA6
hjhodHRwOi8vY3JsLmdsb2JhbHNpZ24uY29tL2dzZ2NjcjNwZXJzb25hbHNpZ24yY2EyMDIwLmNy
bDAoBgNVHREEITAfgR1mbG9yaWFuLmZhaW5lbGxpQGJyb2FkY29tLmNvbTATBgNVHSUEDDAKBggr
BgEFBQcDBDAfBgNVHSMEGDAWgBSWM9HmWBdbNHWKgVZk1b5I3qGPzzAdBgNVHQ4EFgQUUwwfJ6/F
KL0fRdVROal/Lp4lAF0wDQYJKoZIhvcNAQELBQADggEBAKBgfteDc1mChZjKBY4xAplC6uXGyBrZ
kNGap1mHJ+JngGzZCz+dDiHRQKGpXLxkHX0BvEDZLW6LGOJ83ImrW38YMOo3ZYnCYNHA9qDOakiw
2s1RH00JOkO5SkYdwCHj4DB9B7KEnLatJtD8MBorvt+QxTuSh4ze96Jz3kEIoHMvwGFkgObWblsc
3/YcLBmCgaWpZ3Ksev1vJPr5n8riG3/N4on8gO5qinmmr9Y7vGeuf5dmZrYMbnb+yCBalkUmZQwY
NxADYvcRBA0ySL6sZpj8BIIhWiXiuusuBmt2Mak2eEv0xDbovE6Z6hYyl/ZnRadbgK/ClgbY3w+O
AfUXEZ0xggJtMIICaQIBATBrMFsxCzAJBgNVBAYTAkJFMRkwFwYDVQQKExBHbG9iYWxTaWduIG52
LXNhMTEwLwYDVQQDEyhHbG9iYWxTaWduIEdDQyBSMyBQZXJzb25hbFNpZ24gMiBDQSAyMDIwAgwT
/D/YSkVckoN0L+QwDQYJYIZIAWUDBAIBBQCggdQwLwYJKoZIhvcNAQkEMSIEILx6/BdlBcvEfCcu
gWeaip9TwqoHVikvt1VKHnC6OVvLMBgGCSqGSIb3DQEJAzELBgkqhkiG9w0BBwEwHAYJKoZIhvcN
AQkFMQ8XDTIzMDUxNjIzMjgxOVowaQYJKoZIhvcNAQkPMVwwWjALBglghkgBZQMEASowCwYJYIZI
AWUDBAEWMAsGCWCGSAFlAwQBAjAKBggqhkiG9w0DBzALBgkqhkiG9w0BAQowCwYJKoZIhvcNAQEH
MAsGCWCGSAFlAwQCATANBgkqhkiG9w0BAQEFAASCAQCiBs/5vM0gL/bC+B0s1oUukoIfRmXSuaBL
Y3PQIDRh1nXjIq4Smfgf39VE1CjT9De4VVMQkU22s1YfWWCXPHcFCCbcMhXIHs3+BDSWZkUDvza4
wyv75pPMZEr5wsr3elz6OrrY1RVlUZBTcSdH4y+WNI/suYCgJcTW2Ao4epXrm7xDCuA8QVGmpWlW
IuLPH2dSp4DQP+svW3ZEijVpwMTYlR+in021DDJCrXy2P4oxcKMdrF1cJaDz/wh9V6gSHbL53EWd
1Hgla1huldSTMR3TayK0wl1frwhyTGX64ck0ClrUbaBv0FVW7qgSHrHp1O9BOQJL36FU6yxJLKyf
LCYT
--0000000000002f6daa05fbd7ed3e--
