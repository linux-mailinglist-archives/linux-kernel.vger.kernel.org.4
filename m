Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B039765E82D
	for <lists+linux-kernel@lfdr.de>; Thu,  5 Jan 2023 10:48:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231977AbjAEJsc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 Jan 2023 04:48:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231429AbjAEJsM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Jan 2023 04:48:12 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A265254726;
        Thu,  5 Jan 2023 01:48:11 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 1ED213200A49;
        Thu,  5 Jan 2023 04:48:10 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Thu, 05 Jan 2023 04:48:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672912089; x=1672998489; bh=fx
        RgFMFJkcfqXAuf9yZKddG/6gTkmyvw+JYOIZcIs6Y=; b=HUzOxVzi8SPiFZ+jm4
        ZPDcF9rrI5dUTEUDRToWj4YCk/L3GWo5Kiel48b0qHBa4wHEXFRN05qIYhIQg4Sv
        KkgQoU43LDTrvPsvRfY0bkMSaoVjHtQyEH+wuZcKtrAOvqWiY9FVM/SmpzEl7kqW
        tlxMXZg2nuSZ2EPCV5oDWCYnQrzMCAuISfe+w4CvPDsr9jf1YOB4t7eSsuCB1/KT
        vwFs0Z/rZUNLGvDYvn072/IottGCP941pTrVhqcksymhPB14Xyzwq4uhDd3xfzpL
        HfKPvjC5cOHUtKgHC2dhvhiGFmdiW7M3wJLhBdvrz7dLPxMyMG9zkBADvmagsAPx
        rTkA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1672912089; x=1672998489; bh=fxRgFMFJkcfqXAuf9yZKddG/6gTk
        myvw+JYOIZcIs6Y=; b=PuNY1tKr2WSwgtb7gL5tb1jgzhb2sarZFEBSzF5ZgcjV
        lkVRDU4tD/ZYO3E/nBYiRqW0znTxcDTHd33xjclOZ2AiAEOPon411jk2o1xzEnOo
        Nfx03L3zhS0Lwm/DY8kF26DjYWXgDSxafHacSOHcbT1LPSlMO1zvvq1f4zTbDeon
        hJudUmDC030QeHk9OXnYvuwCWpQ9T5ntkiZJKPxZ6LpwvuQ5QKytea6boBr5/dra
        PvltiSSz4iWIXKSxW2tootZOa7UGh/fMBLk/A9kozpf9/qm0w73z7hV3PMWAFNRQ
        0BAJ1vwzR6LnohcTOAOQsfS7XMzdA9LxIQxW4BP/+g==
X-ME-Sender: <xms:2Zy2Y2_M2zTPFrMVkpbYo0qFBp-nw2-iL4Si5hA3oe2utbATArjSWA>
    <xme:2Zy2Y2vhi_ue9B7cd_G0XTeVCo9N0KpR-sY02ulJ5Rd3Rm-OB5JkcTZdAjROJP1Js
    5d3W_jVzIFbJ_YBgmo>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjeekgddtkecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:2Zy2Y8B0GVdM-I5_Pt17r-NbiZu3419bgodhUWNxLWUOxUtUk9qHkw>
    <xmx:2Zy2Y-ehnlope9GIwkuPDbZ7yBMPpCL5qHCyADT0dgiQtMAXXvXs6Q>
    <xmx:2Zy2Y7M9OOpJd9q9BlYaXT7O3I0nPNJ7XrZo-mhz1lTkDfXx5sX8GQ>
    <xmx:2Zy2Y8GiRY4wnx9jtsWQI3Opwmtbt_xhN_FjhnMaV3GnpwEectSUZg>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 41F2EA6007C; Thu,  5 Jan 2023 04:48:09 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <7ecde27b-05e9-4727-8441-e17916df237a@app.fastmail.com>
In-Reply-To: <3af091e9-09b4-53a0-da2d-5b2640040b9d@marcan.st>
References: <20230104110013.24738-1-marcan@marcan.st>
 <20230104110013.24738-4-marcan@marcan.st>
 <71bffbd4-f8b0-4201-b2eb-7a15847ac2c6@app.fastmail.com>
 <3af091e9-09b4-53a0-da2d-5b2640040b9d@marcan.st>
Date:   Thu, 05 Jan 2023 10:47:39 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Hector Martin" <marcan@marcan.st>,
        "Joerg Roedel" <joro@8bytes.org>, "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>
Cc:     "Alyssa Rosenzweig" <alyssa@rosenzweig.io>,
        "Janne Grunau" <j@jannau.net>, "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, iommu@lists.linux.dev,
        asahi@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/7] iommu: dart: Support >64 stream IDs
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Thu, Jan 5, 2023, at 05:43, Hector Martin wrote:
> On 2023/01/04 22:37, Sven Peter wrote:
>>>  #include "dma-iommu.h"
>>>
>>> -#define DART_MAX_STREAMS 16
>>> +#define DART_MAX_STREAMS 256
>> 
>> Feels a bit wasteful to allocate 256-wide sid2group and save_{tcr,ttbr}
>> arrays even for the M1 where 16 are enough. But then again, that's still <100 KiB
>> for all DARTs combined and these machine have >8 GiB of RAM so it probably won't
>> make a difference
>
> Yeah, I don't think this is worth the extra fumbling around with dynamic
> allocation.
>
>>>  	/* enable all streams globally since TCR is used to control isolation */
>>> -	writel(DART_STREAM_ALL, dart->regs + DART_STREAMS_ENABLE);
>>> +	for (i = 0; i < BITS_TO_U32(dart->num_streams); i++)
>>> +		writel(U32_MAX, dart->regs + DART_STREAMS_ENABLE);
>> 
>> This seems weird: this code writes U32_MAX to the same register
>> again and again. 
>
> Whoops, that was supposed to have a `+ 4 * i` in there. Fixed for v2.

Great! Feel free to also add

Reviewed-by: Sven Peter <sven@svenpeter.dev>

then.


Best,

Sven
