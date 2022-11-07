Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53ABA61EC3D
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 08:40:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231448AbiKGHkb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 02:40:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiKGHk3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 02:40:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37831D9A;
        Sun,  6 Nov 2022 23:40:28 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ABE4560E2C;
        Mon,  7 Nov 2022 07:40:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F552C433D6;
        Mon,  7 Nov 2022 07:40:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667806827;
        bh=Q9sAm/EGEjJ9UW42di1s+Bb/pLDCYceoSWiZMW02CYQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U2UcuxX3fs0itggbRp+T6jp7dthfdNQfr3Z6g4GVy9gv4EuSmz/mZO/RA1k/vxoet
         biC4KXEGXJuRwCviYZxZizPLMngz/zNc6fvxBy3yUkOe0wLSecqe6ah2FwakbssSyQ
         xn/Om35wDC31jqNP+gVt5q8KdfQqQs2ErAiZK/coJdq3fw1olTYx7H6sx6SzGkkgED
         q79+ozn1rtKi8g0MU4MFYAaWW6MEiuWW+D9BoYQJhykMUuviJFgig4lYDK3wikO3/w
         k2PSD3mlaX5mBVts7BpSbaTsZWTnmj/XA51Si/HBhkofb0i4h2krjO2wh6ZDoQCgp9
         mcqOARAghrOOw==
Date:   Mon, 7 Nov 2022 13:10:15 +0530
From:   Manivannan Sadhasivam <mani@kernel.org>
To:     Slark Xiao <slark_xiao@163.com>
Cc:     Manivannan Sadhasivam <mani@kernel.org>,
        gregkh@linuxfoundation.org, loic.poulain@linaro.org,
        dnlplm@gmail.com, yonglin.tan@outlook.com,
        fabio.porcedda@gmail.com, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: Re: [PATCH] bus: mhi: host: pci_generic: Add macro for some vids
Message-ID: <20221107074015.GA5340@thinkpad>
References: <20221102024437.15248-1-slark_xiao@163.com>
 <20221103125009.GH8434@thinkpad>
 <cbb018a.ab1.1844fe4a7e8.Coremail.slark_xiao@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cbb018a.ab1.1844fe4a7e8.Coremail.slark_xiao@163.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 10:21:36AM +0800, Slark Xiao wrote:
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> 
> At 2022-11-03 20:50:09, "Manivannan Sadhasivam" <mani@kernel.org> wrote:
> >On Wed, Nov 02, 2022 at 10:44:37AM +0800, Slark Xiao wrote:
> >> To make code neat and for convenience purpose, using macro for
> >> some vids.
> >
> >s/using/use
> >s/vids/VIDs
> >
> >> Refer to previous patch in pci_ids.h side, they are
> >> not allowed to add new entries of single driver needed. So we
> >> add it in our local file.
> >>
> >
> >Reference to the previous patch has no relationship with this commit once
> >merged. How about,
> >
> >"These macros are supposed to be added to pci_ids.h. But until the macros are
> >used in multiple places, it is not recommended. So adding it locally for now."
> > 
> >> Signed-off-by: Slark Xiao <slark_xiao@163.com>
> >> ---
> >>  drivers/bus/mhi/host/pci_generic.c | 18 +++++++++++-------
> >>  1 file changed, 11 insertions(+), 7 deletions(-)
> >> 
> >> diff --git a/drivers/bus/mhi/host/pci_generic.c b/drivers/bus/mhi/host/pci_generic.c
> >> index c4259cb2d289..5abc778a5290 100644
> >> --- a/drivers/bus/mhi/host/pci_generic.c
> >> +++ b/drivers/bus/mhi/host/pci_generic.c
> >> @@ -24,6 +24,10 @@
> >>  
> >>  #define HEALTH_CHECK_PERIOD (HZ * 2)
> >>  
> >
> >Add a comment,
> >
> >/* PCI VID definitions */
> >
> >> +#define PCI_VENDOR_ID_THALES	0x1269
> >> +
> >
> >No need of newline
> >
> >> +#define PCI_VENDOR_ID_QUECTEL	0x1eac
> >> +
> >
> >Just use a space after PCI_VENDOR_ID_QUECTEL like above.
> >
> >Thanks,
> >Mani
> Hi Mani,
> I didn't get the point of this format issue.
> Do you mean remove that newline between these 2 definitions?

Yes, since both are VIDs, there is no need to add a newline between them.

Thanks,
Mani

> >
> >>  /**
> >>   * struct mhi_pci_dev_info - MHI PCI device specific information
> >>   * @config: MHI controller configuration
> >> @@ -557,11 +561,11 @@ static const struct pci_device_id mhi_pci_id_table[] = {
> >>  		.driver_data = (kernel_ulong_t) &mhi_telit_fn990_info },
> >>  	{ PCI_DEVICE(PCI_VENDOR_ID_QCOM, 0x0308),
> >>  		.driver_data = (kernel_ulong_t) &mhi_qcom_sdx65_info },
> >> -	{ PCI_DEVICE(0x1eac, 0x1001), /* EM120R-GL (sdx24) */
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1001), /* EM120R-GL (sdx24) */
> >>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> >> -	{ PCI_DEVICE(0x1eac, 0x1002), /* EM160R-GL (sdx24) */
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x1002), /* EM160R-GL (sdx24) */
> >>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> >> -	{ PCI_DEVICE(0x1eac, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_QUECTEL, 0x2001), /* EM120R-GL for FCCL (sdx24) */
> >>  		.driver_data = (kernel_ulong_t) &mhi_quectel_em1xx_info },
> >>  	/* T99W175 (sdx55), Both for eSIM and Non-eSIM */
> >>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0ab),
> >> @@ -585,16 +589,16 @@ static const struct pci_device_id mhi_pci_id_table[] = {
> >>  	{ PCI_DEVICE(PCI_VENDOR_ID_FOXCONN, 0xe0d9),
> >>  		.driver_data = (kernel_ulong_t) &mhi_foxconn_sdx65_info },
> >>  	/* MV31-W (Cinterion) */
> >> -	{ PCI_DEVICE(0x1269, 0x00b3),
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b3),
> >>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> >>  	/* MV31-W (Cinterion), based on new baseline */
> >> -	{ PCI_DEVICE(0x1269, 0x00b4),
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00b4),
> >>  		.driver_data = (kernel_ulong_t) &mhi_mv31_info },
> >>  	/* MV32-WA (Cinterion) */
> >> -	{ PCI_DEVICE(0x1269, 0x00ba),
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00ba),
> >>  		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
> >>  	/* MV32-WB (Cinterion) */
> >> -	{ PCI_DEVICE(0x1269, 0x00bb),
> >> +	{ PCI_DEVICE(PCI_VENDOR_ID_THALES, 0x00bb),
> >>  		.driver_data = (kernel_ulong_t) &mhi_mv32_info },
> >>  	{  }
> >>  };
> >> -- 
> >> 2.17.1
> >> 
> >
> >-- 
> >மணிவண்ணன் சதாசிவம்

-- 
மணிவண்ணன் சதாசிவம்
