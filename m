Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7B756F70AC
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:16:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229861AbjEDRQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229970AbjEDRQd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:16:33 -0400
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C69D335A0
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:16:31 -0700 (PDT)
Received: by mail-wm1-x330.google.com with SMTP id 5b1f17b1804b1-3f315712406so72679585e9.0
        for <linux-kernel@vger.kernel.org>; Thu, 04 May 2023 10:16:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683220590; x=1685812590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=o2RAHhaxyXIg8vqIKXQz3LeM9SzAwuVSXKa9rGCQUhg=;
        b=FC9Sq09wan3CTtRshB35e+apWwzPyXyqLx1Z6Jmy43MuTwNCij7HmCtL8JTQCBAwG8
         YeSvP5AlsHY214taapVE+bareqY1qcxH/Pb23AcyrY09fqN8l6Q2SEFaQPCioxw4lUU5
         YtzMr6WM7Q+sjzl+7s2OXw5tfnpUPvChxQvA09AqUpocyIb4yGP4LQCzagwMsL72QpCZ
         z5jw8hqZLeWLC5iQJt0lrFz70+T1fe8RfrFa5BEtbaWpfk+5zgX5zwFSyygaVuzf9FbR
         ofoM/dZdv3PLq/xuLgleAwHmEN8HYGhGL4GcNyn05DUtxl8GNGI2bvADKQGEm7IFNJCk
         M/Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683220590; x=1685812590;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=o2RAHhaxyXIg8vqIKXQz3LeM9SzAwuVSXKa9rGCQUhg=;
        b=ADAhLTJT5hj1QBrjdJry8ohtYtjuyvci07j6SOGtHWAU6XBcbs0D85/a3X9Qs5tSdG
         0MwvuH3BmOlmJagEzMnH01WsFaFLStvyq4VvRz7akz7ZcTmIg/G+YTTicdh2x7yahvEl
         15CtWjFO53nHrewjAO6U0CeCwGnyVRRuTUv1jmIg9pm5P81LOXNxwi3oCpQT6opsZPOf
         +ybP22MXzErBu8Y7k9alBiOvf+DX2Y618sNB2Eko22G+aIcrA8MNq3z4NwsOa7DYe35l
         Xe13kgC/4qa1F248oM3vhP8gC7aKR+LUJ+9vvCTLBHZvzUlkNI+FSeXXKTI6pk72ehlX
         mihA==
X-Gm-Message-State: AC+VfDxY4jm75MbkqKDq0wQA8MdZWgVOE/vJtK8Gd309sl/o8uUqRhEJ
        k02oa7ubr7GecCvx0qMFjk2V4ZBJNzlsy8sb/pdkZQ==
X-Google-Smtp-Source: ACHHUZ7hZ50T/Pwr9w/GflPdscw+9rCulRDegeWiCCmJWCsRX4pJH5oZJaDR9tMlZJxoYuZb6tWW84RIZsYCa7hjlgE=
X-Received: by 2002:adf:f4cf:0:b0:307:5091:5b96 with SMTP id
 h15-20020adff4cf000000b0030750915b96mr1426097wrp.22.1683220590241; Thu, 04
 May 2023 10:16:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230501105832.1185477-1-bhupesh.sharma@linaro.org>
 <20230501105832.1185477-4-bhupesh.sharma@linaro.org> <1aaff58a-f07b-1e2a-e27b-df41eacd19e7@linaro.org>
 <CAA8EJpog9cbB_y4zyeECkXRjOGznEATpztAOYsMx61NgyH3Xqg@mail.gmail.com>
In-Reply-To: <CAA8EJpog9cbB_y4zyeECkXRjOGznEATpztAOYsMx61NgyH3Xqg@mail.gmail.com>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Thu, 4 May 2023 22:46:19 +0530
Message-ID: <CAH=2NtwVtLdE5hg8Qhd_MLCPJTqXvus8+qW_uj4O7hnOy7PVUA@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] arm64: dts: qcom: qrb4210-rb2: Enable aDSP and
 cDSP remoteproc nodes
To:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, agross@kernel.org,
        andersson@kernel.org, linux-kernel@vger.kernel.org,
        bhupesh.linux@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski@linaro.org, devicetree@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 2 May 2023 at 17:53, Dmitry Baryshkov
<dmitry.baryshkov@linaro.org> wrote:
>
> On Tue, 2 May 2023 at 14:58, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >
> > On 1.05.2023 12:58, Bhupesh Sharma wrote:
> > > Enable the aDSP and cDSP remoteproc nodes on Qualcomm QRB4210 RB2 board.
> > >
> > > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > > ---
> > >  arch/arm64/boot/dts/qcom/qrb4210-rb2.dts | 10 ++++++++++
> > >  1 file changed, 10 insertions(+)
> > >
> > > diff --git a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > > index bff6ba1d689f..3ab46499d3fa 100644
> > > --- a/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > > +++ b/arch/arm64/boot/dts/qcom/qrb4210-rb2.dts
> > > @@ -34,6 +34,16 @@ &qupv3_id_0 {
> > >       status = "okay";
> > >  };
> > >
> > > +&remoteproc_adsp {
> > > +     status = "okay";
> > > +     firmware-name = "qcom/sm6115/adsp.mdt";
> > status last
> > also, don't we want to use .mbn (squashed binary)?
>
> Yes, please. Also, just to make sure, are sm6115 and qrb4210 binaries
> fully compatible? We already have a mess of sdm845 vs sda845.

That's a fair point. Let's use qrb4210 naming instead of sm6115 here.
I will send a fixed version shortly.

Thanks,
Bhupesh
