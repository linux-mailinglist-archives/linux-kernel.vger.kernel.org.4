Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC91661134
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 20:01:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232711AbjAGTBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 14:01:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229785AbjAGTBa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 14:01:30 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF911C136
        for <linux-kernel@vger.kernel.org>; Sat,  7 Jan 2023 11:01:26 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id k22-20020a05600c1c9600b003d1ee3a6289so3362264wms.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 Jan 2023 11:01:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7/sxMeg8vzoXDNyj6J6+A0Llqgaiq+xMNXLTHh7TosY=;
        b=mkA6uLYt0wMqF/ouJZQ7frahvZ6dZKbJqpoLuoaH1BFR2ahEzQla7uFMAZA8omTwdR
         EXqAMwdtRXA6TaPpJY8P81TydThHMmKjxcFRQzN69jbcuh8h1iG5cRSas/vvz9bjaNGm
         JRwaryIksx5laxCZ1BFgHRyPro/Wg29w1v+Onpnr8DJash+MMyngNACaN+H/otJChMkb
         s7Cd7xJzZoEH+LjnwVwBCu8k47If3oX278oqlbMQCTTz94aI4Hnr1qO8Ro6kn6NWgOs1
         FbIw0aysIUAxyMAOhH/EBoUC2N+rNFTcbqHn4y62uhrWsncFLXizRiSdWmizGSrP6+DN
         nlNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7/sxMeg8vzoXDNyj6J6+A0Llqgaiq+xMNXLTHh7TosY=;
        b=DZbpXiRk+GBkrZ/eZX8Q7a+tjWX0Eh/e4mC8wB+BtrPSwf5xACmWUPo0yvyL6fgwgp
         qvkI2fmPtgTpewPeBK4PmSPPQdVxTW6zqFjrnc4J6VjF549H7NEMd3IW00Ox1pZmsdhL
         rkepaz9jASF4xTpLJPeV3oy/bD61XXhlraiY3ySWzP0scy3DuKOcZtYyjnGOCYb9Mdhi
         cuvTrQw5/HyK+cDUnxCbByXxxP3lIe0WN/mMOlTdd2dx8raDcv0TsKHlNOpdVTAPvcmd
         Md3KXaAKEOELFXq1i41AZHOXS2MMYA51I4kIMgCcC4gJVkNJvCJ3p6nnPMV7BMBKynuY
         /y+A==
X-Gm-Message-State: AFqh2kqE64wKKZuOUa8EQ8aPcRriOlw/15vXyTlbepmTrJ0SKDeOo3Ne
        qp80yKsLPVUQu+KZOkZaVlgtJw==
X-Google-Smtp-Source: AMrXdXvuhRSpwXsnJIRCr+otbPHOLEKZXI30bBUVRPQLHlb/gYyydYyfm7xdBPcr9H9aF7BRZ41RDw==
X-Received: by 2002:a05:600c:1f12:b0:3d2:267d:64bd with SMTP id bd18-20020a05600c1f1200b003d2267d64bdmr51240604wmb.3.1673118084475;
        Sat, 07 Jan 2023 11:01:24 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id m17-20020a05600c3b1100b003cfbbd54178sm19011371wms.2.2023.01.07.11.01.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 Jan 2023 11:01:23 -0800 (PST)
Message-ID: <3afcb445-7a62-ced7-eb54-1b2d8a9085ce@linaro.org>
Date:   Sat, 7 Jan 2023 20:01:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: Annoying message on the console for the db845c board
Content-Language: en-US
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        "agross@kernel.org" <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <e0ced334-e6c1-caeb-322a-f67a23ee58da@linaro.org>
 <CAA8EJpr0A=VjWEv6NPaZ-t_3TgNaWpsVO8_inJhxqoThry_zZA@mail.gmail.com>
 <17e2d99d-31e5-b29a-e729-4f4d70b2efbc@linaro.org>
 <CAA8EJprcVT=vyEhU0Nbtr4Wu1YxcGs+NLNxtpTaFtaJSTqvgYw@mail.gmail.com>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <CAA8EJprcVT=vyEhU0Nbtr4Wu1YxcGs+NLNxtpTaFtaJSTqvgYw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,BITCOIN_SPAM_02,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        PDS_BTC_ID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi Dmitry,

thanks for your help

On 07/01/2023 15:11, Dmitry Baryshkov wrote:
> On Fri, 6 Jan 2023 at 22:08, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>
>> On 06/01/2023 19:14, Dmitry Baryshkov wrote:
>>> On Fri, 6 Jan 2023 at 18:37, Daniel Lezcano <daniel.lezcano@linaro.org> wrote:
>>>>
>>>>
>>>> Hi all,
>>>>
>>>> Does anyone have an idea on how to fix these timeout messages ? They are
>>>> displayed again and again every 5 seconds and that saturates the
>>>> filesystem after awhile.
>>>
>>> Could you please check that you have CONFIG_QCOM_RMTFS_MEM enabled and
>>> the rmtfs daemon running?
>>> I think that's the usual cause of such messages.
>>
>> Yes, I have the option and the daemon running:
>>
>> zcat /proc/config.gz | grep CONFIG_QCOM_RMTFS_MEM
>> CONFIG_QCOM_RMTFS_MEM=y
>>
>> ps -ef | grep rmtfs
>> root      9888     1  2 20:07 ?        00:00:00 /usr/bin/rmtfs -r -P -s
> 
> I don't seem to be able to reproduce it here. Could you please share
> your kernel commit, .config and md5sums of
> /lib/firmware/qcom/sdm845/m*
> 
> Thank you.

I have this message since I began to use the board, so v6.2-rc2 is the 
latest commit where the message appears.

Here are the checksums:

5533fa7714fb3cce82e87f53ef176f2b  /lib/firmware/qcom/sdm845/mba.mbn
fc8a991ef6de938b98f6b8add935f763  /lib/firmware/qcom/sdm845/mfido.b00
891ff112c4b850bc42dfd3b6de4fa5b2  /lib/firmware/qcom/sdm845/mfido.b01
87fee3b957cc4db82e6059ecc93fa407  /lib/firmware/qcom/sdm845/mfido.b02
63a7b2d8b45d5c45c06d692990978549  /lib/firmware/qcom/sdm845/mfido.b03
9a948d36de06c6061faf778df587055e  /lib/firmware/qcom/sdm845/mfido.b04
01d66841828ef931a9c38276ee625009  /lib/firmware/qcom/sdm845/mfido.b05
9e8d0a8f7af2a6c871d57e52d77dbcc3  /lib/firmware/qcom/sdm845/mfido.b06
1295c311bfa46356042dabb45918e068  /lib/firmware/qcom/sdm845/mfido.b07
414e0abb604838279a267044f4c944d7  /lib/firmware/qcom/sdm845/mfido.mdt
12266b36b7b5c23fb52639ac663ebf31  /lib/firmware/qcom/sdm845/mlipay.b00
3de44af432e79ccbb7641add632a95a3  /lib/firmware/qcom/sdm845/mlipay.b01
133976d78cf0615bb9cea303a4954aa5  /lib/firmware/qcom/sdm845/mlipay.b02
0dbdf878624e31b5f09147b130600d88  /lib/firmware/qcom/sdm845/mlipay.b03
5dc64a1b8dd56122392f311e67096c73  /lib/firmware/qcom/sdm845/mlipay.b04
120800490c1b6ecb9670f4dbd0ebb213  /lib/firmware/qcom/sdm845/mlipay.b05
6ed32e554551e82d0c3b2db7029822bf  /lib/firmware/qcom/sdm845/mlipay.b06
089bdc9f19e1797051a0c1f230669f1f  /lib/firmware/qcom/sdm845/mlipay.b07
731b3ef3e26abacc56062dd22d5ade1f  /lib/firmware/qcom/sdm845/mlipay.mdt
f52909691b8b7caf9b4b5df034cb409b  /lib/firmware/qcom/sdm845/modem.b00
31b13980b0ce2dd003ae5fc785d73edc  /lib/firmware/qcom/sdm845/modem.b01
81b3278eb711869d8b2586e76c17a42c  /lib/firmware/qcom/sdm845/modem.b02
fd03fc9524da65557f48cd54453afb79  /lib/firmware/qcom/sdm845/modem.b03
6f4574fa6d3399ddd44d218251d103aa  /lib/firmware/qcom/sdm845/modem.b04
8029ecce466e3a8f5363cfbe0526a25a  /lib/firmware/qcom/sdm845/modem.b05
289e1b9e75a99e997fcf5bea2556b6a7  /lib/firmware/qcom/sdm845/modem.b06
1f2c55145dd857846c3af85341e91692  /lib/firmware/qcom/sdm845/modem.b07
2d23ad2aaba8fa0f8ebee2dfc4bafb69  /lib/firmware/qcom/sdm845/modem.b08
87acd90067133b479296e6e2dfe33862  /lib/firmware/qcom/sdm845/modem.b09
55fadce7dac041e691f9653a8cec0623  /lib/firmware/qcom/sdm845/modem.b10
b570020fb4b0b3b2b15c6dce2eacf36d  /lib/firmware/qcom/sdm845/modem.b11
8720757ffbdffa143847fb091dfc7ab3  /lib/firmware/qcom/sdm845/modem.b12
80f4e29dbfd22bd0a2c414506b732c8c  /lib/firmware/qcom/sdm845/modem.b13
d466218216a25fe0ebf3e546ba1f0a7b  /lib/firmware/qcom/sdm845/modem.b15
a6328fae9ebfaeb3b9d108bcced145f3  /lib/firmware/qcom/sdm845/modem.b16
3a18fd44bddd1d19b8c369a1c3e45b4b  /lib/firmware/qcom/sdm845/modem.b17
da2bc943c0d9a669dbffbe083c8bb355  /lib/firmware/qcom/sdm845/modem.b18
d6e44ee4f65b8f062fe794333d6abb46  /lib/firmware/qcom/sdm845/modem.b20
3eac979300ae1cdfa2a0a4aa723e7bb5  /lib/firmware/qcom/sdm845/modem.b21
99e3ec3c4ce3ccb426e09ad58c60e047  /lib/firmware/qcom/sdm845/modem.b22
e247a0474d2c30db5c2ed023c16008d4  /lib/firmware/qcom/sdm845/modem.b23
22ec959a5da1cd2639787717100015ff  /lib/firmware/qcom/sdm845/modem.b24
65f80038d994cd7f6d32435afe083e8f  /lib/firmware/qcom/sdm845/modem.b25
90650a7ca2f7911f4584261a51e03545  /lib/firmware/qcom/sdm845/modem.b26
8eecb5553b0ab616cd8da6d86f1b4efc  /lib/firmware/qcom/sdm845/modem.b27
5ef7472400a0600e54bd26ef985a4ee9  /lib/firmware/qcom/sdm845/modem.b28
967351c89ce72cfe48100ee48d18b7dc  /lib/firmware/qcom/sdm845/modem.mbn
967351c89ce72cfe48100ee48d18b7dc  /lib/firmware/qcom/sdm845/modem.mdt
md5sum: /lib/firmware/qcom/sdm845/modem_pr: Is a directory
0791674ed874a849510aed1e8d77905f  /lib/firmware/qcom/sdm845/modemr.jsn
bad87ccee828ee70d0281db170985738  /lib/firmware/qcom/sdm845/modemuw.jsn




-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

