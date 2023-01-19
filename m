Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ADD6673D9D
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 16:35:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230121AbjASPfc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 10:35:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbjASPfN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 10:35:13 -0500
Received: from mail-wm1-x32e.google.com (mail-wm1-x32e.google.com [IPv6:2a00:1450:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C9B484541
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:35:12 -0800 (PST)
Received: by mail-wm1-x32e.google.com with SMTP id l8so1838016wms.3
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 07:35:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=nZL+EvzEvrAfF5w1mqqATHNa4cpLOo+MW+TpXyhWCHM=;
        b=fHNkuVltpvcapP0msNuKmLRanamZBxuyYOCRyGewd+VVXRtvCT05Y0ai/WF9vSz6tY
         TRuA/6COyvo+EKDIiGLuUJgzKH9Da54RNY2XhWFp2zzifPR5lPQY60bXYGtOAlaYj2v1
         1veATYgBXA+Ef+YmS6+HrYl8Z4VpAvFwaCMx8llsjf+ONQDIaYANiA1G29ghHxM7Xqjw
         ZqEuz5FLtSNtH+N8mPcMaIp+Ovqni62lJnuOjkOkD+ymGZg6lYlKYSOpcNhbeoQIqcCO
         b/qClz1B42F/M7/TS0B1R9NTOWpPwFLD+aLhuvRR8X9LdAtufdcLvTv5mzrjeYYpaBH8
         91Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nZL+EvzEvrAfF5w1mqqATHNa4cpLOo+MW+TpXyhWCHM=;
        b=2pei5XqgDVyYG+4Amypkri8ALRjk7LvEo4RMcGSffRE/YUmJQEmO6hD6ukh5InGDYQ
         8Puu/Agj50Slcyey0ldDB52thsyVHaOGRqnNZpR55vl7LMx0GvGATWtzlQLvGzVpiQo7
         4X1V4WHyfc8sGN+uuhrarlxg4E0I5YrwbAebwvEB9fS7bfo3xt+O0GbZrC9NHl9p5lfC
         R1QcH4BRWKSaqnFhzj+WU+/+8vcZy9zu3Z3Dq6UhiB9JkOqqhpXUvolx5QUzpknN20EB
         VFqW+/ypolLMp/5bNju4UISm3FnYzkUALiSzG8CSEz/cfI5yvYDiyk1mswv+k0HoJavZ
         35Tg==
X-Gm-Message-State: AFqh2kqEomIjRYtR8BiSAQaCYujpcxEtmK2v6P3qF9Fc3Ej0ySB4XNBE
        /gx0+OYDCZYtRuoOn1UZ7siWNQ==
X-Google-Smtp-Source: AMrXdXsQgjNOKgyBhRiFhNp7IpHqVoVUV1i9ePpAWGBcvM/SHjIii/CsB63IjRkyDA7IeZ0KuvPI0w==
X-Received: by 2002:a1c:7414:0:b0:3d9:779e:9788 with SMTP id p20-20020a1c7414000000b003d9779e9788mr6884710wmc.37.1674142510780;
        Thu, 19 Jan 2023 07:35:10 -0800 (PST)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id j15-20020a05600c190f00b003d9aa76dc6asm7608427wmq.0.2023.01.19.07.35.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 19 Jan 2023 07:35:09 -0800 (PST)
Date:   Thu, 19 Jan 2023 17:35:08 +0200
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Manivannan Sadhasivam <mani@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4 10/12] PCI: qcom: Add SM8550 PCIe support
Message-ID: <Y8ljLJ8vsqxdQtW8@linaro.org>
References: <20230119140453.3942340-1-abel.vesa@linaro.org>
 <20230119140453.3942340-11-abel.vesa@linaro.org>
 <20230119142155.GA101896@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230119142155.GA101896@thinkpad>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-01-19 19:51:55, Manivannan Sadhasivam wrote:
> On Thu, Jan 19, 2023 at 04:04:51PM +0200, Abel Vesa wrote:
> > Add compatible for both PCIe found on SM8550.
> > Also add the cnoc_pcie_sf_axi clock needed by the SM8550.
> > 
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> 
> Reviewed-by: Manivannan Sadhasivam <mani@kernel.org>
> 
> > Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> > ---
> > 
> > The v3 of this patchset is:
> > https://lore.kernel.org/all/20230119112453.3393911-1-abel.vesa@linaro.org/
> > 
> > Changes since v3:
> >  * renamed cnoc_pcie_sf_axi to cnoc_sf_axi
> > 
> > Changes since v2:
> >  * none
> >  
> > Changes since v1:
> >  * changed the subject line prefix for the patch to match the history,
> >    like Bjorn Helgaas suggested.
> >  * added Konrad's R-b tag
> > 
> > 
> >  drivers/pci/controller/dwc/pcie-qcom.c | 4 +++-
> >  1 file changed, 3 insertions(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> > index 77e5dc7b88ad..30f74bc51dbf 100644
> > --- a/drivers/pci/controller/dwc/pcie-qcom.c
> > +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> > @@ -182,7 +182,7 @@ struct qcom_pcie_resources_2_3_3 {
> >  
> >  /* 6 clocks typically, 7 for sm8250 */
> 
> Now this comment is outdated ;)
> 

Fair point. I'll wait for some more comments before
I'll send a new version.

> Thanks,
> Mani
> 
> >  struct qcom_pcie_resources_2_7_0 {
> > -	struct clk_bulk_data clks[12];
> > +	struct clk_bulk_data clks[13];
> >  	int num_clks;
> >  	struct regulator_bulk_data supplies[2];
> >  	struct reset_control *pci_reset;
> > @@ -1208,6 +1208,7 @@ static int qcom_pcie_get_resources_2_7_0(struct qcom_pcie *pcie)
> >  	res->clks[idx++].id = "noc_aggr_4";
> >  	res->clks[idx++].id = "noc_aggr_south_sf";
> >  	res->clks[idx++].id = "cnoc_qx";
> > +	res->clks[idx++].id = "cnoc_sf_axi";
> >  
> >  	num_opt_clks = idx - num_clks;
> >  	res->num_clks = idx;
> > @@ -1828,6 +1829,7 @@ static const struct of_device_id qcom_pcie_match[] = {
> >  	{ .compatible = "qcom,pcie-sm8250", .data = &cfg_1_9_0 },
> >  	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
> >  	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
> > +	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
> >  	{ }
> >  };
> >  
> > -- 
> > 2.34.1
> > 
> 
> -- 
> மணிவண்ணன் சதாசிவம்
