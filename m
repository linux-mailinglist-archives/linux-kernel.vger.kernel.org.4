Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B8CE72798C
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 10:05:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235141AbjFHIFU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 04:05:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234908AbjFHIFJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 04:05:09 -0400
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E083E1FFE;
        Thu,  8 Jun 2023 01:05:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686211507; x=1717747507;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=BsF2PIZTl/X54NX478X5GNlrDe30L7rgjFo/J/dUhzE=;
  b=Wby+t0NijiIsDCBMSQYoljnDPM63355v0q561xvPZxhUDKEG3wk1qKQx
   3nrPW8k68pTkHX8OZKx6U9OUZ5vB9+vZD3kUHDrM88wmNXO6eocl0rZzr
   q7eI8U8JIIw6ERZ4AkJbjZtGdUr2TBeq96s05/6gfaS9F3/SSTx9tulGP
   NdFjFDx6p813Lob+WDATQT7FvnD5PzipJJYyI37eWoIWO3dVftkK5fzI0
   OvapOzno3eyynBX9xS6lOK54AxhSUon8ZaaOYLVzGa3GMWNmVakQosx68
   8f4elSe7RVWb8GjMOGUW4MVrMoMbnTz5aK/CiACt6dEP+I3SjQyDygsKb
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="385583369"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="385583369"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2023 01:03:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10734"; a="854248810"
X-IronPort-AV: E=Sophos;i="6.00,226,1681196400"; 
   d="scan'208";a="854248810"
Received: from kuha.fi.intel.com ([10.237.72.185])
  by fmsmga001.fm.intel.com with SMTP; 08 Jun 2023 01:03:16 -0700
Received: by kuha.fi.intel.com (sSMTP sendmail emulation); Thu, 08 Jun 2023 11:03:15 +0300
Date:   Thu, 8 Jun 2023 11:03:15 +0300
From:   Heikki Krogerus <heikki.krogerus@linux.intel.com>
To:     neil.armstrong@linaro.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-usb@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] usb: typec: add support for the nb7vpq904m Type-C
 Linear Redriver
Message-ID: <ZIGLQ31CXN1VuVDI@kuha.fi.intel.com>
References: <20230601-topic-sm8x50-upstream-redriver-v2-0-dda89b22b1c0@linaro.org>
 <20230601-topic-sm8x50-upstream-redriver-v2-2-dda89b22b1c0@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230601-topic-sm8x50-upstream-redriver-v2-2-dda89b22b1c0@linaro.org>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Jun 07, 2023 at 09:51:09AM +0200, neil.armstrong@linaro.org wrote:
> +static int nb7vpq904m_set(struct nb7vpq904m *nb7)
> +{
> +	bool reverse = (nb7->orientation == TYPEC_ORIENTATION_REVERSE);
> +
> +	switch (nb7->mode) {
> +	case TYPEC_STATE_SAFE:
> +		regmap_write(nb7->regmap, GEN_DEV_SET_REG,
> +			     GEN_DEV_SET_CHIP_EN |
> +			     GEN_DEV_SET_CHNA_EN |
> +			     GEN_DEV_SET_CHNB_EN |
> +			     GEN_DEV_SET_CHNC_EN |
> +			     GEN_DEV_SET_CHND_EN |
> +			     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
> +					GEN_DEV_SET_OP_MODE_USB));
> +		nb7vpq904m_set_channel(nb7, NB7_CHNA, false);
> +		nb7vpq904m_set_channel(nb7, NB7_CHNB, false);
> +		nb7vpq904m_set_channel(nb7, NB7_CHNC, false);
> +		nb7vpq904m_set_channel(nb7, NB7_CHND, false);
> +		regmap_write(nb7->regmap, AUX_CC_REG, 0x2);
> +
> +		return 0;
> +
> +	case TYPEC_STATE_USB:
> +		/*
> +		 * Normal Orientation (CC1)
> +		 * A -> USB RX
> +		 * B -> USB TX
> +		 * C -> X
> +		 * D -> X
> +		 * Flipped Orientation (CC2)
> +		 * A -> X
> +		 * B -> X
> +		 * C -> USB TX
> +		 * D -> USB RX
> +		 *
> +		 * Reversed if data lanes are swapped
> +		 */
> +		if (reverse ^ nb7->swap_data_lanes) {
> +			regmap_write(nb7->regmap, GEN_DEV_SET_REG,
> +				     GEN_DEV_SET_CHIP_EN |
> +				     GEN_DEV_SET_CHNA_EN |
> +				     GEN_DEV_SET_CHNB_EN |
> +				     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
> +						GEN_DEV_SET_OP_MODE_USB));
> +			nb7vpq904m_set_channel(nb7, NB7_CHNA, false);
> +			nb7vpq904m_set_channel(nb7, NB7_CHNB, false);
> +		} else {
> +			regmap_write(nb7->regmap, GEN_DEV_SET_REG,
> +				     GEN_DEV_SET_CHIP_EN |
> +				     GEN_DEV_SET_CHNC_EN |
> +				     GEN_DEV_SET_CHND_EN |
> +				     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
> +						GEN_DEV_SET_OP_MODE_USB));
> +			nb7vpq904m_set_channel(nb7, NB7_CHNC, false);
> +			nb7vpq904m_set_channel(nb7, NB7_CHND, false);
> +		}
> +		regmap_write(nb7->regmap, AUX_CC_REG, 0x2);
> +
> +		return 0;
> +
> +	default:
> +		if (nb7->svid != USB_TYPEC_DP_SID)
> +			return -EINVAL;
> +
> +		break;
> +	}
> +
> +	/* DP Altmode Setup */
> +
> +	regmap_write(nb7->regmap, AUX_CC_REG, reverse ? 0x1 : 0x0);
> +
> +	switch (nb7->mode) {
> +	case TYPEC_DP_STATE_C:
> +	case TYPEC_DP_STATE_E:
> +		/*
> +		 * Normal Orientation (CC1)
> +		 * A -> DP3
> +		 * B -> DP2
> +		 * C -> DP1
> +		 * D -> DP0
> +		 * Flipped Orientation (CC2)
> +		 * A -> DP0
> +		 * B -> DP1
> +		 * C -> DP2
> +		 * D -> DP3
> +		 */
> +		regmap_write(nb7->regmap, GEN_DEV_SET_REG,
> +			     GEN_DEV_SET_CHIP_EN |
> +			     GEN_DEV_SET_CHNA_EN |
> +			     GEN_DEV_SET_CHNB_EN |
> +			     GEN_DEV_SET_CHNC_EN |
> +			     GEN_DEV_SET_CHND_EN |
> +			     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
> +					GEN_DEV_SET_OP_MODE_DP_4LANE));
> +		nb7vpq904m_set_channel(nb7, NB7_CHNA, true);
> +		nb7vpq904m_set_channel(nb7, NB7_CHNB, true);
> +		nb7vpq904m_set_channel(nb7, NB7_CHNC, true);
> +		nb7vpq904m_set_channel(nb7, NB7_CHND, true);
> +		break;
> +
> +	case TYPEC_DP_STATE_D:
> +	case TYPEC_DP_STATE_F:
> +		regmap_write(nb7->regmap, GEN_DEV_SET_REG,
> +			     GEN_DEV_SET_CHIP_EN |
> +			     GEN_DEV_SET_CHNA_EN |
> +			     GEN_DEV_SET_CHNB_EN |
> +			     GEN_DEV_SET_CHNC_EN |
> +			     GEN_DEV_SET_CHND_EN |
> +			     FIELD_PREP(GEN_DEV_SET_OP_MODE_MASK,
> +					reverse ^ nb7->swap_data_lanes ?
> +						GEN_DEV_SET_OP_MODE_DP_CC2
> +						: GEN_DEV_SET_OP_MODE_DP_CC1));
> +
> +		/*
> +		 * Normal Orientation (CC1)
> +		 * A -> USB RX
> +		 * B -> USB TX
> +		 * C -> DP1
> +		 * D -> DP0
> +		 * Flipped Orientation (CC2)
> +		 * A -> DP0
> +		 * B -> DP1
> +		 * C -> USB TX
> +		 * D -> USB RX
> +		 *
> +		 * Reversed if data lanes are swapped
> +		 */
> +		if (nb7->swap_data_lanes) {
> +			nb7vpq904m_set_channel(nb7, NB7_CHNA, !reverse);
> +			nb7vpq904m_set_channel(nb7, NB7_CHNB, !reverse);
> +			nb7vpq904m_set_channel(nb7, NB7_CHNC, reverse);
> +			nb7vpq904m_set_channel(nb7, NB7_CHND, reverse);
> +		} else {
> +			nb7vpq904m_set_channel(nb7, NB7_CHNA, reverse);
> +			nb7vpq904m_set_channel(nb7, NB7_CHNB, reverse);
> +			nb7vpq904m_set_channel(nb7, NB7_CHNC, !reverse);
> +			nb7vpq904m_set_channel(nb7, NB7_CHND, !reverse);
> +		}
> +		break;
> +
> +	default:
> +		return -ENOTSUPP;

That should be -EOPNOTSUPP.

> +	}
> +
> +	return 0;
> +}
> +
> +static int nb7vpq904m_sw_set(struct typec_switch_dev *sw,
> +			      enum typec_orientation orientation)

While at it, one line should be enough for this one.

thanks,

-- 
heikki
