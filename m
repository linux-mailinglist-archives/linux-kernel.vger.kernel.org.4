Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55B356C2C41
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 09:25:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230070AbjCUIZG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 04:25:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229723AbjCUIZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 04:25:01 -0400
X-Greylist: delayed 246 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 21 Mar 2023 01:25:00 PDT
Received: from wnew1-smtp.messagingengine.com (wnew1-smtp.messagingengine.com [64.147.123.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9162EAF3F;
        Tue, 21 Mar 2023 01:25:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 724D62B0786B;
        Tue, 21 Mar 2023 04:24:56 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Tue, 21 Mar 2023 04:24:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm1; t=
        1679387096; x=1679394296; bh=4iLq9Xa+73gwOb3UlDSdvfiv5ERn90/uFq1
        d82g+tiU=; b=rdHvg9X4s7IuEFLwOqkG2UcVTIQtMo8CBrROImB1m0gBuy+6tJz
        nvN25hQYXWBWd5TzOsNAIqUSBdYOZO1LNd4xgYDblKk1cO1IIxfJRNa0bvyvrazT
        xrQvrf7L3YhkORUS0fS9fSWLf4ZxEyyNkc5xzP30dy1zJYFIHDjhau2Elll//dY9
        nYo/KGN53Slm4iVLuTGVY/ucB82e0s6lj9GBrB0b2RBU4jKugBQlAzYVvGCyLsvK
        2ODAwwWJq1I2P/+tdewXjtdtX5Sv2Kgq2XB+/9KpDgnNksthZYFizt8nG6W7AYF2
        4O39Vbl93iCYb/8DvYwEw037Qaa+zZGkWCQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:content-transfer-encoding:content-type
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1679387096; x=
        1679394296; bh=4iLq9Xa+73gwOb3UlDSdvfiv5ERn90/uFq1d82g+tiU=; b=B
        hyxCBqLaapFDZlJ/HOkIlV7PkLct4IPKtWpVJysyq05qIwjT91pxeaQ/1D+SxwNg
        H996FUt8AgY59kr/cndqRtmddhjjtBqoXd+P+jhcdCxSOu/AcOSw6g8fNIYCNDsH
        W2TAUc2dJQ/hHGo+zVZSt76m4iGOdKhAgczNI1j5EjJJv+CUm8A5bhWhSyuMRP36
        Mq06D0tf6/F6GGpwLfPyyKaN6v53AhqU3QLGMoIcZ/EBbIbwFFnWqLAL8j8iSvxA
        072iFPGtt/rf2otztkR9jlPOdcwq4gr+6Lh6n5qBRFUEV7UhjwNarXciqTCZXfe7
        FQNDgYBCRA7QP/+/ZPeYQ==
X-ME-Sender: <xms:1WkZZGXrpB-bCzWA0vrcEQrvJKNMHcgkvOtw4MMBqNSm0yE40GuuIA>
    <xme:1WkZZCkUx4PzphnKgVxbx2x-w-4-Ur27OODA8sdKYb1jL1Rq1Zlt7RBDtskyQ--4g
    afdIPi0VZx5axXnCOw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdefledguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefofgggkfgjfhffhffvufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeffkedtffejkeeihedtffevtedvhfdvhfehfffgleekgffgveeftdefgeek
    vedvjeenucffohhmrghinhepkhgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivg
    eptdenucfrrghrrghmpehmrghilhhfrhhomheprghrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:1WkZZKbDDBO7G9zG6aM76fUgHKZuJRgiGx001mneKGt_bEavigDz5g>
    <xmx:1WkZZNXdISqhAYAQRAIDIM-Fw0V3uIrscbZkVvbBnHoPV5Coh5zkxQ>
    <xmx:1WkZZAmWWNDcJWKV2dZpqSHpIRhV5OGT-3qQH-5yKjBiwJ7lDCZHug>
    <xmx:2GkZZIhAHpgfZEhxZJ_CzumJNBOoMxu-GwEfC42g24b9XnBmRluH5M0OZTc>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C764EB60086; Tue, 21 Mar 2023 04:24:53 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-221-gec32977366-fm-20230306.001-gec329773
Mime-Version: 1.0
Message-Id: <b9342459-efec-4e17-aee6-332ee17f44d2@app.fastmail.com>
In-Reply-To: <8b7816b0-1daa-1c49-6f9d-40769d228a39@linaro.org>
References: <20230312131318.351173-1-krzysztof.kozlowski@linaro.org>
 <20230312131318.351173-20-krzysztof.kozlowski@linaro.org>
 <86431868-488b-4a72-944b-231b6d0382b0@app.fastmail.com>
 <8b7816b0-1daa-1c49-6f9d-40769d228a39@linaro.org>
Date:   Tue, 21 Mar 2023 09:24:33 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Joe Tessler" <jrt@google.com>,
        "Hans Verkuil" <hverkuil-cisco@xs4all.nl>,
        "Mauro Carvalho Chehab" <mchehab@kernel.org>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Kevin Hilman" <khilman@baylibre.com>,
        "Jerome Brunet" <jbrunet@baylibre.com>,
        "Martin Blumenstingl" <martin.blumenstingl@googlemail.com>,
        "Thierry Reding" <thierry.reding@gmail.com>,
        "Jon Hunter" <jonathanh@nvidia.com>,
        "Manivannan Sadhasivam" <mani@kernel.org>,
        "Michael Tretter" <m.tretter@pengutronix.de>,
        "Pengutronix Kernel Team" <kernel@pengutronix.de>,
        "Jacopo Mondi" <jacopo+renesas@jmondi.org>,
        "Kieran Bingham" <kieran.bingham+renesas@ideasonboard.com>,
        "Laurent Pinchart" <laurent.pinchart+renesas@ideasonboard.com>,
        =?UTF-8?Q?Niklas_S=C3=B6derlund?= 
        <niklas.soderlund+renesas@ragnatech.se>,
        "Rui Miguel Silva" <rmfrfs@gmail.com>,
        "Wenyou Yang" <wenyou.yang@microchip.com>,
        "Bin Liu" <bin.liu@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "AngeloGioacchino Del Regno" 
        <angelogioacchino.delregno@collabora.com>,
        "Minghsiu Tsai" <minghsiu.tsai@mediatek.com>,
        "Houlong Wei" <houlong.wei@mediatek.com>,
        "Andrew-CT Chen" <andrew-ct.chen@mediatek.com>,
        "Andrzej Pietrasiewicz" <andrzejtp2010@gmail.com>,
        "Jacek Anaszewski" <jacek.anaszewski@gmail.com>,
        "Sylwester Nawrocki" <s.nawrocki@samsung.com>,
        "Patrice Chotard" <patrice.chotard@foss.st.com>,
        "Yong Deng" <yong.deng@magewell.com>,
        "Paul Kocialkowski" <paul.kocialkowski@bootlin.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Jernej Skrabec" <jernej.skrabec@gmail.com>,
        "Samuel Holland" <samuel@sholland.org>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        "Ezequiel Garcia" <ezequiel@vanguardiasur.com.ar>,
        "Philipp Zabel" <p.zabel@pengutronix.de>,
        "Sean Young" <sean@mess.org>, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-tegra@vger.kernel.org,
        linux-mediatek@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-rockchip@lists.infradead.org,
        oushixiong <oushixiong@kylinos.cn>
Subject: Re: [PATCH 20/28] media: platform: jpeg: always reference OF data
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023, at 09:21, Krzysztof Kozlowski wrote:
> On 21/03/2023 09:11, Arnd Bergmann wrote:
>> On Sun, Mar 12, 2023, at 14:13, Krzysztof Kozlowski wrote:
>>> The driver can match only via the DT table so the table should be al=
ways
>>> used and the of_match_ptr does not have any sense (this also allows =
ACPI
>>> matching via PRP0001, even though it might not be relevant here).  T=
his
>>> also fixes !CONFIG_OF error:
>>>
>>>   drivers/media/platform/mediatek/jpeg/mtk_jpeg_core.c:1890:38: erro=
r:=20
>>> =E2=80=98mtk8195_jpegdec_drvdata=E2=80=99 defined but not used=20
>>> [-Werror=3Dunused-const-variable=3D]
>>>
>>> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>=20
>> I see now that we both submitted the same patch, but now Hans
>
> We as you and me? I cannot find your patch on lore:
> https://lore.kernel.org/all/?q=3Df%3Aarnd%40arndb.de

This is the one that I sent back in January:

https://lore.kernel.org/all/20230117172644.3044265-1-arnd@kernel.org

      Arnd
