Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 49BB26D5A1B
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:57:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233951AbjDDH5Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:57:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjDDH5N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:57:13 -0400
Received: from gofer.mess.org (gofer.mess.org [IPv6:2a02:8011:d000:212::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A45310EB;
        Tue,  4 Apr 2023 00:57:12 -0700 (PDT)
Received: by gofer.mess.org (Postfix, from userid 1000)
        id A69AD100092; Tue,  4 Apr 2023 08:57:10 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=mess.org; s=2020;
        t=1680595030; bh=tFJ8XvtQpKbMir3v/8NgdGKtwzIot+dw70ghZwiiuR0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Y+Lans47MkyD1Ltz2+Fj0te4w5FJOeg1W/iHvD7G9b/htihCX02iV084h190jHD0P
         3/5yI2Tv+VoM636QjQ2T2eH2GbyXTXF4JFJEUBscuoc20iBbykam4eji8/qny1kmdt
         /YLD54F3JrqEkDkLOCMm+25/vh19Jl4mjaCNAcOQ0PfYgzZWz7jLcscDil52jWMKqb
         GvCfmGM9Z04mSBoqbfznuiQhmxJAQ9winf3mePpGklQfsEzMVnvzrGH/E9cGFNchHV
         B342fcTKa3h/XN5L8KtKwYbiSvAv4lR924L+Y93U0avrHyzLqtb6bzQTC6w2Q0uIVq
         eXdEpGEQXykZQ==
Date:   Tue, 4 Apr 2023 08:57:10 +0100
From:   Sean Young <sean@mess.org>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Ravi Kumar V <kumarrav@codeaurora.org>,
        "open list:MEDIA INPUT INFRASTRUCTURE (V4L/DVB)" 
        <linux-media@vger.kernel.org>,
        "open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS" 
        <devicetree@vger.kernel.org>,
        Matthew Lear <matthew.lear@broadcom.com>
Subject: Re: [PATCH v2 0/2] Correct gpio-ir-recv wakeup capability
Message-ID: <ZCvYVoH96pINE+4I@gofer.mess.org>
References: <20230324203833.3540187-1-f.fainelli@gmail.com>
 <4cea1e91-f0d4-291f-813d-353f8b9d2a5e@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <4cea1e91-f0d4-291f-813d-353f8b9d2a5e@gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 03, 2023 at 03:06:44PM -0700, Florian Fainelli wrote:
> On 3/24/23 13:38, Florian Fainelli wrote:
> > This small patch series fixes the gpio-ir-recv binding and driver to
> > first indicate that it can be a wake-up source for the system, and
> > second actually make that happen.
> > 
> > Changes in v2:
> > - corrected the indentation of the description for "wakeup-source"
> > 
> > Florian Fainelli (2):
> >    dt-bindings: media: gpio-ir-receiver: Document wakeup-souce property
> >    media: rc: gpio-ir-recv: Fix support for wake-up
> 
> Ping? Someone maintaining this driver?

That's me :) Applied, thanks for the reminder.


Sean
