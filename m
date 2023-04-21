Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7660F6EA57F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 10:03:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbjDUIDR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 04:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230153AbjDUIDO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 04:03:14 -0400
Received: from relay5-d.mail.gandi.net (relay5-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::225])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B270E7A89;
        Fri, 21 Apr 2023 01:02:55 -0700 (PDT)
Received: (Authenticated sender: herve.codina@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 8A5BC1C0003;
        Fri, 21 Apr 2023 08:02:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1682064173;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1pFJRyZLKhI+ddHgFFM7+c7rf18DVGxElQZA6evq+ls=;
        b=Ei5/mjYjRKklT3mLuCyguK3kJtMqrSdJRjUPCG2YrvBjzRalZvU2mG8Ew4sSEILvefmvUj
        KWnIddgfjhfS9Ad40pxTF4tb580bNpi/9uLhF3ze1zUlsRma7EM/90Dc8ELVpYh0LQjia1
        /T6dIELiar2HvRp0YFHo0Cl+XhVe9DTxCtOXFF0UJGh5Ugg3NDweRLdJrLhFLyJyLnvaJ2
        +Y/0k7HfPB9Bjlq0wRbkW2gR+Umay25FovfovW7ceguAxUlL7xzvTTT3ofqsMUACm7/az8
        2JSenjyf4QbmCgzDom3UJnTuI7fAzBHL0dwKAIu0KTOXGRQEOuuWAbb+BFLfbA==
Date:   Fri, 21 Apr 2023 10:02:51 +0200
From:   Herve Codina <herve.codina@bootlin.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Subject: Re: [PATCH v2 1/3] dt-bindings: iio: potentiometer: Add the Renesas
 X9250 potentiometers
Message-ID: <20230421100251.1ae232ee@bootlin.com>
In-Reply-To: <0d9740e7-bb03-dc16-5a1e-a551343b213f@linaro.org>
References: <20230420161052.270366-1-herve.codina@bootlin.com>
        <20230420161052.270366-2-herve.codina@bootlin.com>
        <0d9740e7-bb03-dc16-5a1e-a551343b213f@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Apr 2023 09:54:25 +0200
Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org> wrote:

> On 20/04/2023 18:10, Herve Codina wrote:
> > The Renesas X9250 is a quad digitally controlled potentiometers.
> > 
> > Signed-off-by: Herve Codina <herve.codina@bootlin.com>
> > ---
> >  .../iio/potentiometer/renesas,x9250.yaml      | 56 +++++++++++++++++++
> >  1 file changed, 56 insertions(+)  
> 
> My comments for v1 apply, I guess.
> 
> Best regards,
> Krzysztof
> 

Yes and I will take care on v3.

Best regards,
Hervé
