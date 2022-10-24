Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4A6360AE2B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235537AbiJXOvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231139AbiJXOui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:50:38 -0400
Received: from wout3-smtp.messagingengine.com (wout3-smtp.messagingengine.com [64.147.123.19])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4699D109D45;
        Mon, 24 Oct 2022 06:28:13 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 39C833200929;
        Mon, 24 Oct 2022 09:02:29 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 24 Oct 2022 09:02:30 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-type:date:date:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1666616548; x=1666702948; bh=fnUx1p++KA
        gQPiBJE68Mp5QTxMcFigBIoFmgz0FSbXg=; b=Ciftl+pnvzR/NkjC1/DqpZioet
        mnNu0E4l+5B5n770Eka+AsL+NG9UmPQs+qyqA2ZBWqJ+Dj3pgiq48TNSrHK8Y00G
        j9pND3I5ATMW4osmuiOo3MO2pojazrzNveyiTSMpJxZV1ABR0llIR/RDp9q+jhYJ
        nZfr/R03qN1h4sDqh6YSWRvk9hBlAye8YkblCCxOQOox4dJfaca7aDmlgW5vxXOE
        y/ZNkpWYYum/YVp0Q6e7VyxjCDmFtoadWL0DkFP9FRtj+WHfcgPvwOvYBtRXOSyq
        sYuY1iLMGMy2+weG0qbv+iT8zD85+jEc2LAs38vu1H9FTCAE2NQB/pNnlj2g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm3; t=1666616548; x=1666702948; bh=fnUx1p++KAgQPiBJE68Mp5QTxMcF
        igBIoFmgz0FSbXg=; b=HIpo0JS8spKcPxCx6vTiUvfI6jPkE2rb6B6ulpnKkEFl
        tGqWSJV6LtM2znMrj8lziMf6SxqYZojDYy+XI7UjBDiIl3UYBBMEhTmZ+/nNciAC
        U9qz59tXzdxVkfJ4ylHx4kRYQRHqd5zzHUMEsNw4i7tyitA7DpZKYqRzNsSjLK/N
        6y4vifV5AFXDdcWLOZ4yCjjVOlnvNqqCYrYZcTvEQpEwXI1CLoW4wPEYfk8jekBE
        /rlircUjRq5yi94BjKD7Fro9jGC3GekcTBhiJo6ia5BdspcPMtSCEnfF/0vVqqBF
        aLYRR6m50F5dBOFixJeCSvbF/NfUD7RBB9EkTU9o/w==
X-ME-Sender: <xms:44xWYwGcAcFGNJwxn-swI999BN6vmv1YzLwrVhBvg3kbnxMX6wrFIw>
    <xme:44xWY5VuupZ59qDiHlR6FnEZiJiZsrFSBhG409gAIsjCbhaDoYNFwas4ag-F2EA4Q
    P_c-_9TUFFkorRAkt4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrgedtgedgheehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtsehttdertderredtnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepffehueegteeihfegtefhjefgtdeugfegjeelheejueethfefgeeghfektdek
    teffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:44xWY6JLd8s5lkVR7mtvPK1NGJ6oUaz4YqP25rn05Evd7HF42aO2Qg>
    <xmx:44xWYyEs-kkQDDpW1Vltbq1EQuyg2l-v2Zw6KTgvs4KhJtYPx8bFiQ>
    <xmx:44xWY2U02svQNmG5lwDMe_lplRsbvj006jLf6f7LvvtoMsOh_eXc2A>
    <xmx:5IxWYxHIIKjif0AqMcgy4jrMKZSSy2ObDXHVcpxf3QTNRkhcDXB2lA>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 876A9B6008D; Mon, 24 Oct 2022 09:02:27 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1047-g9e4af4ada4-fm-20221005.001-g9e4af4ad
Mime-Version: 1.0
Message-Id: <a074e9c5-7a1e-4b76-b75e-9f46d621ec0e@app.fastmail.com>
In-Reply-To: <ce7c18ef-8619-1719-59e8-7983e4b0bdc1@linaro.org>
References: <20221021202254.4142411-1-arnd@kernel.org>
 <20221021203329.4143397-17-arnd@kernel.org>
 <ce7c18ef-8619-1719-59e8-7983e4b0bdc1@linaro.org>
Date:   Mon, 24 Oct 2022 15:02:07 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Arnd Bergmann" <arnd@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        "Dmitry Torokhov" <dmitry.torokhov@gmail.com>
Cc:     linux-kernel@vger.kernel.org, "Ben Dooks" <ben-linux@fluff.org>,
        "Simtec Linux Team" <linux@simtec.co.uk>,
        "Alim Akhtar" <alim.akhtar@samsung.com>,
        linux-input@vger.kernel.org, linux-samsung-soc@vger.kernel.org
Subject: Re: [PATCH 17/21] input: remove s3c24xx touchscreen driver
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022, at 14:50, Krzysztof Kozlowski wrote:
> On 21/10/2022 16:27, Arnd Bergmann wrote:
>> From: Arnd Bergmann <arnd@arndb.de>
>> 
>> The s3c24xx SoC support and its adc driver was removed, so this driver
>> has no remaining users.
>> 
>> Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>> ---
>>  drivers/input/touchscreen/Kconfig      |  12 -
>>  drivers/input/touchscreen/Makefile     |   1 -
>>  drivers/input/touchscreen/s3c2410_ts.c | 464 -------------------------
>>  3 files changed, 477 deletions(-)
>
> This also could be usable on S3C64xx, but it seems no one added any DT
> nodes, so:
>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks. To clarify, the key bit here is the 'depends on S3C_ADC',
and that driver in turn 'depends on !ARCH_MULTIPLATFORM' since
2014. So even for the boardfile variant of s3c64xx, it was
already impossible to use for a long time without anyone complaining
or trying to fix it.

     Arnd
