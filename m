Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D983713813
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 08:38:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229534AbjE1Gis (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 02:38:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbjE1Gir (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 02:38:47 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 897AFD8
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:38:45 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso49125466b.0
        for <linux-kernel@vger.kernel.org>; Sat, 27 May 2023 23:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685255924; x=1687847924;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UY/WSQ9WFQUn1R6eZg5dGSWjhyOOZkalxHvn5V45skY=;
        b=kuxolb67EhLB83qoIqEHcXrDoz0faJ9GZaXi+nHf5CRZ9GJJxPaULRBhv32MqT73HH
         zRklkaUO/xUcdyD5/k0hi+UoWDuv3ZDkHedE8iTfbxUFnCy4D8pvHyBhuKT84JjnoJ9T
         4ppELkQUFRizIp3lZ13OvOXDrFPeC3MxBdXcRTEA7BCbMXdIa+XHRyA2e65Sw5ObpYjZ
         lLFpg7ev0c0z492usLSl4/3yDS54eUh5gXF5eKIanCeXta1N8zckBSmFmMLyxmI3pnGb
         +g392/ZwrmkCX//Su+3KDKf+7Mey/5Rva4nDEpXkmZCdXcL9uMm7Qpiifrp5hsRVW0OE
         ISQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685255924; x=1687847924;
        h=content-transfer-encoding:in-reply-to:cc:references:to:from
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UY/WSQ9WFQUn1R6eZg5dGSWjhyOOZkalxHvn5V45skY=;
        b=DipiZB1Byk55rOzEo1KGioFB8FuD2l75RhMoKeE/hC7Iz9/zve1Lg39LMv9S1NNjEy
         nOR12cJeNG3CyZwmBe67k+bVDlnt2BuV1nrWtGQSt2kW0Vwd03ZEwAuKyBrCs4BMxCkd
         cnWkeKf4GONyzP4bWfSiwiy8A6uzp6SqI3WFHAL0XDc0kz3qeTJRIOdajLfhfObuo30C
         5iI+BbD3W8aEf5i3eoC9R5+MdtvbuuxZZKlb0vqfJHgOWmAfLleqwh03fzafYGUTqjnS
         hs2AxuU206jemywZSQYYQ/Q5AhU8jTtQ3s3Zzj4bJMNjV6TCk4FJ8ySZ9fF2sE8hNZp7
         Znmg==
X-Gm-Message-State: AC+VfDwjozAvbmMYeqLVyaMwIJA6kY4qkkx11EbtSK1leQ8PCI36dzCZ
        lgNPW8u3TsiE/D9SEPsX9tA=
X-Google-Smtp-Source: ACHHUZ70eO6uKTHIt1c+XP0JhnVfxNjZE4+ckJ+YoL6Rnsk1fRI+X/mpSFPShBnzjwaFqp/RwHEMbA==
X-Received: by 2002:a17:906:73cc:b0:929:b101:937d with SMTP id n12-20020a17090673cc00b00929b101937dmr5746922ejl.1.1685255923783;
        Sat, 27 May 2023 23:38:43 -0700 (PDT)
Received: from [192.168.0.103] (p57ba2e0b.dip0.t-ipconnect.de. [87.186.46.11])
        by smtp.gmail.com with ESMTPSA id r20-20020a170906365400b0094e7d196aa4sm4261999ejb.160.2023.05.27.23.38.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 May 2023 23:38:43 -0700 (PDT)
Message-ID: <acac3ff7-36cd-72b4-1857-c8e3588d287f@gmail.com>
Date:   Sun, 28 May 2023 08:38:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: staging: rtl8192e: Replace drivers rtllib_crypt_ccmp_... with
 lib80211_crypt_...
Content-Language: en-US
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1683960684.git.philipp.g.hortmann@gmail.com>
 <e3c29c3db33d314dffb673f8e563da0fb1f2b22f.1683960685.git.philipp.g.hortmann@gmail.com>
Cc:     "Larry.Finger@lwfinger.net" <Larry.Finger@lwfinger.net>
In-Reply-To: <e3c29c3db33d314dffb673f8e563da0fb1f2b22f.1683960685.git.philipp.g.hortmann@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

it is possible to remove three modules from the staging area by replacing:
rtllib_crypt_ccmp with lib80211_crypt_ccmp
rtllib_crypt_tkip with lib80211_crypt_tkip
rtllib_crypt_wep with lib80211_crypt_wep

The following issues arise:
- rtl8192e needs to be switched to software encryption or
   lib80211_crypt_... needs to be extended with hardware encryption.
- Performance is dropping on my computer from 12,5MB/s to 1,5MB/s when
   switching to software encryption.(it does not really change if I use
   rtllib_crypt_ccmp or lib80211_crypt_ccmp)
- Fix: rtllib_rx_decrypt: decrypt frame error that occure sometimes on
   lib80211_crypt_ccmp

Below the changes on the driver that made use of lib80211_crypt_... 
possible.

So the questions are:
Is it worth the effort or is this going in the wrong direction?
Does it help the kernel community or is it just creating more effort?
Why does LIB80211 not support hardware encryption? Or does it?

Thanks for your support.

Bye Philipp

diff --git a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c 
b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
index 17b70dde7eeb..ef0fa05ff510 100644
--- a/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
+++ b/drivers/staging/rtl8192e/rtl8192e/rtl_core.c
@@ -22,7 +22,7 @@

  #include "rtl_pm.h"

-int hwwep = 1;
+int hwwep = 0;
  static char *ifname = "wlan%d";

  static struct pci_device_id rtl8192_pci_id_tbl[] = {
diff --git a/drivers/staging/rtl8192e/rtllib_wx.c 
b/drivers/staging/rtl8192e/rtllib_wx.c
index 82b537da8b21..0db6e32b5494 100644
--- a/drivers/staging/rtl8192e/rtllib_wx.c
+++ b/drivers/staging/rtl8192e/rtllib_wx.c
@@ -522,16 +522,16 @@ int rtllib_wx_set_encode_ext(struct rtllib_device 
*ieee,
         sec.enabled = 1;
         switch (ext->alg) {
         case IW_ENCODE_ALG_WEP:
-               alg = "R-WEP";
-               module = "rtllib_crypt_wep";
+               alg = "WEP";
+               module = "lib80211_crypt_wep";
                 break;
         case IW_ENCODE_ALG_TKIP:
-               alg = "R-TKIP";
-               module = "rtllib_crypt_tkip";
+               alg = "TKIP";
+               module = "lib80211_crypt_tkip";
                 break;
         case IW_ENCODE_ALG_CCMP:
-               alg = "R-CCMP";
-               module = "rtllib_crypt_ccmp";
+               alg = "CCMP";
+               module = "lib80211_crypt_ccmp";
                 break;
         default:
                 netdev_dbg(ieee->dev, "Unknown crypto alg %d\n", ext->alg);

