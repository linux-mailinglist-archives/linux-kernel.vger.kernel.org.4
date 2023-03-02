Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C7286A883B
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 19:05:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229800AbjCBSF2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 13:05:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229494AbjCBSFZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 13:05:25 -0500
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AEAFF1817B;
        Thu,  2 Mar 2023 10:05:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1677780324; x=1709316324;
  h=from:to:cc:subject:in-reply-to:references:date:
   message-id:mime-version;
  bh=Bf3iWqZn8ZHJC8UqH7R7YhZdFebd0SSSAZOsxRPZafQ=;
  b=gaQ9R4dmUK3WN1p5f+G5k5yswoQgOy93tV/JsJx+nQrZ6a6y/Qfmuejr
   T2E7p623Fd3g/kEMsDi1DSmGfBWjjrBXvRe7/PXkV6smrJR4fo34VVz1j
   vcmSVIKIsskDhQhUXlRBR5HLBb7RqZidZqsZvdLiPjsJSREXz/bXpr7zC
   voGHrDs75c4BUGCRsI7uz3dOFBnCIw17qC+G1kR9pbOkgjZ+gkLKrhTSh
   AKSWXV063jt5z+5i0lx7CCmtH8fuQNLI4b4/38RyOreYoTLR7oNVqBxz3
   yyW9nP5mLxoHTrTK9uMHrHKobnvWgWA0/SyIeGxpx0doefDIQRnEZwKKa
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="333522917"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="333522917"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Mar 2023 10:05:24 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10637"; a="1004222764"
X-IronPort-AV: E=Sophos;i="5.98,228,1673942400"; 
   d="scan'208";a="1004222764"
Received: from ubik.fi.intel.com (HELO localhost) ([10.237.72.184])
  by fmsmga005.fm.intel.com with ESMTP; 02 Mar 2023 10:05:20 -0800
From:   Alexander Shishkin <alexander.shishkin@linux.intel.com>
To:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>
Cc:     Mao Jinlong <quic_jinlmao@quicinc.com>,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-arm-kernel@lists.infradead.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>,
        alexander.shishkin@linux.intel.com
Subject: Re: [PATCH] stm: class: Add MIPI OST protocol support
In-Reply-To: <20230208124053.18533-1-quic_jinlmao@quicinc.com>
References: <20230208124053.18533-1-quic_jinlmao@quicinc.com>
Date:   Thu, 02 Mar 2023 20:05:20 +0200
Message-ID: <87lekfni5b.fsf@ubik.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mao Jinlong <quic_jinlmao@quicinc.com> writes:

> Add MIPI OST protocol support for stm to format the traces.

Missing an explanation of what OST is, what it's used for, how it is
different from the SyS-T and others.

> Framework copied from drivers/hwtracing/stm.p-sys-t.c as of

You mean stm/p_sys-t.c. Also, it's not a framework, it's a driver.

> commit d69d5e83110f ("stm class: Add MIPI SyS-T protocol
> support").

Why is this significant?

> diff --git a/drivers/hwtracing/stm/p_ost.c b/drivers/hwtracing/stm/p_ost.c
> new file mode 100644
> index 000000000000..2ca1a3fda57f
> --- /dev/null
> +++ b/drivers/hwtracing/stm/p_ost.c
> @@ -0,0 +1,95 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * Copied from drivers/hwtracing/stm.p-sys-t.c as of commit d69d5e83110f
> + * ("stm class: Add MIPI SyS-T protocol support").

Same as in the commit message.

[...]

> +#define OST_TOKEN_STARTSIMPLE		(0x10)
> +#define OST_VERSION_MIPI1		(0x10 << 8)
> +#define OST_ENTITY_FTRACE		(0x01 << 16)
> +#define OST_CONTROL_PROTOCOL		(0x0 << 24)

These could use an explanation.

> +#define DATA_HEADER (OST_TOKEN_STARTSIMPLE | OST_VERSION_MIPI1 | \
> +			OST_ENTITY_FTRACE | OST_CONTROL_PROTOCOL)

Does this mean that everything is ftrace? Because it's not.

> +
> +#define STM_MAKE_VERSION(ma, mi)	((ma << 8) | mi)
> +#define STM_HEADER_MAGIC		(0x5953)
> +
> +static ssize_t notrace ost_write(struct stm_data *data,
> +		struct stm_output *output, unsigned int chan,
> +		const char *buf, size_t count)
> +{
> +	unsigned int c = output->channel + chan;
> +	unsigned int m = output->master;
> +	const unsigned char nil = 0;
> +	u32 header = DATA_HEADER;
> +	u8 trc_hdr[24];
> +	ssize_t sz;
> +
> +	/*
> +	 * STP framing rules for OST frames:
> +	 *   * the first packet of the OST frame is marked;
> +	 *   * the last packet is a FLAG.

Which in your case is also timestamped.

> +	 */
> +	/* Message layout: HEADER / DATA / TAIL */
> +	/* HEADER */
> +
> +	sz = data->packet(data, m, c, STP_PACKET_DATA, STP_PACKET_MARKED,
> +			  4, (u8 *)&header);

The /* HEADER */ comment applies to the above line, so it should
probably be directly before it.

> +	if (sz <= 0)
> +		return sz;
> +	*(uint16_t *)(trc_hdr) = STM_MAKE_VERSION(0, 3);
> +	*(uint16_t *)(trc_hdr + 2) = STM_HEADER_MAGIC;
> +	*(uint32_t *)(trc_hdr + 4) = raw_smp_processor_id();
> +	*(uint64_t *)(trc_hdr + 8) = sched_clock();

Why sched_clock()? It should, among other things, be called with
interrupts disabled, which is not the case here.

> +	*(uint64_t *)(trc_hdr + 16) = task_tgid_nr(get_current());

Is there a reason why trc_hdr is not a struct?

Thanks,
--
Alex
