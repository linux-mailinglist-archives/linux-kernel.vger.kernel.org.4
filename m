Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6CB06F3F26
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 10:35:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233648AbjEBIfH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 04:35:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229722AbjEBIfE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 04:35:04 -0400
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0B210CC
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 01:35:01 -0700 (PDT)
Received: by mail-yb1-xb2b.google.com with SMTP id 3f1490d57ef6-b9a7e639656so5897793276.0
        for <linux-kernel@vger.kernel.org>; Tue, 02 May 2023 01:35:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683016501; x=1685608501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=EQzmsLXS8o53Z/tJTwR8dBrkRh8cGnQKwsG++ZUM2Rw=;
        b=c38iWqoEsV2Ak6ZcqLGqtUG9fKxZwCiTxUe6opQW4xHF2//ciLjPAXSCwCkNIWhnUE
         r7HVF0jPrO1eBnG3aH62ge5xzY7l3xtGxztlwaHJHom9tlIZ1dxTgi/qgVkOKYcfwPK+
         f+VztAoZAyiAM3TGJ/sa2kZJVxZQnuqDvtxLs8XmahPiwWHFpTx7lYRFoEfCthesNAQs
         99pXmMimCxFyvNswavo9rNBF3pMQhVBvP60GRPnjE8ECT1BjjW/a844NMgutFOuvBg+5
         Rke6snxWBgVN6I1E7oqv4nv8WQdEjfkfFR5tIRXPvcMm9+BDfEFJTTI5VwyqxjDmCphp
         MFAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683016501; x=1685608501;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=EQzmsLXS8o53Z/tJTwR8dBrkRh8cGnQKwsG++ZUM2Rw=;
        b=I23LT5mxI4AMEQLQZcYhPrvsAEbNPOmWj7xa1tRf+rrGRX/NouV1Jbuz0EpUKWa6Kt
         CDrgvV3Vy/z/odMcoFZDqyun4NEVEvGxolZK2xl9jd/HeJ03zM1bWxNk3NOckAeJOJBY
         bmZtZnfFttl2t5OsqR6h2zUGlUR5PejnNeZAFZyOrWMoYTHqLuvFaWDGzdpUJ7yuttDA
         CKhKb9Dwk7oifkvf6T514JmJO36zDezgaezW4bwU+kTnRjKXsX3AQGuDxvE+mSO82Z2L
         tEqWPL1qdYuUZP2F5hu4mfM4x88a4FRUc/Ucb/0sFzLSXhc3UI2dFjIKpqn5LLp55Xpm
         yBhw==
X-Gm-Message-State: AC+VfDyDvp+/fPg5VmMVGmj4EwyFZT7PyR2xn+q02HFB9H1z7vHN96Hu
        Ok3Rwf3bBN8Vf2JfkY0e5jiaLFIrT1vIrEPNP/Wcmg==
X-Google-Smtp-Source: ACHHUZ7prVyExhhCDfZ9wbdVmvLpHPC8RmEbBTxceN5puB7edxWSnc7AxGder2kHWuuyjnb5ts+y/AKRZDjsq/tajN0=
X-Received: by 2002:a25:d7d7:0:b0:b9a:66b7:673e with SMTP id
 o206-20020a25d7d7000000b00b9a66b7673emr17241022ybg.43.1683016501059; Tue, 02
 May 2023 01:35:01 -0700 (PDT)
MIME-Version: 1.0
References: <20230421124938.21974-1-quic_devipriy@quicinc.com>
 <20230421124938.21974-7-quic_devipriy@quicinc.com> <CAA8EJpoqq=3o1K=yDaim=e11nEN5n+phJUSd1d5BT_VJkdv6xg@mail.gmail.com>
 <d6b5e395-6d4b-7b5d-f24f-f7dd2e901c00@quicinc.com>
In-Reply-To: <d6b5e395-6d4b-7b5d-f24f-f7dd2e901c00@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 2 May 2023 11:34:50 +0300
Message-ID: <CAA8EJpoaZFArA=CGg_WP5SUXWsn++M82RB21gYuy84NPfNJd+w@mail.gmail.com>
Subject: Re: [PATCH V3 6/6] PCI: qcom: Add support for IPQ9574
To:     Devi Priya <quic_devipriy@quicinc.com>
Cc:     agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        lpieralisi@kernel.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, krzysztof.kozlowski+dt@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, mani@kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-clk@vger.kernel.org, quic_srichara@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_ipkumar@quicinc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 09:36, Devi Priya <quic_devipriy@quicinc.com> wrote:
>
>
>
> On 4/22/2023 5:35 AM, Dmitry Baryshkov wrote:
> > On Fri, 21 Apr 2023 at 15:51, Devi Priya <quic_devipriy@quicinc.com> wrote:
> >>
> >> The IPQ9574 platform has 4 Gen3 PCIe controllers: two single-lane
> >> and two dual-lane based on SNPS core 5.70a
> >> The Qcom IP rev is 1.27.0 and Synopsys IP rev is 5.80a
> >> Added a new compatible 'qcom,pcie-ipq9574' and 'ops_1_27_0'
> >> which reuses all the members of 'ops_2_9_0' except for the post_init
> >> as the SLV_ADDR_SPACE_SIZE configuration differs between 2_9_0
> >> and 1_27_0.
> >> Also, modified get_resources of 'ops 2_9_0' to get the clocks
> >> from the device tree and modelled the post init sequence as
> >> a common function to avoid code redundancy.
> >>
> >> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> >> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> >> Signed-off-by: Devi Priya <quic_devipriy@quicinc.com>
> >> ---
> >>   Changes in V3:
> >>          - Rebased on top of linux-next/master
> >>
> >>   drivers/pci/controller/dwc/pcie-qcom.c | 61 ++++++++++++++++++--------
> >>   1 file changed, 43 insertions(+), 18 deletions(-)
> >>
> >> diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
> >> index 4ab30892f6ef..3682ecdead1f 100644
> >> --- a/drivers/pci/controller/dwc/pcie-qcom.c
> >> +++ b/drivers/pci/controller/dwc/pcie-qcom.c
> >> @@ -107,6 +107,7 @@
> >>
> >>   /* PARF_SLV_ADDR_SPACE_SIZE register value */
> >>   #define SLV_ADDR_SPACE_SZ                      0x10000000
> >> +#define SLV_ADDR_SPACE_SZ_1_27_0               0x08000000
> >>
> >>   /* PARF_MHI_CLOCK_RESET_CTRL register fields */
> >>   #define AHB_CLK_EN                             BIT(0)
> >> @@ -202,10 +203,10 @@ struct qcom_pcie_resources_2_7_0 {
> >>          struct reset_control *rst;
> >>   };
> >>
> >> -#define QCOM_PCIE_2_9_0_MAX_CLOCKS             5
> >>   struct qcom_pcie_resources_2_9_0 {
> >> -       struct clk_bulk_data clks[QCOM_PCIE_2_9_0_MAX_CLOCKS];
> >> +       struct clk_bulk_data *clks;
> >>          struct reset_control *rst;
> >> +       int num_clks;
> >>   };
> >>
> >>   union qcom_pcie_resources {
> >> @@ -1050,17 +1051,10 @@ static int qcom_pcie_get_resources_2_9_0(struct qcom_pcie *pcie)
> >>          struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> >>          struct dw_pcie *pci = pcie->pci;
> >>          struct device *dev = pci->dev;
> >> -       int ret;
> >>
> >> -       res->clks[0].id = "iface";
> >> -       res->clks[1].id = "axi_m";
> >> -       res->clks[2].id = "axi_s";
> >> -       res->clks[3].id = "axi_bridge";
> >> -       res->clks[4].id = "rchng";
> >> -
> >> -       ret = devm_clk_bulk_get(dev, ARRAY_SIZE(res->clks), res->clks);
> >> -       if (ret < 0)
> >> -               return ret;
> >> +       res->num_clks = devm_clk_bulk_get_all(dev, &res->clks);
> >> +       if (res->clks < 0)
> >> +               return res->num_clks;
> >>
> >>          res->rst = devm_reset_control_array_get_exclusive(dev);
> >>          if (IS_ERR(res->rst))
> >> @@ -1073,7 +1067,7 @@ static void qcom_pcie_deinit_2_9_0(struct qcom_pcie *pcie)
> >>   {
> >>          struct qcom_pcie_resources_2_9_0 *res = &pcie->res.v2_9_0;
> >>
> >> -       clk_bulk_disable_unprepare(ARRAY_SIZE(res->clks), res->clks);
> >> +       clk_bulk_disable_unprepare(res->num_clks, res->clks);
> >>   }
> >>
> >>   static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> >> @@ -1102,19 +1096,16 @@ static int qcom_pcie_init_2_9_0(struct qcom_pcie *pcie)
> >>
> >>          usleep_range(2000, 2500);
> >>
> >> -       return clk_bulk_prepare_enable(ARRAY_SIZE(res->clks), res->clks);
> >> +       return clk_bulk_prepare_enable(res->num_clks, res->clks);
> >>   }
> >>
> >> -static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> >> +static int qcom_pcie_post_init(struct qcom_pcie *pcie)
> >>   {
> >>          struct dw_pcie *pci = pcie->pci;
> >>          u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
> >>          u32 val;
> >>          int i;
> >>
> >> -       writel(SLV_ADDR_SPACE_SZ,
> >> -               pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> >> -
> >>          val = readl(pcie->parf + PARF_PHY_CTRL);
> >>          val &= ~PHY_TEST_PWR_DOWN;
> >>          writel(val, pcie->parf + PARF_PHY_CTRL);
> >> @@ -1151,6 +1142,26 @@ static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> >>          return 0;
> >>   }
> >>
> >> +static int qcom_pcie_post_init_1_27_0(struct qcom_pcie *pcie)
> >> +{
> >> +       writel(SLV_ADDR_SPACE_SZ_1_27_0,
> >> +              pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> >> +
> >> +       qcom_pcie_post_init(pcie);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +static int qcom_pcie_post_init_2_9_0(struct qcom_pcie *pcie)
> >> +{
> >> +       writel(SLV_ADDR_SPACE_SZ,
> >> +              pcie->parf + PARF_SLV_ADDR_SPACE_SIZE);
> >> +
> >> +       qcom_pcie_post_init(pcie);
> >> +
> >> +       return 0;
> >> +}
> >
> > I'm not sure about moving the SLV_ADDR_SPACE_SIZE initialization from
> > init() to post_init(). Probably a better solution might be to have two
> > init() callbacks and to call the common function from both of them.
> >
> Hi Dmitry, Originally, the SLV_ADDR_SPACE_SIZE initialization was done
> part of post_init() callback only and we haven't moved it from init() to
> post_init().We have just added two post_init() callbacks to
> handle the SLV_ADDR_SPACE_SIZE initialization accordingly for 1_27_0 and
> 2_9_0.

Ack, I see then.

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

-- 
With best wishes
Dmitry
