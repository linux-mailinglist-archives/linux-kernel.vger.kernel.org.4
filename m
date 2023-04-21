Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CB7B6EA50F
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 09:40:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229791AbjDUHkM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 03:40:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjDUHkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 03:40:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D926593F1;
        Fri, 21 Apr 2023 00:39:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4D213617BC;
        Fri, 21 Apr 2023 07:39:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 62109C433EF;
        Fri, 21 Apr 2023 07:39:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682062785;
        bh=c/hIhFsoEj+hwvVam4K5Wx31rIjWm6XVle2GXFbTwMQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Wxl9b+Ka/bEUloC9ljRGyoSKc7WiGQVMv4dDI+TotPdNJ4Gsi/jG2V41Woyz4qUQm
         UYU05PjfmkKWfYj6rEIsPT1ZqcKDKckol6rrRaZoB+38h+ESAWgI2JX7aXBFh0ok3J
         9hfAdPOAnOSal5dVYJR4Fhj3pKjFOKStzl6YyLu44kMQjY0oYMdI75rmqqA+I6BNl+
         zqMNwankIR3RW7g0UNO/BET0z5rI7wsraHe/jfe0714k9V2j+0tfGni+0GuOPykiXR
         cWbG/vw+jC4Z5pn/QTHPRfqYAkP43LRov1TJnGM8gYNIiLAdPO3QLIkfd3iU2gIAh7
         vk7B0WOMW8oQQ==
Date:   Fri, 21 Apr 2023 08:39:38 +0100
From:   Lee Jones <lee@kernel.org>
To:     Mark Brown <broonie@kernel.org>
Cc:     Okan Sahin <okan.sahin@analog.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Caleb Connolly <caleb.connolly@linaro.org>,
        Marcus Folkesson <marcus.folkesson@gmail.com>,
        Ramona Bolboaca <ramona.bolboaca@analog.com>,
        ChiYuan Huang <cy_huang@richtek.com>,
        Ibrahim Tilki <Ibrahim.Tilki@analog.com>,
        William Breathitt Gray <william.gray@linaro.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Hugo Villeneuve <hvilleneuve@dimonoff.com>,
        ChiaEn Wu <chiaen_wu@richtek.com>,
        Haibo Chen <haibo.chen@nxp.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v7 5/5] mfd: max77541: Add ADI MAX77541/MAX77540 PMIC
 Support
Message-ID: <20230421073938.GO996918@google.com>
References: <20230412111256.40013-1-okan.sahin@analog.com>
 <20230412111256.40013-6-okan.sahin@analog.com>
 <20230420103438.GI9904@google.com>
 <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <09eb8e4c-3e73-41f0-bf42-8ddf3c4254ec@sirena.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Apr 2023, Mark Brown wrote:

> On Thu, Apr 20, 2023 at 11:34:38AM +0100, Lee Jones wrote:
> 
> > Once the regulator driver has been reviewed, I can take the set.
> 
> > Please apply this if you have to resubmit:
> 
> > For my own reference (apply this as-is to your sign-off block):
> 
> > Acked-for-MFD-by: Lee Jones <lee@kernel.org>
> 
> For situations like this where there's a depends on to the MFD it'd be
> great if you could just apply the MFD rather than waiting, the
> individual drivers can either get applied on top or just go via the
> subsystem and have everything sort itself out in the merge window.  It'd
> help things move along faster and be less confusing.
> 
> These serieses tend to get so many resends that I'm often just not
> looking at them, previously I'd have just applied the function driver
> when it's ready but with the complaints when the core ends up missing
> the merge window but function drivers are going in I stopped.  In the 
> past I've ended up missing things because either there's multiple
> serieses for similarly named devices out at once or (less often) some
> change results in a repeat review being needed so it's easier to just
> wait for things to settle down.

I'll try anything once!

Fair warning, I think this is going to massively complicate things. 

Either we're going to be left with a situation where child-driver
maintainers are scrabbling around looking for previous versions for the
MFD pull-request or contributors being forced to wait a full cycle for
their dependencies to arrive in the maintainer's base.

I'm not sure why simply providing your Ack when you're happy with the
driver and forgetting about the set until the pull-request arrives, like
we've been doing for nearly a decade now, isn't working for you anymore
but I'm mostly sure this method will be a regression.

-- 
Lee Jones [李琼斯]
