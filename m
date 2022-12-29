Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A906A65935E
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 00:42:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234272AbiL2Xmb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 18:42:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233995AbiL2Xma (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 18:42:30 -0500
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86EFE13DFA;
        Thu, 29 Dec 2022 15:42:26 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E4D2732005CA;
        Thu, 29 Dec 2022 18:42:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Thu, 29 Dec 2022 18:42:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1672357342; x=
        1672443742; bh=1gy3E5RJ4plz31WG7DEElSsMv0iTidzbV0mFxos58Jc=; b=U
        dJB3D+CKtJysfMw1FOaj5TM8yttV/STDuJXi8EHRU9oC5ld8j/YMVHoou6Ne8CUj
        t/dX81wKmXsC39hPxnkpp0+NC5bVgunkA90+rUp6COC9ZNuT1Sl8AXyUygSqkKCO
        ULCZkKsjjtW7l+p1QTU7py1MnL+prtU5cvPazNL63jFQ3r6yuA6PinItDk/f6fsB
        5U/rIauKfItMT0My9rOu5gvUoy8oAr9RZHh831htOlrey1nHIoCUPABhooVw2KE1
        sxy3fHDfBfzfErWBzPa1FhEBi5YnyK6XIDStL6HVisj3CQJQORE4KLX3g69COVKl
        ES9QGdgsjpz1UmACi9khw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1672357342; x=
        1672443742; bh=1gy3E5RJ4plz31WG7DEElSsMv0iTidzbV0mFxos58Jc=; b=e
        oY9B0MYsxlJ+TDG+x5bM8G9vaZMvjpxQzfvzcofQwVC2Umb07fc5wrL1qFoASfeF
        uk3gaXML/u9sBSWoo0PNsHDcDiH3d4wj4GzbX6CdZsCOwqZp8DenDPAHfw+hxCc+
        fTSvPu2O8zhaiT3TwttCEEHx7Q7hc3T+oGegC10BEcKM7RCTv4q+0KAO6swN9k13
        5s8PkcVxVU5fXCOPe94zAQrBYnjMJisL0qZ/p5uKaMb5xI8mMBE8b/HuNGdEH1L7
        8pbet2iHpusQWq5A9WtLMuqL7LxeLWlRxe7Ozyo962FreA0I24oO6apxQg/37UGK
        HpWDiyQ+pew1ld+4ftiDg==
X-ME-Sender: <xms:3iWuY0Wav1PV8fIzAnlG84yuTA0S551a5N7OFY25u_ck8XrSA3oG5Q>
    <xme:3iWuY4nJwCJbNim14K3DGII8O75skFcewA7sStmniaP5NvWW7n9RXMBv_CAugvbhD
    GO-q4-Z0f2xM8svJA>
X-ME-Received: <xmr:3iWuY4Y905BVRInG-scKOwvH9SSANyR9rIHMaPU_NfDOkymFPTgSEWTpqSeYl3qBHyX1Vw3bN3hPtEQU386VjAL4ag4Rb3Fzy8Rsas7dht5lsSxpKWzfupPkhQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgddufecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepheettdefgeeuudelvdffleejheejueeludduiedvkeffgeetueev
    vdelvdetfeejnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgr
    nhgurdhorhhg
X-ME-Proxy: <xmx:3iWuYzUCo6Ml0ZnklJ8RlnzvE8PNlOVL-08vL7j69wcm2TJVx8bfqA>
    <xmx:3iWuY-lSg1t0qdP48d-FixB2yg_xw9-gYdb2k-2JcUbgbzc5PGqscQ>
    <xmx:3iWuY4c_GvEJ6pdhyRh-VOJsEE_hvS5GafDA4reZfpwR2zbvYoKc2Q>
    <xmx:3iWuYwXIA_liT7dh1at2OaU0E8VZ_PJRIjJphZQBVD7RptMq542xFQ>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 18:42:21 -0500 (EST)
Message-ID: <d5e96e7d-b3c9-5f7d-cfaf-9f747f4058e4@sholland.org>
Date:   Thu, 29 Dec 2022 17:42:21 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Andre Przywara <andre.przywara@arm.com>
Cc:     Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-sunxi@lists.linux.dev
References: <20221229215319.14145-1-samuel@sholland.org>
 <20221229231703.19f5eda7@slackpad.lan>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH] rtc: sun6i: Always export the internal oscillator
In-Reply-To: <20221229231703.19f5eda7@slackpad.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andre,

On 12/29/22 17:17, Andre Przywara wrote:
> On Thu, 29 Dec 2022 15:53:19 -0600
> Samuel Holland <samuel@sholland.org> wrote:
> 
> Hi Samuel,
> 
>> On all variants of the hardware, the internal oscillator is one possible
>> parent for the AR100 clock. It needs to be exported so we can model that
>> relationship correctly in the devicetree.
> 
> So do you plan to use this third clock on any SoCs that don't export it
> yet, like the R40 or V3s, or the older SoCs? This would then create a

I am targeting A31 and A23/A33 with this change, so I can correct those
devicetrees. Currently A31 has the wrong fourth parent for its AR100
clock, and A23/A33 models it completely wrong as a fixed-factor clock.

I have ported Crust to A23/A33, and it sets the AR100 parent to IOSC at
boot (just like on other SoCs), so it doesn't have to change the parent
during suspend/resume. But because the AR100 clock is modeled wrong in
Linux, Linux thinks the APB0 clock is running much faster than it really
is, and sets a totally wrong divider in the RSB controller, which breaks
the RSB bus.

> non-compatible DT change, wouldn't it? Since existing/older kernels
> cannot resolve clock index 2?

With the current patch contents, I expect this change to be backported
as far as 5.4. If I set ".export_iosc = 1" for A31 and A23/A33 instead
of entirely removing the flag, it could be backported further. So that
somewhat mitigates the issue.

The other option would be to add IOSC as a fixed clock in the DT, and
use that as the AR100 parent. We would still want to make this change
now, so we could eventually clean up the DT.

> Or would that not be used by kernels, or would not be fatal?

It might not be fatal if the AR100 clock isn't set to its IOSC parent. I
would have to test this.

Regards,
Samuel

> 
> Cheers,
> Andre
> 
>> Fixes: c56afc1844d6 ("rtc: sun6i: Expose internal oscillator through device tree")
>> Signed-off-by: Samuel Holland <samuel@sholland.org>
>> ---
>> This patch should be applied before [1] so this patch can be backported.
>> [1]: https://lore.kernel.org/linux-rtc/20221229184011.62925-2-samuel@sholland.org/
>>
>>  drivers/rtc/rtc-sun6i.c | 16 ++++------------
>>  1 file changed, 4 insertions(+), 12 deletions(-)
>>
>> diff --git a/drivers/rtc/rtc-sun6i.c b/drivers/rtc/rtc-sun6i.c
>> index ed5516089e9a..7038f47d77ff 100644
>> --- a/drivers/rtc/rtc-sun6i.c
>> +++ b/drivers/rtc/rtc-sun6i.c
>> @@ -136,7 +136,6 @@ struct sun6i_rtc_clk_data {
>>  	unsigned int fixed_prescaler : 16;
>>  	unsigned int has_prescaler : 1;
>>  	unsigned int has_out_clk : 1;
>> -	unsigned int export_iosc : 1;
>>  	unsigned int has_losc_en : 1;
>>  	unsigned int has_auto_swt : 1;
>>  };
>> @@ -271,10 +270,8 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
>>  	/* Yes, I know, this is ugly. */
>>  	sun6i_rtc = rtc;
>>  
>> -	/* Only read IOSC name from device tree if it is exported */
>> -	if (rtc->data->export_iosc)
>> -		of_property_read_string_index(node, "clock-output-names", 2,
>> -					      &iosc_name);
>> +	of_property_read_string_index(node, "clock-output-names", 2,
>> +				      &iosc_name);
>>  
>>  	rtc->int_osc = clk_hw_register_fixed_rate_with_accuracy(NULL,
>>  								iosc_name,
>> @@ -315,13 +312,10 @@ static void __init sun6i_rtc_clk_init(struct device_node *node,
>>  		goto err_register;
>>  	}
>>  
>> -	clk_data->num = 2;
>> +	clk_data->num = 3;
>>  	clk_data->hws[0] = &rtc->hw;
>>  	clk_data->hws[1] = __clk_get_hw(rtc->ext_losc);
>> -	if (rtc->data->export_iosc) {
>> -		clk_data->hws[2] = rtc->int_osc;
>> -		clk_data->num = 3;
>> -	}
>> +	clk_data->hws[2] = rtc->int_osc;
>>  	of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
>>  	return;
>>  
>> @@ -361,7 +355,6 @@ static const struct sun6i_rtc_clk_data sun8i_h3_rtc_data = {
>>  	.fixed_prescaler = 32,
>>  	.has_prescaler = 1,
>>  	.has_out_clk = 1,
>> -	.export_iosc = 1,
>>  };
>>  
>>  static void __init sun8i_h3_rtc_clk_init(struct device_node *node)
>> @@ -379,7 +372,6 @@ static const struct sun6i_rtc_clk_data sun50i_h6_rtc_data = {
>>  	.fixed_prescaler = 32,
>>  	.has_prescaler = 1,
>>  	.has_out_clk = 1,
>> -	.export_iosc = 1,
>>  	.has_losc_en = 1,
>>  	.has_auto_swt = 1,
>>  };
> 

