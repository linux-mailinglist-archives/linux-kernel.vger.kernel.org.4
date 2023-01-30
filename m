Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE58168110E
	for <lists+linux-kernel@lfdr.de>; Mon, 30 Jan 2023 15:09:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237168AbjA3OJq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 Jan 2023 09:09:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237157AbjA3OJo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Jan 2023 09:09:44 -0500
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [217.70.183.197])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C2193B0F3;
        Mon, 30 Jan 2023 06:09:41 -0800 (PST)
Received: from booty (unknown [77.244.183.192])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 003BA1C0018;
        Mon, 30 Jan 2023 14:09:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1675087780;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=KD4t6AFD7zWRuav/9wfKI/33NlxRT+vOROmFd5NS47E=;
        b=ldhsz/T6pvQk9zJ+osMNoqfhUEntk27/80Ft3G6zKe2Roz+Zgcx4HSuwH9VWfGvcYwxyJu
        2Uf43LiYczJZQDCWMzegUMOZTV2SIdik3qb64ONTophqff7ObdB4h6ExKbvomDlI6ThUTA
        67TCnClen+rBEHirq2hf333lEG1G25vOO/tx0S0Us51dcnGGQD77xjbdnrtL5p9ucchTtQ
        qc8TMEF7BBdhaJ5chrEB/qgkpr3PgIIqcFQgYrHmqCKpbW1oBB6+kmGxZxByQLiSnuYWni
        T8NziJRpHdFAgJl620jTp42QKKDTrxvonvf1DLsGah582qWwPbbNtshBXE9XYA==
Date:   Mon, 30 Jan 2023 15:09:36 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Dmitry Osipenko <dmitry.osipenko@collabora.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [PATCH v3 01/21] dt-bindings: display: tegra: add Tegra20 VIP
Message-ID: <20230130150936.381f4008@booty>
In-Reply-To: <e426497b-0421-1bc1-2a72-871b0e2d48a4@collabora.com>
References: <20221229133205.981397-1-luca.ceresoli@bootlin.com>
        <20221229133205.981397-2-luca.ceresoli@bootlin.com>
        <e426497b-0421-1bc1-2a72-871b0e2d48a4@collabora.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, 25 Jan 2023 01:15:22 +0300
Dmitry Osipenko <dmitry.osipenko@collabora.com> wrote:

> On 12/29/22 16:31, Luca Ceresoli wrote:
> > VIP is the parallel video capture component within the video input
> > subsystem of Tegra20 (and other Tegra chips, apparently).
> > 
> > Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

...

> Reviewed-by: Dmitry Osipenko <digetx@gmail.com>
> 
> Please feel free to add my r-b to the rest of the patches. I looked
> though them and haven't noticed anything suspicious.

Thanks you very much, I have applied your r-b tag to all patches except
patch 2 where you spotted a mistake. v4 coming soon.

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
