Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1016A73FD70
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 16:11:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231221AbjF0OK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 10:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230493AbjF0OKv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 10:10:51 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE9C02D76;
        Tue, 27 Jun 2023 07:10:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1687875007; x=1688479807; i=frank-w@public-files.de;
 bh=tcte7WM1r7NehSLZobJtBRLDopOSLUZydTiAMLTHCp8=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=C9ZFOGA4C+sQrqOsBVa1RVfSzK0VGDed5iFUh3DmYoCjb5iz3E2renoX9XiEkIb55ZeyrVv
 GXjPxDCH8QRtyAXQ4RhKr/ubwVLHVSax3B27jdEpAoJ35MQVihAWcRIOq5gyfeTohEGzmzP9Q
 gOOuF9MDA6JZ1B4NPWSMJhOIOfEXFQVVAejZDb+FYhVRrzGbnkmPNAdoZXqego/ZyhYc6EVFS
 MTafAwoqiTyNqIgmTTJzpoPgYPWAuKabIOC/wg1fHkJVep2EDGYGbYcpKJ/E9FDlA+65X8Her
 qSMmlp4NiIHWYpAHiCZ1HxsxwN5qLFseDFIVamMbQ41EsRUDWiOA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.148.1] ([217.61.148.1]) by web-mail.gmx.net
 (3c-app-gmx-bs07.server.lan [172.19.170.56]) (via HTTP); Tue, 27 Jun 2023
 16:10:06 +0200
MIME-Version: 1.0
Message-ID: <trinity-4dd71d69-5514-4da0-8c18-a5676a311df2-1687875006833@3c-app-gmx-bs07>
From:   Frank Wunderlich <frank-w@public-files.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>, linux-mmc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: Aw: Re:  Re: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: update
 assigned-clocks/clock-parents for mt7986
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 27 Jun 2023 16:10:06 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <b6ef76a8-95fc-aa76-d811-ed25ccb8ad8e@linaro.org>
References: <20230625191151.7808-1-linux@fw-web.de>
 <20230625191151.7808-2-linux@fw-web.de>
 <91411797-18b4-f515-d6c0-ca0f8ff39696@linaro.org>
 <trinity-28cad1dc-f8e0-4f65-874f-a2392c2e878e-1687867773444@3c-app-gmx-bs07>
 <b6ef76a8-95fc-aa76-d811-ed25ccb8ad8e@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:/Pe5aYi+s9kKCx0trik0mKEWPWa5NISxt/CIrmej8e0C/W4SDtpPYJ0Cll/ArsO6l7/Zu
 +8+KH5sjk9JiARw4P6SFiDX5vY828bFt5mxI/ynFZRgIFwMFSJSZHy4KilFDsjs+kUPChwrNakGJ
 U9V/s2bYuB+cqbgzGpiXtd1CElHvqKYSJmJPwBeB51hYjzz1XyzO2POzsv+Bti/Gis8NBcpkABqN
 oav0QUuJiHwZ/7BGUfLL4eN1v2YPs6cDawNedCRSUjypTeBXhQ+pkwc5KZruh9kvzSjx9h8U6BbS
 kM=
UI-OutboundReport: notjunk:1;M01:P0:oc/IDCkwfto=;uyMwuWF0joreAn8VyMb6rA3OLle
 KLew97pISH5oXOt+zzFzGQB5tkaorJjmZdciLWsWq/KDEcfWENbej+2y3rRuRl/yxZsDFIxuF
 dbJCOnDbdnYvkzlrS1+ghwMuOPFJQlNHnAJaiHfi6GtmNDp0ITPUMq491nGELu6xrtv+ej/wa
 Ehg+yvN0ZjsVh+ystNLKBCHDPyTfLaoD1QMD1fEvRUY6u35ie9xWO76OxpcnMlFjUSN3uXnAM
 +afIFKzVbtBL4RKMECoj8Az/3SuXUfWI0GxSe/yXVKECkIz6Z1b6lShv9raUFo5dAFCK91iu9
 nDN2HcLeTJgxYJFpKlFaa3n6j5HvjdkvYr9T+tMyBJUGJ/BpocNVugwwL2SwMeYbmbuAFdQiO
 sW+A/oAqKIM37QPtw/XlAkxErK/lH8invVZ0dOM46qA1kDgPvGfcr/Rc++AkWv0/Fsq7UHhHU
 QB+h854E/TCob0i4zIwj1xnBz3wuP21B4eYa87zYaJn+8+Bo225ChxLAL4pMvM7CuiUDN+7a1
 4TjA4GCSE6xOhG1Hv0kuoX4n1xIOcrhGYggOa6bA2jrANJqWZrJ3HiyXw5tAOBPdwSK1l0pU3
 CXDfIb6B+MZn7n19RWUCjUDu7SvA+DcGfAo2iEurqVbJ3Q590ipBpmiOfoVM3454642i4bNZI
 JiRRB8hDHczOdyQ1UVo+Rnweb8gFXVDc1ioeYA5H99Lv0JbVVITDEZdk9JeEVNfT1CdnCt6s2
 IRC4fAvEvveqGqfVGBFwQcP7Mhsqi3PnfYsv5aTfVRBzxzz0Q1EVKxzleTmAhZIEOORIquYPv
 NskoKyUr5oL3iq0x62wQuGYW7d3XmjfH1iasCFZIWjhpE=
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi


> Gesendet: Dienstag, 27. Juni 2023 um 15:37 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> On 27/06/2023 14:09, Frank Wunderlich wrote:
> >> Gesendet: Dienstag, 27. Juni 2023 um 12:44 Uhr
> >> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> >> Betreff: Re: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: update assigned=
-clocks/clock-parents for mt7986
> >>
> >> On 25/06/2023 21:11, Frank Wunderlich wrote:
> >>> From: Frank Wunderlich <frank-w@public-files.de>
> >>>
> >>> MT7986 has 2 clock-parents so update the binding for it.
> >>
> >> You didn't test it, I think. If you do, then you will see errors from
> >> other trees.
> >
> > Hi,
> >
> > i tested it of course...which errors do you see?
>
> The top-level said it can be maximum 1, so raising it in allOf:if:then:
> should not be enough

but the previous error with too long list wasn't there after the change...=
so it seems to work...if it right, i don't know,
but other properties are overriddedn the same way.

> > 11
> > this is basicly how i tested it (in case anything has changed):
> >
> >         logfile=3Ddtbs_arm64.log
> >         exec 3> >(tee $logfile)
> >         ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make DT_CHECKE=
R_FLAGS=3D-m dt_binding_check 2>&3
> >         if [[ $? -ne 0 ]];then echo "arm64 binding check failed!";cat =
$logfile;exit 1;fi
> >         ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make defconfig=
 #dtbs_check need kernel-config
> >         ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make -j8 DT_CH=
ECKER_FLAGS=3D-m dtbs_check 2>&3
> >         if [[ $? -ne 0 ]];then echo "arm64 dtbs_check failed!";cat $lo=
gfile;exit 1;fi
>
> A bit over-complicated... why not running dtbs_check against the schema
> you changed?

it is a script i only start ;) and having a logfile (with all messages - s=
tdin+stdout) makes it easier to find something.
i had always the problem, that second run does not show the errors again w=
ithout changing the yaml or dts.

as you see below i tried the run against the yaml too, but there are many =
many unrelated compatibles which seem to be not
documented or still in txt bindings.

> > and looked into the resulting logfile for keywords like mmc like mtk-s=
d
> >
> > i tried running dtbs_check with passing the yaml-file, but of course a=
ll compatibles not matching this file were reported.
> >
> > ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make -j6 DT_CHECKER_FL=
AGS=3D-m dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mm=
c/mtk-sd.yaml
> >
> > but this spits out many errors "failed to match any schema with compat=
ible" because i defined only the changed one...
> >
> > maybe there is another way to check only one yaml file against all dtb=
s without these unrelated errors.
> >
> > pipeline in dt-bindings-patchwork is clean too
> > https://patchwork.ozlabs.org/project/devicetree-bindings/patch/2023062=
5191151.7808-2-linux@fw-web.de/
>
> Maybe that binding just fails to apply to DTS because of missing or not
> correct compatibles.

the messages are unrelated to current yaml file i passed with the DT_SCHEM=
A_FILES parameter, e.g. the last messages:

	From schema: Documentation/devicetree/bindings/display/mediatek/mediatek,=
dsi.yaml
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb:0:0: /soc/sys=
con@15020000: failed to match any schema with compatible: ['mediatek,mt818=
3-imgsys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb:0:0: /soc/sys=
con@16000000: failed to match any schema with compatible: ['mediatek,mt818=
3-vdecsys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb:0:0: /soc/sys=
con@17000000: failed to match any schema with compatible: ['mediatek,mt818=
3-vencsys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb:0:0: /soc/sys=
con@19000000: failed to match any schema with compatible: ['mediatek,mt818=
3-ipu_conn', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb:0:0: /soc/sys=
con@19010000: failed to match any schema with compatible: ['mediatek,mt818=
3-ipu_adl', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb:0:0: /soc/sys=
con@19180000: failed to match any schema with compatible: ['mediatek,mt818=
3-ipu_core0', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb:0:0: /soc/sys=
con@19280000: failed to match any schema with compatible: ['mediatek,mt818=
3-ipu_core1', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb:0:0: /soc/sys=
con@1a000000: failed to match any schema with compatible: ['mediatek,mt818=
3-camsys', 'syscon']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb:0:0: /mt8183-=
sound: failed to match any schema with compatible: ['mediatek,mt8183_mt635=
8_ts3a227_max98357']
arch/arm64/boot/dts/mediatek/mt8183-kukui-jacuzzi-burnet.dtb: bt-sco: '#so=
und-dai-cells' is a required property

> >> Anyway, I don't understand why defining it in the first place. Just d=
rop
> >> the assigned-clock* from the binding.
> >
> > as it was defined (not looked where it was used) i only used the soc-s=
pecific branch to update the MaxItems...just to not break anything. After =
that the message i got before was fixed
> >
> > arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: mmc@11230000=
: assigned-clocks: [[4, 35], [4, 34]] is too long
> > arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: mmc@11230000=
: assigned-clock-parents: [[5, 6], [4, 18]] is too long
> >
> > but if the right way is to drop the MaxItems from generic (or the prop=
erty itself - where is it taken from then?). The only
> > include i see is Documentation/devicetree/bindings/mmc/mmc-controller.=
yaml and there the assigned-clock* is not defined. And the
>
> The way is to entirely drop assigned-clocks. I don't think there are
> much benefits of having them in the bindings. Maybe if specific rates
> are required, then yes - device cannot work with other rates and you can
> verify it with dtbs_check. But otherwise it is like adding values of
> 'reg' or 'interrupts'. Plus some board might require third item and then
> what?

mhm, disabled all assigned-clock* properties and do not get any messages a=
bout this (don't know why because of "unevaluatedProperties: false", but l=
ooks like it works)

there are only some syscon-nodes in mt8173-*.dtb where these properties us=
ed are reported

btw. need binding also be backported to stable? so do i need to add the ta=
g there?

regards Frank
