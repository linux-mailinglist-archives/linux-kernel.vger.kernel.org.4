Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B08E1664225
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 14:44:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233606AbjAJNoO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 08:44:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238628AbjAJNnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 08:43:50 -0500
Received: from relay1-d.mail.gandi.net (relay1-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::221])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34F958FC1
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 05:43:36 -0800 (PST)
Received: (Authenticated sender: alexandre.belloni@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id A405124000C;
        Tue, 10 Jan 2023 13:43:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1673358215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KJKhvDdvPIztsi5DnjKbmNy7+xwHNtCSveA1o7bsZ5g=;
        b=oGcdjfACr5YSSG6FdLTEq1AGQ0rV2ER1yXyHJ7qSUy+I3t1Hy+CuKEdJ4T3ZZAm24j0PZ1
        Vz/k+jccCL0+Nv6ELPfxjTtun8SyNVYr/1EtBK9z+uvFgTufb9/wVcr3HvKgXorcfanaXs
        PrCC1NlRvRSveukodxRReA7jTNX/ff1mYBlNAPyLMCASubz3IHWY+s48Kti7zTe1rLvUeB
        JnaB8pemE9T9z2k+EEC1ZCq0pRnOKB+2uY9HnULf17VURMmW3grqk1J8Exg7q1lXzVICBZ
        RaRDmDNXpxpv4YO5ullEYcx9u2G+lSazLvSOQWNoYYa9i+3UTlxd/w53qAfWNw==
Date:   Tue, 10 Jan 2023 14:43:33 +0100
From:   Alexandre Belloni <alexandre.belloni@bootlin.com>
To:     Jack Chen <zenghuchen@google.com>
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org,
        Jesus Sanchez-Palencia <jesussanp@google.com>,
        Mark Slevinsky <markslevinsky@google.com>
Subject: Re: [PATCH] i3c: transfer pid from boardinfo to device info
Message-ID: <167335818715.550702.4568478412316741935.b4-ty@bootlin.com>
References: <20230105212952.56321-1-zenghuchen@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230105212952.56321-1-zenghuchen@google.com>
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Thu, 05 Jan 2023 16:29:52 -0500, Jack Chen wrote:
> I3C device PID could be defined in device tree and stored in
> i3c_dev_boardinfo. It should be passed to i3c_device_info when
> allocating a i3c_dev_desc.
> Rational behind this change is: when users decide to use SETDASA to
> assign a dynamic address with exactly the original static address, in
> step of i3c_master_reattach_i3c_dev, this address is checked to be
> taken. Then device information retrieving step is skipped. As a result,
> though the i3c device is registered correctly, its device driver could
> not be probed.
> 
> [...]

Applied, thanks!

[1/1] i3c: transfer pid from boardinfo to device info
      commit: e826acc18bc7bdf4278bf8928caa3a0cd4065432

Best regards,

-- 
Alexandre Belloni, co-owner and COO, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
