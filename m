Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31AF374B617
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 20:07:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjGGSHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jul 2023 14:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229458AbjGGSHu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jul 2023 14:07:50 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2AE1737;
        Fri,  7 Jul 2023 11:07:49 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-1a1fa977667so2140947fac.1;
        Fri, 07 Jul 2023 11:07:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688753268; x=1691345268;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=MNLF+fuq4TwaQ32ICM7m5ZBV/Z5mA1VvoEw8wI2AGyA=;
        b=SqRz5j/2lsoKMcuriLUbAQ498kgk2U4b4mn+RiYqlCYGCZOfshyAZDDshjsBRX3KPb
         N1cYVcM6TdijsWv5Z6F/2X4YNDzlVMPH4BkdH/px3uxUb8n7wH37QD41rfpr6VZ2Yx9/
         J91ruoPGL7vmQY9Wvnh5EDcz1Kv75NA0235ags9TcWwBqMtjBtOjyFEQjjVPyocRW5ZO
         uFUgVCPJAsCRfvsGF48hekjP7XtYZGHTFGuaZ/NRKeYMXwwvXp+WdiE9mvZGU1TB429n
         vcYbwGWc6FCp1uYNLKqxL3bAs5zYLqoz6vNtcBaXYCO8eLAQkfuTtbIVQB79iAGmcb+Q
         Ezvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688753268; x=1691345268;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MNLF+fuq4TwaQ32ICM7m5ZBV/Z5mA1VvoEw8wI2AGyA=;
        b=W9lLdReyHCanNbUfK8OivXDi8O5zscIDthzUpXtryS1Pgm1hLMdZ8QUYbPEeWR60Ad
         YfMEz17r49dWfy3hZxRe27oR3Wn21viHFjTM+JbrVNfRgunN5Ad+KB3P75SarEZMnmLG
         kLvPzNKA12B+pPEG2f6hmqIQXYnu9jS8Ot9IKdPZX/mctKy4e07oBAJdxulB1IDuv5fb
         hcu9+xVDqZEl5I2pqlgKBS2zpyQ9zHtu50HZk4HYNCJB+oa+JqyXLr01FVnliKtu+f19
         pTqdr69MlKwCGI9E6SSCeZEIHj1O6rgGGAUZPLxUlX2j8EHO8gbLZEf8wuQzP+QO5niY
         qTDw==
X-Gm-Message-State: ABy/qLbXHqvbG/GNOC8f13cjUJO5IsTY01gx1ml8S4n6lyhS6Cy/VKWS
        KrhHyBmLbpTKY3x0HSjmAyc=
X-Google-Smtp-Source: APBJJlEylm+KgLskpWfNy37k0fc95tNPJc/nhbkPj/QWCNzxSdVHOzh/vo3l2BXudUBAImvMQkq8+w==
X-Received: by 2002:a05:6870:3912:b0:1a3:2447:7f4a with SMTP id b18-20020a056870391200b001a324477f4amr7987499oap.32.1688753268411;
        Fri, 07 Jul 2023 11:07:48 -0700 (PDT)
Received: from [192.168.1.205] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id dx26-20020a056870769a00b001a68feb9440sm2034955oab.9.2023.07.07.11.07.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Jul 2023 11:07:47 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Content-Type: multipart/mixed; boundary="------------C6f4cDILumD0bj2hMiJ0eR6O"
Message-ID: <0068af47-e475-7e8d-e476-c374e90dff5f@lwfinger.net>
Date:   Fri, 7 Jul 2023 13:07:45 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: Linux-6.5 iwlwifi crash
Content-Language: en-US
To:     Linux regressions mailing list <regressions@lists.linux.dev>,
        Jeff Chua <jeff.chua.linux@gmail.com>
Cc:     lkml <linux-kernel@vger.kernel.org>,
        Gregory Greenman <gregory.greenman@intel.com>,
        Kalle Valo <kvalo@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Linux Wireless <linux-wireless@vger.kernel.org>,
        Linux Networking <netdev@vger.kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>
References: <20230429020951.082353595@lindbergh.monkeyblade.net>
 <CAAJw_ZueYAHQtM++4259TXcxQ_btcRQKiX93u85WEs2b2p19wA@mail.gmail.com>
 <ZE0kndhsXNBIb1g7@debian.me> <b9ab37d2-42bf-cc31-a2c0-a9b604e95530@gmail.com>
 <CAAJw_Zug6VCS5ZqTWaFSr9sd85k=tyPm9DEE+mV=AKoECZM+sQ@mail.gmail.com>
 <7fee3284-b9ba-58f4-8118-fe0b99ae6bf7@leemhuis.info>
 <CAAJw_Zu=MPtGPARgCB2fteP+7F793YDFXE9RuzSH8EqYBS-OOw@mail.gmail.com>
 <64b8732f-6319-9f10-b82a-b4a3dd8d4b8e@lwfinger.net>
 <CAAJw_ZvZNQzrFyQizJnKe5PerqqAUOmPYd6cnjAcvs68xNdwSA@mail.gmail.com>
 <ff646259-8ce1-f1fe-4627-cdf99321dba8@leemhuis.info>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <ff646259-8ce1-f1fe-4627-cdf99321dba8@leemhuis.info>
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------C6f4cDILumD0bj2hMiJ0eR6O
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit

On 7/7/23 03:43, Linux regression tracking (Thorsten Leemhuis) wrote:
> Hi, Thorsten here, the Linux kernel's regression tracker. Top-posting
> for once, to make this easily accessible to everyone.
> 
> Jeff, thx for bisecting. Johannes afaik is unavailable for a while
> (CCing him nevertheless), hence:
> 
> Gregory, could you please take a look at this? And maybe provide a few
> hints for Jeff how to generate more data that allows us to find the root
> of the problem?
> 
> Jeff, btw, the iwlwifi bug reporting guide (
> https://wireless.wiki.kernel.org/en/users/drivers/iwlwifi/debugging
> ) says to file a bugs in http://bugzilla.kernel.org/ Might be wise to do
> this in case Gregory is also unavailable, but instructed someone to keep
> an eye on things there.
> 
> Ciao, Thorsten (wearing his 'the Linux kernel's regression tracker' hat)
> --
> Everything you wanna know about Linux kernel regression tracking:
> https://linux-regtracking.leemhuis.info/about/#tldr
> If I did something stupid, please tell me, as explained on that page.
> 
> On 07.07.23 03:56, Jeff Chua wrote:
>> On Thu, Jul 6, 2023 at 2:11 AM Larry Finger <Larry.Finger@lwfinger.net> wrote:
>>
>>> Fow what it is worth, my 6.4-git (6.5-rc0?) commit d528014517f2 (pulled today)
>>> is working OK with iwlmvm. Lspci says my device is
>>>
>>> 04:00.0 Network controller [0280]: Intel Corporation Wireless 7260 [8086:08b1]
>>> (rev 73)
>>>
>>> I think you do need to do a bisection.
>>> Larry
>>
>>
>> Larry,
>>
>> I did a bisect and here's what it came up with ... reverted the
>> following and iwlwiifi worked again.
>>
>>
>> 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2 is the first bad commit
>> commit 19898ce9cf8a33e0ac35cb4c7f68de297cc93cb2
>> Author: Johannes Berg <johannes.berg@intel.com>
>> Date:   Wed Jun 21 13:12:07 2023 +0300
>>
>>      wifi: iwlwifi: split 22000.c into multiple files
>>
>>      Split the configuration list in 22000.c into four new files,
>>      per new device family, so we don't have this huge unusable
>>      file. Yes, this duplicates a few small things, but that's
>>      still much better than what we have now.
>>
>>      Signed-off-by: Johannes Berg <johannes.berg@intel.com>
>>      Signed-off-by: Gregory Greenman <gregory.greenman@intel.com>
>>      Link: https://lore.kernel.org/r/20230621130443.7543603b2ee7.Ia8dd54216d341ef1ddc0531f2c9aa30d30536a5d@changeid
>>      Signed-off-by: Johannes Berg <johannes.berg@intel.com>

Jeff,

I am certainly no expert on iwlwifi, but this change looks suspicious:

@@ -10,8 +10,7 @@
  #include "fw/api/txq.h"

  /* Highest firmware API version supported */
-#define IWL_22000_UCODE_API_MAX        81
-#define IWL_22500_UCODE_API_MAX        77
+#define IWL_22000_UCODE_API_MAX        77

  /* Lowest firmware API version supported */

The parameter that was originally set to 81 is now set to 77.

Please try the attached patch.

Larry

--------------C6f4cDILumD0bj2hMiJ0eR6O
Content-Type: text/x-patch; charset=UTF-8; name="test_iwlwifi.patch"
Content-Disposition: attachment; filename="test_iwlwifi.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Npc2NvL2Fpcm8uYyBiL2RyaXZl
cnMvbmV0L3dpcmVsZXNzL2Npc2NvL2Fpcm8uYwppbmRleCBiZWVlMDlkZDk1OGMuLjRjYTZh
MWJhNzhlOCAxMDA2NDQKLS0tIGEvZHJpdmVycy9uZXQvd2lyZWxlc3MvY2lzY28vYWlyby5j
CisrKyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2Npc2NvL2Fpcm8uYwpAQCAtNjE1Niw3ICs2
MTU2LDcgQEAgc3RhdGljIGludCBhaXJvX2dldF9yYXRlKHN0cnVjdCBuZXRfZGV2aWNlICpk
ZXYsCiB7CiAJc3RydWN0IGl3X3BhcmFtICp2d3JxID0gJndycXUtPmJpdHJhdGU7CiAJc3Ry
dWN0IGFpcm9faW5mbyAqbG9jYWwgPSBkZXYtPm1sX3ByaXY7Ci0JU3RhdHVzUmlkIHN0YXR1
c19yaWQ7CQkvKiBDYXJkIHN0YXR1cyBpbmZvICovCisJU3RhdHVzUmlkIHN0YXR1c19yaWQg
PSB7fTsJCS8qIENhcmQgc3RhdHVzIGluZm8gKi8KIAogCXJlYWRTdGF0dXNSaWQobG9jYWws
ICZzdGF0dXNfcmlkLCAxKTsKIApkaWZmIC0tZ2l0IGEvZHJpdmVycy9uZXQvd2lyZWxlc3Mv
aW50ZWwvaXdsd2lmaS9jZmcvMjIwMDAuYyBiL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVs
L2l3bHdpZmkvY2ZnLzIyMDAwLmMKaW5kZXggYWE0MzIwY2E0YzMwLi5kM2U3MGMzM2ZiY2Yg
MTAwNjQ0Ci0tLSBhL2RyaXZlcnMvbmV0L3dpcmVsZXNzL2ludGVsL2l3bHdpZmkvY2ZnLzIy
MDAwLmMKKysrIGIvZHJpdmVycy9uZXQvd2lyZWxlc3MvaW50ZWwvaXdsd2lmaS9jZmcvMjIw
MDAuYwpAQCAtMTAsNyArMTAsNyBAQAogI2luY2x1ZGUgImZ3L2FwaS90eHEuaCIKIAogLyog
SGlnaGVzdCBmaXJtd2FyZSBBUEkgdmVyc2lvbiBzdXBwb3J0ZWQgKi8KLSNkZWZpbmUgSVdM
XzIyMDAwX1VDT0RFX0FQSV9NQVgJNzcKKyNkZWZpbmUgSVdMXzIyMDAwX1VDT0RFX0FQSV9N
QVgJODEKIAogLyogTG93ZXN0IGZpcm13YXJlIEFQSSB2ZXJzaW9uIHN1cHBvcnRlZCAqLwog
I2RlZmluZSBJV0xfMjIwMDBfVUNPREVfQVBJX01JTgk1MAo=

--------------C6f4cDILumD0bj2hMiJ0eR6O--
