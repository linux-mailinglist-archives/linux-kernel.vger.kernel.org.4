Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 091BA72D156
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 23:02:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238035AbjFLVCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 17:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232987AbjFLVCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 17:02:16 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF9C64C12;
        Mon, 12 Jun 2023 13:58:07 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686603438; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=mdswLClSU2IGCOOFDZ3FmO4di/aHTm8tfsxwS5Gj38DZtvQ1I33aQkwpRn6tbJSvkW
    gUy/fY8rhxjjxGAfRrux7pu+TGlTWLP6iOwpNbQuINK9KzJBwVrRUlcS+cTwjAKMRf/d
    Xl3ON6uSwGdw0GCGZZwDYJ/m4gz/3OavlloLb1l5n+W/tYweGUJHWU59ymz605hd//K1
    v/UwxcMd4gESyL+JupW6tnx0pmk0G3cYwQx1KCw8dgJCKV/h/QsCaFej/GH+WPHJGLbv
    wEQx63YIbcuoggKlQMhZ6jq7BLh2HdkHLzXeL+bIWgf/fp4SfKiTY1BKr3FM2nJyt4ZP
    k5DQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686603438;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ccKcXThFZ2viloJwURIxcRGKIh0oTf5Ui89a6DL/xcA=;
    b=I94V/zfVenEchHjZN072vYqbo4VoCsMNbrGU+OIZCRxc5HepPZ+BOX9bv776M74u93
    XSNviCaas5nA5fX5FmxLkhg/Fb6fdK4VvDZM1xez3NXmlxGZicouvVqkHJl8FU1G0hux
    kT4htC9COTwv8SFIUQPnXH1zoWdLJQg14FwEy0JccUN1FIjE4ho57y9X8FVtpg+NOkis
    GN4IEdDj25KEO+4CVeq1i6gL+J5ieCRSdJKsw1LIP/4Y89Wi8bPJy+r76cPT5JnlCgU3
    Yn6GJC2KfuM9Jes4Q0R4jmpQbTjf5TP2Fx/fPWeeChGwxb8/gHnROMlxDuT5Qqd6CcFe
    s98Q==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686603438;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ccKcXThFZ2viloJwURIxcRGKIh0oTf5Ui89a6DL/xcA=;
    b=p9BinBavDUws48ueB5yDH5/qjdkBT92YC7w6OOJon1B1W3acZrte184I1l2bC/0vtJ
    2R23nQVWGCxA0gejI8BPEcJByMSnWiIDjw7NGxCDpjqeGqTMweLSlsgA1t/iVex+uslD
    FJq5e7G5zAs/Aaj3u6L4cfjQXeCzl/XyULQhxJHiB46MsPTwV5AkLL5+DrijuDNw8vLd
    FY3xFYQzGMR8rF9e3s+/f3hZdyESwQvHiAdOhHLqi0FWp1mfKwEj3Yw5Jua3sk7coFKS
    jM96bkxo/dRsm3AfAMx1YW3M1Mb8YJep7B8VrpWuOItemqVT3T905uxe+FyyliQ82AK5
    UHYw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686603438;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=ccKcXThFZ2viloJwURIxcRGKIh0oTf5Ui89a6DL/xcA=;
    b=zwbgRqnrItS0ZgLkJ2YLcsGperDPLeYMR6/7LQULSnwOnqw3ZHtKwmSB/kUzSjBKMY
    FWHuSMgQcARe+46F9TCQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA8peN1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z5CKvHVzt
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 12 Jun 2023 22:57:17 +0200 (CEST)
Date:   Mon, 12 Jun 2023 22:57:16 +0200
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
Subject: Re: [PATCH v3 20/23] interconnect: qcom: icc-rpm: Fix bucket number
Message-ID: <ZIeGrCj2bk2nVvIc@gerhold.net>
References: <20230526-topic-smd_icc-v3-0-5fb7d39b874f@linaro.org>
 <20230526-topic-smd_icc-v3-20-5fb7d39b874f@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230526-topic-smd_icc-v3-20-5fb7d39b874f@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 08:24:37PM +0200, Konrad Dybcio wrote:
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
> ---
>  drivers/interconnect/qcom/icc-rpm.c | 14 +++++++-------
>  drivers/interconnect/qcom/icc-rpm.h |  4 ++--
>  2 files changed, 9 insertions(+), 9 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 5ffcf5ca8914..54a9999fe55d 100644
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
> @@ -275,7 +275,7 @@ static int qcom_icc_bw_aggregate(struct icc_node *node, u32 tag, u32 avg_bw,
>  	if (!tag)
>  		tag = QCOM_ICC_TAG_ALWAYS;

We should replace this with the RPM variant. Also, can you check which
header/file still includes qcom,icc.h? Don't think we should have it
included at all for RPM so that referencing the wrong things cannot
happen.

Thanks,
Stephan
