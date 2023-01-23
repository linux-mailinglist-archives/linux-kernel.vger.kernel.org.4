Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B48C678C27
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 00:40:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjAWXkK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 18:40:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWXkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 18:40:09 -0500
Received: from relay3-d.mail.gandi.net (relay3-d.mail.gandi.net [217.70.183.195])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E1371207B;
        Mon, 23 Jan 2023 15:40:07 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 1BD9D60002;
        Mon, 23 Jan 2023 23:40:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1674517206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=twXVOTfg3PW//nw5HJAtxwun0Ebf6bwpsMbeadkZizo=;
        b=mOK7F1IX6zieRQj5tAcNZH7ZuH53ZPVDtLoDdBIHq/QSkSv8F1H+81RSsbFtEKriAAGLTP
        8tpcw/1CSjTfOO0caoF7eiOApTYLbaVF/4aUkkYtgVzzkIAJfsue/w8tcBISKgLxxQB035
        rJX5jjTBY2Jb4JoRdyXrQH8J05ZPUXib7DeIOVZsAwhQ+PgOtzimOAvUinnokSs1BkZqbr
        hVRlmYxmVe6pA2GlG/SrOS2+05xbAqngmGaZJdFCu+a2MEmRPaQEsCf84I7MuwC0yBuPmr
        P4A72bPpI88PIkqSMz0PzWL+1T51tHYeriFBlWHozKmfunUqezQ1wUSKrBU1zw==
Date:   Tue, 24 Jan 2023 00:40:03 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-rtc@vger.kernel.org,
        upstream@lists.phytec.de, Wadim Egorov <w.egorov@phytec.de>
Cc:     riku.voipio@iki.fi, a.zummo@towertech.it,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        lee@kernel.org, pavel@ucw.cz
Subject: Re: (subset) [PATCH v2 2/2] dt-bindings: rtc: Move rv3028 from
 trivial-rtc.yaml into own schema file
Message-ID: <167451718651.1270236.1643750092725647667.b4-ty@bootlin.com>
References: <20230111163404.3526248-1-w.egorov@phytec.de>
 <20230111163404.3526248-2-w.egorov@phytec.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230111163404.3526248-2-w.egorov@phytec.de>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 11 Jan 2023 17:34:04 +0100, Wadim Egorov wrote:
> Move RV3028 RTC bindings from trivial-rtc.yaml into microcrystal,rv3032.yaml.
> 
> 

Applied, thanks!

[2/2] dt-bindings: rtc: Move rv3028 from trivial-rtc.yaml into own schema file
      commit: c690048ed59b5f7df91899507f210ba6591c0d8f

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
