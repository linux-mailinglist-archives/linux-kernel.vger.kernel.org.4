Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74D506D427B
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 12:49:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231712AbjDCKsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 06:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjDCKsm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 06:48:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFDB76EB4
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 03:48:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 74215618CF
        for <linux-kernel@vger.kernel.org>; Mon,  3 Apr 2023 10:48:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DF468C4339C;
        Mon,  3 Apr 2023 10:48:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680518917;
        bh=pJ9feBPMNK8P98DDjfcVQ3MjOh6JJSDCBELiLFJW0/Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AEb+SbfVnEqzy9sAw8S8W7Dsna+2Ti0y0uKakGzBHExV5imlQrA4eK/5pOtUsEKh/
         0FIPZQJCbogiuLn16oNQT0rvO6DRyV0sFmxfTkh0f+eyTETjSXIf0HibsqYyi0PDdD
         4Ir66eRPP0GmuRNgHm/rxf8JqzqbzedGxIYeY8ehjWJdfdEUAHOtyvST6cuPXv8sma
         yBdi3zko892VJ1ewr1u6w02VJHCZty+jHFjJD30AZhETAQpQbj+wEhofprjkGdub/h
         tseS09F0RDIYIzzg78+ZQuAvR+gzKVySOr3bJ25ZyGuTzsmCWIbhjyGZzwP6pyzN9U
         pNux/i4VYQxFw==
Message-ID: <d07884b6-ca82-4e3d-32b0-3ebb0674b64e@kernel.org>
Date:   Mon, 3 Apr 2023 13:48:33 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] phy: ti: j721e-wiz: Fix unreachable code in
 wiz_mode_select()
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
        kishon@kernel.org
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com, t-patil@ti.com
References: <20230403094552.929108-1-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230403094552.929108-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.9 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 03/04/2023 12:45, Siddharth Vadapalli wrote:
> In the wiz_mode_select() function, the configuration performed for
> PHY_TYPE_USXGMII is unreachable. Fix it.
> 
> Fixes: b64a85fb8f53 ("phy: ti: phy-j721e-wiz.c: Add usxgmii support in wiz driver")
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
