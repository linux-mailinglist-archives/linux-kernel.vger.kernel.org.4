Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A30C86AB159
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Mar 2023 17:14:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjCEQOa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 11:14:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229510AbjCEQO2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 11:14:28 -0500
Received: from sonic301-22.consmr.mail.ir2.yahoo.com (sonic301-22.consmr.mail.ir2.yahoo.com [77.238.176.99])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3709C13DC0
        for <linux-kernel@vger.kernel.org>; Sun,  5 Mar 2023 08:14:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1678032864; bh=p75KKh6R36Q0Knz+CmsNst/5CA5AvrTLTrRrW2802z4=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=fKo40SdJ0CWtI9+7DUBgrCZOKrjdNDM0CRAFivVuF03ccA79S5N6bVNEbqY5DJ+tTqVKQUNjrunbu5YmYruzC2a9uJal2jzVJ+EgBIqO5pY3HKNl7PXr5+NumBZThZ5mJwa/zD3yCo6TQSV9qAEXD1I1/974e1CRQn9vDTN4nMJ2vtkBDwqNa5r9lRV+WoP78rEKfkNxpjgB5KNVVGKhKpS4Hb/97ckl73jPO09RnKuYOb7emb96cjj4hGNcRAlXlp//AkLNiof2LznE5Y0cv5iwzOn+9QNGUYdJgh8m1Q48nfPxin10WL475DpgpysnxTnAnyoZInpzG+/kj5kIMw==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678032864; bh=WEIEOMeVEHLPFzSKXhg3TnZhlBOh2mPkaMU9HLFa63j=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=MdDp3lXmXIx3Gfcob3y9pTYYA3JOJUF1gaeIzIDt7eEaDGh1kFmTAdSLYvZPnbku63QCdxSmkuCq+1cCCd1RZBkmvsJzR0yhbbIYddFPLuDQ0JlGxyFJ5dXyNDP/QuWNBv5aV7SPTyzbsOm3Xa5o/fNCOHXk5AYkfy8OQXCDxg1BOFq/jChEj+kJCiIAWt+7yAawD4wxs4Kukys6X1EtFcCebOZKeC70BAVEsahabgZ9BBqB7sJQslSd/1Gjy5q+HLFry3pHRAOEESGo3yQ8WO7lp0IOPA6bKfUJ6Mqs2KlE++VnG+QyXa2F5V5qL2W1PPZNKGM4kVN2MyhEtqkqnA==
X-YMail-OSG: jXpvQLYVM1lldrKWCdTkj9gZXbIeCnjhff_uXlK9uPT9yp0muabLm6NjFMPqdPh
 2r4FziHYmv_7_ybZCQrnXy1EqJsBFOlfg0ClZMd8ePnI7S3Y3081kB_oIdA0D8kuER6GNR5cf6ja
 sC96iCfFZ6VOumhNhAucSAlOSNT3KcXVPjy3C2mKwm0Lz4PJDmvuLW0cc2gCSZwGQ5BWuFs1RQM0
 wLbdfFifKQ1qYeHU7807FybDVS4l6pqDsixDYTH1WiIp8k5Hhzf1ZL4wp4vuaprGcYPWk1miu2G7
 CqJnPQcIaxdaezTySHctW_WMSXSEcTmpZTbTfy8y4kVwN9c.Jbw39GHWLVsQ.ov0vC7W6FKwp5xG
 1noEdUcXye0lxgQ3bZU7BPGt5YYeEvapbe5lFpLfyzodbkdfF6ZB5yjw32X81jE0Eu0b5xN8Mg05
 j.DMnG8R3jSoM3VG54Rl8u8W3kCG50fNZVeK0khPbnGXMxXJC30xHOfWAB2qi9I7v8fCnVklbNcf
 7aSDv_WpArK9fBJlLdGVtxhjnm4VENNUI40TYVZUlrPvTyUKGS2C6KlIedCnqRyzkFh2YevipK.D
 1NH7LdYCAKFVLZNvezOiTV8s05dVF4Gk1K.IGgnY3NcvU1FX5QkOazvkuxFNgpUetiLoKaJJGLJ5
 akI6vdsjdLNhYBfshg.5Y1H8laKOfTHSKZTR26H2BsqLgd6zWRiopiivVnkKifl5H35_7NEzL.yI
 tW.AsrFLP4R3Q8qn67fZCbZTOlmBobvF4q_4fCTgnHHgyVru6GoiWA9Tf5kPjeKegUtoctlVCdIS
 9eaMJ6GqoS4G9i971YoOGHGr7kxqyW_Xb5nDX1RrmIy.QVTpqHqHEeazT760eQWMpwOkcz.KNpQF
 1Pv7gaNFMSu785MSEBsMOf06QmfD4BEz.H1MTQVN3UMOCuL3a2C7oFcieD2AN2mTyTHeKJR3RFpo
 WNbYIzH99pjs3YGYXIQ0J58FEpzPmPiWRR.41sss4bpfPRKC6vYpp.6w68fq7B2fUrcNJqlJGU00
 6_YfRjCoFs91aAkNm.iRc_N99zdVD8owLHNMWcmvT.h_oylhzyUeNFFqCpYgmiO0yPcftzfsI9Jj
 Gn4zm4hJI3LjbXlG1PEtZytohoRhbGIKmteJKjqD8GQMrGHINMmnmwH4I3qVB3I7JBGvvRJUZski
 DFFaLjtAJm9C7C33kdqLdH3EiTToSzeu.6XhIs2Flu2fmU8kt2.iHepQrhinCWsDgpecryS_gk9n
 qeU089vNJ.PGfhPkZ1rQo1fws553w8LZH194ivqjUQyDGhZ.J77O.nFDxmRK32_xWfQwCD7wdqs5
 nm7l2ttBqdVdDFp2Cp1kLsHCiRe__9Pp1hjj5iKLkJnLQJn5jS5Wkj6QM0wV1b48ja14kXoO6gGH
 IwNVkAA8151WDy6uMKOtJEEijfVu6sAH7.xL7HZQXiHC0_Vi.xXWV98DAcDyMW7ikTch0JwFQVce
 BhWUL5VBo4Osl0o2UnwD8FaIPVL60P7_QT4W3kg1FUKi6_KPFk4OTE5kjpP7EVaHARWEwJ2_znHU
 HY.XGcw7TqKxPb6sOTCgEJN2zZ7QymV3PLHUfHVd9JKtFhku_s_L3YpE9YEH7UiFPAPVDNXttpt5
 a5zqf0vcvd08HnWsue5mM8OkESFOqNlJXUe.noD9uezdTdrEGdaUmp7r1ktGwoL5uV.TlKUCIUDm
 e24_W7Ho8qHObMaN8X4TM42KV9debODgeQo9zl51vGYNMKRTvyFPK1zBCBAmbZy2QngQ_y8WVtQQ
 .lZYT220UbZ4NiBiffpD11V11J6LfVHGItF6W_xiLaM3eLj8NX3ksqyrH.h_8eZyyYGVe_g7aFCG
 9jdHAvlyn5IUsxmEj6IEJV8ucDQ2fgPb3ADi6CJT6uUAFe1Yr.y8bXfYXyxAzyGVmjGrDfEiSF29
 Dt.xym8BjueYPrXrAxlmvIQamd4XfwGA7Ff4lXy7H.hlW1_tlLmxuUxvFaQxHVp6AkmovVBx_sna
 bEv8UPeTZlhM2_lrguTZUirGIUM9CNAaDW8Uc8uuGjMPT0qbwMg3xF0wbikTxUF64IHvMuTu3nIp
 Az4AcnEK7CFJddovC6wxG2JgT6BjxT.7NjyJMPKg5HECtzAcR_h4ZSacBc0alVNPoEymUOKKcJ4Z
 JDv6uM09N4EN6yzPFO5supCRw5E5w7.wBU.ZDSrSsOGphnQyqBzDCMXGHjSPdGkK1y4upldp4yxP
 IQj64OEt.QNc.RTCmtA4AoFOjB.BVlWeOZ2gNeEDT.0k6Yt5I6RzfwnHsmUIf7fcQFKZkgBnSzyF
 2A5vcA.Wrg7SnMx7SmN3irW.w7mtf
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 5 Mar 2023 16:14:24 +0000
Received: by hermes--production-ir2-5b7d458747-grn8r (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 1d2fddbecdb94da144c4d8cdf4e4ee4b;
          Sun, 05 Mar 2023 16:14:21 +0000 (UTC)
Message-ID: <9ce4110c-eaff-3f8b-65da-8407e05af493@rocketmail.com>
Date:   Sun, 5 Mar 2023 17:14:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 05/10] mfd: rt5033: Apply preparatory changes before
 adding rt5033-charger driver
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
 <4edfef7fdf129185355d4dd2d3928d63c04bac73.1677620677.git.jahau@rocketmail.com>
 <20230305105551.GJ2574592@google.com>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230305105551.GJ2574592@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21221 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 05.03.23 11:55, Lee Jones wrote:
> On Tue, 28 Feb 2023, Jakob Hauser wrote:
> 
>> Order the register blocks to have the masks in descending manner.
>>
>> Add new defines for constant voltage shift (RT5033_CHGCTRL2_CV_SHIFT),
>> MIVR mask (RT5033_CHGCTRL4_MIVR_MASK), pre-charge current shift
>> (RT5033_CHGCTRL4_IPREC_SHIFT), internal timer disable
>> (RT5033_INT_TIMER_DISABLE), termination disable (RT5033_TE_DISABLE),
>> CFO disable (RT5033_CFO_DISABLE), UUG disable (RT5033_CHARGER_UUG_DISABLE).
>>
>> The fast charge timer type needs to be written on mask 0x38
>> (RT5033_CHGCTRL3_TIMER_MASK). To avoid a bit shift on application, change the
>> values of the timer types to fit the mask. Added the timout duration as a
>> comment. And the timer between TIMER8 and TIMER12 is most likely TIMER10, see
>> e.g. RT5036 [1] page 28 bottom.
>>
>> Add value options for MIVR (Minimum Input Voltage Regulation).
>>
>> Move RT5033_TE_ENABLE_MASK to the block "RT5033 CHGCTRL1 register", in order
>> to have the masks of the register collected there. To fit the naming scheme,
>> rename it to RT5033_CHGCTRL1_TE_EN_MASK.
>>
>> Move RT5033_CHG_MAX_CURRENT to the block "RT5033 charger fast-charge current".
>>
>> Add new defines RT5033_CV_MAX_VOLTAGE and RT5033_CHG_MAX_PRE_CURRENT to the
>> blocks "RT5033 charger constant charge voltage" and "RT5033 charger pre-charge
>> current limits".
>>
>> In include/linux/mfd/rt5033.h, turn power_supply "psy" into a pointer in order
>> to use it in devm_power_supply_register().
> 
> Are there no present users to account for?

At least none I'm aware of. Within the upstream kernel the 
rt5033_charger power_supply didn't exist so far, the patchset is about 
to implement it.

>> [1] https://media.digikey.com/pdf/Data%20Sheets/Richtek%20PDF/RT5036%20%20Preliminary.pdf
>>
>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
>> ---
>>   include/linux/mfd/rt5033-private.h | 53 ++++++++++++++++++++----------
>>   include/linux/mfd/rt5033.h         |  2 +-
>>   2 files changed, 36 insertions(+),` 19 deletions(-)
> 

Kind regards,
Jakob
