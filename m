Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B4196B7038
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 08:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229783AbjCMHnc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 03:43:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229516AbjCMHn3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 03:43:29 -0400
Received: from out-63.mta0.migadu.com (out-63.mta0.migadu.com [91.218.175.63])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB4DE1C7EC
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 00:43:28 -0700 (PDT)
Date:   Mon, 13 Mar 2023 08:43:24 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678693406;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=a9aVOSEiEDVTQVJITzY6AK28fCBDn9src0ksqEKQEUo=;
        b=t9SwMf5Qn5r92Yc1mrEdQKx7qpMLE7XcDm2myyKCaroiy4E1Y082jXOKMXXHiXdYkzJhoP
        Tyx6VZdcoi3GxdZSGVY/GTBx2A2+Jf/4VNBSalMQ9cdpW/e+8GHEG//hVb10kfvDCTtvUe
        6QSz+OBwUvsmpJxAuUDCqvM3IgwEeL8=
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
From:   Richard Leitner <richard.leitner@linux.dev>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Richard Leitner <richard.leitner@skidata.com>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 7/7] usb: misc: usb251xb: drop of_match_ptr for ID table
Message-ID: <20230313074324.GB24063@g0hl1n.net>
References: <20230311173624.263189-1-krzysztof.kozlowski@linaro.org>
 <20230311173624.263189-7-krzysztof.kozlowski@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230311173624.263189-7-krzysztof.kozlowski@linaro.org>
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 11, 2023 at 06:36:24PM +0100, Krzysztof Kozlowski wrote:
> The driver will match mostly by DT table (even thought there is regular
> ID table) so there is little benefit in of_match_ptr (this also allows
> ACPI matching via PRP0001, even though it might not be relevant here).
> 
>   drivers/usb/misc/usb251xb.c:223:35: error: ‘usb2517i_data’ defined but not used [-Werror=unused-const-variable=]
>   drivers/usb/misc/usb251xb.c:215:35: error: ‘usb2517_data’ defined but not used [-Werror=unused-const-variable=]
>   drivers/usb/misc/usb251xb.c:207:35: error: ‘usb2514bi_data’ defined but not used [-Werror=unused-const-variable=]
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Thanks.

Acked-by: Richard Leitner <richard.leitner@skidata.com>

regards;rl

