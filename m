Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1846B061D
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 12:38:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230031AbjCHLiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 06:38:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230206AbjCHLiJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 06:38:09 -0500
Received: from amity.mint.lgbt (vmi888983.contaboserver.net [149.102.157.145])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 308882DE56
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 03:38:05 -0800 (PST)
Received: from amity.mint.lgbt (mx.mint.lgbt [127.0.0.1])
        by amity.mint.lgbt (Postfix) with ESMTP id 4PWr0X17wSz1S5Jt
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:38:03 -0500 (EST)
Authentication-Results: amity.mint.lgbt (amavisd-new);
        dkim=pass (2048-bit key) reason="pass (just generated, assumed good)"
        header.d=mint.lgbt
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mint.lgbt; h=
        content-transfer-encoding:content-type:mime-version:message-id
        :references:in-reply-to:user-agent:subject:to:from:date; s=dkim;
         t=1678275483; x=1679139484; bh=fUz9L+nr5UDOp/B833d5gx+2B4OI8cyq
        Eq9E6OrbgcI=; b=ZT10jEWW2dVZfS8psDQuNQeE0vk1OffgWGF+qHGbP9L+uBXo
        kEZO+EltdbXZtR2z/gotMlLq3RlqGTK8yCddN6BelRMPhqrpU4ERb9ngx2OWqeR9
        ay6LvfgQZ4AqcYgtXQpd9+QoGiI0jC+r4rju6dBPVFLmzoF7+ow2k44KkBhkGJ6b
        UayhbTqmGQXh/gHIoS2O8Qmncm+I3yTy++iTZTKCKA6wUqzYkW/OdfeaeI5JZIwd
        f7g12LICKP9nVNUXa8zC8V+H4u6K4+gz4dyd2xnt0UFmvc2Phdr7YIOM1brzVJrR
        zvSaTsroXq9b40Nt0td2WlQ3s4JY6+i8O4Ak9w==
X-Virus-Scanned: amavisd-new at amity.mint.lgbt
Received: from amity.mint.lgbt ([127.0.0.1])
        by amity.mint.lgbt (amity.mint.lgbt [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id oaG8fLhqVti2 for <linux-kernel@vger.kernel.org>;
        Wed,  8 Mar 2023 06:38:03 -0500 (EST)
Received: from [127.0.0.1] (unknown [186.105.8.42])
        by amity.mint.lgbt (Postfix) with ESMTPSA id 4PWr0L6QcFz1S4yx;
        Wed,  8 Mar 2023 06:37:54 -0500 (EST)
Date:   Wed, 08 Mar 2023 08:37:48 -0300
From:   Lux Aliaga <they@mint.lgbt>
To:     Johan Hovold <johan@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
CC:     agross@kernel.org, andersson@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, vkoul@kernel.org,
        kishon@kernel.org, alim.akhtar@samsung.com, avri.altman@wdc.com,
        bvanassche@acm.org, keescook@chromium.org, tony.luck@intel.com,
        gpiccoli@igalia.com, ~postmarketos/upstreaming@lists.sr.ht,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-phy@lists.infradead.org,
        linux-scsi@vger.kernel.org, linux-hardening@vger.kernel.org,
        phone-devel@vger.kernel.org, martin.botka@somainline.org,
        marijn.suijten@somainline.org
Subject: Re: [PATCH v7 3/6] phy: qcom-qmp: Add SM6125 UFS PHY support
User-Agent: K-9 Mail for Android
In-Reply-To: <ZAhwTcMZoCQVULQe@hovoldconsulting.com>
References: <20230306170817.3806-1-they@mint.lgbt> <20230306170817.3806-4-they@mint.lgbt> <25c17af5-8f6b-a2c3-dab3-f9bc69711db7@linaro.org> <ZAhrT1ICTQjfdeGq@hovoldconsulting.com> <64ab4061-6a8b-662e-1c7a-99b0da26751c@linaro.org> <ZAhwTcMZoCQVULQe@hovoldconsulting.com>
Message-ID: <DE127158-6956-42E9-B7AE-9687B4ABD6DA@mint.lgbt>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Autocrypt: addr=they@mint.lgbt; keydata=
 mDMEYyUigxYJKwYBBAHaRw8BAQdA4Emr08ZPSL9p/JLdojT2GPRmh6URPjLQf9l/Kf7x5eC0G0x1
 eCBBbGlhZ2EgPHRoZXlAbWludC5sZ2J0PoiTBBMWCgA7FiEEYa2kUv8kbagAwdmwtWyAWWhjdDcF
 AmMlIoMCGwMFCwkIBwICIgIGFQoJCAsCBBYCAwECHgcCF4AACgkQtWyAWWhjdDf/YQD/VfoHtwZa
 OyBStI87Sv3Wdydps+MALWt7RfPA/AVd/i0A/21kQ+Wr6Hrb7Lz43H3+JLTaQk1XGKn7HMvpARdw
 tVYBuDgEYyUigxIKKwYBBAGXVQEFAQEHQJE2MuI8EY9+pcwq9ynsMxCh1J0AGGo7hO2n9EQtOClI
 AwEIB4h4BBgWCgAgFiEEYa2kUv8kbagAwdmwtWyAWWhjdDcFAmMlIoMCGwwACgkQtWyAWWhjdDe+
 xwD/ZtWx58K/+zLhrdO/kjGftMVM+J3mPA5fJxRYC2Ut42ABAKb0aGOEwFS5XvkOwCLUAMqLGjRg
 SDwi1EbSA+iQnkkB
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8 March 2023 08:23:57 GMT-03:00, Johan Hovold <johan@kernel=2Eorg> wrot=
e:
>On Wed, Mar 08, 2023 at 12:15:39PM +0100, Konrad Dybcio wrote:
>>=20
>>=20
>> On 8=2E03=2E2023 12:02, Johan Hovold wrote:
>> > On Wed, Mar 08, 2023 at 11:09:48AM +0100, Konrad Dybcio wrote:
>> >>
>> >>
>> >> On 6=2E03=2E2023 18:08, Lux Aliaga wrote:
>> >>> The SM6125 UFS PHY is compatible with the one from SM6115=2E Add a
>> >>> compatible for it and modify the config from SM6115 to make them
>> >>> compatible with the SC8280XP binding
>> >>>
>> >>> Signed-off-by: Lux Aliaga <they@mint=2Elgbt>
>> >>> Reviewed-by: Martin Botka <martin=2Ebotka@somainline=2Eorg>
>> >>> ---
>> >>>  drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec | 12 ++++++++++++
>> >>>  1 file changed, 12 insertions(+)
>> >>>
>> >>> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec b/drivers/ph=
y/qualcomm/phy-qcom-qmp-ufs=2Ec
>> >>> index 318eea35b972=2E=2E44c29fdfc551 100644
>> >>> --- a/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>> >>> +++ b/drivers/phy/qualcomm/phy-qcom-qmp-ufs=2Ec
>> >>> @@ -620,6 +620,13 @@ static const char * const qmp_phy_vreg_l[] =3D=
 {
>> >>>  	"vdda-phy", "vdda-pll",
>> >>>  };
>> >>> =20
>> >>> +static const struct qmp_ufs_offsets qmp_ufs_offsets_v3_660 =3D {
>> >>> +	=2Eserdes		=3D 0,
>> >>> +	=2Epcs		=3D 0xc00,
>> >>> +	=2Etx		=3D 0x400,
>> >>> +	=2Erx		=3D 0x600,
>> >>> +};
>> >>> +
>> >>>  static const struct qmp_ufs_offsets qmp_ufs_offsets_v5 =3D {
>> >>>  	=2Eserdes		=3D 0,
>> >>>  	=2Epcs		=3D 0xc00,
>> >>> @@ -693,6 +700,8 @@ static const struct qmp_phy_cfg sdm845_ufsphy_c=
fg =3D {
>> >>>  static const struct qmp_phy_cfg sm6115_ufsphy_cfg =3D {
>> >>>  	=2Elanes			=3D 1,
>> >>> =20
>> >>> +	=2Eoffsets		=3D &qmp_ufs_offsets_v3_660,
>> >> Will this not trigger OOB r/w for the users of qcom,sm6115-smp-ufs-p=
hy
>> >> which specify the regions separately (old binding style)?
>> >=20
>> > No, that should work fine=2E
>> So do you think the SM6115 binding could be updated too? Or should
>> we keep it as-is for ABI purposes?=2E=2E
>
>They could be and the possibility has been raised=2E I think it may be
>more important to convert the old combo-phy binding (it's on my list,
>but I keep getting preempted), but at some point we can get rid of the
>legacy UFS binding as well=2E
>
>> > But looks like this series needs to be rebased on 6=2E3-rc1 as these
>> > offsets are now already set in mainline=2E
>> =2E=2EOr did you do that already and I can't find it?
>
>It seems a previous version of this patch was merged almost two months
>ago=2E
>
>	9b9e29af984c ("phy: qcom-qmp: Add SM6125 UFS PHY support")
>
>Not sure what failed here=2E
>
>Johan
Yes, but it received some comments regarding using v5 offsets instead of v=
3-660=2E I could spin off this change into a new patch if necessary=2E
