Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77DDC63DB8F
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Nov 2022 18:06:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbiK3RGz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Nov 2022 12:06:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231201AbiK3RGg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Nov 2022 12:06:36 -0500
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 962F084DEF
        for <linux-kernel@vger.kernel.org>; Wed, 30 Nov 2022 09:00:46 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id 74E2B5C01A8;
        Wed, 30 Nov 2022 12:00:42 -0500 (EST)
Received: from imap47 ([10.202.2.97])
  by compute5.internal (MEProxy); Wed, 30 Nov 2022 12:00:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-type:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1669827642; x=1669914042; bh=4B
        IHbe0ZunOdNysyDyAs7e5Nl+Er7gjdTx5kTJsmAhI=; b=kTkEYFOT+51YmyRr0W
        uuK26cq30w6gHYKYqmkGMZvmx4fuLSonon5+GqInSAUimAxZiJszRaCiRONhZDDf
        F+gIj2ARDA7IM+2Y/gnRiEDoHLODeuAe8DknFOIZUcuNWyUnbkhHlgeFdihZDx96
        mrwLCLCzTUFBxE3kqX3X4XzRP6LNORgCJ+G0U/lS0ydmf15qQgO/5i8Xdq8xZcx6
        6fo9DxmgRqJa4WUa4wwbzQNXsC6UlekNeT3pCTHcv8PigCjShg6HTwCZDO2lEodS
        NaKY425J4K5vIcFpDAEvF2N/nair14lFUOoMYaczvEyJzbt+k+OJ0AClBZ4Q9B+D
        Pikg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-type:date:date:feedback-id
        :feedback-id:from:from:in-reply-to:in-reply-to:message-id
        :mime-version:references:reply-to:sender:subject:subject:to:to
        :x-me-proxy:x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=
        fm1; t=1669827642; x=1669914042; bh=4BIHbe0ZunOdNysyDyAs7e5Nl+Er
        7gjdTx5kTJsmAhI=; b=VgMqYh0iq/eR0MZQ8k1vOF8o6LYji5VADjuivBY0Czbz
        xtmFdALzod1Ahq3I4cZr/tEFcq0jBJUuU3YvcuesPVR8wwLH0MLWsZQi07D1TwjB
        LOpbFupr5MQN8Na+2Hg+OK2POCVNNPElJt4MwcaovbcVLljULl2ztBcJ4PtAZ1cU
        NhfObtmqnv3ma7ciRL10ANbdCqk0KHc/kStMOzFjKJUH+AS4jW8y2w5d3BzbtpEd
        YOyF93I1SLYDJUTjGk7H7GNw4Gk+ePwo7rLPwmkm8Tv3sugcXlLcq465OXrDbqYm
        1c/xrCBGDe3x+bhaC8gKZAs/73n3lpyewqcJnb/sEw==
X-ME-Sender: <xms:N4yHY3tixQNB3iFPS4e5K1BH1v728NttXlOoL2lBcw3eXKLNkVo1Kg>
    <xme:N4yHY4eM36wXkPloIBtUUuh2vuhBSrSIRAsA1TMmdPsBjWuGggqOQ8gPSVJ6vnAJN
    plaENKVo1HzFlPbwh4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrtdefgdelfecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefofgggkfgjfhffhffvvefutgesthdtredtreertdenucfhrhhomhepfdfuvhgv
    nhcurfgvthgvrhdfuceoshhvvghnsehsvhgvnhhpvghtvghrrdguvghvqeenucggtffrrg
    htthgvrhhnpeelvefggeffheevtdeivefhkeehfeettdejteduveeiheevveeilefghfei
    veeiueenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsvhgvnhesshhvvghnphgvthgvrhdruggvvh
X-ME-Proxy: <xmx:N4yHY6x3RAmP9g8RrBnv1U6oVg3XkWGN82LdOwaP5n0bUF8C-P3NJw>
    <xmx:N4yHY2PoHjUeoadpQubo2faQp9jd80TPEIActvaztn4kexK8c2Knpw>
    <xmx:N4yHY3-oebQVHhwvJcsdARTAtvF8_6oaks8tK24WKPZxRDsyyMTxew>
    <xmx:OoyHY_9LYDfysdzs3fyDJPopEdNFr3SFlRS3H7dCjoKJRwPutUfzwg>
Feedback-ID: i51094778:Fastmail
Received: by mailuser.nyi.internal (Postfix, from userid 501)
        id 578D4A6007C; Wed, 30 Nov 2022 12:00:39 -0500 (EST)
X-Mailer: MessagingEngine.com Webmail Interface
User-Agent: Cyrus-JMAP/3.7.0-alpha0-1115-g8b801eadce-fm-20221102.001-g8b801ead
Mime-Version: 1.0
Message-Id: <e255ed09-ed67-46b3-b055-287959d1b76f@app.fastmail.com>
In-Reply-To: <20221128064648.1934720-3-baolu.lu@linux.intel.com>
References: <20221128064648.1934720-1-baolu.lu@linux.intel.com>
 <20221128064648.1934720-3-baolu.lu@linux.intel.com>
Date:   Wed, 30 Nov 2022 18:00:38 +0100
From:   "Sven Peter" <sven@svenpeter.dev>
To:     "Lu Baolu" <baolu.lu@linux.intel.com>,
        "Joerg Roedel" <joro@8bytes.org>,
        "Jason Gunthorpe" <jgg@nvidia.com>,
        "Christoph Hellwig" <hch@infradead.org>,
        "Kevin Tian" <kevin.tian@intel.com>,
        "Will Deacon" <will@kernel.org>,
        "Robin Murphy" <robin.murphy@arm.com>,
        "Jean-Philippe Brucker" <jean-philippe@linaro.org>
Cc:     "Suravee Suthikulpanit" <suravee.suthikulpanit@amd.com>,
        "Hector Martin" <marcan@marcan.st>,
        "Rob Clark" <robdclark@gmail.com>,
        "Marek Szyprowski" <m.szyprowski@samsung.com>,
        "Krzysztof Kozlowski" <krzysztof.kozlowski@linaro.org>,
        "Andy Gross" <agross@kernel.org>,
        "Bjorn Andersson" <andersson@kernel.org>,
        "Yong Wu" <yong.wu@mediatek.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        "Heiko Stuebner" <heiko@sntech.de>,
        "Matthew Rosato" <mjrosato@linux.ibm.com>,
        "Orson Zhai" <orsonzhai@gmail.com>,
        "Baolin Wang" <baolin.wang@linux.alibaba.com>,
        "Chunyan Zhang" <zhang.lyra@gmail.com>,
        "Chen-Yu Tsai" <wens@csie.org>,
        "Thierry Reding" <thierry.reding@gmail.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 02/20] iommu/apple-dart: Remove detach_dev callback
Content-Type: text/plain
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Mon, Nov 28, 2022, at 07:46, Lu Baolu wrote:
> The IOMMU driver supports default domain, so the detach_dev op will never
> be called. Remove it to avoid dead code.
>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> ---

Reviewed-by: Sven Peter <sven@svenpeter.dev>

>  drivers/iommu/apple-dart.c | 17 -----------------
>  1 file changed, 17 deletions(-)
>
> diff --git a/drivers/iommu/apple-dart.c b/drivers/iommu/apple-dart.c
> index 4f4a323be0d0..6fbe6b275c79 100644
> --- a/drivers/iommu/apple-dart.c
> +++ b/drivers/iommu/apple-dart.c
> @@ -535,22 +535,6 @@ static int apple_dart_attach_dev(struct 
> iommu_domain *domain,
>  	return ret;
>  }
> 
> -static void apple_dart_detach_dev(struct iommu_domain *domain,
> -				  struct device *dev)
> -{

Thanks for cleaning this entire API up!

It actually turns out that this is slightly broken because I assumed that
detach_dev would always be called for any attach_dev. I think the only
consequence for a device that used to be assigned to domain A and is now moved to
domain B is that any TLB flushes required for A will still flush the TLB for that
device.

That's not a big deal but I'll eventually send a fix.

> -	int i;
> -	struct apple_dart_stream_map *stream_map;
> -	struct apple_dart_master_cfg *cfg = dev_iommu_priv_get(dev);
> -	struct apple_dart_domain *dart_domain = to_dart_domain(domain);
> -
> -	for_each_stream_map(i, cfg, stream_map)
> -		apple_dart_hw_disable_dma(stream_map);
> -
> -	if (domain->type == IOMMU_DOMAIN_DMA ||
> -	    domain->type == IOMMU_DOMAIN_UNMANAGED)
> -		apple_dart_domain_remove_streams(dart_domain, cfg);

Something might complain about unused apple_dart_domain_remove_streams now.
Might make sense to drop that for now as well.



Best,

Sven
