Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC5866E46A
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:07:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232682AbjAQRHB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:07:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjAQRG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:06:57 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B2572FCC9
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:06:56 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 7D3D25C018A;
        Tue, 17 Jan 2023 12:06:55 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Tue, 17 Jan 2023 12:06:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1673975215; x=
        1674061615; bh=t4iV/vJ99RvkwYm8zUEJNfxo7SCMsAHrMTjivM8RwQk=; b=q
        EuYDV9zZcsAxpeoT8fxze95sAWXWnozd/pQTRf3k8cwJQb5maNOvbjRn/7KwGNUX
        JZLZZkMSJKnYJF6+6SwcwUgF+yKdfW+RBIaem8POh9zOakfl7nVvri5O/0hHPViC
        slFApgtP4jcZ4Ydwi1hjhiQ/tjCgM6NDEl0lRkbOAMuZPcDcni7Aka406m+/ldPz
        0gvB+NNiVNdIgD6BfdodS2hVCDMbHxv8bmjUBc1uC5cSZKggKBNjyoar7VUpZPDx
        HsBvoZBtMxWdJzMAtMGiakCuWsbvvOVSec+rjKNo0d28yUpCvU9wyGk1siS+7h0h
        boxbO4fZeFR+xZn56WTsA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673975215; x=
        1674061615; bh=t4iV/vJ99RvkwYm8zUEJNfxo7SCMsAHrMTjivM8RwQk=; b=R
        t4GHNrG+J6dfL0FhHLg6kc5B2uRvKNV/ldXlv7ABaAUQz6/HG7HLMEvsdp583qa9
        SS4VhUrc6yWCcsyO0v6W/54WqZFm4uPia/cNwKFDa2clTCfMIXPwFDTYJLbSZxXU
        oD6qk40JoLMZOndUkXCmQ5a4HX4+Oy4GR/4UluG2qXGzEAUcpicB/tiWQAIjyQBk
        vc6mcESG0OhnIRElMf36FUm3axyjv/xkSC3V20c5rIILJoY3Qsh807ekobyB9aIB
        N0x42gDSTnt1aWRCAHOblssrdQ+L+LbwBwHsTBCT1Ckhw/pEEg78VCSG2IouQV6Q
        eh7xHNhqwyLvelUnQdwFA==
X-ME-Sender: <xms:r9XGY1Z9wklfzZyNfuiVlSynE6BVlXXKUnxXb2u4pNHcpAevNHspIw>
    <xme:r9XGY8a9qIvfAc3XLxO_LRjFYHYSqIYd1BxvqJ4ecHukeGuEfGtdh8_9h1emMAvPQ
    ugY5fmdPWiOxiB0cgg>
X-ME-Received: <xmr:r9XGY38JQa9ZMv2qoZIKKYyzKd20LaJN4Cyq7-hpyK3jlq0GKIQ5ftoWcYSKqpZ_fU5-WYz4LlmFu9HCeLzvleWgJYZH_jep05yXMHmla0Qu6g>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtiedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepleeifffgvdetjeejueejieehuedvteeigeehtefhhfeifeegleekudek
    teegueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:r9XGYzqRMDUHRdTJ2f8hWuhZnXhS_QmljDNww_QMKZxZcpF6MLIdfg>
    <xmx:r9XGYwq247HZaXidlh_0pDvVEqJa-AdIBq24p5ezR9rjcq2NUdTc6A>
    <xmx:r9XGY5QaoFFXdI5NdQiIyNY_y73T1J0YleY2vIClMKS9NtD6LrbO4g>
    <xmx:r9XGY2iReYvux7MR9kRPkHoj-5sS9g75w3i5TL6YRIpJp7jADDbtmg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 12:06:54 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20230117070216.30318-1-rdunlap@infradead.org>
References: <20230117070216.30318-1-rdunlap@infradead.org>
Subject: Re: (subset) [PATCH] drm/atomic-helper: fix kernel-doc problems
Message-Id: <167397518758.2619750.8146316024242297831.b4-ty@cerno.tech>
Date:   Tue, 17 Jan 2023 18:06:27 +0100
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.11.2
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 16 Jan 2023 23:02:16 -0800, Randy Dunlap wrote:
> Fix a kernel-doc warning and other kernel-doc formatting for
> drm_atomic_helper_connect_tv_check().
> 
> drivers/gpu/drm/drm_atomic_state_helper.c:560: warning: Cannot understand  * @drm_atomic_helper_connector_tv_check: Validate an analog TV connector state
>  on line 560 - I thought it was a doc line
> 
> 
> [...]

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
