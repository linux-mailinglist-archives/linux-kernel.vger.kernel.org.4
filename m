Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37E0072EC76
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 22:07:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239858AbjFMUG4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 16:06:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230221AbjFMUGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 16:06:53 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F1B219BC;
        Tue, 13 Jun 2023 13:06:50 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686686808; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=QxTdA3BzhGQuM0qVgRVwC7yUFv/1id8vddIYtVZTKGnP3PzP2SLbPjqOJj3pSN6kyh
    LiekXcmzqO1u3J3Pa5IgvOMPG78ZmRjqWyGTOM1RV8a7OTYaDUtCzn1/Mq9bzaE1lzlo
    c2XkMT/rB6vYk4vh1SiZ3XULiHEGDZat3RK9de5bol+IRVkZr+qHIZSgMLteiBpmebMr
    ckEWi+zawLa+CW9DXn/ivN3hSHDB3LrFZa/AV39eLVyNnP+E+Rig+EbngtotC2C7jEji
    k0nHuHNq1PEofNWsaIZMYq9y7Qnd9ZBJ+3z5GEBcAg4Sfy3AsaNF9ZIndjjHrWZR0TIG
    efbw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686686808;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+bxhoNBUVOI9fXppncyoAFkRXpqT+koMG8ktF5EknW8=;
    b=rCojU6iO6etlp7I2q8kCZSkqkgk7rb82LaaifRDBaLseHY9h6H3/+k3c2uIulWauGa
    UPhVVPum5ciVDhymy51iBffiOyF28nZDD51g2PlgKU9Pe8lBpHs3EwBBT3GVtL2joddN
    Oo2dNNxHtC+OHtwpm/02xd3COU3j9vMJDjT3CB7qfyH/2RH7LCzFo7CcsZsYQDvAT4pI
    MC10EZaNcTeytNOmSkVmP6etw1WBnuyWFVm3OyS1BdgxDvVgHSQFE1+JlcvE5SKeh6Oa
    Dk6Ozhstj6+WzgLPEod2hEddcVzMWfwmE3TrFEYtZTshvYs8rOhkQXzgQusU+HxYkzds
    XRLQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686686808;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+bxhoNBUVOI9fXppncyoAFkRXpqT+koMG8ktF5EknW8=;
    b=beATvTm3F2oPmq+/yOkWF9Z3DOzG40KTJNUbxPPC15XYE1XdQwq+gYqoYmav1j08qO
    HUHmyfQfnW1hvOihIxX5Q/xYCE89ohB2bniIZP7mFWgiQaaLdOojn9QXk2szbuxakCMf
    5sM5ZM/rKlOcCL4KStYhjxra/mNEflwVPCysh1g2JRplzFPnUHwF2fnqqA4zlxmkF23y
    t/zMp4jb78oQ+lBzoQvusCEYETkpNuw6dDhuqBCdOTcTnMvnO0WaOyj9Qsrr2lpQ2NEb
    LpfSS56FXjYNPOuf4/qlNy7fBATwa0kQuNvmbDXjJ2f7UtvnCVYi8F0KbszSUxWYf59+
    iLpQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686686808;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=+bxhoNBUVOI9fXppncyoAFkRXpqT+koMG8ktF5EknW8=;
    b=9xbiNAaoA12sknXf6dfTJoFWsRJjg4+ca3wN5by2NbXBQSnOhFzfpxE7TX+ayqG7FK
    RIT3OC3ir57/9pBiszAA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8Z3h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5DK6ma7K
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Tue, 13 Jun 2023 22:06:48 +0200 (CEST)
Date:   Tue, 13 Jun 2023 22:06:40 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>,
        Evan Green <evgreen@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org,
        devicetree@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Subject: Re: [PATCH v4 19/22] interconnect: qcom: icc-rpm: Fix bucket number
Message-ID: <ZIjMUAvt3vEnYtfe@gerhold.net>
References: <20230526-topic-smd_icc-v4-0-5ba82b6fbba2@linaro.org>
 <20230526-topic-smd_icc-v4-19-5ba82b6fbba2@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v4-19-5ba82b6fbba2@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 13, 2023 at 04:03:19PM +0200, Konrad Dybcio wrote:
> SMD RPM only provides two buckets, one each for the active-only and
> active-sleep RPM contexts. Use the correct constant to allocate and
> operate on them.
> 
> This will make the qcom,icc.h header no longer work with this driver,
> mostly because.. it was never meant to! The commit that introduced
> bucket support to SMD RPM was trying to shove a square into a round
> hole and it did not work out very well. That said, there are no
> active users of SMD RPM ICC + qcom,icc.h, so that doesn't hurt.
> 
> Fixes: dcbce7b0a79c ("interconnect: qcom: icc-rpm: Support multiple buckets")
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Reviewed-by: Stephan Gerhold <stephan@gerhold.net>

> ---
>  drivers/interconnect/qcom/icc-rpm.c | 16 ++++++++--------
>  drivers/interconnect/qcom/icc-rpm.h |  6 +++---
>  2 files changed, 11 insertions(+), 11 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index f9d0ecba5631..01e14b8ced64 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -249,7 +249,7 @@ static void qcom_icc_pre_bw_aggregate(struct icc_node *node)
>  	size_t i;
>  
>  	qn = node->data;
> -	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
>  		qn->sum_avg[i] = 0;
>  		qn->max_peak[i] = 0;
>  	}
> @@ -273,9 +273,9 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>  	qn = node->data;
>  
>  	if (!tag)
> -		tag = QCOM_ICC_TAG_ALWAYS;
> +		tag = RPM_ALWAYS_TAG;
>  
> -	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
>  		if (tag & BIT(i)) {
>  			qn->sum_avg[i] += avg_bw;
>  			qn->max_peak[i] = max_t(u32, qn->max_peak[i], peak_bw);
> @@ -300,11 +300,11 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>  {
>  	struct icc_node *node;
>  	struct qcom_icc_node *qn;
> -	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
> +	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
>  	int i;
>  
>  	/* Initialise aggregate values */
> -	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
>  		agg_avg[i] = 0;
>  		agg_peak[i] = 0;
>  	}
> @@ -317,7 +317,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>  	 */
>  	list_for_each_entry(node, &provider->nodes, node_list) {
>  		qn = node->data;
> -		for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++) {
> +		for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++) {
>  			if (qn->channels)
>  				sum_avg[i] = div_u64(qn->sum_avg[i], qn->channels);
>  			else
> @@ -328,7 +328,7 @@ static void qcom_icc_bus_aggregate(struct icc_provider *provider,
>  	}
>  
>  	/* Find maximum values across all buckets */
> -	for (i = 0; i < QCOM_ICC_NUM_BUCKETS; i++)
> +	for (i = 0; i < QCOM_SMD_RPM_STATE_NUM; i++)
>  		*max_agg_avg = max_t(u64, *max_agg_avg, agg_avg[i]);
>  }
>  
> @@ -339,7 +339,7 @@ static int qcom_icc_set(struct icc_node *src, struct icc_node *dst)
>  	struct icc_provider *provider;
>  	u64 sum_bw;
>  	u64 active_rate, sleep_rate;
> -	u64 agg_avg[QCOM_ICC_NUM_BUCKETS], agg_peak[QCOM_ICC_NUM_BUCKETS];
> +	u64 agg_avg[QCOM_SMD_RPM_STATE_NUM], agg_peak[QCOM_SMD_RPM_STATE_NUM];
>  	u64 max_agg_avg;
>  	int ret;
>  
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index a4588a3aebf3..fe928ab6b878 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -10,7 +10,7 @@
>  #include <linux/platform_device.h>
>  #include <linux/soc/qcom/smd-rpm.h>
>  
> -#include <dt-bindings/interconnect/qcom,icc.h>
> +#include <dt-bindings/interconnect/qcom,rpm-icc.h>
>  
>  #define RPM_BUS_MASTER_REQ	0x73616d62
>  #define RPM_BUS_SLAVE_REQ	0x766c7362
> @@ -105,8 +105,8 @@ struct qcom_icc_node {
>  	u16 num_links;
>  	u16 channels;
>  	u16 buswidth;
> -	u64 sum_avg[QCOM_ICC_NUM_BUCKETS];
> -	u64 max_peak[QCOM_ICC_NUM_BUCKETS];
> +	u64 sum_avg[QCOM_SMD_RPM_STATE_NUM];
> +	u64 max_peak[QCOM_SMD_RPM_STATE_NUM];
>  	int mas_rpm_id;
>  	int slv_rpm_id;
>  	struct qcom_icc_qos qos;
> 
> -- 
> 2.41.0
> 
