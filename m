Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C687723082
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:53:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjFETxt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:53:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235933AbjFETxp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:53:45 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C718E44;
        Mon,  5 Jun 2023 12:53:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685994707; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=PbCowT1C+VesB3t1oxzuEvU8GZsoBU+Yf1zwENMScWyzYLs9eW97yJTGal5e3x3yuV
    ZWkrz9xYU5AlYn0frad2vatQTnPNlQC2sscX4gNY9BKrWHO2JAbSXiOJJvYFCq2OR5lj
    757XxeSW1Q/m6DFkLmfTkNZNTWym9zK45qMgTO8cBtSTJuG0GalWOlaY4gXpKvG+y8Au
    2ttAzlOgHUVF7TeqIJcu8qGncUjjDZKsXbX2eQvHnP3rVYUX6oRTSQ0wxmpjnMoaXchA
    UTD3RDZbnEGNNONeqpeYSlkeIb6VN8z6ipfqxGze42vNlKSapGn8iFTAFHo20vIdrPwP
    RtSw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685994707;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JPravO3myGy54xaRXA7BrFO6QeSQKgTGENq8vhgK3SA=;
    b=NGy/CAeaXiH9A8rjbk5JfPg1AKw5uzRz2ygri/o8H6RFF44+vn/5CBjWT4zG5M2BXB
    R9CC6sPB069gDZQUQCXsw0qa9dUJTcw01t61EiQCpoUMsEBKn7buWQINpfrK10enkWN7
    xbfSlqOeFNgJ0wp1pnVSu8BG6pBPEshwIz4MBm6KrNaF2GH7o5ab2dpL/TEDvXvWvqp/
    xHGN2Dszhae8piCbEwqJsuw2OzZlusrJoc2TodDsp7uHHnF90Qtu9AqAh8CnIjijIksZ
    9qomTxW0GvKKl9OxAK5e65vvc+NbERmNliYD+nB/Esf/b72upTacmOXwKJJdZQcNV0vQ
    KDeg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685994707;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JPravO3myGy54xaRXA7BrFO6QeSQKgTGENq8vhgK3SA=;
    b=jvLYPRGRkVTHjq0rAYVpJOUvO5fhUqYFWDjCCC8lSZBduJwoCVAhb3SNz7ULWgYwrT
    Glmn2a/MoZoLaNlzmtQbxoyYFtHS6Hzdct1xltpm6CIfWK8kAd3nk0u22WJjLRnGv7qA
    Aa8pIyO4lXJvf/5/LPX/1i1nKBdu4Ou+CzI7nQHJoxZ9evMDG3jiCDY1GIEwhi88KhLX
    ve5j/ksZ7hHc8+EcgG2+r5hdc1/kW2axF4E6ew/BJtgZSyLUStYrIYtN5X7fUsVNFVGc
    BnR3M0EfZfmWFjmU5OkOrjSqDwTzdeDVPhjzTFF2I1texCw9Se/ZGVPxeLlLXBlArz3y
    iWxA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685994707;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=JPravO3myGy54xaRXA7BrFO6QeSQKgTGENq8vhgK3SA=;
    b=jRaEg8KO+E5l/wI+YAeeJW2QF+vo91FKHASMtjyFO/eWv2PZ7PQUs5eU68Q41jEPMQ
    Q17jMmxc1yBM3eDEaOBg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z55JplBk1
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 21:51:47 +0200 (CEST)
Date:   Mon, 5 Jun 2023 21:51:46 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 10/14] soc: qcom: Add RPM processor/subsystem driver
Message-ID: <ZH480vq8iNgkoK78@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-10-e0a3b6de1f14@gerhold.net>
 <04745990-d270-b37c-7ac8-dff24b03e02b@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <04745990-d270-b37c-7ac8-dff24b03e02b@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 05, 2023 at 09:06:54PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5.06.2023 09:08, Stephan Gerhold wrote:
> > Add a simple driver for the qcom,rpm-proc compatible that registers the
> > "smd-edge" and populates other children defined in the device tree.
> > 
> > Note that the DT schema belongs to the remoteproc subsystem while this
> > driver is added inside soc/qcom. I argue that the RPM *is* a remoteproc,
> > but as an implementation detail in Linux it can currently not benefit
> > from anything provided by the remoteproc subsystem. The RPM firmware is
> > usually already loaded and started by earlier components in the boot
> > chain and is not meant to be ever restarted.
> > 
> > To avoid breaking existing kernel configurations the driver is always
> > built when smd-rpm.c is also built. They belong closely together anyway.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  drivers/soc/qcom/Makefile   |  2 +-
> >  drivers/soc/qcom/rpm-proc.c | 76 +++++++++++++++++++++++++++++++++++++++++++++
> >  2 files changed, 77 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/soc/qcom/Makefile b/drivers/soc/qcom/Makefile
> > index 99114c71092b..113b9ff2ad43 100644
> > --- a/drivers/soc/qcom/Makefile
> > +++ b/drivers/soc/qcom/Makefile
> > @@ -18,7 +18,7 @@ obj-$(CONFIG_QCOM_RPM_MASTER_STATS)	+= rpm_master_stats.o
> >  obj-$(CONFIG_QCOM_RPMH)		+= qcom_rpmh.o
> >  qcom_rpmh-y			+= rpmh-rsc.o
> >  qcom_rpmh-y			+= rpmh.o
> > -obj-$(CONFIG_QCOM_SMD_RPM)	+= smd-rpm.o
> > +obj-$(CONFIG_QCOM_SMD_RPM)	+= rpm-proc.o smd-rpm.o
> >  obj-$(CONFIG_QCOM_SMEM) +=	smem.o
> >  obj-$(CONFIG_QCOM_SMEM_STATE) += smem_state.o
> >  obj-$(CONFIG_QCOM_SMP2P)	+= smp2p.o
> > diff --git a/drivers/soc/qcom/rpm-proc.c b/drivers/soc/qcom/rpm-proc.c
> > new file mode 100644
> > index 000000000000..0652be7f7895
> > --- /dev/null
> > +++ b/drivers/soc/qcom/rpm-proc.c
> > @@ -0,0 +1,76 @@
> > +// SPDX-License-Identifier: GPL-2.0-only
> > +/* Copyright (c) 2021-2023, Stephan Gerhold <stephan@gerhold.net> */
> > +
> > +#include <linux/module.h>
> > +#include <linux/of.h>
> > +#include <linux/of_platform.h>
> > +#include <linux/platform_device.h>
> > +#include <linux/rpmsg/qcom_smd.h>
> > +
> > +static int rpm_proc_probe(struct platform_device *pdev)
> > +{
> > +	struct qcom_smd_edge *edge = NULL;
> > +	struct device *dev = &pdev->dev;
> > +	struct device_node *edge_node;
> > +	int ret;
> > +
> > +	edge_node = of_get_child_by_name(dev->of_node, "smd-edge");
> > +	if (edge_node) {
> > +		edge = qcom_smd_register_edge(dev, edge_node);
> > +		if (IS_ERR(edge))
> > +			return dev_err_probe(dev, PTR_ERR(edge),
> > +					     "Failed to register smd-edge\n");
> Need of_node_put in both success and IS_ERR paths
> 

Oops. :/

> > +	}
> > +
> > +	ret = devm_of_platform_populate(dev);
> > +	if (ret) {
> > +		dev_err(dev, "Failed to populate children devices: %d\n", ret);
> I may be having a brain lag moment but I think it should be "child"
> singular, otherwise it sounds like they're devices for children!
> 

Uh somehow both sounds fine to me so I'll just change it in v2. :)

> > +		goto err;
> > +	}
> > +
> > +	platform_set_drvdata(pdev, edge);
> > +	return 0;
> > +err:
> > +	if (edge)
> > +		qcom_smd_unregister_edge(edge);
> > +	return ret;
> > +}
> > +
> > +static void rpm_proc_remove(struct platform_device *pdev)
> > +{
> > +	struct qcom_smd_edge *edge = platform_get_drvdata(pdev);
> > +
> > +	if (edge)
> > +		qcom_smd_unregister_edge(edge);
> > +}
> > +
> > +static const struct of_device_id rpm_proc_of_match[] = {
> > +	{ .compatible = "qcom,rpm-proc", },
> > +	{ /* sentinel */ }
> > +};
> > +MODULE_DEVICE_TABLE(of, rpm_proc_of_match);
> > +
> > +static struct platform_driver rpm_proc_driver = {
> > +	.probe = rpm_proc_probe,
> > +	.remove_new = rpm_proc_remove,
> > +	.driver = {
> > +		.name = "qcom-rpm-proc",
> > +		.of_match_table = rpm_proc_of_match,
> > +	},
> > +};
> > +
> > +static int __init rpm_proc_init(void)
> > +{
> > +	return platform_driver_register(&rpm_proc_driver);
> > +}
> > +arch_initcall(rpm_proc_init);
> Maybe we can go as early as core...
> 

SMEM is arch_initcall() so at least for the SMD case it can never
succeed probing in core_initcall() and would likely just cause
unnecessary probe deferrals. That's why I chose arch_initcall().

Are you sure anything will really benefit from core_initcall() here?

I'd just like to avoid making things worse by using a random way too
early initcall level. We have some really weird examples in the tree
currently, e.g.:
  - rpmpd: core_initcall()
  - smd-rpm: arch_initcall()
  - glink-rpm: subsys_initcall()
But they actually need to be loaded in opposite order...

Thanks,
Stephan
