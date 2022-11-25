Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 535C2638BB4
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 14:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229849AbiKYN6X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 08:58:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbiKYN6V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 08:58:21 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 652B317591
        for <linux-kernel@vger.kernel.org>; Fri, 25 Nov 2022 05:58:20 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 0B0A65C00EE;
        Fri, 25 Nov 2022 08:58:16 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Fri, 25 Nov 2022 08:58:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm3; t=1669384696; x=1669471096; bh=HZFW0Q6ily
        rDold9b9ca9gHjKB3WJYu7yBNi/OLlm4s=; b=KGJZiKitRl3OE1rk8bBGc/1ZQ3
        Ma4nnuK/qC4S+Z7c21rN3BBkmmsOTu1iSi306GclQlD1aLoZAI7bxy/Zyf2WWL/c
        T9YvWuOmeJrBE27O8hLQcZnBIRtt9zF029V8GJQjvRIz05T4SrutfObIB2+ecPmU
        aBmXNBORU+7plARbIQUQSQ5mPoXPc7wapieq5aUFQwuQ3c9l+7X8Di1Tkd2WkPey
        JXi606GY2/woLA7wakeS7nNMMWQZj5pAhDMaidzPb4bOqwDKNFBbYuTD93yeC7H7
        nYJlejZXEmApA5wxfE4OEZtGDMbpTAe+VgMh0H2DdXH/wJsvYNw8sBVsSGiw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669384696; x=1669471096; bh=HZFW0Q6ilyrDold9b9ca9gHjKB3W
        JYu7yBNi/OLlm4s=; b=WCy1IAOAaD2q1pazTB73ladozixKckhwGuvVzqadnlJP
        8J01lU3w9VknC9kPGp3I7gOJrs8GiLfpRxTIkKd6S5jJAjCWwHIQhYJNTTJSZTEz
        i3nXo0D2H947sSrNaGRGnq5Kp8vW1eQ1zBUysveDTiTrDXCVrwt/ul8GqKybWKtD
        7V/BtIkBcO16XL/6LR4PoTIzudeUJeTt85YvzVW28dvqxomIk2wSGU5DV1WHXU3H
        ZWgvNxf3+yDutaJgJ/WYFSUUhTJYy/wuxE/IPkXCtHQMWBNM1T3RQXY8C1aaSYps
        39J8LX+2CdwIwUPL7WGG4cv2wSM6DmRkvi8McvKdtg==
X-ME-Sender: <xms:98mAYwTQQTPGZUCY5Ecf99OxN3NiVm8yFLqj-xE3583Zb1FwbQfQdQ>
    <xme:98mAY9xFj3fZePOmQeLVotqhpGpJT82FlInXycwbBhS05dxL7D2bG8b9TqWBgvUHn
    mZ3bCgl9dGb2ra3WG4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieehgdehlecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeffheeugeetiefhgeethfejgfdtuefggeejleehjeeutefhfeeggefhkedtkeet
    ffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrrh
    hnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:98mAY92-9MacwOWeuopHJrwvwn8LiAnzE5Y0q9lTofBIjOxjSE_S2Q>
    <xmx:98mAY0A-T3hqUI6pt_PcBXnOum7WDdCLnvk4tFP0rF6WahVCDRCXwQ>
    <xmx:98mAY5jF7orPhyh-LUci3Lcj-EVZkKEk81Hfz_gu9sIAR7uraz74FA>
    <xmx:-MmAYyZ2dEuifH96GuYTNE97AmSuYSQT7jhv1i24XaZPX_o4hKDJ7A>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 90CCFB60086; Fri, 25 Nov 2022 08:58:15 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <347df991-4755-4f11-b530-4d0e3994a9db@app.fastmail.com>
In-Reply-To: <Y4DFx20YXDLcuVJm@google.com>
References: <20221125120750.3537134-1-lee@kernel.org>
 <20221125120750.3537134-3-lee@kernel.org> <Y4DFx20YXDLcuVJm@google.com>
Date:   Fri, 25 Nov 2022 14:57:55 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Lee Jones" <lee@kernel.org>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Maarten Lankhorst" <maarten.lankhorst@linux.intel.com>,
        mripard@kernel.org, "Thomas Zimmermann" <tzimmermann@suse.de>,
        "Dave Airlie" <airlied@gmail.com>,
        "Daniel Vetter" <daniel@ffwll.ch>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>,
        "Harry Wentland" <harry.wentland@amd.com>,
        "Leo Li" <sunpeng.li@amd.com>,
        "Rodrigo Siqueira" <Rodrigo.Siqueira@amd.com>,
        "Alex Deucher" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        Xinhui.Pan@amd.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev, amd-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org
Subject: Re: [PATCH v2 2/2] Kconfig.debug: Provide a little extra FRAME_WARN leeway
 when KASAN is enabled
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Nov 25, 2022, at 14:40, Lee Jones wrote:
> On Fri, 25 Nov 2022, Lee Jones wrote:
>
>> When enabled, KASAN enlarges function's stack-frames.  Pushing quite a
>> few over the current threshold.  This can mainly be seen on 32-bit
>> architectures where the present limit (when !GCC) is a lowly
>> 1024-Bytes.
>> 
>> Signed-off-by: Lee Jones <lee@kernel.org>
>> ---
>>  lib/Kconfig.debug | 1 +
>>  1 file changed, 1 insertion(+)
>> 
>> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
>> index c3c0b077ade33..82d475168db95 100644
>> --- a/lib/Kconfig.debug
>> +++ b/lib/Kconfig.debug
>> @@ -399,6 +399,7 @@ config FRAME_WARN
>>  	default 2048 if GCC_PLUGIN_LATENT_ENTROPY
>>  	default 2048 if PARISC
>>  	default 1536 if (!64BIT && XTENSA)
>> +	default 1280 if KASAN && !64BIT
>>  	default 1024 if !64BIT
>>  	default 2048 if 64BIT
>>  	help
>
> Note this also fixes 61 warnings when
>
>   (GCC && !GCC_PLUGIN_LATENT_ENTROPY)
>
> ... which as Arnd says should not be enabled by default.  We'll
> address that issue once this set has been applied.

Thanks a lot for checking this!

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
