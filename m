Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 267D473031D
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 17:13:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343590AbjFNPNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 11:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52314 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343594AbjFNPNR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 11:13:17 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4CF2101;
        Wed, 14 Jun 2023 08:13:14 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686755592; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=IBLrXQumV9gvhZ5cuFdLlDATix6u1lpargigSDFWF0idUbwaf4tmwa0U+/caZ1uVGp
    oWV84Sq1SsqsFnAy++6RuZPpC8hh1PJ5uwPHLmHKLdQPsLxmvq6ZsTRqolhPK6ZwZjBy
    NC/JI1srL/1TmLHNakTYEB8StMQ1yREvLji8vF7hDhagfVXfm5aw5io9jchM/78t5muG
    kJ7awRbPixNzXfdyNjqJVTOCZqlMhv+Bg5zpLI0xW3SRQ/F+OesFS6Kl9lo+Utr5XkOj
    qbUuBzeZIsJ6CHDBE4Hq8OQUqLjrjSp/SyhYR0GA6BMFIxOurQqm4MKn7I0LLkQYeQio
    dxZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686755592;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6vWmnjq8PtOemDu4fY8kEJsPcuBxy1e+Pqtj3pY7T9k=;
    b=Si4pICgNty0wr0B1iS//6ReDIJjHqhpfclr3Q0zTR9JTach9ceGMKAGl6SZPs9E05P
    6eCM+WsN9PBjm9qnKw+k8Hm9Twt2VVaRAlviQc+m5FYsIKk5l2ipjmz2x70GVeJaeceF
    RuTtMGqhHK8qK0kS/X1Usham7WZFGjidlMsr7sOxard1KbF/WON7u38yE1YIa9uFtmO2
    7GNQIhrQRwJ29geAa7UI+x7kKbOe+W+8hVF/Hka1NJ0s6pXpeJzcbivSM1Gy+L8yqCFt
    b9VEsbdEsjP3m1CeTqGWN227xkvodGeVII5cE0q5oVP+KeTg9t4kZgE708aAv5iD7tJB
    ir4w==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686755592;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6vWmnjq8PtOemDu4fY8kEJsPcuBxy1e+Pqtj3pY7T9k=;
    b=Mgg741W2+VYSXlbkmVk/GzFkQcxC2/kFof6xc8CuKtdI1kLDM11ACcYWDjVRgUekku
    R8Te2sN3QYE6AKAA1Sv5cyJO0Kn1QFMQ7u0HuTv/5pLd8IExgcOKyymvxdslBhKfhCsJ
    wu7s7K2kMX/SOUuz+tRZQpP1dLZW+YHGnBahgXgQ7BLMzxcidHVTTPG8hA+Sgc5ZD5eO
    E1eUqnQvAGnwK/7h3kdJUsZWtNJ01xcvhLrvZ0SboilzzMSQ0DN7XnudqMfCC2RUMTib
    VdO7siKabiq3p/bdXbe//4m0y/rUY8wb31zb0RP25h7wXYlLDfB4fvpCut84D/S6ZAp5
    YfOQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686755592;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=6vWmnjq8PtOemDu4fY8kEJsPcuBxy1e+Pqtj3pY7T9k=;
    b=vGqj8TXpZQtPvTEGotwrpykui0AN9b3DBr7ThBGtrsD+gJzUvZHRlwljiyVky8LJ6R
    7kc3AdYP4uLnTFUVkXDA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA95nh"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5EFDC0Kr
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Wed, 14 Jun 2023 17:13:12 +0200 (CEST)
Date:   Wed, 14 Jun 2023 17:13:03 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] remoteproc: qcom: Use of_reserved_mem_lookup()
Message-ID: <ZInY_9QjJXIo7Bn8@gerhold.net>
References: <20230529-rproc-of-rmem-v1-1-5b1e38880aba@gerhold.net>
 <20230614151213.qiimwth3fkic5vct@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230614151213.qiimwth3fkic5vct@ripper>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 14, 2023 at 08:12:13AM -0700, Bjorn Andersson wrote:
> On Wed, May 31, 2023 at 11:34:54AM +0200, Stephan Gerhold wrote:
> > Reserved memory can be either looked up using the generic function
> > of_address_to_resource() or using the special of_reserved_mem_lookup().
> > The latter has the advantage that it ensures that the referenced memory
> > region was really reserved and is not e.g. status = "disabled".
> > 
> > of_reserved_mem also supports allocating reserved memory dynamically at
> > boot time. This works only when using of_reserved_mem_lookup() since
> > there won't be a fixed address in the device tree.
> > 
> > Switch the code to use of_reserved_mem_lookup(), similar to
> > qcom_q6v5_wcss.c which is using it already. There is no functional
> > difference for static reserved memory allocations.
> > 
> > While at it this also adds two missing of_node_put() calls in
> > qcom_q6v5_pas.c.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> > See e.g. [1] for an example of dynamically allocated reserved memory.
> > (This patch does *not* depend on [1] and is useful without as well...)
> > 
> > NOTE: Changes in qcom_q6v5_adsp.c and qcom_q6v5_pas.c are untested,
> > I only checked qcom_q6v5_mss.c and qcom_wcnss.c on MSM8916/DB410c.
> > The code changes are pretty similar for all of those though.
> > 
> > [1]: https://lore.kernel.org/linux-arm-msm/20230510-dt-resv-bottom-up-v1-5-3bf68873dbed@gerhold.net/
> > ---
> >  drivers/remoteproc/qcom_q6v5_adsp.c | 22 ++++++++--------
> >  drivers/remoteproc/qcom_q6v5_mss.c  | 35 +++++++++++++++----------
> >  drivers/remoteproc/qcom_q6v5_pas.c  | 51 ++++++++++++++++++++-----------------
> >  drivers/remoteproc/qcom_wcnss.c     | 24 ++++++++---------
> >  4 files changed, 69 insertions(+), 63 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_adsp.c b/drivers/remoteproc/qcom_q6v5_adsp.c
> > index 6777a3bd6226..948b3d00a564 100644
> > --- a/drivers/remoteproc/qcom_q6v5_adsp.c
> > +++ b/drivers/remoteproc/qcom_q6v5_adsp.c
> > @@ -14,8 +14,8 @@
> >  #include <linux/kernel.h>
> >  #include <linux/mfd/syscon.h>
> >  #include <linux/module.h>
> > -#include <linux/of_address.h>
> >  #include <linux/of_device.h>
> > +#include <linux/of_reserved_mem.h>
> >  #include <linux/platform_device.h>
> >  #include <linux/pm_domain.h>
> >  #include <linux/pm_runtime.h>
> > @@ -637,28 +637,26 @@ static int adsp_init_mmio(struct qcom_adsp *adsp,
> >  
> >  static int adsp_alloc_memory_region(struct qcom_adsp *adsp)
> >  {
> > +	struct reserved_mem *rmem = NULL;
> >  	struct device_node *node;
> > -	struct resource r;
> > -	int ret;
> >  
> >  	node = of_parse_phandle(adsp->dev->of_node, "memory-region", 0);
> > +	if (node)
> > +		rmem = of_reserved_mem_lookup(node);
> > +	of_node_put(node);
> > +
> >  	if (!node) {
> > -		dev_err(adsp->dev, "no memory-region specified\n");
> > +		dev_err(adsp->dev, "unable to resolve memory-region\n");
> >  		return -EINVAL;
> >  	}
> >  
> > -	ret = of_address_to_resource(node, 0, &r);
> > -	of_node_put(node);
> > -	if (ret)
> > -		return ret;
> > -
> > -	adsp->mem_phys = adsp->mem_reloc = r.start;
> > -	adsp->mem_size = resource_size(&r);
> 
> Aren't you missing a check for !rmem here? (The others has it)
> 

Indeed, thanks for spotting this! Will send a v2.

Stephan
