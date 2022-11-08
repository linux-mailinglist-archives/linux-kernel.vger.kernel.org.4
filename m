Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70C98620B44
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 09:34:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233278AbiKHIek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 03:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233087AbiKHIeh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 03:34:37 -0500
Received: from mail-qk1-f176.google.com (mail-qk1-f176.google.com [209.85.222.176])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57037E0A3;
        Tue,  8 Nov 2022 00:34:36 -0800 (PST)
Received: by mail-qk1-f176.google.com with SMTP id s20so8693810qkg.5;
        Tue, 08 Nov 2022 00:34:36 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=9rjK+cFGvl0bYlnbNWlNdjkQ+vEPF5KQW+G9V7jNEfE=;
        b=qLHu9TDpIr9TIgM9ckBuIT5QkQ+gAPZNdSQFo3KlE/uVUaji3Ilx1pHnIBS+93YWKY
         S4Zqt91gzM3tYWFWL7uxeK0bsZBFge8lYNJmFUDSK2oKz7hOXVTGuSHc8gKP9q0RrnM/
         8TsJnjBm0Nyc6n4rd4SW1zB8C85rUYfJGoS6UEO3M3S1ch7M3sS1dhnb+YymwqPvgfn6
         6rxjBHvhz5z9nwiWL1YgFXWGguP8RLVO3UVACfk/O31yk1MpTmRK4MPvlRCmGSufLfdV
         UGysRs3IT9dXSuGFqpSczUsq9zk9+rKjjjcRYxlzIdo9JB4EYTTQw6fpMAkZTGvusUig
         EnaA==
X-Gm-Message-State: ACrzQf3GHtPiX//Aj69OI8k7Tmha+c3PUb41fyWmNojt5jsjs3dCdteB
        OQz94oVNkoBIiuqwAt4Sb/8tPuNKX8aP07XL
X-Google-Smtp-Source: AMsMyM5n9RFBhHumsOb4egODJZvbGArk5mUKAGa3NMc6j96Px/+Fkq5AmEvHgTbZKacp4j3Ibdj07Q==
X-Received: by 2002:a05:620a:888:b0:6f5:ec2:6398 with SMTP id b8-20020a05620a088800b006f50ec26398mr840149qka.617.1667896475305;
        Tue, 08 Nov 2022 00:34:35 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id cn3-20020a05622a248300b003a5430ee366sm7668958qtb.60.2022.11.08.00.34.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 08 Nov 2022 00:34:34 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-36cbcda2157so127132167b3.11;
        Tue, 08 Nov 2022 00:34:32 -0800 (PST)
X-Received: by 2002:a0d:e301:0:b0:374:a8ba:99b0 with SMTP id
 m1-20020a0de301000000b00374a8ba99b0mr6035680ywe.358.1667896472556; Tue, 08
 Nov 2022 00:34:32 -0800 (PST)
MIME-Version: 1.0
References: <20221107155825.1644604-1-pierre.gondois@arm.com> <20221107155825.1644604-19-pierre.gondois@arm.com>
In-Reply-To: <20221107155825.1644604-19-pierre.gondois@arm.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 8 Nov 2022 09:34:20 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWOZemsvMfM8+NTvQ4=cDd9hu3=0tVFRmNzFmjaxVhgig@mail.gmail.com>
Message-ID: <CAMuHMdWOZemsvMfM8+NTvQ4=cDd9hu3=0tVFRmNzFmjaxVhgig@mail.gmail.com>
Subject: Re: [PATCH v2 18/23] arm64: dts: Update cache properties for renesas
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        Tsahee Zidenberg <tsahee@annapurnalabs.com>,
        Antoine Tenart <atenart@kernel.org>,
        Brijesh Singh <brijeshkumar.singh@amd.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Khuong Dinh <khuong@os.amperecomputing.com>,
        Liviu Dudau <liviu.dudau@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        William Zhang <william.zhang@broadcom.com>,
        Anand Gore <anand.gore@broadcom.com>,
        Kursad Oney <kursad.oney@broadcom.com>,
        =?UTF-8?B?UmFmYcWCIE1pxYJlY2tp?= <rafal@milecki.pl>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Chester Lin <clin@suse.com>,
        =?UTF-8?Q?Andreas_F=C3=A4rber?= <afaerber@suse.de>,
        Matthias Brugger <mbrugger@suse.com>,
        NXP S32 Linux Team <s32@nxp.com>,
        Wei Xu <xuwei5@hisilicon.com>, Chanho Min <chanho.min@lge.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Lars Povlsen <lars.povlsen@microchip.com>,
        Steen Hegelund <Steen.Hegelund@microchip.com>,
        Daniel Machon <daniel.machon@microchip.com>,
        UNGLinuxDriver@microchip.com, Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Magnus Damm <magnus.damm@gmail.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Jisheng Zhang <jszhang@kernel.org>, Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Tero Kristo <kristo@kernel.org>,
        Viorel Suman <viorel.suman@nxp.com>,
        Abel Vesa <abelvesa@kernel.org>,
        Shenwei Wang <shenwei.wang@nxp.com>,
        Peng Fan <peng.fan@nxp.com>, Ming Qian <ming.qian@nxp.com>,
        Adam Ford <aford173@gmail.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Tim Harvey <tharvey@gateworks.com>,
        Richard Zhu <hongxing.zhu@nxp.com>, Li Jun <jun.li@nxp.com>,
        Marek Vasut <marex@denx.de>,
        Markus Niebel <Markus.Niebel@ew.tq-group.com>,
        Joakim Zhang <qiangqing.zhang@nxp.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Alexander Stein <alexander.stein@ew.tq-group.com>,
        Paul Elder <paul.elder@ideasonboard.com>,
        Martin Kepplinger <martink@posteo.de>,
        Joy Zou <joy.zou@nxp.com>, David Heidelberg <david@ixit.cz>,
        Liu Ying <victor.liu@nxp.com>,
        Oliver Graute <oliver.graute@kococonnector.com>,
        Shijie Qin <shijie.qin@nxp.com>, Jacky Bai <ping.bai@nxp.com>,
        Wei Fang <wei.fang@nxp.com>,
        Clark Wang <xiaoning.wang@nxp.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Vadym Kochan <vadym.kochan@plvision.eu>,
        Sameer Pujar <spujar@nvidia.com>,
        Prathamesh Shete <pshete@nvidia.com>,
        Akhil R <akhilrajeev@nvidia.com>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Sumit Gupta <sumitg@nvidia.com>,
        Diogo Ivo <diogo.ivo@tecnico.ulisboa.pt>,
        Vidya Sagar <vidyas@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Johan Jonker <jbx6244@gmail.com>,
        Christopher Obbard <chris.obbard@collabora.com>,
        Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>,
        Aswani Reddy <aswani.reddy@samsung.com>,
        Shashank Prashar <s.prashar@samsung.com>,
        devicetree@vger.kernel.org, linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org, openbmc@lists.ozlabs.org,
        linux-tegra@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-realtek-soc@lists.infradead.org,
        linux-renesas-soc@vger.kernel.org,
        linux-rockchip@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Pierre,

Thanks for your patch!

On Mon, Nov 7, 2022 at 5:33 PM Pierre Gondois <pierre.gondois@arm.com> wrote:
> The DeviceTree Specification v0.3 specifies that the cache node
> 'compatible' and 'cache-level' properties are 'required'. Cf.
> s3.8 Multi-level and Shared Cache Nodes

"compatible" is present?

> The 'cache-unified' property should be present if one of the
> properties for unified cache is present ('cache-size', ...).

Present, too?

> Update the Device Trees accordingly.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>

> --- a/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> +++ b/arch/arm64/boot/dts/renesas/r9a07g043.dtsi
> @@ -88,6 +88,7 @@ L3_CA55: cache-controller-0 {
>                         compatible = "cache";
>                         cache-unified;
>                         cache-size = <0x40000>;
> +                       cache-level = <3>;
>                 };
>         };
'
This hunk now applies to arch/arm64/boot/dts/renesas/r9a07g043u.dtsi.

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2, with the patch description
and the file names updated to match the real world.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
