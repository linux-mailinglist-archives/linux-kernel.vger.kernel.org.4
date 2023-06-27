Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5007A73FBCA
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 14:10:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231962AbjF0MKY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 08:10:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231948AbjF0MKO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 08:10:14 -0400
Received: from mout.gmx.net (mout.gmx.net [212.227.15.15])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A36F8297D;
        Tue, 27 Jun 2023 05:09:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=public-files.de;
 s=s31663417; t=1687867773; x=1688472573; i=frank-w@public-files.de;
 bh=xdHcE/whBthd94x/WQ7c8IRXdm3DaEqEahfNDdPrpiU=;
 h=X-UI-Sender-Class:From:To:Cc:Subject:Date:In-Reply-To:References;
 b=JmKeWK/e5/gzkD/IRpkToKxv1UBRL7tsoQHCofzr3RalwasG16QZvtK7pAypP5iRlk6CuvX
 N9eofKYrfIePUidNMaeJIvHRHU5VuBmkXx6ECrc6/gLtf6gnid8+BoGaVt6vDmElB9hrmMd2H
 0e3n5PPcARzaIKPbXMjLMROE6vhCPGglKAi4EkQ8GA5GJkG4vjli2FTDIjPBe6vvmnh9yHmpY
 qL6rzGcciTo+/BmHb1HmOWsBtiz8rP6gJIv7b/A3Jf6OK+6n0BQgo2Ov+TuzJxE5IbQbcnkaF
 3WjnV/0La8xhS3T6kuILNuwQr5nruV80bzvogqzuSl8g8UXwm7tA==
X-UI-Sender-Class: 724b4f7f-cbec-4199-ad4e-598c01a50d3a
Received: from [217.61.148.1] ([217.61.148.1]) by web-mail.gmx.net
 (3c-app-gmx-bs07.server.lan [172.19.170.56]) (via HTTP); Tue, 27 Jun 2023
 14:09:33 +0200
MIME-Version: 1.0
Message-ID: <trinity-28cad1dc-f8e0-4f65-874f-a2392c2e878e-1687867773444@3c-app-gmx-bs07>
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
Subject: Aw: Re: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: update
 assigned-clocks/clock-parents for mt7986
Content-Type: text/plain; charset=UTF-8
Date:   Tue, 27 Jun 2023 14:09:33 +0200
Importance: normal
Sensitivity: Normal
In-Reply-To: <91411797-18b4-f515-d6c0-ca0f8ff39696@linaro.org>
References: <20230625191151.7808-1-linux@fw-web.de>
 <20230625191151.7808-2-linux@fw-web.de>
 <91411797-18b4-f515-d6c0-ca0f8ff39696@linaro.org>
X-UI-Message-Type: mail
X-Priority: 3
X-Provags-ID: V03:K1:Wpl0QMXvRlo9cxJewy5JaUWnr3ady4smJq8j0V87WwVmOV7RyXc5ezzcldaYktrMBQXIN
 M2AOETkDUZJUHzes3VfgSYybEjGnoPUCpIeWvAMoBoGMxxTO6vbT9JBjO4T8LzS1YyGdnfuCMPD7
 mPl96k7q+ZTRmXa3JaCTMNVLbPKHsUdgpO0ArJEBBwB7k54GmejHfiGofLoRfLFZUNoMZ2uwEHgk
 uXH/aexMV4YqmmgN79H+oNhvY6N9Hgm7flPjhLL6h9zQaY8LQxbjUO/c0pPJO6EMXAHG+TmsaxOB
 q0=
UI-OutboundReport: notjunk:1;M01:P0:1Z0a4tyvnkQ=;VpvzeAEl8Inn7LOHKtEQJ0APbGE
 wy5+uDfKeYInwKGfypBdqzAg9pUYSbYz7oMsrjbCMJi5fd8+wV/WcIfoSLLRDIvm3Qfhdcsc1
 0xa9V+3ku8De6Lgs49f8KJvcbGl5dkhbx9NlgeMhUuPwf14pBSnxBAi+4NZYJ9x5o/90o6A36
 p0BjPMUoBM/i4wvQNGCPO794wB5h/jXK0EhRd0nRKppL9cwlmK6K2Nml+84dNWu7mpnrsCHz/
 neZS6vAAcEf8bN5/iJmgOCWlsasvRZm+5o/W8JOuyu6CXclUItv1nID5eXFWILp8W+5LiEyVZ
 ChUzxQdfGqBu/7KYpyQhNTL4nkkIcYktsG/ew+5/evblJLGV+YKb8pzvuHDyihQg/RzyasjBo
 gvfbVlaj5fRklbqqykrhEkInlAD459IVzxNRYcuPJQRXrucNJVgfrLEwM+5RuL79Wq2k+q6gp
 vJhlEZ18Ff3c5E0gmQPQaNhUtpuWv5QW9YGlGZ2Vm726DLt2GGYD1oS6kEqxpBT2x3uKQpWqD
 2t99KWVBZ6IhMq7kUpHXD4c+hgFN6ssthuJSqUHxzO2QN+VqzNax4J4Vlpf98gFNAYp3/JGkj
 D/20IRbgGwHgErmWYCmvQK3Xmx0FK+rBjM3Vv+EFnYZLCWJf48ETRgiSOryV7CZGOGC9P7N8c
 TDRFEBND0/nlkOMx5tY/tZ0iV0+SFDp00IZnRMPlslvWVpy8VkF1/HclqnDjfw6jQmROuAakk
 QvFYP4JHDjO8iq8XJXgvNqZRjSIwKjP4OBEfJqN83tP52IlR+LScMFKaLklJAXqmxlJUSnO6w
 /s8tCekdcyvxO5kJv89YeZBg==
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

> Gesendet: Dienstag, 27. Juni 2023 um 12:44 Uhr
> Von: "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>
> Betreff: Re: [PATCH v1 1/2] dt-bindings: mmc: mtk-sd: update assigned-cl=
ocks/clock-parents for mt7986
>
> On 25/06/2023 21:11, Frank Wunderlich wrote:
> > From: Frank Wunderlich <frank-w@public-files.de>
> >
> > MT7986 has 2 clock-parents so update the binding for it.
>
> You didn't test it, I think. If you do, then you will see errors from
> other trees.

Hi,

i tested it of course...which errors do you see?

this is basicly how i tested it (in case anything has changed):

        logfile=3Ddtbs_arm64.log
        exec 3> >(tee $logfile)
        ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make DT_CHECKER_FL=
AGS=3D-m dt_binding_check 2>&3
        if [[ $? -ne 0 ]];then echo "arm64 binding check failed!";cat $log=
file;exit 1;fi
        ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make defconfig #dt=
bs_check need kernel-config
        ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make -j8 DT_CHECKE=
R_FLAGS=3D-m dtbs_check 2>&3
        if [[ $? -ne 0 ]];then echo "arm64 dtbs_check failed!";cat $logfil=
e;exit 1;fi

and looked into the resulting logfile for keywords like mmc like mtk-sd

i tried running dtbs_check with passing the yaml-file, but of course all c=
ompatibles not matching this file were reported.

ARCH=3Darm64 CROSS_COMPILE=3Daarch64-linux-gnu- make -j6 DT_CHECKER_FLAGS=
=3D-m dtbs_check DT_SCHEMA_FILES=3DDocumentation/devicetree/bindings/mmc/m=
tk-sd.yaml

but this spits out many errors "failed to match any schema with compatible=
" because i defined only the changed one...

maybe there is another way to check only one yaml file against all dtbs wi=
thout these unrelated errors.

pipeline in dt-bindings-patchwork is clean too
https://patchwork.ozlabs.org/project/devicetree-bindings/patch/20230625191=
151.7808-2-linux@fw-web.de/

> Anyway, I don't understand why defining it in the first place. Just drop
> the assigned-clock* from the binding.

as it was defined (not looked where it was used) i only used the soc-speci=
fic branch to update the MaxItems...just to not break anything. After that=
 the message i got before was fixed

arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: mmc@11230000: as=
signed-clocks: [[4, 35], [4, 34]] is too long
arch/arm64/boot/dts/mediatek/mt7986a-bananapi-bpi-r3.dtb: mmc@11230000: as=
signed-clock-parents: [[5, 6], [4, 18]] is too long

but if the right way is to drop the MaxItems from generic (or the property=
 itself - where is it taken from then?). The only
include i see is Documentation/devicetree/bindings/mmc/mmc-controller.yaml=
 and there the assigned-clock* is not defined. And the

unevaluatedProperties: false

tells me that removing the generic one will result in unevaluated propety =
error.

regards Frank


> Best regards,
> Krzysztof
>
>
