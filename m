Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E09C6719C10
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 14:26:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbjFAM01 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 08:26:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231759AbjFAM0Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 08:26:25 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [85.215.255.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BD329D;
        Thu,  1 Jun 2023 05:26:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685622380; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=XiG+Vi6gGHQowjb9Bf55mFt3xWEo+WLrPcjZ59s+YmLHF78da17+FBfIctd0IADxwe
    2d5QFc+abGWb6yCVUXWkelWacXu3jdoY38irxUjSsdU2wJsmlKb7AHkz2JolSG+Ov/K1
    1f+teExknD4NzUh5Q3BdknlwxDBv1/qfFbeKNumeNKoICrhIlgZFra6zLXocBIo7KoZk
    VX0Yzydi3Qhus7njRfgDKcSFpRQSjGhZm+6rNJj+kldbXdF8deQDajRHPrp9E9R3eRWR
    3FLB/nPVajRVn/BQ5WqrIieRSF7BKYAloP3/O7FhyhzEeHe1edkKJ8ToOAScvsDqCMZS
    ReFg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685622380;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4nlI0t8cVc1lkSa6LiiU7VWHaD2KWNpreTHmhmut4hU=;
    b=V6RfA2WGKv2qpcqLiAuBj4s/LF5jRgIvir2h1kaHmi/32a3PACXmprmYDwo5GbAqgC
    xNEYj2j9mADfbA1LTolLvyRqWSPdvRLZfTc6VihRiZfGK/r4VZ4fG839oJ0fGm8uUDLY
    3QYH6tyVcBP5gQ0i5vmS3YW7hlYrB9qYlNsPBotUrLxiwhSJldnK5FvcQR5ODlkJOrKa
    Iv2QQfe+FHTC873CwYhf050DVBWzNm5XtASa10LcJGKo+E5eQewj95d22B9SfTgkke/g
    hk6XJi2JWxhSfrmKGdeeer8o3J1HXbmYfpC/LWrIqq8q9PKw7Vwc/SM2iyi0PjQwTmGo
    U5HA==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685622380;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4nlI0t8cVc1lkSa6LiiU7VWHaD2KWNpreTHmhmut4hU=;
    b=iYLH01kMgs6ZDj7J8rFGkkbm/WKj3keNH6pA8doB01oiknePtmcbw0ewNa2eJOk3UM
    7WWrT8HLfgsIeIw8F+VxPPta5PmQa+NgvW1HcVGb/B7kuIreqATN6BZ/X6dkCquYgB1Z
    RAlCbp6kzzPR1DUVkTG1JkX0JzCh9coJpD0GTnkpUFvRwnt2O8H37+cJYQxBKcCE/FVz
    epAbZHQJYHqscbDQPRcZ1E/VHfEFUvI5Dhes9xudYFDW7ctLZcsiraUlDITwxMTxj7Ic
    COPmoZV13XaRCaI5xx0JaGxntDBXJkIAP1gLyojgU06HVrk5pjVbJjX2cC9ACe6HvpF+
    C2Ww==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685622380;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=4nlI0t8cVc1lkSa6LiiU7VWHaD2KWNpreTHmhmut4hU=;
    b=MNsSLRO1kKKD7zWnKTz1vLypyEmOef19RLKMhrf9ruh2rOoYJfjZ1zHZEGt9OmWr6p
    0DafpbOwkx4aZdSzsfAg==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4peA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.4.0 DYNA|AUTH)
    with ESMTPSA id j6420az51CQJquT
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 1 Jun 2023 14:26:19 +0200 (CEST)
Date:   Thu, 1 Jun 2023 14:26:12 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <quic_bjorande@quicinc.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/3] soc: qcom: rmtfs: Support discarding guard pages
Message-ID: <ZHiOZPQYlvxfAAFq@gerhold.net>
References: <20230530233643.4044823-1-quic_bjorande@quicinc.com>
 <20230530233643.4044823-3-quic_bjorande@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530233643.4044823-3-quic_bjorande@quicinc.com>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 04:36:42PM -0700, Bjorn Andersson wrote:
> In some configurations, the exact placement of the rmtfs shared memory
> region isn't so strict. The DeviceTree author can then choose to use the
> "size" property and rely on the OS for placement (in combination with
> "alloc-ranges", if desired).
> 
> But on some platforms the rmtfs memory region may not be allocated
> adjacent to regions allocated by other clients. Add support for
> discarding the first and last 4k block in the region, if
> qcom,use-guard-pages is specified in DeviceTree.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Drop the dma_alloc_coherent() based approach and just add support for
>   the guard pages.
> 
>  drivers/soc/qcom/rmtfs_mem.c | 10 ++++++++++
>  1 file changed, 10 insertions(+)
> 
> diff --git a/drivers/soc/qcom/rmtfs_mem.c b/drivers/soc/qcom/rmtfs_mem.c
> index f83811f51175..28238974d913 100644
> --- a/drivers/soc/qcom/rmtfs_mem.c
> +++ b/drivers/soc/qcom/rmtfs_mem.c
> @@ -213,6 +213,16 @@ static int qcom_rmtfs_mem_probe(struct platform_device *pdev)
>  		goto put_device;
>  	}
>  
> +	/*
> +	 * If requested, discard the first and last 4k block in order to ensure
> +	 * that the rmtfs region isn't adjacent to other protected regions.
> +	 */
> +	if (of_property_present(node, "qcom,use-guard-pages")) {
> +		rmtfs_mem->addr += SZ_4K;
> +		rmtfs_mem->base += SZ_4K;
> +		rmtfs_mem->size -= 2 * SZ_4K;
> +	}

It probably doesn't make a big difference in practice but I would say
there is no need to even memremap() the guard pages. If you adjust the
->addr and ->size before the memremap() then you don't need to modify
the ->base at all.

Thanks,
Stephan
