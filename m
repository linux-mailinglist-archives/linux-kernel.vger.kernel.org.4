Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D52660B11
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 01:48:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236731AbjAGAsG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 19:48:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236749AbjAGAr4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 19:47:56 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5895677D3A;
        Fri,  6 Jan 2023 16:47:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 1F40FB81F44;
        Sat,  7 Jan 2023 00:47:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0E251C433D2;
        Sat,  7 Jan 2023 00:47:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linux-foundation.org;
        s=korg; t=1673052472;
        bh=nNZcUm2y6TRRNHYmy0+qpiZspVpC072+41FVY/tKC7Y=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cYJQWGa79RwekO/UXP3plTpopDgQkWdLf6BXafu/pwqkk5wJUE5Ko9BxRcaL9EGsd
         RgCymAUjIHT7QHTNtJi76uZnX5KfDvIpquWglGa1n4ieQS7jsOvCYRLwoZp0/RNOLO
         swWhSpCpNMdYsYpmttFF0E39evxAgC35q3cy5O9s=
Date:   Fri, 6 Jan 2023 16:47:51 -0800
From:   Andrew Morton <akpm@linux-foundation.org>
To:     Nicolas Ferre <nicolas.ferre@microchip.com>
Cc:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Tudor Ambarus <tudor.ambarus@linaro.org>, <arnd@arndb.de>,
        <richard@nod.at>, <krzysztof.kozlowski+dt@linaro.org>,
        <herbert@gondor.apana.org.au>, <robh+dt@kernel.org>,
        <claudiu.beznea@microchip.com>, <broonie@kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-crypto@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-spi@vger.kernel.org>, <linux-mtd@lists.infradead.org>,
        <pratyush@kernel.org>, <michael@walle.cc>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2] MAINTAINERS: Update email of Tudor Ambarus
Message-Id: <20230106164751.7ddaf5c54e0a764344806848@linux-foundation.org>
In-Reply-To: <f653b23f-cf25-61ec-60d4-91dd7823edd2@microchip.com>
References: <20221226144043.367706-1-tudor.ambarus@linaro.org>
        <feb09bac-0ea4-9154-362b-6d81cba352a8@linaro.org>
        <678ad800-7a3b-e2bf-6428-f06d696d8edb@linaro.org>
        <20230106165506.0a34fa78@xps-13>
        <f653b23f-cf25-61ec-60d4-91dd7823edd2@microchip.com>
X-Mailer: Sylpheed 3.7.0 (GTK+ 2.24.33; x86_64-redhat-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 6 Jan 2023 16:59:52 +0100 Nicolas Ferre <nicolas.ferre@microchip.com> wrote:

> > Are MAINTAINERS changes accepted through fixes PR? I see a number of
> > experienced people in Cc:, I would like to hear from you folks, because
> > I never had to do that before. If yes, then I'll do it right away,
> > otherwise I'll apply to mtd/next. I'm all ears :)
> 
> I remember a conversation that stated that MAINTAINERS changes must land 
> in Linus' tree the quickest, because it'll just avoid confusion and 
> bouncing emails.

Yes, I always merge MAINTAINERS fixes asap.

Probably these fixes should be backported into -stable kernels also -
we don't want incorrect email addresses in *any* kernel.  But I don't
do that.
