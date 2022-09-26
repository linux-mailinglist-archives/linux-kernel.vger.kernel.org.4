Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D68C25EB1F8
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 22:17:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiIZURv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 16:17:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230444AbiIZURp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 16:17:45 -0400
Received: from mail-oi1-f178.google.com (mail-oi1-f178.google.com [209.85.167.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 370A3A3D01;
        Mon, 26 Sep 2022 13:17:42 -0700 (PDT)
Received: by mail-oi1-f178.google.com with SMTP id m130so9643819oif.6;
        Mon, 26 Sep 2022 13:17:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=k0AQrlIxbwy7Ubn2EjodtbFUv1BS5TcuY8f1vFpcfW0=;
        b=wg4ch64kxy4+euNu3MZQAOj2BG23+Pi6/rhja9pajNlsQ0bMk0K0CMEFkvzb/+0/Jb
         9WEBQSiN5zp/owZNC2+D4EMx3CjO0+tH8cYz6yCUnH7As+xJvZDH1hEjPR2MAW2D9XGF
         ZMJnDLk43O43nej32VfrpdojpDgrI6ec+0eq1CHOV5mOPd8QFoa3yz+AZNtcr+WeAX2w
         AVl1BkgoZTUX4B9UsgSYYyf1gMGkcX3G52trvf7vP3yfIXJxlgsXDZ3F2oZjGA6o3yMG
         Us96sVYPx9EW7mdZr++mY4FSfGWCzOgVGValihBrQPwM7KhtWWwFi5zKeVKaroYM1AyF
         nygg==
X-Gm-Message-State: ACrzQf19su+Ys6XK2CbAHeVxIpNH7N7NCMNSpHyDYrzucImdiqaiAeNK
        c2nM5y+Z9+POSTZHtshhwD3ALvXG3w==
X-Google-Smtp-Source: AMsMyM5pA5L+VHMfeMDYk+ZJcAO9IUEAmM1zFB24SDJbCswpwoD8hydbwaxwQ0eIbjpjKu9khowpKw==
X-Received: by 2002:a05:6808:120e:b0:345:aeaf:c064 with SMTP id a14-20020a056808120e00b00345aeafc064mr248896oil.70.1664223461410;
        Mon, 26 Sep 2022 13:17:41 -0700 (PDT)
Received: from robh.at.kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id p3-20020a056830318300b00654625c0c4dsm8227545ots.17.2022.09.26.13.17.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Sep 2022 13:17:41 -0700 (PDT)
Received: (nullmailer pid 2732492 invoked by uid 1000);
        Mon, 26 Sep 2022 20:17:40 -0000
Date:   Mon, 26 Sep 2022 15:17:40 -0500
From:   Rob Herring <robh@kernel.org>
To:     Guru Das Srinagesh <quic_gurus@quicinc.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        ~postmarketos/upstreaming@lists.sr.ht, martin.botka@somainline.org,
        angelogioacchino.delregno@somainline.org,
        marijn.suijten@somainline.org, jamipkettunen@somainline.org,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Robert Marko <robimarko@gmail.com>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] dt-bindings: firmware: document Qualcomm SM6375 SCM
Message-ID: <20220926201740.GA2726270-robh@kernel.org>
References: <20220921001020.55307-1-konrad.dybcio@somainline.org>
 <95fb2bfb-6eb8-012d-88f8-c739d229ef70@linaro.org>
 <8faecd72-0cfd-18eb-d07a-53b3a23ed05a@somainline.org>
 <20220924000932.GA1450@quicinc.com>
 <fcc5bc9f-6b6b-b9ca-45aa-ff2c880a4774@linaro.org>
 <20220926165904.GA17938@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220926165904.GA17938@quicinc.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 26, 2022 at 09:59:04AM -0700, Guru Das Srinagesh wrote:
> On Sep 24 2022 10:17, Krzysztof Kozlowski wrote:
> > On 24/09/2022 02:09, Guru Das Srinagesh wrote:
> > > On Sep 21 2022 20:43, Konrad Dybcio wrote:
> > >> Does it? I did not define this compatible in the driver, so it does
> > >> not consume any clocks.
> > > 
> > > The bindings should describe only those compatibles that the driver supports -
> > > that is, both the driver and its bindings should be in sync.
> > 
> > That's not entirely true. Bindings describe the hardware in the most
> > complete way we can. Not the driver. Whether driver supports something
> > or not, is not relevant here, except that we don't want to document
> > non-existing things or stuff out of tree.
> 
> Is this only applicable to compatibles or device tree properties in general?
> 
> > > 
> > > Could you please update the driver with this compatible as well? Let's not
> > > merge this change without that first.
> > 
> > This could be even merged without change in the driver. However it's not
> > the case here as driver already supports it, so your request is fulfilled.
> 
> My concern is that if somebody specifies a compatible/device tree property that
> the driver doesn't support, their expectations from adding that change will not
> be met. In addition to having the bindings describe HW in full, I think the
> driver should also be in sync with it for this reason.

Which driver? From u-boot, *BSD, Linux, TF-A, ...?

Rob
