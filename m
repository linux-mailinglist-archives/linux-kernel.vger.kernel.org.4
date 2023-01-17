Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EEB6A66E46D
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 18:07:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233571AbjAQRHF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 12:07:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230254AbjAQRG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 12:06:58 -0500
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C37932B081
        for <linux-kernel@vger.kernel.org>; Tue, 17 Jan 2023 09:06:57 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 40AA85C00E9;
        Tue, 17 Jan 2023 12:06:57 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Tue, 17 Jan 2023 12:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1673975217; x=
        1674061617; bh=5twsoyv0qz1wdF1I0/t62yW7R14KJeFgf9Xg4PfxoZ4=; b=S
        olC2TVycv/tQMriQnoieTz3TW2i13RVapLg3CzBd4bb0THbERf1B4vmIlJlfTs7r
        k2ymDH+xl6QSdhThe/ramB49bj4z1sYNk/EdgMq3J/eVvTUnP/TvBUPUZZE+F9Ys
        zl5tLhKSdiY17eeHcfNSz2qYpu6HSbuEiRnXsSpj406rm+X4WU2bNjGgXj/kn8tT
        TDN60I/yojLa2QxsBcDqyNQlsRKnN5VCeH8xU5qeHUEdou9vmm4YHS+/kcjw7SRC
        cPtPGPD4jstxRzhr+5mntJ+Xdx2BbLae5aS3lAfPwwKIqV01r6RiUxWMiLZ+Qp2h
        upgHGRNj/EUb/ruaCLitA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1673975217; x=
        1674061617; bh=5twsoyv0qz1wdF1I0/t62yW7R14KJeFgf9Xg4PfxoZ4=; b=Q
        AB8IpdD8cRO95rpIUVqJov9OoWh5HbL54VGhVIqW1Oe5SsqkZr/NhXxjlVG1gr5V
        DC4saxNtVv29b4lOKcnGwGdVHW0CNovajih+InQ4CJirglk1e7NOK9URwVmc4e6U
        CHerD0hWd09x/vfRkah3UI5TZvErXHwYLl6CKsj7gkGHeqEwDIHLcQJhx9PUyArZ
        vhVackt+4wAdwKaKmx2PwA+8y9+pRZeq2yvWXmCgKQjdK6bKC+c5M9Jt7h7ZLQyc
        AI0Mbxqcp6LRgQtuhFhSGxpY+aJtGoqMHAyDWMD6P+4MimiIt7utwkCbFePEG22L
        a7BmkbGfx0Dq1GUmQAiBg==
X-ME-Sender: <xms:sdXGY7GZBRRui_qZQDUXkgnsrbxgXXqUNkWbM_wwHRIjQXY_Kosfmg>
    <xme:sdXGY4WSmQOg915M-hNRBar9MhlfIInR_ZRTXNLAGd5eAspWrBSY9o6YM7fEhIylS
    hxVPaziXVuKCZIijoI>
X-ME-Received: <xmr:sdXGY9I4A-IaGZ-uPOz91LayrCDlpJ1S5vIWaBM_LIA4dFMStgIZx1O9zZBw90kG29zrcCEobsmBoUIJ26dbozqicoYwLHvy9Hj43Rg0cjIZug>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedruddtiedgleehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvegjfhfukfffgggtgffosehtjeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepleeifffgvdetjeejueejieehuedvteeigeehtefhhfeifeegleekudek
    teegueffnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:sdXGY5FJ5-JIgrbUdRt88grx7OBW9i5c2QCmcPkfS0pjQa_bn8Lozg>
    <xmx:sdXGYxVdgjQDcFQ4egmEzD1VH-LiLuxApPPAcF8qy3dzX7PjU8U9kQ>
    <xmx:sdXGY0McZQHVrlwbOWQra6pc4uBGJvfUzRJ5zi_Xsw5yFEJpPqMdvQ>
    <xmx:sdXGY6vprSBxBG7L8FcO0dLyxXgd_w8LlOftv0lqbmPDY8m0FFPvUg>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 17 Jan 2023 12:06:56 -0500 (EST)
From:   Maxime Ripard <maxime@cerno.tech>
To:     linux-kernel@vger.kernel.org, Randy Dunlap <rdunlap@infradead.org>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org
In-Reply-To: <20230117070224.30751-1-rdunlap@infradead.org>
References: <20230117070224.30751-1-rdunlap@infradead.org>
Subject: Re: (subset) [PATCH] drm/connector: fix a kernel-doc bad line warning
Message-Id: <167397519378.2619750.18386619390759216407.b4-ty@cerno.tech>
Date:   Tue, 17 Jan 2023 18:06:33 +0100
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

On Mon, 16 Jan 2023 23:02:24 -0800, Randy Dunlap wrote:
> Building the kernel documentation causes this warning 7 times.
> Fix it by adding a " *" line instead of a blank line.
> 
> drivers/gpu/drm/drm_connector.c:1849: warning: bad line:
> 
> 

Applied to drm/drm-misc (drm-misc-next).

Thanks!
Maxime
