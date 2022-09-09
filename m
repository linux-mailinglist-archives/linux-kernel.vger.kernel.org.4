Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27B65B33DD
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Sep 2022 11:31:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231400AbiIIJbE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 05:31:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiIIJaY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 05:30:24 -0400
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF7B613D787
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 02:28:30 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 3DB3832008FD;
        Fri,  9 Sep 2022 05:28:21 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 09 Sep 2022 05:28:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1662715700; x=
        1662802100; bh=PjPU9k9R2A+Pq3a2t6Rt8kAyGY1XV3vq1wKmujKhE8c=; b=y
        hOqJ0iujJCrTrNvzDMNAAtapzZabCRBIaB/u8uoch5AQCaZDTh0TDBfQPGioQh16
        jWSOycrPrRxITdvyl6emqt7JRDCY0k7ltG05wOH48X5UXQ3KMPN5qCFj0ODUepHn
        l+BFepm9vK3JmZZsee9BTCKjAmHRgIQQeTGiDdecW25meO/B+mv995iGrE4ubSIv
        LjG+VUqksyWwzsXDH2HQ1qPygEMicAC9N42V0+5DqKcLZIqDxDgjTRFIEmKp1cRp
        lvgNeEALSAaBKvEl64LO1ZzPcWxjnKwIA6BxEE+un/Bl9aytb9z6FLGxygVU3mIA
        wWq+COJTGO9MaBPmFu1iQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=1662715700; x=
        1662802100; bh=PjPU9k9R2A+Pq3a2t6Rt8kAyGY1XV3vq1wKmujKhE8c=; b=Y
        iaCO0JA9F5MlyjE2f6d704OV8Rj6Zh4RBmV+ocM0wa30Q3eHZMEXli33Wjus26Wg
        4w3CHfEY/7iurEWPO31uuMsDm0gU3JY26B+GKlQTKVhkIl6AkL5c5kyHASQ0NTck
        bn1vrXqsr1lRJyUOo9emUr+iYK/05WQebrMbQCcuWFnJMMjRCS4dMZ1H3RSBF1wK
        qkV1gC2rg4QNiQ3cMygPxQLblhRWACRch9G8i9QsroOCkUNPAfIdYYqUjAL1214I
        QuSaL9Xh++sdgYQ4MWllfXTdIMoLgSKOKrzFuZn5Cuau/JcC8ycgKxufa4YwzSCt
        2zYd4q8eMLA6WIIcMPcJA==
X-ME-Sender: <xms:MwcbYzlixEAoCpEnm1AWX6e9ZkDUIufVliI6CSs7_JkFuF2J-tVcPA>
    <xme:MwcbY20kX0b_cHnrmfYPddLgQweqOlJEkjNZaSu1-NNIeF57TE-O9J45zzIkg4px9
    SX2Ku2aq6OP7HCl_CE>
X-ME-Received: <xmr:MwcbY5rIGINYtpJCie-G3rAZ2ob8CZ_bvk1nJxaeNHJNag26UUK2P7Q9Ow>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfedthedgudejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggugfgjsehtqhertddttddunecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepleelfeeileelteetfedvieekfeefffevhfdtvefgheevudevheejvddv
    ieeltdeinecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:MwcbY7kxo9RX7gwuUCJi7WIaW0GlPToEyaha26PsZhgKbJYu_CYWJQ>
    <xmx:MwcbYx0m-KjmQHfJcn2AiwsfgmJOLteXXoRgFHLv0Qldkp2deZN9Tg>
    <xmx:MwcbY6vkiK1OfN3EjjgLgPywK4O9s4iXbuydObvgOxMM-Yk8xPeWQA>
    <xmx:NAcbY4vV9MbhEtznBH2AViPxyGN-S791832Xm10aA5ZvFPXA-bxrNw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 9 Sep 2022 05:28:18 -0400 (EDT)
Date:   Fri, 9 Sep 2022 11:28:16 +0200
From:   Maxime Ripard <maxime@cerno.tech>
To:     =?utf-8?B?TWHDrXJh?= Canal <mairacanal@riseup.net>
Cc:     Isabella Basso <isabbasso@riseup.net>, magalilemes00@gmail.com,
        tales.aparecida@gmail.com, mwen@igalia.com, andrealmeid@riseup.net,
        siqueirajordao@riseup.net, Trevor Woerner <twoerner@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        Javier Martinez Canillas <javierm@redhat.com>,
        David Gow <davidgow@google.com>, brendanhiggins@google.com,
        Arthur Grillo <arthur.grillo@usp.br>,
        michal.winiarski@intel.com,
        =?utf-8?B?Sm9zw6kgRXhww7NzaXRv?= <jose.exposito89@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        kunit-dev@googlegroups.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 2/2] drm/tests: Change "igt_" prefix to "drm_test_"
Message-ID: <20220909092816.oecjw6p5uz3rqxxh@houat>
References: <20220907200247.89679-1-mairacanal@riseup.net>
 <20220907200247.89679-2-mairacanal@riseup.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20220907200247.89679-2-mairacanal@riseup.net>
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        T_SCC_BODY_TEXT_LINE,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 05:02:47PM -0300, Ma=EDra Canal wrote:
> With the introduction of KUnit, IGT is no longer the only option to run
> the DRM unit tests, as the tests can be run through kunit-tool or on
> real hardware with CONFIG_KUNIT.
>=20
> Therefore, remove the "igt_" prefix from the tests and replace it with
> the "drm_test_" prefix, making the tests' names independent from the tool
> used.
>=20
> Signed-off-by: Ma=EDra Canal <mairacanal@riseup.net>
> Acked-by: David Gow <davidgow@google.com>

Acked-by: Maxime Ripard <maxime@cerno.tech>

Maxime
