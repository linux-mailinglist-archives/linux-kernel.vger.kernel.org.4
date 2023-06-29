Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84EF474295D
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 17:20:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232627AbjF2PUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 11:20:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232591AbjF2PTx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 11:19:53 -0400
Received: from mail-io1-f43.google.com (mail-io1-f43.google.com [209.85.166.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 587F5AA;
        Thu, 29 Jun 2023 08:19:52 -0700 (PDT)
Received: by mail-io1-f43.google.com with SMTP id ca18e2360f4ac-7837329a00aso33373839f.2;
        Thu, 29 Jun 2023 08:19:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688051991; x=1690643991;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=blNjDhPR65WgulG05Ac/jsdyPBHD4bO3KAhnWSq5dEY=;
        b=Q3Se/Pm24UapjAL6J8xUEl1CAhfeQCLa7ah/sOnc8LGFTMqLior9QUiOSnBVgtHNEx
         28RLQrCCD4IL5b3TbZ/vhBtEc2Sg564QBuAQ/mKUO8Ha5hbGpfUUtK1G67qT64Zk07a6
         NEt0NMMfvQhfF1yz7io1+TuMBy2HzI18FHhORvMmkEsmvNKiaxpetqyr1E8WToABJ0rO
         z4EY5XyfUYTu73cv10YIUqOA97Kp978fq6UTSu+AMeu1RNkBOCOuTQejjx0vN+awayfH
         EKaOEEDlTBYVHZ5ojk8iO3UbZzAhVKv4tRdd9oq3Qj+ASq5Z11GD8pi4bJhtAf8TfwMy
         bQEg==
X-Gm-Message-State: AC+VfDx3lWZTxJRwdnNXHDK9C+hKpWCsgnJ3oxf7lLM4PKLtFV6u8d28
        7fhly1Mo4diiTeo7aztWCg==
X-Google-Smtp-Source: ACHHUZ59kmFHq1B7LvOcwOCer+K8x3ClmeCwbxyRPdlMfA5CYMemTP6T11UDwDiVATlIKwta/nogpQ==
X-Received: by 2002:a6b:d808:0:b0:783:491a:13fe with SMTP id y8-20020a6bd808000000b00783491a13femr15718132iob.5.1688051991594;
        Thu, 29 Jun 2023 08:19:51 -0700 (PDT)
Received: from robh_at_kernel.org ([64.188.179.250])
        by smtp.gmail.com with ESMTPSA id s24-20020a02cf38000000b0040908cbbc5asm3892004jar.68.2023.06.29.08.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Jun 2023 08:19:50 -0700 (PDT)
Received: (nullmailer pid 3055405 invoked by uid 1000);
        Thu, 29 Jun 2023 15:19:47 -0000
Date:   Thu, 29 Jun 2023 09:19:47 -0600
From:   Rob Herring <robh@kernel.org>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Mark Brown <broonie@kernel.org>,
        Joseph Gates <jgates@squareup.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        James Willcox <jwillcox@squareup.com>,
        linux-usb@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Leo Yan <leo.yan@linaro.org>, Stephen Boyd <sboyd@kernel.org>,
        Andy Gross <andy.gross@linaro.org>,
        alsa-devel@alsa-project.org, Conor Dooley <conor+dt@kernel.org>,
        Christian Marangi <ansuelsmth@gmail.com>,
        iommu@lists.linux.dev, Stephan Gerhold <stephan@gerhold.net>,
        Banajit Goswami <bgoswami@quicinc.com>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Xu Yang <xu.yang_2@nxp.com>,
        Lee Jones <lee@kernel.org>,
        cros-qcom-dts-watchers@chromium.org, Jun Nie <jun.nie@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Will Deacon <will@kernel.org>,
        Konrad Dybcio <konradybcio@kernel.org>,
        linux-kernel@vger.kernel.org, Benjamin Li <benl@squareup.com>,
        Max Chen <mchen@squareup.com>, linux-arm-msm@vger.kernel.org,
        Andy Gross <agross@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Vincent Knecht <vincent.knecht@mailoo.org>,
        Wesley Cheng <quic_wcheng@quicinc.com>,
        Zac Crosby <zac@squareup.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Vivek Gautam <vivek.gautam@codeaurora.org>,
        Joerg Roedel <joro@8bytes.org>, devicetree@vger.kernel.org,
        Peng Fan <peng.fan@nxp.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Subject: Re: [PATCH 07/11] dt-bindings: iommu: qcom_iommu: Allow 'tbu' clock
Message-ID: <168805198676.3055346.17759635264123087851.robh@kernel.org>
References: <20230627-topic-more_bindings-v1-0-6b4b6cd081e5@linaro.org>
 <20230627-topic-more_bindings-v1-7-6b4b6cd081e5@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230627-topic-more_bindings-v1-7-6b4b6cd081e5@linaro.org>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Tue, 27 Jun 2023 18:24:23 +0200, Konrad Dybcio wrote:
> Some IOMMUs on some platforms (there doesn't seem to be a good denominator
> for this) require the presence of a third clock, specifically for
> accessing the IOMMU's Translation Buffer Unit (TBU). Allow it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/iommu/qcom,iommu.yaml | 4 ++++
>  1 file changed, 4 insertions(+)
> 

Reviewed-by: Rob Herring <robh@kernel.org>

