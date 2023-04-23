Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 199A46EBE50
	for <lists+linux-kernel@lfdr.de>; Sun, 23 Apr 2023 11:47:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230082AbjDWJqu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 23 Apr 2023 05:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229977AbjDWJqs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 23 Apr 2023 05:46:48 -0400
Received: from sonic308-17.consmr.mail.ir2.yahoo.com (sonic308-17.consmr.mail.ir2.yahoo.com [77.238.178.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C43019BD
        for <linux-kernel@vger.kernel.org>; Sun, 23 Apr 2023 02:46:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=rocketmail.com; s=s2048; t=1682243204; bh=OcYa52vQ8WeJe4+ms4WziRNK4p5jlYgdUzE9iJMV0sE=; h=Date:Subject:To:Cc:References:From:In-Reply-To:From:Subject:Reply-To; b=uCvLg6y7SnMkOjHBNkDHfhnaFf0MKxMlkTqESnRbzRNVYmBP7otR+yoMYrRpjSONy2V+x0EyOVOjgN071pKba84ufyXUdqEDPxyMcTDC93+vepR/C4moEsLq1On+aCOIWlXmJi1SxhpcbrEpSyXadOhtTtyEi5A+9G3dm3oFG4/ZkSlycqn+Envn58NoggkanTk/6qm0Q35y0T0b8lRvKSJzDEjmIiNkqbVMDe/7LlL2P20DEf+r/3IJDSThNHMPYtkTwKcHsV8LQds5xQOLPQUDLWDKah1ot6L1JCRc6aIduoVibFNUew5Gx7jUziguKRHX/fL5i5FCCGq/B1rxog==
X-SONIC-DKIM-SIGN: v=1; a=rsa-sha256; c=relaxed/relaxed; d=yahoo.com; s=s2048; t=1682243204; bh=/pPdbPiI5+CqQI+RDxa5x11I9VUAQ8EPEnGsBKBepOt=; h=X-Sonic-MF:Date:Subject:To:From:From:Subject; b=oFk2rrcpNYM+3bWp98639gM3+TjvnQMKKXw32S95vd93FsHyvMP3wTNd8R0wJDq2qJL7aEVV2KRt+ooytV0jEqylI5TIw47yewPwFVmj5ISTlP3w0oPe8Lmw4bMLprjHBmHWlAorXfLmLvAEvIx3MpHf7oN1k6al9UA4Z/pizSCBTkx7/m0+qCDIrZUODKj0EoNB79jo+AnClS3ZPaIetKLoGuviFVKgiYVgaz9peyevafWZcrxbAGa9GC04MycvUdApK++nmB+UEAr09B2pz3/FZ/NLFGoMnNynCVTKFA6plwrV1wJvCO0125TALs13YCETtvFOEJq8XQTcdK9pKQ==
X-YMail-OSG: k2IJ99QVM1n1V2Ra_ZGhIccEcFwmfKO7u6r2A8WDqsSj6e4mzJqMLDOoYKGRH3j
 Ignw55X8nsin2xNUlMXreS5aIlBwJx.OAKb_baW_RCfo_kA1oc4tiwhwscG_eXcCU15NZQ.nIPxr
 xBHjaBRbWlhC_UAcx_5Bhupp3Kz2NasBOIVPrY22OI10ApzNMcVqByKX04s4xlmh40p0qql9WAWU
 Sffyj_9ct7VWJzeKlAKgKSLkbc.DepHsaOEvDMbtOEl32HYTiazLivfsJHeH2WyvGH4DF7YFXrgi
 ytI9LxIft2SSU8vDXGkaXxftsDXbGplMnXKm2NUmPcqTlRUWoRakmGd7cmG_PibDbtvdu7MjRvY.
 7VIHayVl667MgbN9IAHKVrKCp_koubciRtY22PWin5LZgodGV3govOGo8W_Z1b_zs.dOZ8KB_jaG
 bwgiDTBPb9WpACjW0ydJPCaGX2E_kZMllDDcb_5KzvonefcGYFPw.Q6q8.XQ4wRsa7JI4G6nRboF
 HN9B2.MXkUyYZzuqghBi.8gXTWUvZ6FdmcTs93Bk3IpznedczhhH3QDq53zu4NHu8DMnvuHxLiLU
 ciAuEkR5AK38ikhBCsaIX8uBSI7_njc5PYDF1xoXEs5DCcMEvcBl8v9Z4xfs.ubO5Xm8eqoXkx.H
 KnbSBkG_B7pshab6QJaen.GalhrDhBExXTjve2JzeZUFuRZ33EAU7qSOWFj6v5D.2FcrDjXNPDBl
 pnMbW61JuBlcntHPnDYabqTgMQF3b9xGCA69xBCbkElRHovVB0HJDGw.k.aycjzOrXE6H4X2mSyl
 7L2V8BUbN6xpt6f.VKyWmOW3hdaggljdSgf5yGKmesYVzDMIu4W8q9nzf2nvw.Zz71RP.RnYGXSa
 zq6olK4WN869p_li7a4OAL6q41aiOMcxNv83Z5.oXLBwgMYluUyUfYCnkjevdTBfHeYRWGTEwBTx
 MdVgyifK9aNoMyO8BWBnOd891lcABoqPJ5vZhf6aJd5wud._KdsGHfy25tvusGt6TaByi5CM4Vqm
 UnB2ltc2CCyugCWiSnTWLhpA_DBW0PAdHnb0yT8FZ4762brpzlbO1Pa4_oub0O1hoX1OEVfVGQXo
 edYNPco9q_df3aO.mzQHVPjeLzVZiZts68Mfaw2iiNpcV28LP6p5Ic7aoGHPP_WqgOwxQxKzCdNU
 PUUh1UFFNNT3H2R9STNP6bfZx1R6u3PJE3krXIy4VPnI5Gm2wArO91x.zTLYGKdIaB18JCSM8dki
 OcwzYourRhC4bMl9VDnddcJyk737mAiia0Cq.MDbS3IuTLC5FQnxz3Coi4mi0mWdX8ucVJAJWFj9
 _cC5_Z0RC3LE6JOgxrsjvUjMOV.ZmiYF75Woj_PSR_iBdHmMNixeyt.WS.9erAaD.j9_UW7oCJwq
 Vij0CGH0By5PjEsJfp_6HCTOSxIZV3eLycJE1aSdelHZUs0C.pN2erSboAzRyLNBE7NlMDKYg.U5
 C4B7rV2gpSe8pTAp9K4EeUKReRCxtC8hq.qQE3DQ24LQC4ATVfn8UzZRrQlsKVeqbc3.Rj.0YMPv
 njZLltNOpcYfdTUKp3o2w7EuYN3HsJiE6CHqo6nkjfQvYrSrS0ieZ4e_C7OEHX5xYVhn20iYBA41
 4JgdSFAmOMKRHUsqwi9TlzSD3um2OB9PfI_buMaHszl64wJsR.uMem.hgB3k7vw4k3zfcF.majLt
 vufrWHINHenfGh_DNvUJUNy4ellfNJiOE3pbSuOZRCkhGZf.GV8QuflIlI7_bmMET0HaU67kpkwJ
 0R83fdftKJPWEo3947SKdOHn1JQERpkMtXiKMC8.czrY30LY5pY2s2kxzIAE..blzE334sKIVm41
 uwh1_eMaddYOTZLELjeUZEQNfrdKQntTWn_5Z_SCphHMeGVtCnmInZSbqHOGDIUgBNdUECP3GD_g
 GK2IopXbjqxZbpdiVOrTUPrjvGhOPHlnYkcthLexL3TuC9xEuYAca36HLcs7B8FPdvTw30wJgf8.
 1cmebVYEz2WeZULGoko8cLg3HTPf3oLbph5WQl61WId6bg9AXyX4JwTN4nIGFHjXWqUsdrg0bdck
 sOJkCxx0NA0fr.n.4CIS9Q6pngJLERSc4NtJgeixuo5G1vX2a6zE9k1kwoo1STkYH4OZW82Ji6PH
 yGoo4nUFRFMd6lKXyDmj7yUv9GcQtI9H1GKXJqSCEFHTXSkD7wC2MU4Bd76oj6bhgl0wTlJ5LS8e
 C0DDrNtvUGF5FxIWIfMQOlqsIHHK6ak.ne5zTzYlgLAWWeNxHeIdI6wg1mqz8LJ1mdmf1OM8.BNi
 7kxAmog3HOTKYzprMH4Qw8puPGrU-
X-Sonic-MF: <jahau@rocketmail.com>
X-Sonic-ID: 1a952371-5450-4346-ad4d-349de2415052
Received: from sonic.gate.mail.ne1.yahoo.com by sonic308.consmr.mail.ir2.yahoo.com with HTTP; Sun, 23 Apr 2023 09:46:44 +0000
Received: by hermes--production-ir2-74cd8fc864-d5c78 (Yahoo Inc. Hermes SMTP Server) with ESMTPA ID c8c0720dde66fb34599bc20c5da29528;
          Sun, 23 Apr 2023 09:46:39 +0000 (UTC)
Message-ID: <15a1ad2b-c07b-7470-6c4b-2c8feab667c5@rocketmail.com>
Date:   Sun, 23 Apr 2023 11:46:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 8/9] power: supply: rt5033_battery: Adopt status
 property from charger
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
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <cover.1681646904.git.jahau@rocketmail.com>
 <23260904aab2566faf86d2ac01a31e7f1e024e66.1681646904.git.jahau@rocketmail.com>
Content-Language: en-US
From:   Jakob Hauser <jahau@rocketmail.com>
In-Reply-To: <23260904aab2566faf86d2ac01a31e7f1e024e66.1681646904.git.jahau@rocketmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Mailer: WebService/1.1.21365 mail.backend.jedi.jws.acl:role.jedi.acl.token.atz.jws.hermes.yahoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sebastian,

I noticed a small mistake in patch 8.

On 16.04.23 14:44, Jakob Hauser wrote:
> The rt5033-battery fuelgauge can't get a status by itself. The rt5033-charger
> can, let's get this value.
> 
> Tested-by: Raymond Hackley <raymondhackley@protonmail.com>
> Signed-off-by: Jakob Hauser <jahau@rocketmail.com>
> ---
>   drivers/power/supply/rt5033_battery.c | 24 ++++++++++++++++++++++++
>   1 file changed, 24 insertions(+)
> 
> diff --git a/drivers/power/supply/rt5033_battery.c b/drivers/power/supply/rt5033_battery.c
> index 5c04cf305219..48d4cccce4f6 100644
> --- a/drivers/power/supply/rt5033_battery.c
> +++ b/drivers/power/supply/rt5033_battery.c
> @@ -12,6 +12,26 @@
>   #include <linux/mfd/rt5033-private.h>
>   #include <linux/mfd/rt5033.h>
>   
> +static int rt5033_battery_get_status(struct i2c_client *client)
> +{
> +	struct power_supply *charger;
> +	union power_supply_propval val;
> +	int ret;
> +
> +	charger = power_supply_get_by_name("rt5033-charger");
> +	if (!charger)
> +		return -ENODEV;
> +
> +	ret = power_supply_get_property(charger, POWER_SUPPLY_PROP_STATUS, &val);
> +	if (ret) {
> +		power_supply_put(charger);
> +		return POWER_SUPPLY_STATUS_UNKNOWN;
> +	}
> +
> +	power_supply_put(charger);
> +	return val.intval;
> +}
> +

If the rt5033-charger driver is not available, this function returns 
"-ENODEV". Instead of an error, in fact the status node in sysfs just 
reports "-19" then. Userspace layer UPower makes status "unknown" out of 
this.

An error message would spam dmesg anyway, as it would be issued every 
time the battery gets polled by UPower, which is quite regularly. The 
scenario of a missing rt5033-charger driver is not unlikely for devices 
where it's not yet implemented in the devicetree or in the configs of 
the compiled kernel. For the displayed battery icon, UPower assumes 
"discharging" for a single battery in "unknown" state.

It makes more sense to return "POWER_SUPPLY_STATUS_UNKNOWN" right away. 
I'll change that line in v3.

>   static int rt5033_battery_get_capacity(struct i2c_client *client)
>   {
>   	struct rt5033_battery *battery = i2c_get_clientdata(client);
> @@ -84,6 +104,9 @@ static int rt5033_battery_get_property(struct power_supply *psy,
>   	case POWER_SUPPLY_PROP_CAPACITY:
>   		val->intval = rt5033_battery_get_capacity(battery->client);
>   		break;
> +	case POWER_SUPPLY_PROP_STATUS:
> +		val->intval = rt5033_battery_get_status(battery->client);
> +		break;
>   	default:
>   		return -EINVAL;
>   	}
> @@ -96,6 +119,7 @@ static enum power_supply_property rt5033_battery_props[] = {
>   	POWER_SUPPLY_PROP_VOLTAGE_OCV,
>   	POWER_SUPPLY_PROP_PRESENT,
>   	POWER_SUPPLY_PROP_CAPACITY,
> +	POWER_SUPPLY_PROP_STATUS,
>   };
>   
>   static const struct regmap_config rt5033_battery_regmap_config = {

Kind regards,
Jakob
