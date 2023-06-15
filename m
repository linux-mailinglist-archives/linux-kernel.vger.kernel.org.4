Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E33B731BCD
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 16:51:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345120AbjFOOv4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 10:51:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344611AbjFOOvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 10:51:51 -0400
Received: from mo4-p01-ob.smtp.rzone.de (mo4-p01-ob.smtp.rzone.de [81.169.146.166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9D8B295E;
        Thu, 15 Jun 2023 07:51:46 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1686840704; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=N6GxiEyymxz1TV+d5zisAAw0oiwr658WejkyecaQs4iTPF6Kj8u7F+RFHtRhtq82Xf
    y/vyolmE6vHxbq+4qA82rgQ3mjgjIzQ3vLDw8YNZNkgr90omKIgNcU3IPQe4UbYviDbI
    ojE2oJ0YbLgpm0nZjjDRKXZFw1FCEqPjPtUgvSUnR63cGuigRN6YFbNhCLzFTXe7gEO5
    3vjrQ18eqdDPDrqtv0v6XIDX1PhapLgWT+sbNHFfY65uHi5KpLwvgEtbO2d++tJd7ELn
    MHUllF0okPpy6j8Phvl7ZcHvelLz3cbAioTI1l4irlzrxjLCW4AIovUvOdqFeGfKe6lB
    AErQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1686840704;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gLpW9WjP7eHJxT/3fEpjZenyr24jFwjCkA2uIbJvOSs=;
    b=fvT/yZNo44X3GJgPoHi7TUScfv1GOkjLudfCCDRXVRGtWU87Xu/uGfgJG7+5vsmZGX
    m4dAghn1yV859vk3PVu0haznhcAsp3jAM+cwtZY8zVj6IFJU+oAgpncDE269dVLygyFk
    kMLUKWCQB2B03TQI16kglQ2dIz96iYD+Ntpma8OLGLxBWlvu4DC5CY3+5Myh/EWFUzXd
    p2hISvQ8GP+KlYXTS587LdKFkiJ8qCax2JhZcpGFHmhmUZWaM+w+DLmC5nXzJF3bLIqk
    606JE9AU9muGtgSObMZMER6mfk+Jd9Vy83NEra1xgkDr+mqwnPEmhVa96Fy6vxBg8KD4
    kkwg==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo01
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1686840704;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gLpW9WjP7eHJxT/3fEpjZenyr24jFwjCkA2uIbJvOSs=;
    b=pgDeBDaUOHm0vH9Z+lc7iZ6SPnTAK2SQCxz+YDGHy6Awj19ZT4SC4MA+ZgJfSTZ8Hw
    2GaDjDU2KEjcVwhT8OTvAvTmoIFSjYKUb1Yk6b2g8bdJCafOD8nVIzdtEeLfj/dY+dET
    5vVINcom6njcXh5VJLUoMCD7DOCg6epOemJzjhrhXDIOr2CBfD/WS/42H+oXhzcKPjdZ
    xO9svwEKJmRCcgp/T6A5ludvPPB0IPiEPZHLRq8vFdj0mDHUCDotN7mZJ8zEnQDC/jAa
    Lkcbhw6FdhNiY43TcHpL34fqdHSRig5OqNDoncxnRc8OH9Os6BcceV8uMwTIQ4yjRJmv
    qAKA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1686840704;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=gLpW9WjP7eHJxT/3fEpjZenyr24jFwjCkA2uIbJvOSs=;
    b=03ndG5zoqyP8MSS8kTCNtTPpaH8zYcb8CnmQafErqjJkobjrsNUa6Ar8BYNixkLnRc
    ShD6NJXFytCL0+bz0XBA==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA9J/h"
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.6.0 DYNA|AUTH)
    with ESMTPSA id D0d0a8z5FEpi3nw
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Thu, 15 Jun 2023 16:51:44 +0200 (CEST)
Date:   Thu, 15 Jun 2023 16:51:35 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Bjorn Andersson <andersson@kernel.org>,
        Caleb Connolly <caleb.connolly@linaro.org>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/2] remoteproc: qcom: Handle reserved-memory
 allocation issues
Message-ID: <ZIsld-MAdkKvdzTx@gerhold.net>
References: <20230529-rproc-of-rmem-v2-0-95e39b959585@gerhold.net>
 <20230529-rproc-of-rmem-v2-1-95e39b959585@gerhold.net>
 <c3f59fb4-4dd8-f27a-d3f5-b1870006a75c@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c3f59fb4-4dd8-f27a-d3f5-b1870006a75c@linaro.org>
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 15, 2023 at 11:44:06AM +0100, Caleb Connolly wrote:
> On 6/14/23 17:31, Stephan Gerhold wrote:
> > If Linux fails to allocate the dynamic reserved memory specified in the
> > device tree, the size of the reserved_mem will be 0. Add a check for
> > this to avoid using an invalid reservation.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> 
> Other uses of of_reserved_mem_lookup() also have unchecked uses of rmem [1],
> or check different things [2].
> 
> Does it make sense to put this check in the function itself?
> 
> I can't think of any obvious scenarios where it makes sense to differentiate
> between rmem being NULL vs having a size of zero at the time where a driver
> is fetching it.
> 
> As Bjorn described in the rmtfs patch, the memory allocation is essentially
> ignored, wouldn't it be better to print an error and invalidate the rmem in
> [3]?
> 

"Invalidating" isn't that easy because the reserved_mem is currently
stored in a simple array. Removing an entry would require shifting all
following values. But I suppose it would be easy to add the rmem->size
!= 0 check in of_reserved_mem_lookup() so it doesn't have to be checked
on all usages.

Given that no one seems to check for this at the moment I'm inclined to
agree with you that it would be better to handle this directly in
of_reserved_mem. Bjorn, what do you think?

Thanks,
Stephan

> [1]: https://elixir.bootlin.com/linux/v6.4-rc6/source/drivers/net/ethernet/mediatek/mtk_wed.c#L818
> [2]: https://elixir.bootlin.com/linux/v6.4-rc6/source/drivers/remoteproc/rcar_rproc.c#L71
> [3]: https://elixir.bootlin.com/linux/v6.4-rc6/source/drivers/of/of_reserved_mem.c#L276
> 
> // Caleb (they/them)
> > ---
> > New patch in v2, I wasn't aware of this until Bjorn posted a similar
> > patch for rmtfs:
> > https://lore.kernel.org/linux-arm-msm/20230530233643.4044823-4-quic_bjorande@quicinc.com/
> > ---
> >   drivers/remoteproc/qcom_q6v5_mss.c  | 2 +-
> >   drivers/remoteproc/qcom_q6v5_wcss.c | 2 +-
> >   2 files changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> > index 70bffc9f33f6..a35ab6e860f3 100644
> > --- a/drivers/remoteproc/qcom_q6v5_mss.c
> > +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> > @@ -1932,7 +1932,7 @@ static int q6v5_alloc_memory_region(struct q6v5 *qproc)
> >   		return 0;
> >   	rmem = of_reserved_mem_lookup(node);
> > -	if (!rmem) {
> > +	if (!rmem || !rmem->size) {
> >   		dev_err(qproc->dev, "unable to resolve metadata region\n");
> >   		return -EINVAL;
> >   	}
> > diff --git a/drivers/remoteproc/qcom_q6v5_wcss.c b/drivers/remoteproc/qcom_q6v5_wcss.c
> > index b437044aa126..9edab9d60c21 100644
> > --- a/drivers/remoteproc/qcom_q6v5_wcss.c
> > +++ b/drivers/remoteproc/qcom_q6v5_wcss.c
> > @@ -882,7 +882,7 @@ static int q6v5_alloc_memory_region(struct q6v5_wcss *wcss)
> >   		rmem = of_reserved_mem_lookup(node);
> >   	of_node_put(node);
> > -	if (!rmem) {
> > +	if (!rmem || !rmem->size) {
> >   		dev_err(dev, "unable to acquire memory-region\n");
> >   		return -EINVAL;
> >   	}
> > 
