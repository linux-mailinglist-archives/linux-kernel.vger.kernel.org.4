Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D7D36188BA
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Nov 2022 20:25:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231313AbiKCTZM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Nov 2022 15:25:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231823AbiKCTYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Nov 2022 15:24:50 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77FAD2613
        for <linux-kernel@vger.kernel.org>; Thu,  3 Nov 2022 12:23:29 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id v81so3048954oie.5
        for <linux-kernel@vger.kernel.org>; Thu, 03 Nov 2022 12:23:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:sender:from:to:cc:subject
         :date:message-id:reply-to;
        bh=BqziTjxfdQl0fNRtQ4I0OSYSj/ru4qxDbXBeei7oy4s=;
        b=BnyE+BDM7GHsEAGM5bYv3B7xOcr4hDUpNNIG/ujmPbCwgopB8ytsNW48mYGReHAjuO
         2z+ZmXr3SuxLQGENZljdN9QXqxdbyJ7e3PzTyOVtBQWeGfZjfsDEY4JOb+UFx9/iwPuD
         lp0dXMt4zkSopM8MYmpcJHUTts45+pRIhommyG5fzFdtomjRUJlkAuGNVRyaFAx2DS5r
         5Z4VyY0NFmzDDnRToUdHfgdSZXSVKtxaoyHAQQDWX1HQCdKeywVSoRKgFhm5rIy0JAHl
         hiPMOW8I+NEKBVzIno/dGEaBd8bXdmuZWXivk3my0fevn5hNDrL2WweH4LRR0k6Yw+wr
         grYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:from:references:cc:to:content-language:subject
         :user-agent:mime-version:date:message-id:sender:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BqziTjxfdQl0fNRtQ4I0OSYSj/ru4qxDbXBeei7oy4s=;
        b=rEuZjXKwPFTnav4sd8/NVv2CA2tho4n65GxwKagC5Do9NQN7NgFwQKbvxbJyvIz7Ia
         fbJqNooyoqzCc/kr6dFv98KJSaFZJPKn80oJf+vwZJaBFvjU+MsLPTYERk7d4mhdk/g6
         3FGPZf+e97mX87tNeSVA+6XhuKAE7hx0W2/g3GgIX0WG083yeljOTlWUnmRj46xgrD7L
         fUA4YVX3ocWR0SDi2fZgnfPD+3TpFyy8D25vpWETFbhCJctysZrd3wCigJTgtxlB7Aqi
         DxN+CWYCGVZVWrE3nlrGtA5vrn8fbNmw+waSMG7/ibaa6NcJvI8yv/hFmFEdZUGFp/nb
         62uw==
X-Gm-Message-State: ACrzQf1QWqYy1ha4cKYBEFk1wkjcU0KA+LIEo+Yy4Or82AOpRBhBxby8
        BEFmtGAFuOJYjFeMjG17NtPofX6FXaY=
X-Google-Smtp-Source: AMsMyM6QCfO3tdz6iQo6iPdNduV07dDacddY1xQyOJNkK+T5SSqWUKtlCDMdf1uJAiHhiMSCAGypBw==
X-Received: by 2002:a05:6808:181e:b0:35a:5959:5909 with SMTP id bh30-20020a056808181e00b0035a59595909mr238097oib.35.1667503408758;
        Thu, 03 Nov 2022 12:23:28 -0700 (PDT)
Received: from [192.168.0.158] ([216.130.59.33])
        by smtp.gmail.com with ESMTPSA id r3-20020a056870e98300b0013bc40b09dasm790796oao.17.2022.11.03.12.23.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 03 Nov 2022 12:23:28 -0700 (PDT)
Sender: Larry Finger <larry.finger@gmail.com>
Content-Type: multipart/mixed; boundary="------------jEpg7InBUcZ4C7rHTIpvDrTk"
Message-ID: <fdbd7d7b-7e3f-8343-1dd9-8fd5c167d91d@lwfinger.net>
Date:   Thu, 3 Nov 2022 14:23:27 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.1
Subject: Re: staging: rtl8192e: build warning on HZ
Content-Language: en-US
To:     Randy Dunlap <rdunlap@infradead.org>,
        "linux-staging@lists.linux.dev" <linux-staging@lists.linux.dev>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     wlanfae@realtek.com,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
References: <a916c06e-a9b5-1cd2-2da7-ac8e46b512c9@infradead.org>
From:   Larry Finger <Larry.Finger@lwfinger.net>
In-Reply-To: <a916c06e-a9b5-1cd2-2da7-ac8e46b512c9@infradead.org>
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a multi-part message in MIME format.
--------------jEpg7InBUcZ4C7rHTIpvDrTk
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit

On 11/3/22 13:07, Randy Dunlap wrote:
> FYI:
> 
> When CONFIG_HZ=24 (arch/mips/):
> 
> ../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtl819x_translate_scan':
> ../drivers/staging/rtl8192e/rtllib_wx.c:220:57: warning: division by zero [-Wdiv-by-zero]
>    220 |                       (jiffies - network->last_scanned) / (HZ / 100));
>        |                                                         ^
> In file included from ../include/linux/skbuff.h:45,
>                   from ../include/linux/if_ether.h:19,
>                   from ../include/linux/etherdevice.h:20,
>                   from ../drivers/staging/rtl8192e/rtllib_wx.c:18:
> ../drivers/staging/rtl8192e/rtllib_wx.c: In function 'rtllib_wx_get_scan':
> ../drivers/staging/rtl8192e/rtllib_wx.c:261:70: warning: division by zero [-Wdiv-by-zero]
>    261 |                                    (jiffies - network->last_scanned) /
>        |

That statement is messed up. Does the attached patch fix it?


Larry

--------------jEpg7InBUcZ4C7rHTIpvDrTk
Content-Type: text/x-patch; charset=UTF-8; name="test_patch_fr_rtl8192e.patch"
Content-Disposition: attachment; filename="test_patch_fr_rtl8192e.patch"
Content-Transfer-Encoding: base64

ZGlmZiAtLWdpdCBhL2RyaXZlcnMvc3RhZ2luZy9ydGw4MTkyZS9ydGxsaWJfd3guYyBiL2Ry
aXZlcnMvc3RhZ2luZy9ydGw4MTkyZS9ydGxsaWJfd3guYwppbmRleCBkYTJjNDFjOWI5MmYu
LjBhMDA3ZjU1Zjk4OCAxMDA2NDQKLS0tIGEvZHJpdmVycy9zdGFnaW5nL3J0bDgxOTJlL3J0
bGxpYl93eC5jCisrKyBiL2RyaXZlcnMvc3RhZ2luZy9ydGw4MTkyZS9ydGxsaWJfd3guYwpA
QCAtMjE2LDggKzIxNiw4IEBAIHN0YXRpYyBpbmxpbmUgY2hhciAqcnRsODE5eF90cmFuc2xh
dGVfc2NhbihzdHJ1Y3QgcnRsbGliX2RldmljZSAqaWVlZSwKIAlpd2UuY21kID0gSVdFVkNV
U1RPTTsKIAlwID0gY3VzdG9tOwogCXAgKz0gc2NucHJpbnRmKHAsIE1BWF9DVVNUT01fTEVO
IC0gKHAgLSBjdXN0b20pLAotCQkgICAgICAiIExhc3QgYmVhY29uOiAlbHVtcyBhZ28iLAot
CQkgICAgICAoamlmZmllcyAtIG5ldHdvcmstPmxhc3Rfc2Nhbm5lZCkgLyAoSFogLyAxMDAp
KTsKKwkJICAgICAgIiBMYXN0IGJlYWNvbjogJWx1cyBhZ28iLAorCQkgICAgICAoamlmZmll
cyAtIG5ldHdvcmstPmxhc3Rfc2Nhbm5lZCkgLyBIWik7CiAJaXdlLnUuZGF0YS5sZW5ndGgg
PSBwIC0gY3VzdG9tOwogCWlmIChpd2UudS5kYXRhLmxlbmd0aCkKIAkJc3RhcnQgPSBpd2Vf
c3RyZWFtX2FkZF9wb2ludF9yc2woaW5mbywgc3RhcnQsIHN0b3AsCg==

--------------jEpg7InBUcZ4C7rHTIpvDrTk--
