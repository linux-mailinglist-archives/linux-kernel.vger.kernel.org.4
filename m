Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B9E9628395
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 16:12:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237127AbiKNPMk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 10:12:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237111AbiKNPMh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 10:12:37 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FE43BCAB;
        Mon, 14 Nov 2022 07:12:35 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 5F49C5C0118;
        Mon, 14 Nov 2022 10:12:32 -0500 (EST)
Received: from imap51 ([10.202.2.101])
  by compute3.internal (MEProxy); Mon, 14 Nov 2022 10:12:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=arndb.de; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1668438752; x=
        1668525152; bh=0AuGUPMpHoja+9h2KXd2rB+g1YZCSmA/pv709yYusZs=; b=N
        imHqBCHQBx3TqPO+3otVYxSKGkXs9YDWBK8oMsEYTqKR9EoIJCrmDRSKajhuDm+t
        xLTCyKkRPHs3O+ij5BTy63PS+jupxgqF2umtceFZYgbFE6YTCKe0Qn8CTzph7Bjn
        QXzhCpOSapHICvU7ROHCfPBYRQVufWoovONSGqAJ37ZE9q/NXHU+U5e61EMfWBd8
        Ahjy4T/tkZ51WxkXz3RrkIlrMoWqVDXqUVyJ9Fz/k+FZlBEsiXfTHIsnUev/DwpC
        F57eKOjmtj+8dv1yrTj5BYuE0SdxDbXIfXb/wBR7//tX36prdU86J03rJrY0sDwy
        Tj2Yq7jEoMiXYGkyy164Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1668438752; x=
        1668525152; bh=0AuGUPMpHoja+9h2KXd2rB+g1YZCSmA/pv709yYusZs=; b=l
        fQLNXCnKbkA0PiBeyW6h5RRt+6oD3D8Q3pbG6mY5+RoQhd7+cLjQum8Q9DJJvZ51
        CNijv/9Fiil1hA305ooBtfYIF98WNix84zLxX+ONDuYL2twQBQKStuY3y/hbyzcW
        IiJHKEFyHI+WwhUr0vJJ3GyJd54VQeY4J1XvzOQ2CZe62IFDausnwo0Ad1LVF62d
        deZlOsPB61X3dffxQ8zzhp3Yaf0Bj36tu/ZmMAY7YCKVc8SIXdOPpm23wYKaYJj0
        S1RZDBlUXA6FXgGCXJHGaMX8X5z2jbHR4xfrW853TuejXe/+7Z3y+jHes3/M5UeE
        SI+ifKZ53v+kiAaX0GQ+Q==
X-ME-Sender: <xms:31pyY0VjEwxO4EUW4JC-rkT1WJFaktgNwfoQbSCB5gxKgs312nLL7Q>
    <xme:31pyY4leAzEB72KnV4EBvk3-i2PolJiBgggZsJXDnLCatVeqbipug-HYUp6hA00zx
    v5IrrOpB7sRFJdxG-s>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrgedvgdegiecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgfgsehtqhertderreejnecuhfhrohhmpedftehr
    nhguuceuvghrghhmrghnnhdfuceorghrnhgusegrrhhnuggsrdguvgeqnecuggftrfgrth
    htvghrnhepgeefjeehvdelvdffieejieejiedvvdfhleeivdelveehjeelteegudektdfg
    jeevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprg
    hrnhgusegrrhhnuggsrdguvg
X-ME-Proxy: <xmx:31pyY4auCtGnKuYCUHE2ey5OhveTmmnaHss32ff3o_ZAfOKV6FBdmQ>
    <xmx:31pyYzUfxPb39MIdkWZo6zEyNV4CjCgkn-RgocA9m2SnJdYX2H44hQ>
    <xmx:31pyY-mrqjwT4Db8756KAc9bjOnJuyrTpS42w7ymvcQiTlaIj1wFkA>
    <xmx:4FpyY8tZffa25m1byUcHEEBq8VzuHYfdg-DU2LEaArTgu7bxeNKDiQ>
Feedback-ID: i56a14606:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id C3AF2B60086; Mon, 14 Nov 2022 10:12:31 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <48a6bfab-6b88-4a5a-989d-ab87430290c7@app.fastmail.com>
In-Reply-To: <20221102171012.49150-1-kory.maincent@bootlin.com>
References: <20221102171012.49150-1-kory.maincent@bootlin.com>
Date:   Mon, 14 Nov 2022 16:12:11 +0100
From:   "Arnd Bergmann" <arnd@arndb.de>
To:     =?UTF-8?Q?K=C3=B6ry_Maincent?= <kory.maincent@bootlin.com>,
        "Viresh Kumar" <viresh.kumar@linaro.org>,
        "Shiraz Hashim" <shiraz.linux.kernel@gmail.com>,
        "Vipin Kumar" <vipin.kumar@st.com>,
        "Vijay Kumar Mishra" <vijay.kumar@st.com>,
        "Deepak Sikri" <deepak.sikri@st.com>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     "Thomas Petazzoni" <thomas.petazzoni@bootlin.com>,
        "Viresh Kumar" <vireshk@kernel.org>, soc@kernel.org,
        "Rob Herring" <robh+dt@kernel.org>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        "Russell King" <linux@armlinux.org.uk>,
        "Michael Turquette" <mturquette@baylibre.com>,
        "Stephen Boyd" <sboyd@kernel.org>,
        "Sudeep Holla" <sudeep.holla@arm.com>,
        "Gregory Clement" <gregory.clement@bootlin.com>,
        "Neil Armstrong" <neil.armstrong@linaro.org>,
        "Alexandre Ghiti" <alexandre.ghiti@canonical.com>,
        "Rajeev Kumar" <rajeev-dlh.kumar@st.com>,
        "Vipul Kumar Samar" <vipulkumar.samar@st.com>
Subject: Re: [PATCH v2 0/6] Support new features to the SPEAr600
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Nov 2, 2022, at 18:10, K=C3=B6ry Maincent wrote:
> From: Kory Maincent <kory.maincent@bootlin.com>
>
> This patches series adds two features of the SPEAr600 SOC:
>
> - Enable the display controller
>
> - Enable the SPI buses using the SSP controller
>
> Changes in v2:
> - Keep the I2C_CONFIG in the spear6xx_defconfig while enabling DRM.
> - Send cover letter which was not sent in v1 due to a mistake in my git
>   mail config.
>
> Viresh, will you take the patches and submit a pull request to the ARM=
 SoC
> maintainers?
>
> Kory Maincent (6):
>   arm: configs: spear6xx: Refresh defconfig
>   arm: dts: spear600: Fix clcd interrupt
>   arm: configs: spear6xx: Enable PL110 display controller
>   clk: spear: Fix CLCD clock definition on SPEAr600
>   arm: dts: spear600: Add ssp controller nodes
>   clk: spear: Fix SSP clock definition on SPEAr600

I've picked up patches 1 and 3 into the arm/defconfig branch,
and patches 2 and 5 into the soc/dt branch now.

I can also take patches 4 and 6, but I think it's better to have
them merged through the clk tree.

Maybe resend them to just the clk maintainers.

       Arnd
