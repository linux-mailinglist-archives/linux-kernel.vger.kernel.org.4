Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA826FB85B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:37:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233462AbjEHUhL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:37:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38086 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232941AbjEHUhJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:37:09 -0400
Received: from sonic312-26.consmr.mail.ir2.yahoo.com (sonic312-26.consmr.mail.ir2.yahoo.com [77.238.178.97])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D96D558F
        for <linux-kernel@vger.kernel.org>; Mon,  8 May 2023 13:37:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1683578226; bh=t4+SrCPMdRcrKZEemyCVdw3uY83K6P9r2Nkbak5C0J0=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=UmZU77EogypVMy21ccwpymNjkFS/Sg+PiTuzjfAr21uubAbLTRqUvrpSz+Sr+YjStisMbgAi+TNxL1kQh8QGNWAcvhWs39zsVfcagjYbF2MJqDCY+hh045m8Xl1tms5y+ALSS3u9TdYxCfye0tjIDzP1Dh3u3vnC93aKiij/iW84p3IApPMCGv1eOcnBxFd43Fkw3v5frsE4tKvwYPaKTCtBu3Xjxal3jYX5nILzk/tOY9bxDKU6CkCglaLgslrB3P/+FypojXj5pb8Qa7QT3ukyguuH2NCqrYIvvlKW5TAqZoxZ5gkxRm5+XWv9F4OHF0RrNCh+/6vs0cFyNarcLQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1683578226; bh=C4tr815zQmBO8Wf0Gsz6npblhY+d2wq3Ptw7Slh6ZGN=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=ZOlYJESBaTs/42RQbRxOih1RJUn1huBjkNq68sFaE+bgYDTYiNPPYDkFkQPa/BBf6RamJy+waGaZaCQOdIzLwdQ4hca/om5SyXwNYcasxxWI7P8lyH48bE4l815xc94C+H90d/MqhJ2TdDWa60adS/UeUveTocT5UHH1CXab3eEt0UtEQR4onc+8hCOomS9N7MgKRuGrcRZRCIJM+VTuQNskl3vkWDK17qYhN2KPHCu5fiEjo4GPXoMj+v+O6aoKBxTz8qyxCgGMUBrcW+FaUDG4loNBXpqUGMHHnyGK4/i+FNJRUpCvZW73NHtV52H91oxXyUf3E4TSzCSUVOms+g==
X-YMail-OSG: NuhPGH8VM1kycUfNI86TPRU.19yU3NIJso6_CaXPB062ZVMYAhxAnpsr..JxcWD
 9tGvzkYTWHZQRbATAt29w07korQT1LG3.2mrvy5zZJtfMkczj_CxnNVlbgjhAf2ciqIRzIHW0j6N
 SqNaQzkmYWCY.wIj.QjEeeJx6OZjUWyq3xXgouDOSdFIj3PFVhMZypwV99CjkS3nYznLhUg4Kq5G
 PgknInjRbhCqd9ikPHLEj.KBWRjy2Q.OxEkqwcnLFMV1cl5D8o0Tbqs0fhx5DFVVzPjO4XQVsFuM
 0V1UP46dg5wQ24E_YGZAqW_kPPGE8PHWFuIL692__LHHMeL_o3J7EYZzo2AYRQPm26fZi8Ui07AP
 gqpLtREajirYzdSBuIcDVgF9bzGhHwczG5D3wjsfkq58cIgqbgKDz7uIPmFL16gbpSUoIKUzLHN4
 9faAuqSbgUAg.Za4ONB6xM6aLB4rcyDYoSnO5gDdrEOF9.8iQ9mFXrXdbQ3p2Z6xYiUNVEzoBo28
 tv.MllwHwwWSH2zYXyueTlF1.AbnTzFAxWYlg3YFgxg5dQl5uq0FQAy9ZeIUlxkK935jEteOXPdt
 Mqpfr.JQUWT2.J6OPEN_i9KzXLR9r9jfAnCwBSAq6z9Thw1d1VILzCB1esCMWS85S3EH6Srj.oQh
 otBFYJaraGdwM4bwDQ3rdPj1e8RgpRR6H7YLgybcMlyT82hXyMWs5kh_dnIiCT9PKkWDGZAMyecN
 L.FuM_2PSfHksfVnRK1wx_L_bKoC3t.IcO1qQaxXwlNNvj6.X5dQNDXXrYBhoc9C965JTP0PdNhs
 8fIMae3rAFGAtL1nTI6O9as2e0xSCP0N5rcQezI6iGODg3leo4N6a.k7sBrtV3xSAMyxzC_1IeHO
 wxlnGcxVjoEwUnDneBMDwwtOnUhAF.K_2IEFzt313EaNY9_K19b2nq.uya3pPLmPR6sfSc3N0j5X
 vsL5IgXOBwuzTORL11wHZrC8wp9O0KubmK8YCPHzNhIW59ktBC6mKATVoU.lkkRJF3RHe9uNgjGT
 2hjq.x4Jr0ZmpkIM_H9tl9btM1o4uQwkkcuxpRYssU5Ti5WYf0z3NrXm_tKmw4jSyw4qswQR4_ID
 3FlxGKeav_qnI9VGIv4P9h7Upq.Odg.Zmz9.YD1IAaFzpuQtcFv237J7s6VTh1a3G0urxU8E.LQt
 gMrrxGPqyR5QAmk6MqrePcdOCowg9cCA5.xvuXbvsZEcUdwFa7Y_kWsvmJBuzbWT4NLvWyblwEjL
 4vBLSsNy0pyUVEWrI4AVT7szjIbiQtvzJ8sokkPaPGHEIL2K.nLpaMKgsrq3dHHUuzXzWawYjfxt
 dH6eRr7bbZrM12Xs3NFMcYL7GQBRAGcEF1CNmbOemkZnTGbkqgBCnAH9qqG_GuI_R86_xPXrvX7.
 i6aviylJGdmhoe6pFCZ6s7gXi.u19.sY42yvWf1VAG3LZdcoumEu3nsNeUSGoA8Eo8PpjnDTikol
 5RpGZS7k7ARFMB737TGAppfEJb8xi8rVRavbLMNlfvGTtWRjhMSHj3UTw8vHcu.B3rO0skcvj5Nf
 NiuGixfrGE7xoa8G_z4kjPS7kyGjShV3WMPpSbDuGvIOxMKwY.mK9XjBQF40QA7cWDnkEX2nBLYK
 aBmb_6YoQHtB8UFcZpcH5bXKQJAf2U0rTiTNTJCwctIPqV.A6Y0MB7bh_jsxd__dSKbAhuM2tncy
 zY5q8BKvgvtbOtUL3Q6mcnR86Sel6fFSrs3Bi1PwemzWLFVSqwXUC9.yAMs04pNA05sdxxDVqpZ8
 Tnu52m04ecHxzyHtMLBr_bjzfMt4_m5CPJmbI.Z0H2E5BWf.VMJvmmXigby12iE.DjuBq32JbMzf
 isTOcgQUmhj_rNB8mEjZ34ZIQwcelwYMsXnJz60rjVLbIyDiwaEe1vLBUuQ5eY_L7GOlkZJ8XEtj
 4Jr.0dzQolwh9MWKRw4YC1Hnm7pOzBU3rf4oKEnGTWznydtM5Y9tqkkpAqt.veJYuG_mjeBWv5F2
 DP.RnfVBrTnViDKssEs7iuDtltbx9wfqp_oEPapWNcAQgnylUY_l.iTgkVj7zQEil8v6yk0MHlW6
 C9YVIzlW0DbXn_XVga52PRXxVz5AOiIjW0NWqc533GrZQjGNMEY.VcYay7F9tErftiyq6rpPy7VC
 s0y9UD1MfgzzNlE.IZwwa3geCH5zBFWQPzEtcG7VU59Wm7SvMYaVN3pxyCqTWdpml65AgGwmPXas
 gQrRWPRJ8VuvDcx7KmPbJlP0EDJmCUPRVy3PkEmCYROf883IZbGme2rpldKaythu.hjc8ukR_zDC
 LQOc5Ih8-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 8660b609-22ca-44ba-9f7d-d2ad45bf4bc0
Received: from sonic.gate.mail.ne1.yahoo.com by sonic312.consmr.mail.ir2.yahoo.com with HTTP; Mon, 8 May 2023 20:37:06 +0000
Received: by hermes--production-ir2-74cd8fc864-w4pg2 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 0defa889196eb91511a25a6013c239c4;
          Mon, 08 May 2023 20:37:01 +0000 (UTC)
Message-ID: <c76035f3-3b7d-4a28-b218-8ed9e3f11014@rocketmail.com>
Date:   Mon, 8 May 2023 22:36:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 6/8] power: supply: rt5033_charger: Add cable detection
 and USB OTG supply
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Lee Jones <lee@kernel.org>, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Beomho Seo <beomho.seo@samsung.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Raymond Hackley <raymondhackley@protonmail.com>,
        Pavel Machek <pavel@ucw.cz>, Axel Lin <axel.lin@ingics.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Henrik Grimler <henrik@grimler.se>, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
References: <20230506155435.3005-1-jahau@rocketmail.com>
 <20230506155435.3005-7-jahau@rocketmail.com>
 <20230508114323.rzqbp2isvczzg3wx@mercury.elektranox.org>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230508114323.rzqbp2isvczzg3wx@mercury.elektranox.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21417 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 08.05.23 13:43, Sebastian Reichel wrote:
> On Sat, May 06, 2023 at 05:54:33PM +0200, Jakob Hauser wrote:

...

>> diff --git a/include/linux/mfd/rt5033.h b/include/linux/mfd/rt5033.h
>> index e99e2ab0c1c1..d2c613764756 100644
>> --- a/include/linux/mfd/rt5033.h
>> +++ b/include/linux/mfd/rt5033.h
>> @@ -53,6 +53,14 @@ struct rt5033_charger {
>>   	struct rt5033_dev		*rt5033;
>>   	struct power_supply		*psy;
>>   	struct rt5033_charger_data	*chg;
>> +	struct extcon_dev		*edev;
>> +	struct notifier_block		extcon_nb;
>> +	struct work_struct		extcon_work;
>> +	struct mutex			lock;
>> +	bool online;
>> +	bool otg;
>> +	bool mivr_enabled;
>> +	u8 cv_regval;
>>   };
> 
> Please move 'struct rt5033_charger' and 'struct rt5033_charger_data'
> to drivers/power/supply/rt5033_charger.c; they are not supposed to
> be used directly by others. Making it private helps to avoid
> cross-subsystem series for future maintanence patches.

Makes sense, I'll change that.

For completeness, I'll add an additional patch to move the 'struct 
rt5033_battery' [1] to drivers/power/supply/rt5033_battery.c.

[1] 
https://github.com/torvalds/linux/blob/v6.4-rc1/include/linux/mfd/rt5033.h#L35-L40

Kind regards,
Jakob
