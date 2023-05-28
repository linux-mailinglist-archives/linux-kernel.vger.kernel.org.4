Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08FBD713C2D
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 21:06:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjE1TGY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 15:06:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjE1TGX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 15:06:23 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A00B9A0;
        Sun, 28 May 2023 12:06:22 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 36E2D618CE;
        Sun, 28 May 2023 19:06:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 612FDC433EF;
        Sun, 28 May 2023 19:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1685300781;
        bh=OIuqp59lUf40kaYvD5eE2Yil+YmjWeHlLRKmLGFOo0E=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=fRe9TjHnppIgO9QmpzpjnIcadDMEMRiXdLsyWUsFe+g+1jafeQ9n0OOZYbUXyGiGV
         6L/FJqOUiRCpdyYk7HPUZXAIiky+LOQUF4T+gcA8vHs+vyj7K8lnabgN75OhXHH/k5
         tvECNpOdoSyKOFAQqYLMzGu+pNTxlX7D4ghfWlqgUSCE2W5gbFFYkGTQjK29yw0LZ3
         4JjnCUBJ3PcTSZHRdaW+XpYoxnHwFjImPgRA/Ji/UPVx/RRvb0/rSVDVwGsXgBniCj
         6uiwjS+azB15JTSiW6qQkx3jt4keDRpTCxvfJoPS7kSuWDCXR3NfMh44kHQNOHGYez
         hE7ZVWXu62h4A==
Date:   Sun, 28 May 2023 20:22:39 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Conor Dooley <conor@kernel.org>
Cc:     Anup Sharma <anupnewsmail@gmail.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Peter Meerwald <pmeerw@pmeerw.net>,
        u.kleine-koenig@pengutronix.de, andriy.shevchenko@linux.intel.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 0/2] Add dt-binding support for ti tmp006
Message-ID: <20230528202239.6aebd407@jic23-huawei>
In-Reply-To: <20230520-context-emblaze-2456dbeb2414@spud>
References: <cover.1684579603.git.anupnewsmail@gmail.com>
        <20230520162002.7aba7c04@jic23-huawei>
        <20230520-context-emblaze-2456dbeb2414@spud>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 20 May 2023 23:32:03 +0100
Conor Dooley <conor@kernel.org> wrote:

> On Sat, May 20, 2023 at 04:20:02PM +0100, Jonathan Cameron wrote:
> > On Sat, 20 May 2023 16:21:50 +0530
> > Anup Sharma <anupnewsmail@gmail.com> wrote:
> >   
> > > These patches introduce device tree binding support and
> > > add an of_device_id table entry to the driver.
> > > 
> > > Changes in v2:
> > > 	- Keep the exsisting MODULE_DEVICE_TABLE entry.
> > > 	- Removed the inner comma in of_device_id.
> > > 	- Order the included header to improve code organization.
> > > 	- Adding missing semicolon to fix syntax error detected
> > > 	  using dt_binding_check.
> > > 	  
> > LGTM - I'll leave them a little while though for others to comment before
> > picking them up.  
> 
> It may be a wee bit before you here from Krzysztof, but the binding
> check issues have been fixed, as have the things he pointed out in the
> original submission AFAICT.
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> 

Thanks!

Applied to the togreg branch of iio.git and pushed out as testing for
the autobuilders to have their fun.

Thanks,

Jonathan

> Thanks,
> Conor.

