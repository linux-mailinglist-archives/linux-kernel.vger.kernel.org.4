Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B46606CAFE3
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 22:22:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231956AbjC0UWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 16:22:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjC0UWN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 16:22:13 -0400
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F44530C6
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 13:22:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1679948529; bh=Lp3cV9klCyxkQCSTcYxlGIMNTmYQI8olxZQ70AOBqjc=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=klmY2vn1YJDUubToOgpROOgJBC9u89PZl/6BHQPycsE6by+jTDoK+D8kcvIlTNog1nbZ18kzKRPc69lOsvS0U9HB8edo/cc1jtPgYXOsH8F67Hkk1TcBzvi+SHvpvr5xT8YjIodc9yhYMNBnuqDVvkdiJ/tzCmJDoMxvPJ/JuW1SHlGAY1yLHAbKSJzLhMQFPX7AFUgDyM2al3yhB/+pyfaIq+wjvxdn7Sa49zOned7eLMXNGzzMJTufOd7PodnkjQX+sA3wfXUoTxv4VANDrCP22E38yhJ+rdATDVTOy0nM2XOu81gKv8zWUjoZ+fFQz6WD0z1F1cddZ/Hu2G0gwg==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1679948529; bh=7iYfH2GeDA2V4GIET8TRq2RsO4Gj/qBB0VuP9mOUqy2=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=av3n9rD8lArDa0LbOxUQnoYOfwrBaelb7hLy5WwOSw99otQ1ptrqt+zUbYXB1ePCfMoKiPL3XejGW3vscSzlP3mp3iMloQ643lWT2vV7vKJ8SamlX7NHaC5/esQwJZr8bxQitlEHFZLOVvdt6BqjT/fIVOACQPPl6+VI5qcdLr1HUhyC0tMa4bi51qcf9mXNHsPXzbrLL1vcQ5Mg4QKX7zfZ1PkSCn07vmJ/oF+5ZXInRUk0L6BpSuyLZnW16v48CoIq7zU4D7xl0QXaAJe1mThMkpP/hGlpD/EbCznqL7e7CwvVY75436aMNEqLtRMFYci4wQxmZ9hVF8YDtXalnA==
X-YMail-OSG: q7PDkaMVM1lKhsa4YX2IsXwZ_kJtGxbWJlLHOVtF5Mtm2HAcLguIeZu3rpvoxLf
 kG6ba2sDycDMR8mEuPe0PXPRN2Y.cO5JllNVvAd6MNM0a1eEzCjCwRmMvF1Cz07rPOTUdD03X.cW
 MS6VwzhwuVD_kMyDySBgANMLPP0bPEYLupWeKiMVc5gelqwK3rztif8RG4kUPgHkQeSmkP_4aaan
 9eoJ0vwkZyQYMf3b5mPNXVwsN_wwbe6hwPbR8S7gxScxqbORzqMx7FM3chXo_Px7Xn6eB_RZywxE
 HSY5khol8uLAmzMHwhErA6YCnltsiL_xwrwr6NdH62YiO1oQtdeVBCSS8A7CR456uvrHz.75_dZs
 8JHwYP6mvyt5Ot_M2z79uPcCQGVByfrPj4Mi8dwalQVGXFQqZRZ7qZx5MfL8yAbZkjcqRaL_NUP6
 TQkvqS0DOcLD14sVyRHv0Tyg6UNJyCOXdDsbOn7l6vWIY6qGWSI3HkvJQLcTdTYr3owv_3lI4ZPO
 _lnWGe_qnAmSQWqbxNwlyq7wjhaokVbFiGBj6PKPS4WcDKQRoLhCN_Q.v7vrXhwLihrVgD3.Whig
 cq499QPzcJoMpa7SU431Va_pLcxZZSASDM71s.eCxfMlf6F.2ln7AVfl8IZCHHjNj29CgR0HVggM
 R6rY8IV37LpJhN6Zg3_EggfVlXPFqVmgZSOVcprw7B.Yxo39IXewjLw.k4wK5P0Qj.jbapdSOche
 CH3mqwQVZaXv5ZQ.v.amI9zf44N5rU3lY5FC5FPVXeHZX1Jcn1T9v5CF3tXiwm8M7.Ni9uskSAG1
 lTEtqHz_Xnos8g6VIGgX4no4MABNdbQvTOqQ9gCPjO4VVHNCixVspkwbxPFFOrAX56yYbj7nk_co
 IgcMCnhpl2QVZNBf9McEHvdB1K4o._S_zh.soj4GoBcjJk_XRmBdricLN.OWWmKBSXbVfqRrfgKF
 D7Z8aqzY5Q_riTrUYuq9NaMGEhFR3XpyFc5vgkfHmEkW779f2BNlBADcDpnQ9IRk6YJh2gDF8O5D
 Bt3_3_nfNsVA_D9mu1LBCmZ_nSd.1RcHjM1DdvqRLnHsq0XilJRYUr3zhzpdy48YE_AYUqH_SHfO
 4jFcnIq0s1crhtrfy9MCINiZl5PFD1dXKOssnswL3Co5Anw9XA1QMq4rYG3y860WHEUqH0PB.X0t
 2gJVPJ82ChqTMzSASjNXR7Rcsm6ASdcrtpK8zZO7tUte6F51yi.y6tBmmJGLaRTflqoBX0TfS2EO
 yfKAWF0XhBRE.Y7tgAyo7fcUIvEYJskZMQABCzCPtUnKKRvcdr3WgqKxxpvMBaVWt1yZpxPNs3wQ
 0ezPFMeiXhFYJz_srednxoiWLVNEZUyG6DPEgAtAXTNeleYb6z5uXIH9kBQf7DLHgXBQUzwytZl.
 O3haDR1.pyJWrLe9Kxsl2jXNtMqB1sQ3Cuy1rlbNfnGlfOeRiKfHOEoyvUhX7BT6xTQPPLVvhdGu
 M3JkN.Ayck1wjLCLqOlPzBql5V.KoyJemabxY8Sbtcmn.4EVRr9za2C4HdQdRsplVTfTNyjYp8jY
 ng4LiRBCEnss3T3eQlyLNj.rITeIBDBHxCoVyy_xCaIBFkftdw9RLtLO2jZooT47H32XW49t.2YL
 mrwoAGZ1ZXmAKoj9XlZbpZjVS.hwSJSCTvs_f70OPvAe8DDSTr2FGszRx5fpWwyjoMxpBpL.TVCI
 GQ9bhG95bcMlw.zFG88pgAx7_gpWOk5V4JJN.Kp7RECZH5CqFqLV5zbkc0mqMXV5ij7YGUG6cuT4
 Rq5FSHboypZJvHWn0meBSZxIMkPWBDWKB4ZbsikbzSRw4rQ97MDxq2sz.m0rY5QtgguGqjEMV67l
 YYNDxNaz1B7AAmjv6p91l1j_KN59zOKrNO7LCrAvLvsm7VJycnzqJ5orPzINS0wuy0mJ7Ha.ch8t
 hM3XkVdNLY_ttsOjxyQNQp0qf7HLz7By189jHJD8G5KfEXYzTeeP4Q8A0cRCRHoKVV8OXfMVfumL
 laGUeo7j.qvsRdLocQ3ULJPeR5WMvTvdhIKYspa3v.zKsznysp1WAubg.s2F4eQMdN8S_anfO6aq
 GTzjYt73k1oZiFAacSZGOBRTxYISLzbpde1BXQ3GoqrZn4jGS3bPCHtwLyBVjO4fuzByNgknMIVE
 MEm70W5TzFmT0Ia3.hEP5hahVEyR67SFzH.FDD5dth5nirrcgn2JkXn52j7rApG23kgtgUZGIAHz
 qTcyPu92UJ8cHTHTQBQzHaeMRhZHvjgdsVeStxoUPTA121EZ.r4QlOvlduIfyaY998euw3jAg4eu
 8a5Ilfyp.za7Spm1mQl5nuRk-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: a979ba60-6072-4ba4-ac6e-5e8a429e1c47
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Mon, 27 Mar 2023 20:22:09 +0000
Received: by hermes--production-ir2-5b7d458747-pvwxd (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 348cf5bb173447de6266ad670e12dd95;
          Mon, 27 Mar 2023 20:22:06 +0000 (UTC)
Message-ID: <4ebbbd58-e9d2-6d7d-63d3-d128840238cb@rocketmail.com>
Date:   Mon, 27 Mar 2023 22:22:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 00/10] Add RT5033 charger device driver
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Sebastian Reichel <sre@kernel.org>, Lee Jones <lee@kernel.org>,
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
References: <cover.1677620677.git.jahau.ref@rocketmail.com>
 <cover.1677620677.git.jahau@rocketmail.com> <20230325160819.GA1820@bug>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230325160819.GA1820@bug>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pavel,

On 25.03.23 17:08, Pavel Machek wrote:
> Hi!

...

>> - The third option of the rt5033 chip is enabling charging termination. This
>>    also enables a re-charge cycle. When the charging current sinks below the
>>    end-of-charge current, the chip stops charging. The sysfs state changes to
>>    "not charging". When the voltage gets 0.1 V below the end-of-charge constant
>>    voltage, re-charging starts. Then again, when charging current sinks below
>>    the end-of-charge current, the chip stops charging. And so on, going up and
>>    down in re-charge cycles. In case the power consumption is high (e.g. tuning
>>    on the display of the mobile device), the current goes into an equilibrium.
>>    The downside of this charging termination option: When reaching the end-of-
>>    charge current, the capacity might not have reached 100 % yet. The capacity
>>    to reach probably depends on power consumption and battery wear. On my mobile
>>    device, capacity reaches 98 %, drops to 96 % until re-charging kicks in,
>>    climbs to 98 %, drops to 96 %, and so on. Not reaching 100 % is a bit
>>    confusing to the user, too.
> 
> Is the system powered from the battery in the not-charging case?

Yes, at RT5033 in the "not charging" state the system draws the power 
from the battery.

...

Kind regards,
Jakob
