Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7AA467C524
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 08:48:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236166AbjAZHsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 02:48:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235269AbjAZHsg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 02:48:36 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 533F84B1B4;
        Wed, 25 Jan 2023 23:48:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EED59B81D0C;
        Thu, 26 Jan 2023 07:48:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 21FAEC433EF;
        Thu, 26 Jan 2023 07:48:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674719312;
        bh=76XT9aCTD8B8LT/q4agWyU0rMRgv/FmnnUUpPtrX7Go=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sw/vGS+2pAXtLvctCylbRvR+u/imgaZoMtOLeimjFEQNJNjGptMd1vAbA/RlBD7Ki
         mG0YkGFe3I91Z+mzXfv3Qv0/i2eP19WhP96lYluQ2vPBclUfvgM0UTbmKbwtuiht5+
         ebwhII+jfGloNGj5Q0x3TfIMFXgDVOqMUbBt7Z8I=
Date:   Thu, 26 Jan 2023 08:48:29 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Wesley Cheng <quic_wcheng@quicinc.com>
Cc:     srinivas.kandagatla@linaro.org, mathias.nyman@intel.com,
        perex@perex.cz, lgirdwood@gmail.com, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, Thinh.Nguyen@synopsys.com,
        broonie@kernel.org, bgoswami@quicinc.com, tiwai@suse.com,
        robh+dt@kernel.org, agross@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        alsa-devel@alsa-project.org, devicetree@vger.kernel.org,
        linux-usb@vger.kernel.org, quic_jackp@quicinc.com,
        quic_plai@quicinc.com,
        Mathias Nyman <mathias.nyman@linux.intel.com>
Subject: Re: [RFC PATCH v2 02/22] xhci: remove xhci_test_trb_in_td_math early
 development check
Message-ID: <Y9IwTTb7dfkI7C6b@kroah.com>
References: <20230126031424.14582-1-quic_wcheng@quicinc.com>
 <20230126031424.14582-3-quic_wcheng@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230126031424.14582-3-quic_wcheng@quicinc.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 25, 2023 at 07:14:04PM -0800, Wesley Cheng wrote:
> From: Mathias Nyman <mathias.nyman@linux.intel.com>
> 
> Time to remove this test trb in td math check that was added
> in early stage of xhci driver deveopment.
> 
> It verified that the size, alignment and boundaries of the event and
> command rings the driver itself allocated are correct.
> 
> Signed-off-by: Mathias Nyman <mathias.nyman@linux.intel.com>
> ---

Note, if you pass on a patch from someone else, you HAVE to also
sign-off on it as well.  For that reason alone this series would have to
be rejected :(

thanks,

greg k-h
