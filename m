Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCBAD6AB155
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 17:12:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229528AbjCEQMA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 11:12:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229507AbjCEQL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 11:11:57 -0500
Received: from sonic302-20.consmr.mail.ir2.yahoo.com (sonic302-20.consmr.mail.ir2.yahoo.com [87.248.110.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09E41EB63
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 08:11:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1678032713; bh=dtE96raQEZ6w5exNSJbbcUM91YX2n33Si0WhgJpBGaA=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=i+8dyBUd50xYd2u7KB+yMhNos+hT8Yg8E3riix03CwFrw7v7gHK5lF8UOgn3hySfpCUebm8zWfRsbta+7UBSrFRsVHzfkzlL+raqbEWO1rLj217+RP2u5a7S2okBNqLx/Wb50aPxHlHqaSfPh53xucmb0qp0qi8HHFOc4l2f0gKrLv5/SJZJtYkGAo4Q2zQQGDJ20x9nhTudk3LYObnWpGfhbL+GXg03wVA8ti1amg7Kg+ooXEMm2Xb1Ag+eDBplMYF44UAEK5jseEH+lA7NX/S8MGlk0bgX1RPWqPxFKsW9ygDQ1IMmR726dcAXSOH5M+qc8VmdN3pWByuiww9C8g==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678032713; bh=fEz+obwPgao3G0KzqNq7I+Wzuo1yqnpUd1aM7oCmBDd=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=bXBGMvScHEzT/vMxFCmOmwPQ74Zzzjpt+xd6H2D+1fChFUbG4CDm8GQ0sHn358YxLlU0K373KZFpOR/8EC8gSPjJX4ojemMKcNjK7sGJAR32ysUwbkt5ydoHItO/1Nc350yCEMshF6HjWasMJZrMmqRYmj3yfmbJh11wgci7VQD5ksqiyTDSgfuBGcXAzSj2b77IlqUvbV1BLTZOVvbKpzUxak0BMasx5EUHiOYLCvzj/kxZm2ioeNC/OQC6tR5LZPUrBHvKKw/3kHkowRgJKXrkKIH9zWWT4DN/+X5LVO/lKbQTcgHwPCj6CULkYGW2x2g1QTVoU8hAMPYSj8Lciw==
X-YMail-OSG: zWBfk3IVM1lG7WsuEOsTPMu026yqIiSId1BbX4pYT6Gx4B_DawfgIYiOefxFFmO
 2NA8Dv06umF4ieG_nDstQVaAz3GfH4DvF20WZmzxENJaqL0e_EhioS6Wok4eUn.2uC2vshAV91n5
 _VpsHVgwzC0ufM.raz3BMtImvvLAP7MClslvdBQaMLf1UgzS07Cvx291Uq076mFgqiz8CuzP.C3U
 j412Mn51vVWieg.3MhvAl6Y5SQcP7RrpqxFI3Rh0lDMmA7FXbhRUK2bputGQwwTEeTCqyfDVgDEl
 0Zo27iOQl86dNzd2ScpKTG9.4WlJjt4EN9vx8DsO1XAZmXG9ndAGIVF_BCoHQOnzpzNvo3aBpdnY
 FfJ1tr3AJC43II_Kg6Ykn8MJrBEpt315zxodLNBrWWUTfZxh.76Jx5AEibLHUN6guYf9qBjNXtjF
 Ab4KE6RnxYnFdEaprGQC_S1QcQmW4CPdkFE7Hb7EDo34RBZzEYDvPjfR8ZExt.3eruvq2.3XG5zt
 5FI_UtEucSLi3D4sAZyhYJpRIPxBD5V1AwiWlGi3rik3XxXtZxgrdujeCwhzztJgxIRL6cTAN_P_
 0.UmEDBEmbcvprO2JAnO0HMGJCb4WjmSumBEMouNQNE4pLC5c_1zc3wprl.tSaKIqdLY6X5ypMl8
 .nMimvUTthpH8hARcCZAPFzPziXLuSDRn5Rux15U8YARZ1J8v.y2wSsmUtwmYloVjb_4Qp2nFKb8
 iTZ2D04mRhxnbwpCTA1VBBzfHNaaV2az2LO.fQHdozM0B0mlUmBrXHUh5.ouucwWl_JMYsVG7a.t
 273wvNc0n7mTBt8uXvxi7_rNW8PzY0RPsDpXC.vuo0EqrTYjKI_LQON7X8DA8ZREruLBGnSn9Dz5
 zUXvvwheCdLcsBfrL92hvmI6s2dg5nx0sNfVV4.NkNtMv028fHIcxAjSI87MNgNLuUcF.xDuEp6d
 j6hiwQNU6R6dUQ4qP0XouAa.9AG_Jd7QMfWUPnlwjM47XLfUZUDCVF3pkDF4V7Esn0LiEIXz93DW
 Qtpr6Jk4OhYC6f89fwzdChupHs5sV05lyGYjIQdXmQVRGt9MGaQ7jzm2WORoKDg.niopaPLsuPf6
 9MKd9CceoDSli_adS_55rP2uMsSS2ec0ceHWwwXwGfv6acYTmLge2UudQ0vOxHZBi6lZccuZOmtJ
 mb56kn8bZz.GCq7VySAsD4.Txm2YyPDakG3SsUvRolRcoXvR92wEtRciHpW2UWiPH89X1m2hqniI
 ZJbPwelmvCQpLC79UvvMDb8Rs4auevBdQXBirlBHniNabVMHbV_Kroz0O1xnovKzEyt.LdKPwP02
 i8863OD945UFVQIm8sPPU.Uvq7W1i77TDg7Gg9HoNETTZdq3f0mutB5o34RmrdXMgchrI9wF_mzN
 GEA5M6bzG1Oa69dpY31GjTsXKcmPrMGiFt8c1syPNZHkthS_NQObf7EZMnBYHRrIt8NR5A3l.nGS
 eXzKAjxgfaIhb5JUTBM3B_79rGpxs3L.YXMFfoksRKkH2_7jhAHj1eHibFjOK7TNRaG8TI2xRmCK
 _mwN.8rbmu5iErSMN0.wwKkAJK_nCTujsXEDYMeL6IP4RBm8AbOSP9dp1zOXPk_p3HAmKj9zTf1p
 ruLGdKKnvNSdsZ9HvyCiXCMCRYuKKerOB1YYYeWiuTDrTm3oNtT_sA0p5G7TX4Lzm3sbp0JABO6_
 Gxd3OkcEqijM1nFtI7kg_pCHjEYvgyi_9UmpoLeYNbjONd9969kZtPOPiuKsJ0lhiqKSun1GoPxK
 LgsDkaB7xbgGuLqA0pbRrcXIpi2fAHs4CTT2WTo4m9PrxAlexUkfm0gB3jLVzpHgo2lnfhkNVJcz
 zImeljxqpaX6i8twT33_UE9WhiYL20a4iehqPl1mTKtTkOeCH9nA76RPkY944Ty9w_kyw2ByTDJy
 BxaZ6XlEHK9ReTYkfEf45P3Adi7lgk359hRia_Z51NdbGmqeaVLIabsAC2qyJ.w8snrhljz2Wm6M
 Hs09I1gV92ZaZqKvxMPuzE_hpQTzQ_c47sa2CdHFl6OaTpuZDC9.XTBzWJALUk5BlmgU_Iv3AsDB
 5hMhnSak788abwtWvnEXusJPWaUB6OnDcsqTkpYyBaNswu0zjuels_EpS0xEcjB2MFcmUqOzmYAe
 KgSaS.v1vDOtfgVr.vV.PeDTv09HbnWgjXayvnQZI01Z98YdrdMmuFPTcYtiFpd0sZFct_6p8k7E
 R3J.MJzSsH4l32DAvVuViyrEDEafY4vW.ouz6GYAUxMBRLrtMZf3Bcd6zpyKU_JroXQ0XCU.X7R.
 glmNZ7BF_EL56RMamOeGfe_q6Xx.g.g--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic302.consmr.mail.ir2.yahoo.com with HTTP; Sun, 5 Mar 2023 16:11:53 +0000
Received: by hermes--production-ir2-5b7d458747-z6qxt (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 7767db3293682666276cd8f39107f1c9;
          Sun, 05 Mar 2023 16:11:52 +0000 (UTC)
Message-ID: <1c110bcc-7e65-fc01-44ec-1a79cfe49795@rocketmail.com>
Date:   Sun, 5 Mar 2023 17:11:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 03/10] mfd: rt5033: Fix comments and style in includes
To:     Lee Jones <lee@kernel.org>
Cc:     Sebastian Reichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1677620677.git.jahau@rocketmail.com>
 <606950da6f4b36f5a124ff13756c78644fc89804.1677620677.git.jahau@rocketmail.com>
 <20230305104835.GH2574592@google.com>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230305104835.GH2574592@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 05.03.23 11:48, Lee Jones wrote:
> On Tue, 28 Feb 2023, Jakob Hauser wrote:
> 
>> Fix comments and remove some empty lines in rt5033-private.h. Align struct
>> rt5033_charger in rt5033.h.
>>
>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
>> ---
>>   include/linux/mfd/rt5033-private.h | 17 +++++++----------
>>   include/linux/mfd/rt5033.h         |  7 +++----
>>   2 files changed, 10 insertions(+), 14 deletions(-)
> 
> Applied, thanks
> 

Thanks! Does this mean I should skip this patch in the next versions of 
the patchset? Or should I just add the Acked-for-MFD-by tag of yours? In 
the first case I'm not sure what base to use for the next versions of 
the patchset. Sorry, I'm not so much familiar with the procedures.

Kind regards,
Jakob
