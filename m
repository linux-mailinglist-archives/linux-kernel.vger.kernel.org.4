Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 861F2722FB8
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 21:21:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235669AbjFETVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 15:21:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235689AbjFETVW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 15:21:22 -0400
Received: from mo4-p02-ob.smtp.rzone.de (mo4-p02-ob.smtp.rzone.de [81.169.146.170])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00468127;
        Mon,  5 Jun 2023 12:21:13 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1685992688; cv=none;
    d=strato.com; s=strato-dkim-0002;
    b=KpZaH3G5VeHecBV0b5jJ1EmTd13VdsdZXsmN7ErZB/x5W7EPOTKyinFfB2nk3LQuSV
    xrmcC0GgEOe+wW54iqW3Ty4Yf1uVdya1nvW//Ds6latbCyf7wZ+p8O68OdlATr5EcpI5
    AgD4LruF0xIxI3TRMnYbTVc+nAeamm0HO57v2s+KAMYBudhRLIHni2TA5CLXoBeG1JB0
    gzITxTiD5Ie3y/B8rk2fLQO9qb2FBQ0wk1jL6L3r6qZytEZqvp0SFT22/0oZ3fP3pOyK
    K7Nx8kdQW9kanwhUbeXSKFl3oPG/TwLlSqmPWDsWGihFv2LCeWGLqwJI4oBaQyK/MWi0
    cvdg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; t=1685992688;
    s=strato-dkim-0002; d=strato.com;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nwUZOE4ivaFUd1EhPNuWsSDQJ499AupgZ2LyVSZEuns=;
    b=bs3u2o29hMxiKPrUGh7vRtYDzkDkCllvLgcL0Ky6doepstCFzIwv2kzfCYxa4fyeRe
    GVhvXX0X0Ze4dT3krFi73SO1a958aFzxEWHP6WkHaDFSpjx/GFE0TAzv8NAQjnGzAfrv
    FD5ntoAb9TioUrk44ngVDalqP4fs5DTJzJ8YTmv8Qju7Msxh0Wd1cJWlUPibiQaZmcCe
    GF7ry0043toGiQ+LHJ6YXW7QNlLdOLb+1W0MShQPtoDNa+B4p1+z5zxA5cE37y8MrAFZ
    ES+l+2SlLMWxZoku3Hh5yVioZ+7qpVrnBJRAMuOdaO3uJgf4EPWnQr4s7hQmVWQKS92c
    9EYQ==
ARC-Authentication-Results: i=1; strato.com;
    arc=none;
    dkim=none
X-RZG-CLASS-ID: mo02
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; t=1685992688;
    s=strato-dkim-0002; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nwUZOE4ivaFUd1EhPNuWsSDQJ499AupgZ2LyVSZEuns=;
    b=DZHWisTGOO/EEJwVBCMmJ3hkE4vFQiujPVoWol2njjfGa5W69V1DJdl4qYzgDWaiaG
    I4P+TxYpfzKIvo4NbJ9dTPeewGSBUnoe9Hlj/tde7TjQmVnM+LNQs1KZ7sRZSIA5Rnvv
    t3JLXUO2NrPPfgPOX0u8EraTYrkRkp+dNwXK2PncLQwC1zDZyJK9AePvUgSraITRigd/
    gEcyJcFdgtaWdlMPf8uPcnOrQDENhML6FgQ7pK0HzQW+8eilxAk8ZifKBgY7v40a0FiE
    JZDPZuaNksONMVJIcRsm0lImP+xQqvT0L8/7yMuv0jUqU8WtbqHTkTlXCXHcvfiX6suW
    OdXg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; t=1685992688;
    s=strato-dkim-0003; d=gerhold.net;
    h=In-Reply-To:References:Message-ID:Subject:Cc:To:From:Date:Cc:Date:
    From:Subject:Sender;
    bh=nwUZOE4ivaFUd1EhPNuWsSDQJ499AupgZ2LyVSZEuns=;
    b=3tI4pC3TpPXOUDplXAjCFodcAxe0byBa5z+OaNnNT34CGLZIHtR/KRNzePoJewJ7Wm
    Xjl6jbPfYpOu6j+2WEBQ==
X-RZG-AUTH: ":P3gBZUipdd93FF5ZZvYFPugejmSTVR2nRPhVOQ/OcYgojyw4j34+u261EJF5OxJD4paA8Z+J1A=="
Received: from gerhold.net
    by smtp.strato.de (RZmta 49.5.3 DYNA|AUTH)
    with ESMTPSA id Z82ec2z55JI8Bgj
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256 bits))
        (Client did not present a certificate);
    Mon, 5 Jun 2023 21:18:08 +0200 (CEST)
Date:   Mon, 5 Jun 2023 21:18:07 +0200
From:   Stephan Gerhold <stephan@gerhold.net>
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-remoteproc@vger.kernel.org
Subject: Re: [PATCH 09/14] rpmsg: qcom_smd: Use qcom_smem_is_available()
Message-ID: <ZH407yP8RQmTlQtf@gerhold.net>
References: <20230531-rpm-rproc-v1-0-e0a3b6de1f14@gerhold.net>
 <20230531-rpm-rproc-v1-9-e0a3b6de1f14@gerhold.net>
 <0f48649e-27d6-97f7-98b8-fe10b99d0236@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0f48649e-27d6-97f7-98b8-fe10b99d0236@linaro.org>
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

On Mon, Jun 05, 2023 at 08:56:44PM +0200, Konrad Dybcio wrote:
> 
> 
> On 5.06.2023 09:08, Stephan Gerhold wrote:
> > Rather than looking up a dummy item from SMEM, use the new
> > qcom_smem_is_available() function to make the code more clear
> > (and reduce the overhead slightly).
> > 
> > Add the same check to qcom_smd_register_edge() as well to ensure that
> > it only succeeds if SMEM is already available - if a driver calls the
> > function and SMEM is not available yet then the initial state will be
> > read incorrectly and the RPMSG devices might never become available.
> > 
> > Signed-off-by: Stephan Gerhold <stephan@gerhold.net>
> > ---
> >  drivers/rpmsg/qcom_smd.c | 10 +++++-----
> >  1 file changed, 5 insertions(+), 5 deletions(-)
> > 
> > diff --git a/drivers/rpmsg/qcom_smd.c b/drivers/rpmsg/qcom_smd.c
> > index 7b9c298aa491..43f601c84b4f 100644
> > --- a/drivers/rpmsg/qcom_smd.c
> > +++ b/drivers/rpmsg/qcom_smd.c
> > @@ -1479,6 +1479,9 @@ struct qcom_smd_edge *qcom_smd_register_edge(struct device *parent,
> >  	struct qcom_smd_edge *edge;
> >  	int ret;
> >  
> > +	if (!qcom_smem_is_available())
> > +		return ERR_PTR(-EPROBE_DEFER);
> > +
> >  	edge = kzalloc(sizeof(*edge), GFP_KERNEL);
> >  	if (!edge)
> >  		return ERR_PTR(-ENOMEM);
> > @@ -1553,12 +1556,9 @@ EXPORT_SYMBOL(qcom_smd_unregister_edge);
> >  static int qcom_smd_probe(struct platform_device *pdev)
> >  {
> >  	struct device_node *node;
> > -	void *p;
> >  
> > -	/* Wait for smem */
> > -	p = qcom_smem_get(QCOM_SMEM_HOST_ANY, smem_items[0].alloc_tbl_id, NULL);
> > -	if (PTR_ERR(p) == -EPROBE_DEFER)
> > -		return PTR_ERR(p);
> > +	if (!qcom_smem_is_available())
> > +		return -EPROBE_DEFER;
> >  
> >  	for_each_available_child_of_node(pdev->dev.of_node, node)
> >  		qcom_smd_register_edge(&pdev->dev, node);
> Hm.. we're not checking the return value here, at all.. Perhaps that
> could be improved and we could only check for smem presence inside
> qcom_smd_register_edge()?
> 

I think the goal here it to register as many of the edges as possible,
so we wouldn't necessarily want to abort if one of them fails. That's
why it's enough to check for only for a possible -EPROBE_DEFER first.

But more importantly after this series this is legacy code that exists
only for backwards compatibility with older DTBs. The probe function
won't be called for DTBs in mainline anymore. So I think it's not worth
to improve it much anymore. ;)

Thanks,
Stephan
