Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95BA05EAE53
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 19:40:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiIZRkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 13:40:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230490AbiIZRkG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 13:40:06 -0400
X-Greylist: delayed 482 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 26 Sep 2022 10:05:24 PDT
Received: from alexa-out-sd-02.qualcomm.com (alexa-out-sd-02.qualcomm.com [199.106.114.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B547AD77
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 10:05:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1664211924; x=1695747924;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=3VMcO93PozK+g8jLLMrs6D7u1SFekdD0LmnHxmEpbPI=;
  b=yeUfXzPBhLNv2aRphxRwcPlr/6g2asfqYKLE0VVZA75y+uytgyx8TyhX
   3ZHCWVkYOx4pfMa91Z61Xbzi7Yl9XwjoqYpFZ8gzdFLcKDugPsrPXG+uM
   efvqsYXtOmLbsY42Cdi4wwErcNPqAlf9iqKNBPGNLCesdk+DNToCdAaAR
   0=;
Received: from unknown (HELO ironmsg04-sd.qualcomm.com) ([10.53.140.144])
  by alexa-out-sd-02.qualcomm.com with ESMTP; 26 Sep 2022 09:51:12 -0700
X-QCInternal: smtphost
Received: from nasanex01b.na.qualcomm.com ([10.46.141.250])
  by ironmsg04-sd.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Sep 2022 09:51:12 -0700
Received: from quicinc.com (10.80.80.8) by nasanex01b.na.qualcomm.com
 (10.46.141.250) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.986.29; Mon, 26 Sep
 2022 09:51:11 -0700
Date:   Mon, 26 Sep 2022 09:51:10 -0700
From:   Guru Das Srinagesh <quic_gurus@quicinc.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Rob Herring <robh+dt@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Lee Jones <lee@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] bindings: Update maintainer's email address
Message-ID: <20220926165110.GA1297@quicinc.com>
References: <1663979817-1078-1-git-send-email-quic_gurus@quicinc.com>
 <dc0ef30b-0c99-7086-7b49-755f51fe9668@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <dc0ef30b-0c99-7086-7b49-755f51fe9668@linaro.org>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sep 24 2022 10:21, Krzysztof Kozlowski wrote:
> On 24/09/2022 02:36, Guru Das Srinagesh wrote:
> > Update Guru Das Srinagesh's email address.
> > 
> > Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> > ---
> >  Documentation/devicetree/bindings/extcon/qcom,pm8941-misc.yaml | 2 +-
> >  Documentation/devicetree/bindings/mfd/qcom,pm8008.yaml         | 2 +-
> 
> Use subject prefixes matching the subsystem (git log --oneline -- ...).
> Here it should be "dt-bindings". Also describe who's address you are
> updating:
> dt-bindings: Update Guru Das Srinagesh's email address
> 
> With the subject fixed:
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Sorry, I'm aware of these rules and had made these fixes locally but
accidentally sent out this wrong patchset.

Thank you.

Guru Das.
