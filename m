Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6AC636B1BC3
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 07:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230218AbjCIGqw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 01:46:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230202AbjCIGqk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 01:46:40 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEB52DABA8;
        Wed,  8 Mar 2023 22:46:34 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C7F4B6194F;
        Thu,  9 Mar 2023 06:46:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B61ADC433D2;
        Thu,  9 Mar 2023 06:46:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678344363;
        bh=oS5Du0iAPnOVgwot0CXctvGp/xcbqSatUPFEbkf5n6w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ykNgJTHX7Zf3nvuXnS0xHP+nA2BxOCOOG+UGEL5w+2XDS+tFOhOvYliLHGR1Bhgda
         s84EvWQ9G7QbwLuBIV1gyUEfyLZI0GaWhthUDDY/o3bOrNTO4vJGzZbHukVlni0+k6
         n2redErcF2q1X7zFeycnWMeasREPKZu2IMl15gns=
Date:   Thu, 9 Mar 2023 07:46:00 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, broonie@kernel.org, lgirdwood@gmail.com,
        krzysztof.kozlowski+dt@linaro.org, agross@kernel.org,
        Thinh.Nguyen@synopsys.com, bgoswami@quicinc.com,
        andersson@kernel.org, robh+dt@kernel.org, tiwai@suse.com,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com
Subject: Re: [PATCH v3 00/28] Introduce QC USB SND audio offloading support
Message-ID: <ZAmAqGg7NglUw8MO@kroah.com>
References: <20230308235751.495-1-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230308235751.495-1-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 08, 2023 at 03:57:23PM -0800, Wesley Cheng wrote:
> Changes in v3:
> - Changed prefix from RFC to PATCH
> - Rebased entire series to usb-next
> - Updated copyright years

This is much better, thanks.  I've done some very brief high-level
skimming and found minor issues, and one major one.  I'll let others
review this in more depth right now, as I am way behind in reviewing
other USB patches and need to get to them first.

thanks,

greg k-h
