Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99C716AD21F
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229919AbjCFW5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:57:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjCFW5K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:57:10 -0500
Received: from sonic303-21.consmr.mail.ir2.yahoo.com (sonic303-21.consmr.mail.ir2.yahoo.com [77.238.178.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FFAF55066
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:57:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1678143426; bh=XSBz/sbloJzyHXx4Q7tnCEBikxS3m0uN7IkqFail+lQ=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=I0YzCmHtjg/Fi6ou1e3gpzia0ZaLoZ/CBSL66f4is1wpgTGE1YjtTf5pENkBb1g5Kyp0T5a1S+SXUD9EvBn+lK1Zvxo1VTSQTXWb5Tskwu3rhcKIuo4LVO3N3ez6JzSHB8HB+vYl3bBvSFfxiZJ+4wRGIX1X7h9UM0r9TzwhpM22yo//5SbJ2JxVkb8xwXBygHE/wdvg3p3rHENQsA5NiJrQVcd8fU3rGmlDN+NSQzAZahYR8BSlCy6Q7InvrPHuApEIpAXJm57c8goavoludt8l24qe6wxJdoEsGwhFEPXxeYk8p4RruY22sCVVM+i3tkLK+n4YQKwqqzx8RrxRjQ==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1678143426; bh=99AJE0orR8p0MB2Jm3rQ1HFqgTJ/9qwOmgbe+q/0kLG=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=Vj2TzfTMDpl11vAwCUAIyYXotc6BBTiErU2YyAhHE78hJTYu7RRjLV2P4TSK+Rpuxhow16y0C2WLoywwKzvK4OUHW1EThrH0fwPzm/bT+ku5y6AOsJhzI1Ts/UhMPvyjVc7Gmjn7HMQXzuBveYZ630EwnBXh9CHR3JVfMX4ta/kNt4s3ZWRj4iSiLxqCLL4Ja6QNWjLdO5C5aor1Chv1F0jcrDTkqsBORyj8yK+y0m/EOAMPCZimzRjpqHcFZkxgZ+Drs/ZQrqjFafbub/McVqKB6/JzS+nZTGaLxVLuZwI9bOq5PcfjlSiH2kwCyFnYSRqW6b5vK2B8BAJBv4uogw==
X-YMail-OSG: PPt8Y64VM1mLJQbCnv2MOlZmRb5yXuN2EZPv8mK.ytdOMLfh6iyTXVbEXOEfW2h
 i_X7PXchxzHpMd7HJzXNBPISYv7vCOSk_q6ZqZ61zr.3jD8b4G5rPnCYTWiYR9u224EeX0PRqtoQ
 YRWyfXj4AtuBvxMF_SXDq7HOtCvQt7XR06CoVleYoZEFodqTIdt1lAuGnZDn5Oz6r5h53v6f7WFU
 PBdwsvgWzgZerqXBHQtpAGniskm6liYvsPwOiTF9oTFfFpTG5oaTyDmplz9poMX_aRevaiNqD1j3
 EylXvz22Woqz8gBArkq5pedlDESauwuEs4eaTw4IppmbudTH1M1V_kNMSmNVddHinw6yqaeIguke
 elKNtjHOWz.a.rQAbqUG.LOu6rZWHJkQwesl3gc0CiVTrpJrzcn_2gsg0QHxd4ET8hmBdK.88_3_
 2TxaCqk4VO0o14VmEzDeGEesr1tgAWAdkswvYCSMwmEcXKriUMx7M0wuaLWBxxwyZiMdBa0dPoqp
 qNQ78IygqNxjuyCPeS0Ha4J9OtEbk08Oc2i4odyL_IPQ65bZMC5JSquIvx693b80y66JZ8u3ZMSI
 yGmBC67fkdMb_72K09jeqlus6Yom8lI0HBI9Z9mQVGt5S0UI1ZMW4uhNYTaLilq6X48IkNtoSPjJ
 OPu.zTaYVMBkVwqdJXzvJNVM7lsMG9ewzBStWflfBRop3AKZvwYtjsr21cl_X1i5C_XWH8uS8ttV
 5w424O412CXXWqbfrtPIF6uU2MZVcfnBZEKw8Qm8X1lvXRapJ07sp9QCfIQgvPq9Odn9lwbOD.F.
 skzlJE4jq6Hg0zTnndSvYpXow.nHXVxs5UCx9NjE2WIfshcxZuDZ_fG4gIWGnAVI2nCCSShW4sz2
 WTcna2DoYgqdxotMKeKAdx8UUkUsMX0KowT4vtfbqBoFGKXoFzEy2FSpI5YVn1IL0HCxL1AcRUuP
 tJ2wyDNgeVFw9yONZcf7fSuk0w0txmmioDYv2yymFPJbspfTm28JBx6jSLbjs24B86Ogls60SS_l
 blEuiY6vE1kKqguLELthfPm0rukfSTUBDJctTJ0xtl47daioARpmrXw1EDtqy.1yA1hVg8Fdu0zd
 vHLnAWUrjeBdV.qBjZiDngbfaXqNK4vk_0x0i8cjen8hvlBMMe3dYCUnxZFuOOtwEqcr5WNitzsX
 wukzu2FMi9dG8uuzMzDWAlqGwnScHHW9cHt3iOPnCqZI_8Mz3hQpwTPor.y.p.2yXwQbpwCfIoGP
 2BFXNR2iefbDcnwO6.3WmVtJa1SrffP3_kNiOKoJ8luIQu4Un3VUL5szXrQ6sGQA7qHvOZLBntw7
 bYEmyQSFZ272W6IL8USATbCOvMqSFNw72qAJm3dbT_AAiXOXMSad9nxO1ZnpzRozG9.u2xcpmG9X
 Qp_wxm8DoW.03zXY5cE0MaTQbMLh30jXYEl65gh_GGo.D19Mg_ZON8l9s_OJOm8fSdA3xBtgQYQN
 ivoHLTu.JVrUDBEVGvU9E81Ki0_JJ6XGqwBqWHgq8JoPdutnE8GUEtgZuo7TcgTg_QQvyu5EYsqB
 5C8pT5s07XaymnzgmJCYrNWMSxT9Jz4WBTDUU9GQm51qWoHUuTh8HN7xW_0PUC2tD1NHeflThszG
 KqEFRE.nH41M_pbXneFuF6t38y8LCG5gzeVpBMX8TithaB8jqHeYvKSSqMWtnNVbskfO4vGPrAJp
 U6F4J8skuqaKH6bMJ07fmcY07h9kq8DrxX6wmy5pZ1TVDJGTt8Cl.Pxi.lrBhGRqrTUjoDMTWxCp
 kBrIL9UoONZL8I8ctZGkCCC_HJQM1y.5BFMfl90gtkkTVZxeQbMy4MER.thVuTaMvg4skQUT6c_2
 N7c4bN0jHkbflPy6GX.gr4jzDK58xNHDO55szDNKcV1Ewz0L5Wu8KfbzwU_lUqAQx0Kti4za.34J
 DQ2cu5CSE8BfFD51RSqdLt8kvV1mZ1.NN.09FWTlgnI33VoKFsyLDOFmeEF8d2W1Z1pPDJKim_29
 7VX9scm7.39vW8_AOSFGa3bjS06cg7ABRCGh2bKveMP3Oc6GhxjvZ9Gr11goj0Tifdv6tdQGVkJb
 E9EIzq8Fx4qaPDjIPWq5nPByiG9rjwzEVxg5E1mwol1GX3wJ0EXushjUzmkzEhDu5UYC3uJU3VsN
 nvlBrcVAM1E9aBeMEeyYGR.DJag0s0I3sbfF9SojCux18pjP6L9o.cIOxQ2mrAq6d6qDUDbeOOKC
 i884e64ffPEFjAIm0LgOTVyKx2Qvjen1KlbmXW1kafhzouqU5oyZtY9DOONTkTAN20sbxlVbPVgI
 uM0uFLzKIYi9Kiu8SU8W2dlrNPsR9WQ--
X-Sonic-MF: <jahau@rocketmail.com>
Received: from sonic.gate.mail.ne1.yahoo.com by sonic303.consmr.mail.ir2.yahoo.com with HTTP; Mon, 6 Mar 2023 22:57:06 +0000
Received: by hermes--production-ir2-5b7d458747-xwgkr (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID fa2112826ed9439f5fbb2bca96b124cf;
          Mon, 06 Mar 2023 22:57:06 +0000 (UTC)
Message-ID: <66db70ea-9605-58c3-6f2c-2195128193ea@rocketmail.com>
Date:   Mon, 6 Mar 2023 23:57:04 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH 02/10] mfd: rt5033: Fix chip revision readout
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
 <a667a64d0cbeef00baed2d4b117ba9f50eaf3988.1677620677.git.jahau@rocketmail.com>
 <20230305104704.GG2574592@google.com>
 <96c54beb-228c-d606-5b9c-613ee2bc5e70@rocketmail.com>
 <20230306091843.GE9667@google.com>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230306091843.GE9667@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21284 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Lee,

On 06.03.23 10:18, Lee Jones wrote:
> On Sun, 05 Mar 2023, Jakob Hauser wrote:
> 
>> Hi Lee,
>>
>> On 05.03.23 11:47, Lee Jones wrote:
>>> On Tue, 28 Feb 2023, Jakob Hauser wrote:
>>>
>>>> After reading the data from the DEVICE_ID register, mask 0x0f needs to be
>>>> applied to extract the revision of the chip [1].
>>>>
>>>> The other part of the DEVICE_ID register, mask 0xf0, is a vendor identification
>>>> code. That's how it is set up at similar products of Richtek, e.g. RT9455 [2]
>>>> page 21 top.
>>>>
>>>> [1] https://github.com/msm8916-mainline/linux-downstream/blob/GT-I9195I/drivers/mfd/rt5033_core.c#L484
>>>> [2] https://www.richtek.com/assets/product_file/RT9455/DS9455-00.pdf
>>>>
>>>> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
>>>> ---
>>>>    drivers/mfd/rt5033.c               | 8 +++++---
>>>>    include/linux/mfd/rt5033-private.h | 4 ++++
>>>>    2 files changed, 9 insertions(+), 3 deletions(-)
>>>>
>>>> diff --git a/drivers/mfd/rt5033.c b/drivers/mfd/rt5033.c
>>>> index 8029d444b794..d32467174cb5 100644
>>>> --- a/drivers/mfd/rt5033.c
>>>> +++ b/drivers/mfd/rt5033.c
>>>> @@ -55,7 +55,8 @@ static const struct regmap_config rt5033_regmap_config = {
>>>>    static int rt5033_i2c_probe(struct i2c_client *i2c)
>>>>    {
>>>>    	struct rt5033_dev *rt5033;
>>>> -	unsigned int dev_id;
>>>> +	unsigned int data;
>>>
>>> In terms of nomenclature, this is a regression.
>>>
>>> 'data' is a terrible variable name.  Why not keep it as-is?
>>
>> While not having a datasheet for RT5033 available, in similar products like
>> RT9455 the register is called "Device ID", the first part of that is
>> "VENDOR_ID" and the second part "CHIP_REV", [1] page 23 top. Or in RT5036
>> preliminary data sheet the register is called "ID", the first part
>> "VENDOR_ID" and the second part "CHIP_REV_ID", [2] page 27 top.
>>
>> I wanted to avoid confusion between "dev_id" and "chip_rev". Therefore in
>> the patch it's written as getting some "data" from the register and extract
>> "chip_rev" from that data.
>>
>> I could change it to "reg_data"? Or something in that direction? I still
>> think that getting "chip_rev" out of "dev_id" would be confusing.
> 
> You're reading from a register called RT5033_REG_DEVICE_ID.  I don't see
> any reason why the variable you read into can't reflect that.

OK, I'll use "dev_id" and "chip_rev" for the variable names.

...

Kind regards,
Jakob
