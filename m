Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0AE6643DD0
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 08:49:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiLFHtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 02:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231600AbiLFHtK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 02:49:10 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BCE513F8B;
        Mon,  5 Dec 2022 23:49:10 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B30C76158F;
        Tue,  6 Dec 2022 07:49:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 12C3EC433C1;
        Tue,  6 Dec 2022 07:49:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670312949;
        bh=AjymSXQTjEUupLPnuok4nTVvTlNVhtz7pMWL0eg3FrY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=TiO+BPVmkJg/CYiYMeAZ18DWtNGxWKJfE9gC0ILlxn9guVMzwvxV6tcWBFPlNvcix
         twBKv1l6LtneN/MkGTk6RdY5dtbtPy/f3vIxXwQx+QFcKALV2H9rqOQ1cWjv6mm5CH
         YWmXj3rrGUa8oAlZAjo0o4GM0bMTZP9z8zncM4VsjVzqYC6lKCNTT4OXk2D1uu48U6
         sYIFcK5HdWXHGYuUE+oMTMDvg44SgjxeigD8opXhUG4WtaaXntnNckrWY6+GV9ePG3
         nW7Ry1n8YVTH5bU4zqJwfqhYJK6AzrbxX5rJ7Ba+vNiHN/+znmbvGHrFVN+kdwJKW4
         A4wEgtBGFhVrA==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1p2ShY-00070z-Cm; Tue, 06 Dec 2022 08:49:16 +0100
Date:   Tue, 6 Dec 2022 08:49:16 +0100
From:   Johan Hovold <johan@kernel.org>
To:     Rob Herring <robh@kernel.org>
Cc:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Avri Altman <avri.altman@wdc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Bart Van Assche <bvanassche@acm.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-scsi@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: ufs: qcom: allow 'dma-coherent' property
Message-ID: <Y47z/DSw49Klk0px@hovoldconsulting.com>
References: <20221205100837.29212-1-johan+linaro@kernel.org>
 <20221205100837.29212-2-johan+linaro@kernel.org>
 <20221205115906.GA20192@thinkpad>
 <Y43e9KRDsTCS5VI4@hovoldconsulting.com>
 <20221205122018.GC20192@thinkpad>
 <Y43jtpHqlyiIEZ0S@hovoldconsulting.com>
 <20221205130048.GD20192@thinkpad>
 <Y43uUA2X4Vzn+VLF@hovoldconsulting.com>
 <20221205223522.GA2799349-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221205223522.GA2799349-robh@kernel.org>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 05, 2022 at 04:35:22PM -0600, Rob Herring wrote:
> On Mon, Dec 05, 2022 at 02:12:48PM +0100, Johan Hovold wrote:
> > On Mon, Dec 05, 2022 at 06:30:48PM +0530, Manivannan Sadhasivam wrote:
> > > On Mon, Dec 05, 2022 at 01:27:34PM +0100, Johan Hovold wrote:
> > > > On Mon, Dec 05, 2022 at 05:50:18PM +0530, Manivannan Sadhasivam wrote:
> > > > > On Mon, Dec 05, 2022 at 01:07:16PM +0100, Johan Hovold wrote:
> > > > > > On Mon, Dec 05, 2022 at 05:29:06PM +0530, Manivannan Sadhasivam wrote:
> > > > > > > On Mon, Dec 05, 2022 at 11:08:36AM +0100, Johan Hovold wrote:
> > > > > > > > UFS controllers may be cache coherent and must be marked as such in the
> > > > > > > > devicetree to avoid data corruption.
> 
> Typically, you'd only be doing unnecessary cache flushes without it 
> rather than getting data corruption. However, it is possible this 
> property triggers other system setup or something that would cause 
> problems if not setup right.

You can end up with data corruption, for example, if the kernel remaps
a consistent buffer and writes data through the non-cacheable alias
while the coherent device snoops stale data from the caches.

Johan
