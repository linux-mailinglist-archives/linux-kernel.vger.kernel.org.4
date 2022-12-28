Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 030B66576BC
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 14:03:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiL1NDk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 08:03:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiL1NDi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 08:03:38 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD38DBC87
        for <linux-kernel@vger.kernel.org>; Wed, 28 Dec 2022 05:03:34 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id BBA103200805;
        Wed, 28 Dec 2022 08:03:29 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Wed, 28 Dec 2022 08:03:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding
        :content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1672232609; x=1672319009; bh=TLU74PXJfz
        pqn0KEHaCOSImGRn46WMSc3FVLWqZtgWU=; b=GDcjXRQ4N09gwZN6PNPWoXXffs
        XDkLib1G0GwCpaT0hbzfsudMFLyD8Jz13KbsrMOYxBcoWgIjXmXZwRJFDJUg9Dg4
        fL/jVj5JQGnxfIqwCw5Cqxp0PGS8if1hed4H33jFpJvzKLjqy0rrGqSx510Tc7aJ
        lte5+92Ont5K6tiPuU66BhBrSpDN1pKWzZiX0rnufmp+6iqNPENgY8PSeHCgkpvS
        3fSdxNpBGsExnDOvo1/+s/t6jWsqR3ms3hARDB10Nola6y7I/+SmzXXc+mmCzG8j
        X0O7pfOGtkKnxvGWmmCkeaJ6x/hPmR/CpovN9nTdFIC89K4kY0fkpgpk7Vcg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672232609; x=
        1672319009; bh=TLU74PXJfzpqn0KEHaCOSImGRn46WMSc3FVLWqZtgWU=; b=j
        deDm03g+ySGgWg23fAXJp2+voMZabMNC2p8boQsWe5NiY1FxI0Pn9+ODUw9/EJfx
        8NXto8syXN77fXbWs1SZJ9RYp+chBp6H0UlxNQDFR0okO2007YECZhGwgYkHEZDX
        SCF1CW5pw2eW9FBqdclKpUbya0n9zjRabH5E/q7DIIoQ8RoKgK7l9hWrLPtuNBg9
        kPectq1HukX8RC4KJqHjmhEu2nVwu1ozxXD7UMS/5OD8qgezWaDKQ0OHKReVXO9P
        GDISuL7Ihkz/9XPlVavZETacPSY561UhS5wjpvqbs5LM4kaP+/BZOOSVQ4fzY9E1
        k1SBLLJD39ZUcbg3/WkTg==
X-ME-Sender: <xms:oD6sY_-EtDKB1JeUBpmpCDqlr9HvECHRPuWy_N75IyMQKRM5h2ez1g>
    <xme:oD6sY7vWY8vJ95sKORu89J1RuCuFCnkr5FkNRUp7WDLCEVucb5xbWnaC8LZsID0OW
    rdEgVaqEF-bCtzqhQ>
X-ME-Received: <xmr:oD6sY9DHMmL7ns_WsHU9JHwaXmund1ISvJeJn0J-4_I2nG3ythmF6yGwKxGFtCiNI4w9V_5w6AX34vBDCebqucjU>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdegkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfuvfevfhfhjggtgfesthekredttdefjeenucfhrhhomhepvfhomhcu
    hfhithiihhgvnhhrhicuoehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhkqe
    enucggtffrrghtthgvrhhnpeefgfekteduffeiudegfeejfefgvddufefhvedukeeiffdu
    gfeludfhhefgvdegffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrih
    hlfhhrohhmpehtohhmsehtohhmqdhfihhtiihhvghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:oD6sY7dfx0ccTAZ3FfrwgPxSAGCWpcgvYNItXxj5UCh8sGLBIKLdaQ>
    <xmx:oD6sY0Pv2do8ZqwS_1KXoOfvHAAdPXZYhm5M-94HhtvJVTh-OQCmNQ>
    <xmx:oD6sY9mtayhQCnNpMhJo8hC-NdnouST97C9s5j9SoQAqKpNk_WNJfQ>
    <xmx:oT6sY_EipqLBB_Mkv2jwOJ0X1-3BRfdXBSRfxaJ3_SsiBqmpdoyBVA>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 08:03:23 -0500 (EST)
Message-ID: <f224714d-4606-7f69-beda-6113ba17e619@tom-fitzhenry.me.uk>
Date:   Thu, 29 Dec 2022 00:03:20 +1100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v3 2/4] drm: panel: Add Himax HX8394 panel controller
 driver
To:     Javier Martinez Canillas <javierm@redhat.com>,
        linux-kernel@vger.kernel.org
Cc:     Peter Robinson <pbrobinson@gmail.com>,
        Martijn Braam <martijn@brixit.nl>,
        Maya Matuszczyk <maccraft123mc@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Neal Gompa <ngompa13@gmail.com>,
        =?UTF-8?Q?Kamil_Trzci=c5=84ski?= <ayufan@ayufan.eu>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Robert Mader <robert.mader@posteo.de>,
        Onuralp Sezer <thunderbirdtr@fedoraproject.org>,
        Ondrej Jirman <megi@xff.cz>, dri-devel@lists.freedesktop.org,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Thierry Reding <thierry.reding@gmail.com>
References: <20221227110335.2923359-1-javierm@redhat.com>
 <20221227110335.2923359-3-javierm@redhat.com>
Content-Language: en-US
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
In-Reply-To: <20221227110335.2923359-3-javierm@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/12/22 22:03, Javier Martinez Canillas wrote:
> From: Kamil Trzciński <ayufan@ayufan.eu>
> 
> The driver is for panels based on the Himax HX8394 controller, such as the
> HannStar HSD060BHW4 720x1440 TFT LCD panel that uses a MIPI-DSI interface.
> 
> Signed-off-by: Kamil Trzciński <ayufan@ayufan.eu>
> Co-developed-by: Ondrej Jirman <megi@xff.cz>
> Signed-off-by: Ondrej Jirman <megi@xff.cz>
> Co-developed-by: Javier Martinez Canillas <javierm@redhat.com>
> Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> Reviewed-by: Sam Ravnborg <sam@ravnborg.org>

Tested-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>

Tested to boot on my Pinephone Pro, thanks for the mainlining!
