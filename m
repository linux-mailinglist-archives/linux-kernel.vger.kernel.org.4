Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B44173BF40
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 22:12:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231750AbjFWUMg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 16:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjFWUMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 16:12:34 -0400
Received: from mail-io1-f50.google.com (mail-io1-f50.google.com [209.85.166.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A3E62721;
        Fri, 23 Jun 2023 13:12:33 -0700 (PDT)
Received: by mail-io1-f50.google.com with SMTP id ca18e2360f4ac-78337d6b14fso11356039f.1;
        Fri, 23 Jun 2023 13:12:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687551152; x=1690143152;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mIR790y01Y2bPW5MOoqgrgXvnrYJCrBg8XRy1PjtoJY=;
        b=BJoG/cNi7CtWImHF7kin1/5vG96A0IKW4Rho44zIGheD0gfGjM2EJ6S1lfQIg7ifgB
         9+EpjDIasiH+trW/Wtu/L3xfnY8kcN4AZgeWqGUSh/pMDATAOsYTMkuCkXbVyQq+1KV7
         /5Lqg4q7ljyniDdLi8hm155oet//C29/8ef25lOJEHH9f9nwq1d0Oq6Ey0XXWhEsTUGa
         p+Itg2jsXBCy/7/755KPE/5w4on2Oy72inqXpjg6SBrtaCYk8kpfaGxnjmEExShw6Qp6
         VoE8tXN+kb2szIGYrNtUoqiVgizIfH6cq/HMgxLAYRyHwW1enJ2jzDbSv3FhMg6xVY1K
         gDJw==
X-Gm-Message-State: AC+VfDyM+3jJWHICqDX3e/otb/Dgj0UgCx/kDQOJhQmmOwHuCfXahnL9
        D334IlcXvTJQIfTIHtheOg==
X-Google-Smtp-Source: ACHHUZ5+4vAMYvqL65nBRMGEpteSxNFOw4+9+RQXvw/CZSamsT8j+pvvD3T/frJwTVTFe9VBJYQ5qA==
X-Received: by 2002:a6b:ef16:0:b0:780:d76c:b645 with SMTP id k22-20020a6bef16000000b00780d76cb645mr4084530ioh.1.1687551152417;
        Fri, 23 Jun 2023 13:12:32 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id j25-20020a5d9d19000000b00780dcff0414sm44315ioj.20.2023.06.23.13.12.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Jun 2023 13:12:31 -0700 (PDT)
Received: (nullmailer pid 1024620 invoked by uid 1000);
        Fri, 23 Jun 2023 20:12:30 -0000
Date:   Fri, 23 Jun 2023 14:12:30 -0600
From:   Rob Herring <robh@kernel.org>
To:     Abel Vesa <abel.vesa@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        "Martin K . Petersen" <martin.petersen@oracle.com>,
        devicetree@vger.kernel.org, linux-scsi@vger.kernel.org,
        Manivannan Sadhasivam <mani@kernel.org>,
        Avri Altman <avri.altman@wdc.com>,
        Bart Van Assche <bvanassche@acm.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Subject: Re: [PATCH 4/5] scsi: dt-bindings: ufs: qcom: Fix sm8450 clocks
Message-ID: <20230623201230.GA1022063-robh@kernel.org>
References: <20230623113009.2512206-1-abel.vesa@linaro.org>
 <20230623113009.2512206-5-abel.vesa@linaro.org>
 <168752288418.27031.1090471926569361855.robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <168752288418.27031.1090471926569361855.robh@kernel.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 23, 2023 at 06:21:24AM -0600, Rob Herring wrote:
> 
> On Fri, 23 Jun 2023 14:30:08 +0300, Abel Vesa wrote:
> > The sm8450 has an ICE clock, so move the compatible to the proper
> > clocks check.
> > 
> > Fixes: 462c5c0aa798 ("dt-bindings: ufs: qcom,ufs: convert to dtschema")
> > Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
> > ---
> >  Documentation/devicetree/bindings/ufs/qcom,ufs.yaml | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> 
> My bot found errors running 'make DT_CHECKER_FLAGS=-m dt_binding_check'
> on your patch (DT_CHECKER_FLAGS is new in v5.13):
> 
> yamllint warnings/errors:
> 
> dtschema/dtc warnings/errors:
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: clocks: [[4294967295, 151], [4294967295, 10], [4294967295, 150], [4294967295, 166], [4294967295, 0], [4294967295, 164], [4294967295, 160], [4294967295, 162]] is too short
> 	from schema $id: http://devicetree.org/schemas/ufs/qcom,ufs.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: clock-names: ['core_clk', 'bus_aggr_clk', 'iface_clk', 'core_clk_unipro', 'ref_clk', 'tx_lane0_sync_clk', 'rx_lane0_sync_clk', 'rx_lane1_sync_clk'] is too short
> 	from schema $id: http://devicetree.org/schemas/ufs/qcom,ufs.yaml#
> /builds/robherring/dt-review-ci/linux/Documentation/devicetree/bindings/ufs/qcom,ufs.example.dtb: ufs@1d84000: reg: [[0, 30949376, 0, 12288]] is too short
> 	from schema $id: http://devicetree.org/schemas/ufs/qcom,ufs.yaml#

Looks like patch 1 didn't apply for me and would fix this.

Rob
