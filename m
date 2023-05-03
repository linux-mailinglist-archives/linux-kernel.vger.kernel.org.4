Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F83C6F5659
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 12:39:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230036AbjECKj0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 06:39:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229526AbjECKjY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 06:39:24 -0400
Received: from wnew2-smtp.messagingengine.com (wnew2-smtp.messagingengine.com [64.147.123.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65EE635A6;
        Wed,  3 May 2023 03:39:22 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailnew.west.internal (Postfix) with ESMTP id 0B6772B069AF;
        Wed,  3 May 2023 06:39:16 -0400 (EDT)
Received: from imap51 ([10.202.2.101])
  by compute6.internal (MEProxy); Wed, 03 May 2023 06:39:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1683110356; x=1683117556; bh=KFS31okKAQr6a5v2aX2V60/5Oir48XmaFQI
        kt18Yq3s=; b=cCNN8RO8bpidd+UJ0C9CSxmE2ngQi1eKpYDtrZ9AfJAY6TIaz13
        EmGcasdJ7/bdeHe+4ZxWAfgDRZDcpl205W4uAsyflcMpm7RzKXD8rCGxrAmhXpm+
        PCeZ1wagXERCNPHrZBrne1hUi7JO+8vnwjo7kiOl5T9Xq5BEWuxCCsr+8dcbmVLj
        q+XJrDl1Pu5hmzTa09GWU8P6qcra38bOTHxoMmdQ/lKD3IANqed6cQjJAG1J8RYr
        egEn8IJVZXe1OgZjTU2Nk3G5qVKeYylawACz+HYvM8hn4EmX0uUuRV1u3Tq/0zFx
        ie02zZD4EWP/DkbAuskHq1k33K2j/7XQCMQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683110356; x=1683117556; bh=KFS31okKAQr6a5v2aX2V60/5Oir48XmaFQI
        kt18Yq3s=; b=D5Zk9chIXEUE5emL/CiVs88rJWLLH60Bm0GXkiiaFvA8qgE19WR
        GzE8bCNj6o+6QctI7/9IPXBW37tE3DC4iP+QipUVHJj9l7d1P+Wy7ee74WKE22k6
        hNikSyF3CVUiHKorJLPFqTJ9qThhfiBr8nGcxcfbRMRHfuZoxq92DIwckGxvV+Og
        WUmuFOSlIQUKMhPiiyR2dZvW+Aaz9529A7PeI9YNC3vgUs/lSx23D6iGwCd/L8Sy
        hbDrgfc79i85YURrk415I3trHkE7rYEK0B+dqSXMTG67z/MdANnofW0F9Ju7c9gw
        wqeI4aNRnMMtaRII6LULrT6GTsS/HftIeLw==
X-ME-Sender: <xms:1DlSZB7HiFiKBkbDk9Fv7gPm0PBlQwsViA2U0jrJ-zAvaGGXygjRfw>
    <xme:1DlSZO7Xv3BGjOkExLnmK9KmCr--oWstES3EN49SY5iNy2GzZvlcZGCBKUJPghkrI
    QHcpC3F6G8-6XDxIKM>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvkedgvdelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepofgfggfkjghffffhvfevufgtgfesthhqredtreerjeenucfhrhhomhepfdet
    rhhnugcuuegvrhhgmhgrnhhnfdcuoegrrhhnugesrghrnhgusgdruggvqeenucggtffrrg
    htthgvrhhnpeegfeejhedvledvffeijeeijeeivddvhfeliedvleevheejleetgedukedt
    gfejveenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    grrhhnugesrghrnhgusgdruggv
X-ME-Proxy: <xmx:1DlSZIccd8i4Vx2LA8c2HM7NFtzw7mZtVBcV3SKmH2AQM6JbCF_CHQ>
    <xmx:1DlSZKLbrwHphpHQEODq666D9lh730jAC6AHGXPodgu0ZEkePvTEhA>
    <xmx:1DlSZFLUz-hUAS40dmSCJktAgcIF6Zhaiq8T6Xf-Uy8e1qyU5yr_Tg>
    <xmx:1DlSZAIqlEfAPQg-BumeZvu2_KmGcwHX44l_oJiCgrykutWtz2oOTfYnqQo>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id E9F69B60086; Wed,  3 May 2023 06:39:15 -0400 (EDT)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.9.0-alpha0-386-g2404815117-fm-20230425.001-g24048151
Mime-Version: 1.0
Message-Id: <5e318b02-8f33-4e2d-a956-5660e1c60619@app.fastmail.com>
In-Reply-To: <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
References: <20220328000915.15041-1-ansuelsmth@gmail.com>
 <85eb14ec-f465-7447-ad77-a3dabc666f47@kernel.org>
 <YkKRYnN84D9VZhGj@Ansuel-xps.localdomain>
 <CAL_Jsq+RQQ-ADMxLPUFwk6S6kGmb6oNDy4k52fnU0EtbUvqmSA@mail.gmail.com>
 <CAMuHMdWNTE48MFy6fqxAsfMWz9b6E7dVNXtXtESP95sxk2PGwA@mail.gmail.com>
 <CAL_JsqJthKTm8bhRF2B=ae1tvtPeYYXx_Tm76qQtSwLtH5C6VA@mail.gmail.com>
 <720a2829-b6b5-411c-ac69-9a53e881f48d@app.fastmail.com>
 <CAL_JsqKCtmkwzKa01gyG65fH8ye6R3KhR41PJbJhOJ4X9j=znA@mail.gmail.com>
 <bce93654-fc36-3d12-282d-76fafb8f51ce@linaro.org>
 <CAL_JsqJXd_EpOQwwNEAn25mzFfkhEvqzur6ui5Ca+dbt2kA8-Q@mail.gmail.com>
Date:   Wed, 03 May 2023 12:38:55 +0200
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     "Rob Herring" <robh+dt@kernel.org>,
        "Dmitry Baryshkov" <dmitry.baryshkov@linaro.org>
Cc:     "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Olof Johansson" <olof@lixom.net>,
        "Christian Marangi" <ansuelsmth@gmail.com>,
        "Krzysztof Kozlowski" <krzk@kernel.org>,
        "Krzysztof Kozlowski" <krzk+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-actions@lists.infradead.org,
        linux-sunxi@lists.linux.dev,
        Linux-OMAP <linux-omap@vger.kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-aspeed@lists.ozlabs.org,
        linux-rpi-kernel@lists.infradead.org,
        chrome-platform@lists.linux.dev,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        kernel@dh-electronics.com, linux-mediatek@lists.infradead.org,
        openbmc@lists.ozlabs.org, linux-tegra@vger.kernel.org,
        "linux-oxnas@groups.io" <linux-oxnas@groups.io>,
        linux-arm-msm@vger.kernel.org, linux-unisoc@lists.infradead.org,
        linux-rockchip@lists.infradead.org,
        linux-realtek-soc@lists.infradead.org
Subject: Re: [RFC PATCH 0/1] Categorize ARM dts directory
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 3, 2023, at 03:17, Rob Herring wrote:
> On Tue, May 2, 2023 at 5:52=E2=80=AFPM Dmitry Baryshkov <dmitry.barysh=
kov@linaro.org> wrote:
>> On 02/05/2023 22:40, Rob Herring wrote:
>> >      'berlin' : 'berlin',
>> >      'pxa2' : 'pxa',
>> >      'pxa3' : 'pxa',
>> >      'pxa' : 'marvell',
>>
>> I'd question if it makes sense to split the pxa line. Yes, it was sold
>> by Intel to Marvell, but IIRC the devices still had some inheritance.
>> So, if we have the 'pxa' subdir, I'd move Marvell PXAs to that dir to=
o.
>
> I think I probably split it because it was different maintainers.
> Though it doesn't look like pxa168 or pxa910 have any maintainer. They
> are a mixture of pxa and mmp I think.

I think the original split here is probably the best we can do,
but there is no good way to do it because of the confusing naming
and the problem that there is no clear line between pxa and mmp.
As far as I can tell, the release timeline was:

Intel pxa2xx (mach-pxa, xscale, still exists)
Intel pxa3xx (mach-pxa, xscale, still exists)
Intel pxa90x (never merged)
Marvell pxa93x (mach-pxa, xscale, removed in Linux-6.3, no DT)
Marvell pxa92x (never merged)
Marvell pxa91x (mach-mmp, pj1, still exists)
Marvell pxa168 (mach-mmp, pj1, still exists)
Marvell pxa95x (mach-pxa, pj4, long gone)
Marvell pxa688 (mach-mmp, pj4, known as mmp2)

So with pxa93x out of the picture, we can simplify it as using
'pxa' as the name for all the above chips with an Intel XScale
core, and 'marvell' for all the other ones that have a Marvell
core and exist in mach-mmp.

     Arnd
