Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298736398FF
	for <lists+linux-kernel@lfdr.de>; Sun, 27 Nov 2022 00:49:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiKZXtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 18:49:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbiKZXtR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 18:49:17 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67A1813E07
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 15:49:12 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id D501D5C00A5;
        Sat, 26 Nov 2022 18:49:11 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 26 Nov 2022 18:49:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1669506551; x=
        1669592951; bh=DIPXyu8HQb1ZeFRaVm//QFcNLLl7SMnvb14+RRPUPkc=; b=R
        iQY/SIv5HjpaoqzBhGUqZTel7ZSmfVLzHObK8TWSgG8S9O37n60ZJdjBEY2tNpqe
        3JQiF4Zh4ztELmsG0Za9AgQjHtLA2RVVO5XuxeDQOCMfTLEJlSI7PTfauv7Sd6IX
        mxvX3ExWhe4dEV5xemUwd+jYxczFoOo4M8NI414QWpbFOvMOsEdjrH0o7gREgBDy
        XlmiIOAbd4rKasEh2qDtQ/ezof12Ul3sbiViG+BmBW61DY0C64y0YuM+kNHKKgqF
        LzR1LwPKouhNPrhlBpbezOarHV5/GxWZzvaIbfSReS2niW+ScP9wBreMMB4MPnp5
        VVgTMdx9l2+DJ9UO6Wc0A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1669506551; x=
        1669592951; bh=DIPXyu8HQb1ZeFRaVm//QFcNLLl7SMnvb14+RRPUPkc=; b=U
        C8GgaWMjisgvQdcz3hLMSiJ20Ew4vch670rNrLHvb9AFf0Hv9sZEOL7UDQoB/teG
        sh8Ur2Z0VJLn83s+VcTmiyen6PJ9jO8cQOhJaNVQwMtI0eaB+qqMPfPFtIPM6hUS
        BA19nc6E6K5paeJdjeFOFJDV083ekZBeNe5nz2xjKq9ZhCnV28r+0gWorEozm5FQ
        979QJ7RG5ZYVMlqhDNH30EqmRjNHqRsuDjmiw5Kbf/W1MZsoB6sx7FG1wvWSi4be
        6h5mKvazqzVhFx0sURnQZ3NHn+uLjZnrZmxKuaVKVLQiwxOM5nZ+9+H4g8byVkVu
        4JbC5feOTbrqg6+Gm7zLA==
X-ME-Sender: <xms:96WCY4iUeF_qQCWuMx1cT57Rd41M07iYQOlNy07RSO25VAf6ibGDAA>
    <xme:96WCYxCKHyH9mwItEdndrtCgtLI1MNf5GvDfPWjl-NZ6I5kuk3Xsb3ey1YgyHf3Nv
    yvlJQ3Vlu6JAfj8Fg>
X-ME-Received: <xmr:96WCYwGBmI5qIafbT0yeVnwkTZWAr-yKzWQVxgyK_39MQE368PqeTP7JrCYY-zwBXUd6jeucGjtZywpm45jT-sANBjrLf0Ic_QgJwxGNIUFaV31cO3BNmhxSPw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrieekgddugecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefkffggfgfvvehfhffujggtgfesthejredttdefjeenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepjefgfffhudejfedtuedugeeutdetgfeiteffffehjeeugfeuvdeh
    jeetfedtffdtnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:96WCY5Q_pcqRKMNb4NMPG198kIsx0z4zToCvn-_XEFP6rL7Gwn2kIQ>
    <xmx:96WCY1zOLvDR-BFdiU6RNZLnOGXltIZQ7D4cJV38f4NREIhJbM6ArA>
    <xmx:96WCY34hC9cwjFCKgYTeOSwoT1Ifg5psGo34BVMkYxmo_6GycUSO-A>
    <xmx:96WCYw_LSryUVugF09crF1Dgf1MUhCqoKb2XQ0dfZuwN_jdX4phGRw>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 26 Nov 2022 18:49:10 -0500 (EST)
Message-ID: <cf953917-efe4-8254-f468-3baf7e596483@sholland.org>
Date:   Sat, 26 Nov 2022 17:49:10 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux ppc64le; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Content-Language: en-US
To:     Marc Zyngier <maz@kernel.org>, Tiezhu Yang <yangtiezhu@loongson.cn>
Cc:     Thomas Gleixner <tglx@linutronix.de>, linux-kernel@vger.kernel.org
References: <1666841949-5244-1-git-send-email-yangtiezhu@loongson.cn>
 <87v8n1ubbj.wl-maz@kernel.org>
From:   Samuel Holland <samuel@sholland.org>
Subject: Re: [PATCH v2] irqchip: LoongArch: Select
 GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
In-Reply-To: <87v8n1ubbj.wl-maz@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/26/22 06:53, Marc Zyngier wrote:
> On Thu, 27 Oct 2022 04:39:09 +0100,
> Tiezhu Yang <yangtiezhu@loongson.cn> wrote:
>>
>> An IRQ's effective affinity can only be different from its configured
>> affinity if there are multiple CPUs. Make it clear that this option is
>> only meaningful when SMP is enabled.
>>
>> Signed-off-by: Tiezhu Yang <yangtiezhu@loongson.cn>
>> ---
>>
>> v2: rebased on 6.1-rc2
>>
>>  drivers/irqchip/Kconfig | 2 +-
>>  1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/irqchip/Kconfig b/drivers/irqchip/Kconfig
>> index 7ef9f5e..8461915 100644
>> --- a/drivers/irqchip/Kconfig
>> +++ b/drivers/irqchip/Kconfig
>> @@ -575,7 +575,7 @@ config IRQ_LOONGARCH_CPU
>>  	bool
>>  	select GENERIC_IRQ_CHIP
>>  	select IRQ_DOMAIN
>> -	select GENERIC_IRQ_EFFECTIVE_AFF_MASK
>> +	select GENERIC_IRQ_EFFECTIVE_AFF_MASK if SMP
>>  	select LOONGSON_LIOINTC
>>  	select LOONGSON_EIOINTC
>>  	select LOONGSON_PCH_PIC
> 
> We already have this:
> 
> # Supports effective affinity mask
> config GENERIC_IRQ_EFFECTIVE_AFF_MASK
>        depends on SMP
>        bool
> 
> Do we really need to express this for every interrupt controller?

Unfortunately yes, because "select" does not respect dependencies. So
the "depends on SMP" line does not enforce anything; it only serves to
provide a warning at configure time that the build will break.

Regards,
Samuel

