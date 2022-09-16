Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DC125BAEF0
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Sep 2022 16:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231854AbiIPOH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 10:07:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231723AbiIPOH0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 10:07:26 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A20C5AF0FC;
        Fri, 16 Sep 2022 07:07:25 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id a8so35693491lff.13;
        Fri, 16 Sep 2022 07:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date;
        bh=iLu0VuA8ebe7pmbktT8jzi5ca8f+ukCGrOYtjSJn1ig=;
        b=kCVVOahsbGvFKnGNjkLKeuPqjOfwWfrJu4cPdzi5fiE1fXznySCPBifuFsji63TPiC
         9NRfPZhqqlbgzsssoz6mqfLsJTQrOFEaEFV5xDMNVBv3/ZCY8XcXSgZWer/9FPH+Nal1
         wGy1LyQHRHo8lAPJGR7pYTERnOMRj77XZXaxp5yozfx39q65EJkbsU3e0p0ggKwMbKVW
         LPrN/zbC1i4F1Ya0EAPKQB3f4vhy+Eg7nTh8ZTn/uA8J7vVidCNJpgawAUEGmjp1fWaN
         S0kAFuIOB6MCnroTfADCES+UcOIjj2gTQ6HAgm4IKtJjh45AcWNVWRu5z10sywveD3oz
         0z5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date;
        bh=iLu0VuA8ebe7pmbktT8jzi5ca8f+ukCGrOYtjSJn1ig=;
        b=DASgczW7+I7TcD+CW6CZJhBe6bKovFb1E7c1D9slpSGHFbfhl6pP/GP28GbpLDXFxO
         FFLllYE1YfRnmyGnoB8y1uTqLGW4toN5RLz5NMwlYo7/Gqf03RqBm+RhXVeQazQ8ePFU
         lCmqbdPiC+PRCXvPCtlJqWQvGEhtHX+EWjEb50Mcq62bl68J6gxOepcgAFyCpIwg/jNC
         qS1aILu6KkvaBLGIcxR7+XGkdub2D/U7tP5zLi++dGu06Zc4XIwdPOX72XflHNVu2h/G
         5vqXB4yZs1anlx+FkU4Wsr7qs9a2FXNFzziKKPgm7EOAfTv/c6Ijz1UwCXMrAU7jxnD3
         1kOQ==
X-Gm-Message-State: ACrzQf2SnZwLP0T2/uA/YdHkzW/tX9K+XDJiaRcsGp4FLsQiwhnObL5b
        niHxvUxFf3eCqYyvSPEnlgYpr3dUPBIg5w==
X-Google-Smtp-Source: AMsMyM6vV77YRUFXuXhsIdJCqGXePBDlYMvgp7+fNLQuTnjx+oENs8hLkArKp5CHJhOVcVr/JLgBWw==
X-Received: by 2002:a05:6512:3503:b0:496:517:5802 with SMTP id h3-20020a056512350300b0049605175802mr1713258lfs.83.1663337243713;
        Fri, 16 Sep 2022 07:07:23 -0700 (PDT)
Received: from razdolb (95-31-185-216.broadband.corbina.ru. [95.31.185.216])
        by smtp.gmail.com with ESMTPSA id v6-20020a197406000000b004979df1c1fasm3513091lfe.61.2022.09.16.07.07.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 07:07:23 -0700 (PDT)
References: <20220911200147.375198-1-mike.rudenko@gmail.com>
 <20220911200147.375198-3-mike.rudenko@gmail.com>
 <20220914155122.GA9874@tom-ThinkPad-T14s-Gen-2i>
 <87k064pa2v.fsf@gmail.com>
 <20220916133401.GB2701@tom-ThinkPad-T14s-Gen-2i>
User-agent: mu4e 1.9.0; emacs 28.1
From:   Mikhail Rudenko <mike.rudenko@gmail.com>
To:     Tommaso Merciai <tommaso.merciai@amarulasolutions.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Jacopo Mondi <jacopo@jmondi.org>,
        Shawn Tu <shawnx.tu@intel.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Daniel Scally <djrscally@gmail.com>,
        Christian Hemp <c.hemp@phytec.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Marek Vasut <marex@denx.de>, linux-media@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: add support for ov4689
Date:   Fri, 16 Sep 2022 16:44:31 +0300
In-reply-to: <20220916133401.GB2701@tom-ThinkPad-T14s-Gen-2i>
Message-ID: <87r10bo1k5.fsf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2022-09-16 at 15:34 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
> Hi Mikhail,
>
> On Thu, Sep 15, 2022 at 11:50:23PM +0300, Mikhail Rudenko wrote:
>>
>> Hi Tommaso,
>>
>> On 2022-09-14 at 17:51 +02, Tommaso Merciai <tommaso.merciai@amarulasolutions.com> wrote:
>> > Hi Mikhail,
>> > I do a first round on reviewing your driver :)
>> >
>> > On Sun, Sep 11, 2022 at 11:01:35PM +0300, Mikhail Rudenko wrote:

<snip>

>> >> +
>> >> +	ov4689->xvclk = devm_clk_get(dev, "xvclk");
>> >> +	if (IS_ERR(ov4689->xvclk)) {
>> >> +		dev_err(dev, "Failed to get xvclk\n");
>> >> +		return -EINVAL;
>> >> +	}
>> >
>> > ^ I think is better to use devm_clk_get_optional instead of clck_get.
>> > clck_get can fail in CPU's that use ACPI
>> >
>> >> +
>> >> +	ret = clk_set_rate(ov4689->xvclk, OV4689_XVCLK_FREQ);
>> >> +	if (ret < 0) {
>> >> +		dev_err(dev, "Failed to set xvclk rate (24MHz)\n");
>> >> +		return ret;
>> >> +	}
>> >> +	if (clk_get_rate(ov4689->xvclk) != OV4689_XVCLK_FREQ)
>> >> +		dev_warn(dev, "xvclk mismatched, modes are based on 24MHz\n");
>> >
>> >
>> > What do you think about?
>> > Thanks.
>>
>> Unfortunately, I have no experience with ACPI-based devices. :(
>>
>> Do you mean that in the case of an ACPI device and devm_clk_get_optional
>> returning NULL we should assume that the clock is already enabled and
>> will stay enabled during sensor operation? How should we distinguish it
>> from the case of an OF-based system and clock just missing from device
>> tree?
>
> Not exaclty :)
>
> I copy comment from [1]
>
> if you use ov5693->xvclk to identify the ACPI vs OF use case shouldn't
> you use the get_optionl() version ? Otherwise in the ACPI case you will have
> -ENOENT if there's not 'xvclk' property and bail out.
>
> Unless my understanding is wrong on ACPI we have "clock-frequency" and
> on OF "xvclk" with an "assigned-clock-rates",
>
> [1] https://patchwork.linuxtv.org/project/linux-media/patch/20220627150453.220292-5-tommaso.merciai@amarulasolutions.com/
>
> Let me know if you need more details.

Thanks for the pointer! I'll try to implement something along the lines
of your ov5693 series.

But I'm not sure that will be enough to support ACPI systems
correctly. What about lanes number and link frequency checks? Should
they be made conditional on CONFIG_OF? Anything else I don't know?

>
> Regards,
> Tommaso
>
--
Best regards,
Mikhail Rudenko
