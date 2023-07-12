Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9E6974FEDF
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jul 2023 07:47:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231858AbjGLFrY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jul 2023 01:47:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231776AbjGLFrT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jul 2023 01:47:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0A9D173B;
        Tue, 11 Jul 2023 22:47:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 66ACE616DA;
        Wed, 12 Jul 2023 05:47:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4571FC433C8;
        Wed, 12 Jul 2023 05:47:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689140837;
        bh=tv7+G1sTRAmpHP+NsXZWJZzIX4WDWhx4O5Js86b6Tf0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=kW2fQoLIFzmvqPIsD8GMQCYXIhyPhMNN6wiMaGe121gszV1BR1ZsqBh75GjcYhXnl
         rzvkKXDlP3cEs0ARrU0O+YhmNlmWP4La0Tj0zPAdyws5b6A/73YA/r2IrhOmJDJ1+2
         j6vSXAxanaxt3RWfwLclGbPK4vmFZVxbK0dPn6jdWcIvOFdCabNDTgz2ZE4nE5W3Kd
         9WLws7xHy4I81Orm6+rX/7nhmBBAmqnI8YxhnUA2tuz65PILopYY/Nmfz7WFskX07v
         idPmnbmd8U+/WF2zgVG+lIrmsSnLylHOih8vBusxLm+lYzIjSdS9uB+9HilJhVgHkK
         FlnV8l4vt+qww==
Message-ID: <9425ee08-f714-2833-6c94-a0f15cb608b5@kernel.org>
Date:   Wed, 12 Jul 2023 07:47:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v3 2/3] dt-bindings: usb: snps,dwc3: Add
 allow-rtsusp-on-u3 property
Content-Language: en-US
To:     Elson Roy Serrao <quic_eserrao@quicinc.com>,
        Thinh.Nguyen@synopsys.com, stern@rowland.harvard.edu
Cc:     gregkh@linuxfoundation.org, rogerq@kernel.org,
        linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org,
        quic_wcheng@quicinc.com, quic_jackp@quicinc.com
References: <20230711174320.24058-1-quic_eserrao@quicinc.com>
 <20230711174320.24058-3-quic_eserrao@quicinc.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230711174320.24058-3-quic_eserrao@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/07/2023 19:43, Elson Roy Serrao wrote:
> This property allows dwc3 runtime suspend when bus suspend interrupt
> is received even with cable connected. This would allow the dwc3
> controller to enter low power mode during bus suspend scenario.
> 
> This property would particularly benefit dwc3 IPs where hibernation is
> not enabled and the dwc3 low power mode entry/exit is handled by the
> glue driver. The assumption here is that the platform using this dt
> property is capable of detecting resume events to bring the controller
> out of suspend.

v3 and still ignoring maintainers?

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC. It might happen, that command when run on an older
kernel, gives you outdated entries. Therefore please be sure you base
your patches on recent Linux kernel.

You missed at least DT list (maybe more), so this won't be tested by
automated tooling. Performing review on untested code might be a waste
of time, thus I will skip this patch entirely till you follow the
process allowing the patch to be tested.

Please kindly resend and include all necessary To/Cc entries.


Best regards,
Krzysztof

