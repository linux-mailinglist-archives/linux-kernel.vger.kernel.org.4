Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7418372B27A
	for <lists+linux-kernel@lfdr.de>; Sun, 11 Jun 2023 17:25:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230384AbjFKPZU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 11 Jun 2023 11:25:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjFKPZS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 11 Jun 2023 11:25:18 -0400
Received: from relay2-d.mail.gandi.net (relay2-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::222])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 745D9129;
        Sun, 11 Jun 2023 08:25:17 -0700 (PDT)
X-GND-Sasl: alexandre.belloni@bootlin.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1686497114;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=fiEW/G41BWiGsN06YA7FOjBuZy9frZVGjVph/Ohsgis=;
        b=ERf26ZnjhSj/0HgohekTGulJ4OdiZInwm21U1G3Y9Ff34NRP4E+OcIacvZ23TAhGQES2TI
        quWgywmOuvJh5TkwcLkPnAEY/8nD4D/QrEHvLS8MBdeArk0F88eg3m5eQQ5nZ4yBFGIqBy
        ixEQFuZgdKkHyHqdFpdVISAubexyBLUBvZqKKtNGZ0I7DdkOYPm7ikbvkfLShj2Pfjp1Ct
        H9F9qCLrLNKPY8h/YJMv15NY/SfUYxwO+L75aJ7C8pkMSlpcvQvCc59AFUT1gV1/jtfznr
        Ok8Qqa4kHRJrviR+WcUUBl3r+HstFay0SnyTJA8KYzeCEQBu4W3UDLBpbyBBGA==
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
X-GND-Sasl: alexandre.belloni@bootlin.com
Received: by mail.gandi.net (Postfix) with ESMTPSA id C9A6240004;
        Sun, 11 Jun 2023 15:25:10 +0000 (UTC)
Date:   Sun, 11 Jun 2023 17:25:10 +0200
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Rob Herring <robh@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Conor Culhane <conor.culhane@silvaco.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-i3c@lists.infradead.org,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: i3c: silvaco,i3c-master: fix missing schema
 restriction
Message-ID: <20230611152510003a8361@mail.local>
References: <20230609141107.66128-1-krzysztof.kozlowski@linaro.org>
 <168634884066.2555331.39755837725706368.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168634884066.2555331.39755837725706368.robh@kernel.org>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/2023 16:14:03-0600, Rob Herring wrote:
> 
> On Fri, 09 Jun 2023 16:11:07 +0200, Krzysztof Kozlowski wrote:
> > Each device schema must end with unevaluatedProperties: false, if it
> > references other common schema.  Otherwise it would allow any properties
> > to be listed.
> > 
> > Fixes: b8b0446f1f1a ("dt-bindings: i3c: Describe Silvaco master binding")
> > Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/i3c/silvaco,i3c-master.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> Applied, thanks!

As you took this one, I assume you are going to take the previous patch.

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
