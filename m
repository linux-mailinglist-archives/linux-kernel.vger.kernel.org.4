Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B0556551B8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 15:57:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236294AbiLWO5a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 09:57:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41608 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiLWO51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 09:57:27 -0500
Received: from verein.lst.de (verein.lst.de [213.95.11.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CACB61A047;
        Fri, 23 Dec 2022 06:57:26 -0800 (PST)
Received: by verein.lst.de (Postfix, from userid 2407)
        id 6691D68BFE; Fri, 23 Dec 2022 15:57:22 +0100 (CET)
Date:   Fri, 23 Dec 2022 15:57:22 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc:     Christoph Hellwig <hch@lst.de>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Uladzislau Rezki <urezki@gmail.com>,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        iommu@lists.linux.dev
Subject: Re: [PATCH 1/2] Revert "remoteproc: qcom_q6v5_mss: map/unmap
 metadata region before/after use"
Message-ID: <20221223145722.GA29401@lst.de>
References: <20221223092703.61927-1-hch@lst.de> <20221223092703.61927-2-hch@lst.de> <20221223144731.GA4587@thinkpad>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221223144731.GA4587@thinkpad>
User-Agent: Mutt/1.5.17 (2007-11-01)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 23, 2022 at 08:17:31PM +0530, Manivannan Sadhasivam wrote:
> Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Btw, if the hardware really does not like a kernel mapping, the
right way is to just keep using the normal dma allocator, but make
sure that there shared-dma-pool with the no-map property for the
device.
