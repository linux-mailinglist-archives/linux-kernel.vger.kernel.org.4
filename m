Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C05568DCB5
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:16:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232213AbjBGPP6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:15:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232060AbjBGPPz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:15:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E62019A;
        Tue,  7 Feb 2023 07:15:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 29D9E60CF2;
        Tue,  7 Feb 2023 15:15:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8A326C433EF;
        Tue,  7 Feb 2023 15:15:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675782953;
        bh=T9VXNoczJLMf0GiB+a7Wu+O+LLfCrOlQJE/wqnN8IM8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=UKPWbKwDGgU7tXlh7BV49nxT12EgWwJ4OQL538YiL/Plp3JelpQQceJqgeVptSnfp
         0ZTIsCy0fWy+78spqQQgWpHiuDhUns6GwTui/fPzLKsTqKDOcyJih4dre75gyASXfL
         wMs3P8nSNthyHgJ4rGgi6Mdgs5ju70WyamX6pD9bbMrs9cwjnENZ9WuuF19Ol4az4Q
         gLlCG23GfyZRulmPaZvBu09sK6+L9BVqCN0SfuH3XitvtyjkupUSg599p2rJ/fvsCG
         5a8VDyD9E2029AMmTyy/bq8D/IUD6NGa/A1HVtN44Tau9lknTMaIQu82CTSCmXKtl4
         GEdEK26gop0gQ==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPPhr-000285-6m; Tue, 07 Feb 2023 16:16:27 +0100
Date:   Tue, 7 Feb 2023 16:16:27 +0100
From:   Johan Hovold <johan@kernel.org>
To:     David Collins <quic_collinsd@quicinc.com>
Cc:     Johan Hovold <johan+linaro@kernel.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maximilian Luz <luzmaximilian@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-rtc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 06/22] rtc: pm8xxx: drop unused register defines
Message-ID: <Y+JrS4mpWQrFsj0y@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-7-johan+linaro@kernel.org>
 <41d1f7bf-0bb3-ca49-8d1f-54921b10e8fc@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <41d1f7bf-0bb3-ca49-8d1f-54921b10e8fc@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:15:02PM -0800, David Collins wrote:
> On 2/2/23 07:54, Johan Hovold wrote:
> > Drop the original register defines which have been used since commit
> 
> s/used/unused/

Good catch. Perhaps Alexandre can amend the commit message when
applying.

It should be clear from Subject and the diff that this was a typo so I
don't think this alone is worth resending the series for.

> > c8d523a4b053 ("drivers/rtc/rtc-pm8xxx.c: rework to support pm8941 rtc").
> > 
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  drivers/rtc/rtc-pm8xxx.c | 6 ------
> >  1 file changed, 6 deletions(-)
> 
> Assuming that the minor commit text comment above is addressed:
> 
> Reviewed-by: David Collins <quic_collinsd@quicinc.com>

Johan
