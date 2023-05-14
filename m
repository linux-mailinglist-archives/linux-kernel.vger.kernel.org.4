Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93FA0701D7C
	for <lists+linux-kernel@lfdr.de>; Sun, 14 May 2023 14:55:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233722AbjENMzL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 14 May 2023 08:55:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231640AbjENMzJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 14 May 2023 08:55:09 -0400
Received: from sonic301-21.consmr.mail.ir2.yahoo.com (sonic301-21.consmr.mail.ir2.yahoo.com [77.238.176.98])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3ABD1BF6
        for <linux-kernel@vger.kernel.org>; Sun, 14 May 2023 05:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1684068904; bh=4FWmRfs7yx3IOYIayoPinOb2mIoFyDgaxGg2QcZUWGk=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=CfcKA7Ytpb+JA8OE6ioIQG+MIp/8eyKdUFsA3pXDlB4pM3H0b7FqtN+rsnwQ7Aio3DAoeJxzM7RkUp5pU7w3pq+xGgkU8EeTDhmHYlqTUMHDAvr6Gkr36W19GHDBXwf1MBBS2ufUNczJWR2/5wQvEGCV8KRQN1xnrOZ1BOlsDnNoKDTrKo/gLF7xwbWC57NsHDWZ6HV3gprBYDKkDShQIBG3NgK8uFD/x3J8QyabDXQ80nQRKXPfRs7LgyAyuFpf5PrkYsMQCxRi3hZshBfO9ROaMZ0kHn2Crsu+D5I9vq6zPFH4YloLn73MT5oz70FbyAgvJnBURa5WFFz6s/k9XA==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1684068904; bh=rHgPN1HIDU+dzt5eIS9VyEQOLS00FFWUl06jFXgW9IA=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=gCbQCS7oM6Ad+66GHlUvKim/i/GzWoUK1vPsG065ocebiEXLupdbra0HOxruWel6PocVVeC2q93aq160XQfE+dNWdFJWs3XM+8sEw4lJ+bunJYUt0pbh1FL/S4Yj6muFHHonW3r3f7/WpBdKKkh+Evb4+p4VET230QHQBybtuNkLltA5i+CIDfgdPU+A3yF+Wwem0aGuvd7cZsr9FvtdWg4s4eCR0Z8u+kD21FzLII6ywsaDcbah2iLnsdqufnmq31VaqZWoQGVLgNT+uYkYFOJ2iABoIqgtiglkzjsgX0GKYNyB1nBvYGP63+ir2VlCePUbvm1BdpQuV36nnswGtA==
X-YMail-OSG: prDlHUoVM1kOww2zAf3gGm.JpiAui8OXRckEGcXorw6R9T1ov9.ffSb51UKwFz7
 VVYc3mAfaSPobePJTSDYBn2g5YxoTZlb8wOue9i5W8nXTgTetuRSnqtH8HN32eOzigoG.GHV8luY
 aHZ20e2tG4KmvlAQuoNsvp3PO82x2Ra2Rh5CGeKGhNljmZGRyTc6jBKrHRStprasDcPFw9zs8i1e
 54E8SfacQxvyAR598vFY4HtXPW88XE9mgFvPcwCL7BZ.Fv.C1QE7LWPzDBaDdcbmVCbuOw8fE7cs
 3XLox8riIh2rvbeLN_vyRqf0rR6lCsSvQEhbnDfszltK.IXiGIzu77YXCMChPbVO.af7q_onnfuX
 VFsVtIz6Pwo_BZltrJaIYQ5xBsaQTKB367XWiSZbUUQSY9boEPSEQWKgiceeanB6CT0kpTH2lOCF
 LTBOOmJ0027tpk8x3c6ITN6mUCXLSQVLffD5KTFOw9CyklnVN.pCL9zJZggWJ7wTLMhh4ghbIK46
 QgOwJfGXnCLf8iIYsJHFLqlD0_vnnpRJUZsDHwMmCXolNPSv74TFSv8I3F9ZsA5pNMKaYBlAF5TV
 8XNchKUV5WFB38YIIp6PztRdCIab5atNLQAu7RE.OGR1_IW.w7nRM4zOXtGaMTB500NF2co3pXEv
 sa7aRL662.x8mZmsJcgnjqih.TNNSnV7AML03qrE3jANXCusMu5sHN4nO0yZY3Qc6LcjtBU.OLZ_
 NKjSA6wlQuTEyxb8M8KI_09IUX8hUhhIl0vHjaoFYzHoH0tjwda2_FlyEHCAX4QyMxZQDhm.vG4G
 yJx35RO3yA4keO20lUChOmNtToLwfroCT0dvBHZvt9uKSjzNHYkLJMtOwCpCBvgXxl2ahDOIDUzc
 uUsk5_9FxxOYtwWZCUdamjp9T1qLNL17zprObUMCFpFvbkdxhw3CpKvYkYRemoa8pURuqoiN25KJ
 kKVOAtKyZafsWvxWxlkbw9M8udtVXpHgYuUJZ1CpEvhAoPHOnUgROsuklVBqEC49rtMqjYO3kABm
 qLIFJbg7zx1L9BkFWyilpSh8P3t4_hAqS.KObWi5B4sOqIyAcYlB_0gcJF._moGEQcBTOpMSy0Y2
 m3.TDwxDdxPNYq7Ljy28dgd1QCzdZoWXf2BZuNTvXSk2fT6xb3hcxix9TQ9nhibzhaOtY7PXFXJq
 d3LE_hpiLJHFax9V.BS3W7gTYs1nu2GVSJp7U8igZOyxiLnpuXqBIFFVxKxU9uUMZeF7LqyuI1vu
 8wqR.6h1bUfYkgbfAL_k.D42aYaaS_p_aM1Lhb1gDL7zJ1Z5V9WV6Nz917FQwMIE.fVKTEOlhQio
 wq9vXDBXvPywloPcoLVdKR4urhQ2Sn1CloLfrTDA19Dg0SVUI7EDIQcvaRWJdPr9ytxfnZ5nah0_
 N2xTXcvmjpT_GorEOEXNrn.u2FrZB35uyTs8qEDXLtWVbjpS3lei6gcmqoDZuDet2T4it3AT2cdH
 o9mBAcRhTTQC4mtlBqWdhB1slkcZss9AUIvGjXKoX8R6ON7ge6chmgizwT9CItJTUS4yvU4JPv0P
 De2fJRROnrkroi9row1h0dxzH1EcD8_lTgmLebzkTKZplgKMQYukkwGplAEeLJqruMClzhRBWz4W
 3fA_jNjV2eNsogDB4cXXfRIkSk_s3.uMJImFTE7UnSOyVrMKIPWFUG9cMP8fZokMCoH_vVjbaRpV
 hb6QAraGFjeXXTiJOaR5yph6Y4_mbVPh3lXpf4ueG5hzR65e0p8HFt5sEm6r7iJuEGHRiliqhMnO
 HmZqOFGTi71H96SQWktMY41Ef66JeVwaXPIlArC9ji1rZVHYT.sztkBLzNccZT9Nmhsd0dVbb4Rk
 m0nJtRpEvwL3SyVaIVoxb6xlgz0RvdN9i5KICcitL6tdj_0sj2pLxWs9YsEs9wzNiIdH_lvyEPBN
 uRnqN4bc0wkCHOR6t9rTOC0NsAVcokdrOqqPaP_7nr8V3Tn0cJcItQlHVDCsqvYo.xSsTZNMnrYk
 7ctlgGGdRYTXX2rL5stUN.V3GWU9CaHYGvTcjo.CdUSZarlMR4dkf7PRO5UdQs8xM0Gks0f_t1.I
 zbMjKtxe8YUXD9mXCL0hbzlXL0cxqtEEqHNDlQRjfhtBXyRt3d79rHSGMBX.JNDpga42XC0PnSuP
 sfliwICOCbga41LqKRJaVCVxMqSQFRBYw1XLsLB81uz1r7Yt2RZOMLJxLSCvWf3.5YIqU8.1mLpW
 Ch4ZIjfABmTVl8vDtkUHFmXOvCgNqgRtdh2VTMcd4UnY4_eC8oyxxbmMezBljOc.PbFSNeYEoZ.R
 uWI6Z.dzDZ1EkhfGuK5Q-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 5946cb55-2381-4bb6-b3a6-8305a0b4e364
Received: from sonic.gate.mail.ne1.yahoo.com by sonic301.consmr.mail.ir2.yahoo.com with HTTP; Sun, 14 May 2023 12:55:04 +0000
Received: by hermes--production-ir2-7867f454fc-mmctx (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID 971468d8e911c4952f8a7901d6118ac3;
          Sun, 14 May 2023 12:54:59 +0000 (UTC)
Message-ID: <200945d3-f4ca-9a73-f101-4fda96ab8b2c@rocketmail.com>
Date:   Sun, 14 May 2023 14:54:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v5 05/10] power: supply: rt5033_charger: Add RT5033
 charger device driver
To:     Sebastian Reichel <sre@kernel.org>
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
References: <20230514123130.41172-1-jahau@rocketmail.com>
 <20230514123130.41172-6-jahau@rocketmail.com>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <20230514123130.41172-6-jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21471 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

On 14.05.23 14:31, Jakob Hauser wrote:
...
> +static struct rt5033_charger_data *rt5033_charger_dt_init(
> +						struct rt5033_charger *charger)
> +{
> +	struct rt5033_charger_data *chg;
> +	struct power_supply_battery_info *info;
> +	int ret;
> +
> +	chg = devm_kzalloc(charger->dev, sizeof(*chg), GFP_KERNEL);
> +	if (!chg)
> +		return ERR_PTR(-ENOMEM);
> +
> +	ret = power_supply_get_battery_info(charger->psy, &info);
> +	if (ret)
> +		return ERR_PTR(dev_err_probe(charger->dev, -EINVAL,
> +			       "missing battery info\n"));

Here you suggested to use: "info = charger->psy->battery_info;". This 
didn't work.

The supply type of the rt5033-charger is set as POWER_SUPPLY_TYPE_USB. 
The one of rt5033-battery is POWER_SUPPLY_TYPE_BATTERY. Which makes 
sense because if both of them are POWER_SUPPLY_TYPE_BATTERY, userspace 
sees two batteries reported, one of which with 0% capacity (the charger 
doesn't report capacity).

The ...->psy->battery_info, however, gets populated only for a power 
supply device that is supply type POWER_SUPPLY_TYPE_BATTERY [1].

[1] 
https://github.com/torvalds/linux/blob/v6.4-rc1/drivers/power/supply/power_supply_core.c#L1390-L1399

> +
> +	/* Assign data. Validity will be checked in the init functions. */
> +	chg->pre_uamp = info->precharge_current_ua;
> +	chg->fast_uamp = info->constant_charge_current_max_ua;
> +	chg->eoc_uamp = info->charge_term_current_ua;
> +	chg->pre_uvolt = info->precharge_voltage_max_uv;
> +	chg->const_uvolt = info->constant_charge_voltage_max_uv;
> +
> +	return chg;
> +}
...

Kind regards,
Jakob
