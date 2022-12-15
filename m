Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BB8E64D777
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Dec 2022 08:59:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229787AbiLOH7n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Dec 2022 02:59:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229724AbiLOH7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Dec 2022 02:59:39 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99978639B
        for <linux-kernel@vger.kernel.org>; Wed, 14 Dec 2022 23:59:35 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 75E3A5C0113;
        Thu, 15 Dec 2022 02:59:32 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute5.internal (MEProxy); Thu, 15 Dec 2022 02:59:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1671091172; x=
        1671177572; bh=XxJENoxJPrXK6VoYTo12KmgD5xuHGRhCp9WC7SZ3Alc=; b=F
        Jg8ivcguRZ/JH+HYpXq/tCX+KiubFOjIBhC4WTazoovo9UK9MAMwFlHO9MvUAzRR
        fF9D6eTN+i2NWyelGFQhZdjIk8W7Crxi/b2YQAqQ+qtPt/sxyXR+KNeIoc8ZxU25
        sGTditnTqW4XCFn71zDD6g40dAaUcclcN00XRVo1K/DLfYL/7bFM8EW9DRVHjOTr
        EALzOaHUPn1ChSlM2ZjfbDycOtmiYKNJap+qot+hjfX9eaJQm4zq8tJKyBHVCnTy
        BokGI/9CynhDZKMqZAhvGFQo3ssr7INg3DnICw3LigaZPcb6LvGYHk6LUHmFlkDk
        h8+hBdbFUBBtnsQvVUrmg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1671091172; x=
        1671177572; bh=XxJENoxJPrXK6VoYTo12KmgD5xuHGRhCp9WC7SZ3Alc=; b=w
        R+ib27vINEcyCsvvOSa2brfa6mVwUf8CYjYesI+D6l3GWo1X2rIFAGX6g9xCKpy2
        kDoM6E8EHCuRySeXyO4WDF6vYJsTmetLVJtf0voU/uvDHPdZxRKG9rKeMe6DntPk
        c6bWt4LQfIP2Brnbuylw1gV7Cu/p8aepk5ldA86+pcgtg1JhdkDBV8HzytVgustT
        UX6/EsImpXoJXlzaKgBEDCzqmGEOQkl/PghlkQqJX267j9ZxvVhYv6Oj5yp26xWJ
        bxBV2AL+yLVwm2l2qA7m2GhAzSWDi7hLVS9n2dpp2mwTJ/zmUQjm85hf4Uvg7rfd
        SPUh9mcPVkxQJp92jg3LQ==
X-ME-Sender: <xms:5NOaY09jpx9EBtAJ0xIyMIn10X7CcQ6QL7URfwmgvlBbPS6JvrNzFw>
    <xme:5NOaY8teSDTKYOpZveRjqBR5rms8jpGzZzwTPlr-dob7JwuQ8-U2jtCY7GwGYvQJM
    adw50TmCE6XLj9hNoM>
X-ME-Received: <xmr:5NOaY6AWf6wrSCowE4UcTJGHp1IFBNKvfk0Zlh9VHFCJMof30hEYOFAvyOxMglV-bsOtvQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeggdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:5NOaY0fO04C0BiSNMiaw4Nu7D5xZOwarzh_fT5oaFay1dypgI2Fx5A>
    <xmx:5NOaY5NiOh0DT5T9htsDLLxk-vDtcxc6rqtzYIUMQm3bMReEgIej2A>
    <xmx:5NOaY-mm1sCsktaJgB9CA84vW4LZG0VXYmBJshv1U0zFb-9NZPol8Q>
    <xmx:5NOaYwkcQgMwEdyiVn7gCtgPsC7dTKwqCwteZNPwLzF6tszWmBM5dA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 15 Dec 2022 02:59:31 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maxime Ripard <maxime@cerno.tech>, Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>
Subject: Re: [PATCH 0/6] drm/vc4: dsi: Conversion to bridge
Date:   Thu, 15 Dec 2022 08:59:29 +0100
Message-Id: <167109115427.120387.17469145550626590243.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221207-rpi-dsi-bridge-v1-0-8f68ee0b0adb@cerno.tech>
References: <20221207-rpi-dsi-bridge-v1-0-8f68ee0b0adb@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Dec 2022 11:22:43 +0100, Maxime Ripard wrote:
> This series converts the vc4 DSI driver to a bridge. It's been in use for a
> while on the downstream tree.
> 
> Let me know what you think,
> Maxime
> 
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
