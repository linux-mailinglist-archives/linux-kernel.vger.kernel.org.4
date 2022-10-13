Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50AE65FD8DD
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Oct 2022 14:11:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229673AbiJMMLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Oct 2022 08:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiJMMLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Oct 2022 08:11:09 -0400
Received: from new3-smtp.messagingengine.com (new3-smtp.messagingengine.com [66.111.4.229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DF2FF53DC
        for <linux-kernel@vger.kernel.org>; Thu, 13 Oct 2022 05:11:06 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailnew.nyi.internal (Postfix) with ESMTP id 260DC58020D;
        Thu, 13 Oct 2022 08:11:06 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 13 Oct 2022 08:11:06 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1665663066; x=
        1665670266; bh=qcZsBTf58+HESkQB33dGWzDH6NKnBJENLMiHvWdxzLk=; b=d
        xIgbA+IpkGqBRnPFDaFcWLWqbvfApoE9jpIIv/7uvQ7BKT11dyuasLvoVEhlCSwR
        OQKfpIflEqSca0zKSAxyo+o46RRlZciDBF4kH6qtviJkC/oDRz1NBW4WJOcNoiUI
        fLiWFZWMsGua+NGI5DvzPo/jencfmP7l3nfTw/34j1r5Bq3E00lJJ0cGhfwWTU2U
        uMQcVceZhjS7dZ9RvyANAQVre4c46vRgk+I7V/T2VXTZ4+wEPgYu/njJOWPmJ35Y
        ux/nVwtggmSFmvr/exV1D4d0lNLVFyjvOR9j/hPbdm67vYmADxU8d51vcipYCihg
        /xeazrVDBer1jvyBmTPHQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1665663066; x=
        1665670266; bh=qcZsBTf58+HESkQB33dGWzDH6NKnBJENLMiHvWdxzLk=; b=r
        p0DnD5CzLVnqFr9XjslUsXQocWaxkUEqI4lDK+KM8RqhG1FwTHenRKpQtYFzjp6v
        vSkxEt2bTJboNDIGytVRN2bMcdk6/mzBZvn/HoPyKzTWdiHgK76Fjc88dm/z5ImW
        V86/36+LnzjHbAGqvmz89/L2dQH1Y0CZr2L84ukvs+P8FdLNiUpcyRRGdd0HBj1k
        5Zis/UlbX8zT6YisDcibytq3spBpJ0oEzdBjRUOVEkrh09nmefhSxAAXM/JuLVP/
        R9SJCExB3ORrbx0Qlp11zFflQTkVRwIb6qTKV8Hk+Phbq3MuKzxqV9rQQ5nPIcOT
        44WPEASR8no7vMEN93ceA==
X-ME-Sender: <xms:WQBIY2ATDGFJMYMv5AJ_EI09D7ahHT21A7nsWuV88os7StWV3q464g>
    <xme:WQBIYwicApClxfNCWVC85v6UMGN8LTJWYxc_VgOVWBwCDUyaW4KQWEeVbDF4T4RCn
    bY0uK0T8EOztxFDqhY>
X-ME-Received: <xmr:WQBIY5n3C2jVTDNYQUcZ0EQL7s-yaV2TfO105HPJZdfYyTi1Hog50TBhESqebs40brtHnTl339ztlU1k_MtXEXQROghx693hwV98>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeektddghedvucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhggtgfgsehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepueeigefghfffffeifeehudeiuedvteegueefffevgfetvdffheehkeff
    vedufeeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:WQBIY0xOe0GZU8R7aCDvrBtqsBibY3nccCWp4eOhJjAwkHop-iaAvw>
    <xmx:WQBIY7RiLPwpe2Ktf4fXYGwtAvPRueKHFan6G-eDNZepG0la-_rnLg>
    <xmx:WQBIY_ZaatYNSXScEKL6RM1Oa26rpdJzVH02s6qXz-XmImSTfA8Ojg>
    <xmx:WgBIY8ROE0jqv6zptajvDWVdJ78SEydNnDHSFMkJTdFrf0ANHiP2EA>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 13 Oct 2022 08:11:05 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Maxime Ripard <mripard@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>, Emma Anholt <emma@anholt.net>
Cc:     dri-devel@lists.freedesktop.org,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        linux-kernel@vger.kernel.org
Subject: Re: (subset) [PATCH 1/2] drm/vc4: hdmi: Enforce the minimum rate at runtime_resume
Date:   Thu, 13 Oct 2022 14:11:00 +0200
Message-Id: <166566305526.1731673.3705584062975325232.b4-ty@cerno.tech>
X-Mailer: git-send-email 2.37.3
In-Reply-To: <20220929-rpi-pi3-unplugged-fixes-v1-1-cd22e962296c@cerno.tech>
References: <20220929-rpi-pi3-unplugged-fixes-v1-0-cd22e962296c@cerno.tech> <20220929-rpi-pi3-unplugged-fixes-v1-1-cd22e962296c@cerno.tech>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 29 Sep 2022 11:21:17 +0200, Maxime Ripard wrote:
> This is a revert of commit fd5894fa2413 ("drm/vc4: hdmi: Remove clock
> rate initialization"), with the code slightly moved around.
> 
> It turns out that we can't downright remove that code from the driver,
> since the Pi0-3 and Pi4 are in different cases, and it only works for
> the Pi4.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime
