Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C3A06AB40D
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 01:52:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229638AbjCFAwv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Mar 2023 19:52:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbjCFAwt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Mar 2023 19:52:49 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E29AF12874;
        Sun,  5 Mar 2023 16:52:47 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id cw28so32152315edb.5;
        Sun, 05 Mar 2023 16:52:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ubliUs4c/D0gi6kNRTGbrhZhzXPXrqrIjYYmRR0+Q1g=;
        b=l2nj+FTrMZkliD4scjoqzTp0KaW/6bL3hwhNloebiM3377CUkhUUcz02ZzS5XK+feU
         PU0pFBJaZDqf0o6CapL7OTvaw4m0VsUHDOaqWjz0bCCQvKy/5Gwrr/ZnqhSOqK9xRrfL
         D7L81LRGXJ4I3kf1cRurQpbPq8KaL6HCfkR40=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ubliUs4c/D0gi6kNRTGbrhZhzXPXrqrIjYYmRR0+Q1g=;
        b=WDrJwmv/7nXpGEP1/95M4O2UXooe7W54JtVF9POfiFYiFj9bLByzHWQnllxJIk/GdM
         02/ZJGuMsUYfCeo3AxGuLJbywxlClWTEs+OhurvIhvidlIaFYoxKVbFv/FG+kLf964rO
         n9Wk6lwe350UY9xtC9Qpj7CzlZfl8ooyUfnY0uWCZEzhLYKpVwSsfgC6ltIXAtJrvNwb
         5/U60UwaJUWvby/sP+d85R//yA42J1LAfaJCATAK+VT3xwe83ow9R3jofNjabtnJlY3J
         t2nBg3EYn9AbDIqf5l/ZEo/rRNNZIMeGmjHiqdlQKEIzLm7wsRkCW9xGLy+j8uJb0xUx
         9GxQ==
X-Gm-Message-State: AO0yUKVSejTrTUtljjm6jE/3sU/1LTLhdO5MOM2ZglYiDLaBuJ/srH6O
        Mqbc+OtuTXAOJKtUL0DR8TCMR9aut4biCmhedTA=
X-Google-Smtp-Source: AK7set8NoYry9Yq6J5sNZxc7BnHokFJ8tCFNa0+B50Ai5S744OfZBFpSH9uj+oKRQGyqnrfCD59MdvbyvoJLlcyEUiE=
X-Received: by 2002:a50:9b53:0:b0:4ae:f648:950b with SMTP id
 a19-20020a509b53000000b004aef648950bmr4829258edj.7.1678063966118; Sun, 05 Mar
 2023 16:52:46 -0800 (PST)
MIME-Version: 1.0
References: <20230228102820.18477-1-chanh@os.amperecomputing.com>
 <775059b1-4697-b745-4743-55f7f7a9143e@molgen.mpg.de> <8033851a-6eaf-e4e7-5e80-0a1f7331c67a@amperemail.onmicrosoft.com>
In-Reply-To: <8033851a-6eaf-e4e7-5e80-0a1f7331c67a@amperemail.onmicrosoft.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 6 Mar 2023 00:52:33 +0000
Message-ID: <CACPK8XfJmjF6cMta=igG7absJwttOv1H7=437_Vq_upeeKmdHA@mail.gmail.com>
Subject: Re: [PATCH v2] ARM: dts: aspeed: mtmitchell: Enable NCSI
To:     Chanh Nguyen <chanh@amperemail.onmicrosoft.com>
Cc:     Paul Menzel <pmenzel@molgen.mpg.de>,
        Chanh Nguyen <chanh@os.amperecomputing.com>,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andrew Jeffery <andrew@aj.id.au>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-aspeed@lists.ozlabs.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,URIBL_CSS,WEIRD_QUOTING autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Mar 2023 at 15:59, Chanh Nguyen
<chanh@amperemail.onmicrosoft.com> wrote:
>
>
>
> On 01/03/2023 14:51, Paul Menzel wrote:
> > Dear Chanh,
> >
> >
> > Thank you for the patch.
> >
> > Am 28.02.23 um 11:28 schrieb Chanh Nguyen:
> >> Support the mac3 (RGMII4) as an NC-SI stack instead of an MDIO PHY.
> >>
> >> The OCP slot #0 and OCP slot #1 use a common the BMC_NCSI signal,
> >
> > *the* seems a leftover.
>
> Thank Paul,
> I'll remove it.
>
> >
> >> so we use only one of them at the same time. The OCP slot #0 will
> >> be enabled by PCA9539's setting by default.
> >>
> >> Also, enable the OCP Auxiliary Power during booting.
> >
> > Is there a reason not to make this a separate commit?
> >
> >
> > Kind regards,
> >
> > Paul
> >
>
> I wouldn't like to separate it.
>
> This is "Enable NCSI" commit, so I would like to support all configs,
> that make NCSI feature works.

That sounds reasonable.

>
> Thanks,
> Chanh
> >
> >> Signed-off-by: Chanh Nguyen <chanh@os.amperecomputing.com>
> >> ---
> >> Changes in v2:
> >>     - Change PCA9539APW node name.                     [Krzysztof]
> >> ---
> >>   .../boot/dts/aspeed-bmc-ampere-mtmitchell.dts | 37 ++++++++++++++++++-
> >>   1 file changed, 36 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> >> b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> >> index 4b91600eaf62..1e0e88465254 100644
> >> --- a/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> >> +++ b/arch/arm/boot/dts/aspeed-bmc-ampere-mtmitchell.dts
> >> @@ -251,6 +251,14 @@
> >>       pinctrl-0 = <&pinctrl_rgmii1_default>;
> >>   };
> >> +&mac3 {
> >> +    status = "okay";
> >> +    pinctrl-names = "default";
> >> +    pinctrl-0 = <&pinctrl_rmii4_default>;
> >> +    clock-names = "MACCLK", "RCLK";
> >> +    use-ncsi;
> >> +};
> >> +
> >>   &fmc {
> >>       status = "okay";
> >>       flash@0 {
> >> @@ -439,6 +447,26 @@
> >>       status = "okay";
> >>   };
> >> +&i2c8 {
> >> +    status = "okay";
> >> +
> >> +    gpio@77 {
> >> +        compatible = "nxp,pca9539";
> >> +        reg = <0x77>;
> >> +        gpio-controller;
> >> +        #address-cells = <1>;
> >> +        #size-cells = <0>;
> >> +        #gpio-cells = <2>;
> >> +
> >> +        bmc-ocp0-en-hog {
> >> +            gpio-hog;
> >> +            gpios = <7 GPIO_ACTIVE_LOW>;
> >> +            output-high;
> >> +            line-name = "bmc-ocp0-en-n";
> >> +        };
> >> +    };
> >> +};
> >> +
> >>   &i2c9 {
> >>       status = "okay";
> >>   };
> >> @@ -530,13 +558,20 @@
> >>       /*V0-V7*/
> >> "s0-hightemp-n","s0-fault-alert","s0-sys-auth-failure-n",
> >>               "host0-reboot-ack-n","host0-ready","host0-shd-req-n",
> >>               "host0-shd-ack-n","s0-overtemp-n",
> >> -    /*W0-W7*/    "ocp-aux-pwren","ocp-main-pwren","ocp-pgood","",
> >> +    /*W0-W7*/    "","ocp-main-pwren","ocp-pgood","",
> >>               "bmc-ok","bmc-ready","spi0-program-sel","spi0-backup-sel",
> >>       /*X0-X7*/    "i2c-backup-sel","s1-fault-alert","s1-fw-boot-ok",
> >>
> >> "s1-hightemp-n","s0-spi-auth-fail-n","s1-sys-auth-failure-n",
> >>               "s1-overtemp-n","s1-spi-auth-fail-n",
> >>       /*Y0-Y7*/    "","","","","","","","host0-special-boot",
> >>       /*Z0-Z7*/    "reset-button","ps0-pgood","ps1-pgood","","","","","";
> >> +
> >> +    ocp-aux-pwren-hog {
> >> +        gpio-hog;
> >> +        gpios = <ASPEED_GPIO(W, 0) GPIO_ACTIVE_HIGH>;
> >> +        output-high;
> >> +        line-name = "ocp-aux-pwren";
> >> +    };
> >>   };
> >>   &gpio1 {
