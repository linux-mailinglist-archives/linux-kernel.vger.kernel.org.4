Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8C672AE2A
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 20:46:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231895AbjFJSqz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 14:46:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbjFJSqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 14:46:53 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B1A897;
        Sat, 10 Jun 2023 11:46:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686422809; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=WjYJDbrFhDkMFN2za0w+7PgNJveNq3jRUXikUZtmavUOwBgLvteBmOm3PgOtpscSiS
    a44B19fVi0AxvsReTZA1UR6UEzsQFMqavCbXKCVH/tOPZ7cnq82Ff4tJVUJJ+OTyco1f
    8m0NtSrQYzyw+tmbcD1beI8GF1lCP2xT1jdEOtHPx35ZzSfpfiXXDSZgwRXYcPqI4AfP
    0B2EPIasDbhMCACC5d6xCM2ElomRv6Z5vNjEAUgTBOFcmrmgg2w7OATpTtiC0kdfBJ0Q
    qQYMoFtt2KCwbZqwjBzzqIk/gdZAM0kcgXV852QUgf66xx1MFU97JozZ2O3KX42GzZUG
    GvIA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686422809;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2AMUFn5IX9GLq5SNm5QSRFrW03jC6ZjkIrT0mD6MVFU=;
    b=grccgoJP1TjGb7cs1tTzaBpBashUz2kRUtM4hZFlUW8Ff9fNvIHJqqnwk/SEL3mM+z
    k8D0XhOhmX5Z7LuT5cmtjT+Gai2kOLwV0RFTqdnVDCI1tvzPNi8++qUq3Hu2RWJrt9mg
    WwuiBnWWNp2dlYXko3vhBY76fsQXZKy5P0WExvQSyKUBDp4mtY8SowU5T/BTnLMUKeKg
    QaE/QGMEzhzdyV9DPC7IGohtv2YTG+XO6G2qnTg7IVRR+eRPz7KxFqM6vmzUMmXFfZTH
    7HNyRZJQzXSsHDt0VX7nz2KJlqH/rUcU4fjrJ1LoQ6W5O1njhYm40L01Ig2Scdv6E2jA
    +pTA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686422809;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2AMUFn5IX9GLq5SNm5QSRFrW03jC6ZjkIrT0mD6MVFU=;
    b=L28LVUoSkh4RXyjl6el18WUPRV1/UvsfPrFXruSqWBrtazCy2DL39Va1AcQEMTSRhF
    jmr10tw/uKH5BkVYtMLGOmM/j48+LKQnccnEmIYxD5hQLfJLdoHvB6atY/cY/Xuv2Tms
    LS0qjuuVQTOXX0gAwPs6lRLMZo+p13bxVHrLzEosqvtbg4gPqdF4oKxHOYNTueMebvz+
    EhzOsk8FtnkP/mkNKmRxQIddnkDVMnkp2ytdsVEkc75yvRLeUFo78Iq+2+UO9IS5QBrZ
    s19CEdo3gR7mMR1ITSFxfi068czp4gPWUliJtrVrfs+i0rVPZV1USNPXZJXUFoBPhQnz
    DlMQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686422809;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=2AMUFn5IX9GLq5SNm5QSRFrW03jC6ZjkIrT0mD6MVFU=;
    b=RqE8gVA56qsbr8bzmE3PbZL1qIrw6G7I1lKc1uX3vyzvfii7FZ0z3VWhhzkhqRAl/E
    iRTVhE0mL5z4loPQvRAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5AIkmQdF
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 20:46:48 +0200 (CEST)
Date:   Sat, 10 Jun 2023 20:46:47 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v2 21/22] interconnect: qcom: icc-rpm: Set correct
 bandwidth through RPM bw req
Message-ID: <ZITFF9Jn3Ko1qAHs@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-21-e5934b07d813@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v2-21-e5934b07d813@linaro.org>
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

On Fri, Jun 09, 2023 at 10:19:26PM +0200, Konrad Dybcio wrote:
> Currently, we're setting the aggregated-on-provider bandwidth on each
> node, individually. That is of course incorrect and results in far too
> high votes. Use the correct values to ensure we're not wasting power.
> 
> Fixes: 30c8fa3ec61a ("interconnect: qcom: Add MSM8916 interconnect provider driver")
> Reported-by: Stephan Gerhold <stephan@gerhold.net>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/interconnect/qcom/icc-rpm.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index ac719013077e..1508233632f6 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -355,12 +355,12 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  
>  	qcom_icc_bus_aggregate(provider, agg_avg, agg_peak, &max_agg_avg);
>  
> -	ret = qcom_icc_rpm_set(src_qn, agg_avg);
> +	ret = qcom_icc_rpm_set(src_qn, src_qn->sum_avg);
>  	if (ret)
>  		return ret;
>  
>  	if (dst_qn) {
> -		ret = qcom_icc_rpm_set(dst_qn, agg_avg);
> +		ret = qcom_icc_rpm_set(dst_qn, dst_qn->sum_avg);
>  		if (ret)
>  			return ret;
>  	}
> 
> -- 
> 2.41.0
> 
