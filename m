Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5D1E6C45EA
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 10:14:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230335AbjCVJO2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 05:14:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229922AbjCVJO1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 05:14:27 -0400
Received: from relay6-d.mail.gandi.net (relay6-d.mail.gandi.net [217.70.183.198])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED6D62196D;
        Wed, 22 Mar 2023 02:14:24 -0700 (PDT)
Received: from booty (unknown [37.160.6.101])
        (Authenticated sender: luca.ceresoli@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 711B5C0003;
        Wed, 22 Mar 2023 09:14:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1679476463;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=deGf4hUAwHy3aFmh+GEX0MrCG/Z4A2oTIyUdBJkliMk=;
        b=FcUqVMG0jy2j8wsgIutB3P8OM24PcNQNWBz/Oz16g8RToD5DJEy5rdWd6kKMp2GZdUfq+h
        xUu+Wf9ibxwbvZaUvUSlT9NOQ1KANWdSurt9yPw+uB1IH2iQo/zvJr1Ko8BDW7Owe/vD3x
        Oei1F7LKlH6GrTB1h6GRyiNcllzYXPfjtaiYgEpL5i3Gmo9NbNNxY2uSdJ+DKNtK8BPsjq
        Y5T3ND3mtKcyIfygf8QnqSEU7Ngc+sGqOICeS5J+uSEJ6/6qrX8Dzn4tIXVWJ5MXIwg4BR
        Y3ZCQgLKRiSrn5CZ2oSjXWhVhlmG3RptxTrPyQ4BnSmZD14Y3s2C97Opga6VCA==
Date:   Wed, 22 Mar 2023 10:14:17 +0100
From:   Luca Ceresoli <luca.ceresoli@bootlin.com>
To:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Sowjanya Komatineni <skomatineni@nvidia.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Dmitry Osipenko <digetx@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     linux-media@vger.kernel.org, linux-tegra@vger.kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Paul Kocialkowski <paul.kocialkowski@bootlin.com>,
        Richard Leitner <richard.leitner@skidata.com>
Subject: Re: [RESEND PATCH v4 00/21] Add Tegra20 parallel video input
 capture
Message-ID: <20230322101417.4561a7ae@booty>
In-Reply-To: <20230309144320.2937553-1-luca.ceresoli@bootlin.com>
References: <20230309144320.2937553-1-luca.ceresoli@bootlin.com>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

On Thu,  9 Mar 2023 15:42:59 +0100
Luca Ceresoli <luca.ceresoli@bootlin.com> wrote:

> TL;DR: Resending this series with Rob's review tag added. Now all DT
> patches have at least a reviewed-by tag from Rob or Krzysztof, all the
> driver patches have one from Dmitry.

This is a gentle ping about this series. All patches have a
reviewed-by, there are no major changes since v2, and it's touching a
staging driver anyway.

I don't think there is more I can do at the moment besides pinging, but
should there be anything, I'd be glad to know! :-)

Best regards,
Luca
-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
