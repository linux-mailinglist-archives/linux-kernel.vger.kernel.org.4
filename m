Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C48C64EAD6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Dec 2022 12:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231201AbiLPLtL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Dec 2022 06:49:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229495AbiLPLtB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Dec 2022 06:49:01 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50A692CCA0;
        Fri, 16 Dec 2022 03:49:00 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 0F9DE3200708;
        Fri, 16 Dec 2022 06:48:56 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Fri, 16 Dec 2022 06:48:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1671191336; x=1671277736; bh=kU35CPgp3n
        vA6LdQKqXJPSk0/v+oA3trIRauG4K8Ze0=; b=bcxr5jnvgRjNAFsqIBEUVIt+AM
        i+MXSxqI3uaAXNLpW6x7DxeBtlw5PepzNy9d8k9oY74QONmfqLlBJKAr5MC5Uixy
        r7lMONGsst2KWE3OMMcLFLU9zRKCLk1uM9WcZWjVtUlbqcRxcc/RJ8WRhIorSbwT
        FXVfnXGHrq07mMlG3tkFoylttAanLPuhZUjqp0pzokUKu4JE4aXyptENgzcbk5Z0
        mrJhFK71CS4qTkPzbxABHuIWmyoEdZ/FnIDpluuEcokB5jhX69gK9rnTt4kOlw/h
        2r7hlk5gWVBGYayJBppElHT7/IhilkH0dKj43oP61t6ey8nRwVBl0MJm4eWw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm2; t=1671191336; x=1671277736; bh=kU35CPgp3nvA6LdQKqXJPSk0/v+o
        A3trIRauG4K8Ze0=; b=GtuKxE2Fsy1VJWC9GQp1T6cVuRJdx/SLgWoWsrRKMvmS
        sfEMV20HBaeSCe46xNZI3MuEcg07PHqNVOnthQUse3Ozj3BFpV5WGl4TVjeCRKpO
        IvANQ2eJGgVRHcMxipykj2xP7frSZiKHiTyk6ruubW50n44h1+zGE20tMiqK05bt
        VZmr9A4zT19v+VH4xbdMlpBgZYBqrGpBISj1M6dKorf+9icgkFcaS8lF1JBeupvM
        5M+XJcRUKv1N4aWFtOZxdarUNYoz+ytKn+/R7x8kbLhYpbFXgFi0Mi6mmG1N7WTT
        RuSWUkHZ1qY3YzbxPBXkFHuKRkQtS0xyJaK5zcXZKQ==
X-ME-Sender: <xms:J1ucY1rESxiX0OHiXDQUlWcF5SxiWbkeif3nDFiOhFeH1bdSahhfnw>
    <xme:J1ucY3qSmcH4nOlvasc7udse7hQztflWUuoOVBe3oBBnx6tBxY50Y49t3t0ZaAjdn
    Rp9L1g5IcQ4ROInGPc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejgdefudcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesmhdtreerreertdenucfhrhhomhepfdetrhhn
    ugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrghtth
    gvrhhnpeekledvieevudeltefghefggffgtdelveetieejhfelteevieehteeljedtkefg
    ueenucffohhmrghinhepphgrshhtvggsihhnrdgtohhmnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:J1ucYyNS1TP6Hp1o-4ji_qxbcWyhYoAO_ZZrHt5ate5FSRUhe3Uh0A>
    <xmx:J1ucYw7XxhC3HtwokQFaHoihPuuUQfFfokF-p3GrfQt4hy1jL8aVqA>
    <xmx:J1ucY07pC2ugwLoYZIHNc5Fr1AikuPwcosLAm8j9CT6iZxo3-sJm9g>
    <xmx:KFucY_IQvnnkR0sXZAd3mx--HVxiNrRyuU7IRuujQueCerfBcGqcQQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 9135EB60086; Fri, 16 Dec 2022 06:48:55 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1185-g841157300a-fm-20221208.002-g84115730
Mime-Version: 1.0
Message-Id: <7528ccc8-7337-4e7f-9474-0d94ed6152ed@app.fastmail.com>
In-Reply-To: <Y5xVHU5FBr5qzAOs@hirez.programming.kicks-ass.net>
References: <20221215162905.3960806-1-arnd@kernel.org>
 <Y5xVHU5FBr5qzAOs@hirez.programming.kicks-ass.net>
Date:   Fri, 16 Dec 2022 12:46:18 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Peter Zijlstra" <peterz@infradead.org>,
        "Arnd Bergmann" <arnd@kernel.org>
Cc:     "Robert Foss" <robert.foss@linaro.org>,
        "Todor Tomov" <todor.too@gmail.com>,
        "Josh Poimboeuf" <jpoimboe@kernel.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Konrad Dybcio" <konrad.dybcio@linaro.org>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Jonathan Marek" <jonathan@marek.ca>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        "Nick Desaulniers" <ndesaulniers@google.com>
Subject: Re: [PATCH] media: camss: csiphy-3ph: avoid undefined behavior
Content-Type: multipart/mixed;
 boundary=2a2f36a5189a4026b84f150ff64abf18
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--2a2f36a5189a4026b84f150ff64abf18
Content-Type: text/plain

On Fri, Dec 16, 2022, at 12:23, Peter Zijlstra wrote:
> On Thu, Dec 15, 2022 at 05:28:46PM +0100, Arnd Bergmann wrote:
>> diff --git a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
>> index 451a4c9b3d30..04baa80494c6 100644
>> --- a/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
>> +++ b/drivers/media/platform/qcom/camss/camss-csiphy-3ph-1-0.c
>> @@ -429,7 +429,8 @@ static void csiphy_gen2_config_lanes(struct csiphy_device *csiphy,
>>  		array_size = ARRAY_SIZE(lane_regs_sm8250[0]);
>>  		break;
>>  	default:
>> -		unreachable();
>> +		WARN(1, "unknown cspi version\n");
>> +		return;
>>  	}
>
> So no real objection here; but unreachable() does have an objtool
> annotation inside, so clearly the compiler managed to defeat that --
> perhaps we should look at that too.

Ah, I forgot this annotation existed. I see that this
particular objtool warning only happens with clang (I used
version 14.0.6), but it does not happen with gcc-12.2.

I see the function ends in

	jmp	.LBB3_45
.LBB3_54:
	#APP
.Ltmp0:
	.section	.discard.unreachable,"",@progbits
.Ltmp1:
	.long	.Ltmp0-.Ltmp1
	.text
 	#NO_APP
.Lfunc_end3:
	.size	csiphy_lanes_enable, .Lfunc_end3-csiphy_lanes_enable
                                        # -- End function


full assembler output at https://pastebin.com/F8HGCUvk, object file
attached.

    Arnd
--2a2f36a5189a4026b84f150ff64abf18
Content-Disposition: attachment; filename="camss-csiphy-3ph-1-0.o.xz"
Content-Type: application/x-xz; name="camss-csiphy-3ph-1-0.o.xz"
Content-Transfer-Encoding: BASE64

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
Z/sCAAAAAARZWg==

--2a2f36a5189a4026b84f150ff64abf18--
