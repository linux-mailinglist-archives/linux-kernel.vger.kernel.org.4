Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8A196C6DBD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 17:35:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231558AbjCWQfy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 12:35:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230039AbjCWQfc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 12:35:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5921C2BECE;
        Thu, 23 Mar 2023 09:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CD6B7627F4;
        Thu, 23 Mar 2023 16:33:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AEEC4C433B4;
        Thu, 23 Mar 2023 16:33:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1679589238;
        bh=BClF/ebjW5Hky5VLt08yA80pi2zvmy7CU8/qtkRTawM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=v+7gQI9XqOjD1ty8RChnHb3vuki9n2rsw1SCKVVCTxODmC6qtWxzWM6al8FN9ebsO
         CwP0DNFtmVYZGzBFt4AkKR5ojHfKQl8PjTECtJLffxAhXO4tLiQ01x9ALliIxz/Hih
         gJn2Pd/q2X/26t4Uze+thGn0oBCslbmazPKkbGtU=
Date:   Thu, 23 Mar 2023 17:33:55 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Neil Armstrong <neil.armstrong@linaro.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        linux-usb@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v5 01/12] usb: typec: ucsi: add PMIC Glink UCSI driver
Message-ID: <ZBx/c4efiJ+6Kv9o@kroah.com>
References: <20230130-topic-sm8450-upstream-pmic-glink-v5-0-552f3b721f9e@linaro.org>
 <20230130-topic-sm8450-upstream-pmic-glink-v5-1-552f3b721f9e@linaro.org>
 <20230322023102.nai4cru27tba56kx@ripper>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230322023102.nai4cru27tba56kx@ripper>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 21, 2023 at 07:31:02PM -0700, Bjorn Andersson wrote:
> On Tue, Mar 21, 2023 at 02:21:41PM +0100, Neil Armstrong wrote:
> > Introduce the UCSI PMIC Glink aux driver that communicates
> > with the aDSP firmware with the UCSI protocol which handles
> > the USB-C Port(s) Power Delivery.
> > 
> > The UCSI messaging is necessary on newer Qualcomm SoCs to
> > provide USB role switch and altmode notifications.
> > 
> > Reviewed-by: Heikki Krogerus <heikki.krogerus@linux.intel.com>
> > Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> 
> Reviewed-by: Bjorn Andersson <andersson@kernel.org>
> 
> 
> Greg, this has no build time dependencies to the remainder of the
> series, so can you pick this patch 1 and patch 5 (dt-bindings: usb:
> snps,dwc3: document HS & SS OF graph ports) through your tree?

Yes, will do so, thanks!

greg k-h
