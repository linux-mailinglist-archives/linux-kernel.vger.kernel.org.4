Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5086B72ADDC
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Jun 2023 19:46:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjFJRqf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Jun 2023 13:46:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229735AbjFJRqd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Jun 2023 13:46:33 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [85.215.255.80])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B39C23592;
        Sat, 10 Jun 2023 10:46:29 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686419187; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=fUeeLWR7YnRTKnToU7natYqSH5ieWF82K2mSOSnL8fjXZELFDMkOSKiJ4s3n49SyG6
    1SS7eoStzQqStrHwvmONYJWxrPn1lU1uv2GmhID27XaCcs52jqJvbdRUpMdCMqNDg4CQ
    pBgE365xVAdpGYk+j3y4UhquddgR2XuREs+4hIICohPe9FJfZfu7fTZkfAbFonZbu59V
    +pTVHMHP61F8tkZx+qLwi+EJtrxbiMeql5vt30uz9Veb5qRBw1A4eG1ZK/ZBhEgytrN4
    SlGC8wkNLfegvUzVNempFXXStCy5kn7hx3NbQ8Kkl34hwhPDOfnr9Wi8+QdghIQu234S
    iCvw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686419187;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oH0BizfUqIgRQXEwNc0Sz7uUUantI/rz95IfbtW4CCY=;
    b=UIwEkX4rbnQ5XOMvX0lnTQL/b3Q5pqNx2rD/SirWP1DImDNkCSq/Tv3h48dFoqDhpZ
    josn0KbeJmYkTvzzyBXu5VoG1w+H2Yp0jvxFiceUopx6Gz74Z9R+GC20OpQUEmNYMQUi
    NgUqAK7+hRGnWCETi4DlPlUUryaJIY+3M1AsbRVJLrByKwLPVJWpR7ZzfESrWHGNXVs+
    QEMzX7U9QZKvR2r6uDSHtCO+DGg1of5ugRSZ+q6/u1qDb1fPAS5rdOgNmboK1U1uclIp
    vBXjvhUPO4pg01fDyBBIwlZ4ftxM7a6gnKrgRO/rnjtLwSg1bkcLCaOrmn6RoajKpXfs
    pphA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686419187;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oH0BizfUqIgRQXEwNc0Sz7uUUantI/rz95IfbtW4CCY=;
    b=D2oa5zsiirWQyzRZHTEJFTfn1CqEbaDAPCT5K08CJUl8TOjpaTOoQbDPjFePBtyiVt
    4lWZZcrB5XNZNM+RsC+R41IyeNEcjJ9BVuiTEiz+6cjEFmKx/V9nhX3bFerhj3br64oy
    +o+UMFWHwmX/l5X3kjv3XwnWWB+ab6wJA4Q5in3rcZaeyTZ0UoyD5gF0Wf7hfTnXaL1V
    Ty3jNFYmC6m8xvpA7LTUyEjqQifxkEcOb3CmiJfOUq8DYY+wNMwi/cJnhqmNAH3plwbv
    P7dlqFtz5IazG+1hsED/n8kcQ3BXmkY/8ZvaYVqyusUDhSWbuUgKvr3gYSg/AyoQDOCu
    u5UA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686419187;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=oH0BizfUqIgRQXEwNc0Sz7uUUantI/rz95IfbtW4CCY=;
    b=PoK9ULrn+np78Qiop0zEDKZxLPrXA9MXDJt2WZU4q51xlOU64hOd0Vs2a8745WEfc4
    D7uLdwko/+ontrwAYjCg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5AHkRQaE
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Sat, 10 Jun 2023 19:46:27 +0200 (CEST)
Date:   Sat, 10 Jun 2023 19:46:25 +0200
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
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v2 19/22] interconnect: qcom: icc-rpm: Fix bucket number
Message-ID: <ZIS28eN1JEuXV2AT@gerhold.net>
References: <20230526-topic-smd_icc-v2-0-e5934b07d813@linaro.org>
 <20230526-topic-smd_icc-v2-19-e5934b07d813@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v2-19-e5934b07d813@linaro.org>
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

On Fri, Jun 09, 2023 at 10:19:24PM +0200, Konrad Dybcio wrote:
> SMD RPM only provides two buckets, one each for the active-only and
> active-sleep RPM contexts. Use the correct constant to allocate and
> operate on them.
> 
> Fixes: dcbce7b0a79c ("interconnect: qcom: icc-rpm: Support multiple buckets")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
>  1 file changed, 7 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 6d40815c5401..3ac47b818afe 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> [...]
> @@ -275,7 +275,7 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>  	if (!tag)
>  		tag = QCOM_ICC_TAG_ALWAYS;
>  
> -	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
>  		if (tag & BIT(i)) {

Hm, I think QCOM_ICC_NUM_BUCKETS is actually intentional here. There is
a hint about this in the description of the commit in your Fixes line:

> This patch studies the implementation from interconnect rpmh driver to
> support multiple buckets.  The rpmh driver provides three buckets for
> AMC, WAKE, and SLEEP; this driver only needs to use WAKE and SLEEP
> buckets, but we keep the same way with rpmh driver, this can allow us
> to reuse the DT binding and avoid to define duplicated data structures.

As far as I understand, the idea was to reuse the definitions in
qcom,icc.h and just ignore the AMC bucket for now. AFAIU AMC (or rather
the lack thereof) is basically caching: Sending requests without AMC bit
set is delayed until the next rpmh_flush() call that happens when
entering a deep idle state. It requires some work but I guess
theoretically one could implement exactly the same for RPM.

What you're actually doing here is not fixing the commit but changing
the bindings. On MSM8909 I defined the ICC path for CPU<->RAM like this:

	interconnects = <&bimc MAS_APPS_PROC QCOM_ICC_TAG_ACTIVE_ONLY
			 &bimc SLV_EBI QCOM_ICC_TAG_ACTIVE_ONLY>;

Per definition in qcom,icc.h:

	QCOM_ICC_TAG_ACTIVE_ONLY = (AMC | WAKE) = (BIT(0) | BIT(1))

Without your patch series this behaves correctly. It results in an
active-only vote.

The change of behavior is in PATCH 17/22 "interconnect: qcom: icc-rpm:
Control bus rpmcc from icc". It silently switches from
QCOM_ICC_BUCKET_WAKE (1) and QCOM_ICC_BUCKET_SLEEP (2) to
QCOM_SMD_RPM_ACTIVE_STATE (0) and QCOM_SMD_RPM_SLEEP_STATE (1).

In other words, QCOM_ICC_TAG_ACTIVE_ONLY (BIT(0) | BIT(1)) now results
in an active+sleep vote, not an active-only one. :)

There doesn't seem to be an upstream user of the ICC tags/buckets for
icc-rpm yet so personally I would be fine with changing it. However,
then qcom,icc.h should get a clear comment that it's rpmh-only and we
should define a new qcom,icc-rpm.h.

Or perhaps we should just drop this patch and continue using
QCOM_ICC_BUCKET_WAKE and QCOM_ICC_BUCKET_SLEEP as before?

Thanks,
Stephan
