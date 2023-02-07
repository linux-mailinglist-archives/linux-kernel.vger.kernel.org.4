Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E0D68DCEB
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 16:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231821AbjBGPYW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 10:24:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbjBGPYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 10:24:20 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 248E711D;
        Tue,  7 Feb 2023 07:24:19 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B3C8B60E87;
        Tue,  7 Feb 2023 15:24:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 07B9DC433D2;
        Tue,  7 Feb 2023 15:24:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1675783458;
        bh=ryvnmyTVD0opUc4DjrEl6f3pgUv/hzePaZ3/59RkEKQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=pUDdomIahlSdTMDN+sGGYnboaJCDE3SClnRrVGn8tKIhvBXFubGJvxQdeFhktFVuu
         TuMS/g5j0SqEPtZjeefzK9lxRDoQyX5sKAi++AcR8d0MSy6zzA7nc1lpQx7ZE+Tzzh
         szhUYd58s+9RSxL/PzE7B+iJO9dWWMqnAS8z6o3EHlegCpscHsDDJj1PWQZxl0ROIQ
         mRwt07OJshXC3yVHS+qcaSjWMl1Lw8OneJa60F1TZgB0qoXmueltsrzyQMvKI8P8Ck
         hc5OFHNYTxio7YZJpMPFiw47euIX2/HY8Jvvj5ut9P5FrBxix+Cize86k/YVIYSi2P
         dXpUl7Eskha9w==
Received: from johan by xi.lan with local (Exim 4.94.2)
        (envelope-from <johan@kernel.org>)
        id 1pPPpz-00029h-FJ; Tue, 07 Feb 2023 16:24:51 +0100
Date:   Tue, 7 Feb 2023 16:24:51 +0100
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
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [PATCH v2 16/22] dt-bindings: rtc: qcom-pm8xxx: add nvmem-cell
 offset
Message-ID: <Y+JtQ26xEU70KxkC@hovoldconsulting.com>
References: <20230202155448.6715-1-johan+linaro@kernel.org>
 <20230202155448.6715-17-johan+linaro@kernel.org>
 <d9cfbdfe-5068-f826-dc37-252ef165589f@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d9cfbdfe-5068-f826-dc37-252ef165589f@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 06, 2023 at 07:16:37PM -0800, David Collins wrote:
> On 2/2/23 07:54, Johan Hovold wrote:
> > On many Qualcomm platforms the PMIC RTC control and time registers are
> > read-only so that the RTC time can not be updated. Instead an offset
> 
> s/can not/cannot/

As far as I can tell, 'can not' is still correct even if it's less
commonly used this way compared to 'cannot'.

> > needs be stored in some machine-specific non-volatile memory, which a
> > driver can take into account.
> > 
> > Add an 'offset' nvmem cell which can be used to store a 32-bit offset
> > from the Unix epoch so that the RTC time can be updated on such
> > platforms.
> > 
> > Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> > Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> > ---
> >  .../devicetree/bindings/rtc/qcom-pm8xxx-rtc.yaml     | 12 ++++++++++++
> >  1 file changed, 12 insertions(+)
> 
> Assuming that the minor commit text comment above is addressed:

I'm definitely not resending because of this, but I'll keep it in mind
for future patches. Thanks.

> Reviewed-by: David Collins <quic_collinsd@quicinc.com>

Johan
