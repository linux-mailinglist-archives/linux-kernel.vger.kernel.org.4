Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C9FE6F664F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:51:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjEDHu6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:50:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229938AbjEDHuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:50:44 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5BD93592
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:50:43 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id 4CA205C049D;
        Thu,  4 May 2023 03:50:43 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 04 May 2023 03:50:43 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:content-type:date
        :date:from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm2; t=
        1683186643; x=1683273043; bh=3Mw5TdaacQ7QVHJymuilr27t1TddXpNXJ/S
        G0oJrGxc=; b=RsZGqzESydprVhI3/QA7NMKghIdjkQR7Pu3tfiTHrkFa92BCJ5Z
        oZZ/h/5kYs2d0znpZiB5WLCofgyDRannKdfjEPYDZ0eYOxoi1Tlq8BzTm5LLCn2Z
        qmGuefWpUltGHILVHt/KAHPAzzYK+Tg457/cx2Mii/T5d7CE2Fcx+ediVlilpmKk
        +mIqh5f7z+FS2HWujs+OCtqixvQ9HsR1TivrAKRHRhHst4JPtM0MjI/iswBk8dlj
        Rh+WksR1a3l/VESedVtoP0XVAjE8b3jmOU+SmTl94SAkOoUuinik+b9x3qmKkfZd
        kcVQj7tW12p3rbIWq8Z1V5UWL/stfPCohmw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1683186643; x=1683273043; bh=3Mw5TdaacQ7QVHJymuilr27t1TddXpNXJ/S
        G0oJrGxc=; b=DVDzYNG/qKAW6DVAG+VhxPxj2zJTHSmYoC0Vl3d4e65+ZAIdHHs
        nszl20ANPcLT7JkR7k2WFbjem5ALt+HwsW9EQoMl8b9WyDKhjywCJA1GS2zgkGrN
        7VZBW5Bf6DPG1cMwKyU3Zb2HMEEUKtvkqJP3kbnc+UxINfGl47A2m+J6zF+gCl1P
        7OaGhQxU+1KBMtxF0Y41oKFGol0OGhsrdsgIkT5z9IzUuRW2knEqW/6N1zx/YTj6
        +E07a6sOjVX8O0nKixxxn76G0dEcYVDQUq2sLT+YKGJOcowIHPpqlmsZ4tBGHIK6
        skFTL3qEx7x8E/lbItxkQ+rgKYt+Y2PQy6Q==
X-ME-Sender: <xms:0mNTZLPlVY5RtTS8aGvhCTTBGI2cAYywZAqj2rTryNb77ZlsfcxMYw>
    <xme:0mNTZF-76wk0eL7K-EAVknrnmz6LVILBsS5Exd0xk8lQJX5Py7H_N0-OwmBOuvFRF
    6n2vLJ2y5XLXf6V9yA>
X-ME-Received: <xmr:0mNTZKR5qhhr6Lzg77U3oDFnP0foo-DB7qwHaXnyWf3UECTSsPfbNz41pJhdI0SDUDJh03a1czf_aGPnHJwk72IJuaJ-BJE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfedvledguddvvdcutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpefhvfevjghfuffkffggtgfgofesthejredtredtjeenucfhrhhomhepofgr
    gihimhgvucftihhprghrugcuoehmrgigihhmvgestggvrhhnohdrthgvtghhqeenucggtf
    frrghtthgvrhhnpeelieffgfdvteejjeeujeeiheeuvdetieegheethffhieefgeelkedu
    keetgeeuffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmrgigihhmvgestggvrhhnohdrthgvtghh
X-ME-Proxy: <xmx:0mNTZPuO8kk4NkSEaJedRsoToewFxRHgfwb5glqfilp4dpbvaGJ0QQ>
    <xmx:0mNTZDcnZB4Lnkb2z08VjHL-ZWzZ19kzWqC0KKnJ17-d1u4aObdPqw>
    <xmx:0mNTZL24ekU4YHYqwJFN6f04v3FZqECLve5BoOKWe7IpevMQ0nbAlA>
    <xmx:02NTZL101G1BPlrLkrwXovjajh7YU9CcbXkOHb6MFoAN5HeMq9MiRQ>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 4 May 2023 03:50:42 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
To:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <treding@nvidia.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Saravana Kannan <saravanak@google.com>
Cc:     kernel-team@android.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, Martin Kepplinger <martink@posteo.de>
In-Reply-To: <20230310063910.2474472-1-saravanak@google.com>
References: <20230310063910.2474472-1-saravanak@google.com>
Subject: Re: [PATCH v1] drm/mipi-dsi: Set the fwnode for mipi_dsi_device
Message-Id: <168318663946.258409.13765059153391035868.b4-ty@cerno.tech>
Date:   Thu, 04 May 2023 09:50:39 +0200
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 09 Mar 2023 22:39:09 -0800, Saravana Kannan wrote:
> After commit 3fb16866b51d ("driver core: fw_devlink: Make cycle
> detection more robust"), fw_devlink prints an error when consumer
> devices don't have their fwnode set. This used to be ignored silently.
> 
> Set the fwnode mipi_dsi_device so fw_devlink can find them and properly
> track their dependencies.
> 
> [...]

Applied to drm/drm-misc (drm-misc-fixes).

Thanks!
Maxime

