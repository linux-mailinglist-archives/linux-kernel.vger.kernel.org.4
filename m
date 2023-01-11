Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC23665EE2
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 16:17:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238692AbjAKPRA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 10:17:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47306 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235295AbjAKPQr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 10:16:47 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 886AAF58C
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 07:16:45 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id DDAD0CE1BCE
        for <linux-kernel@vger.kernel.org>; Wed, 11 Jan 2023 15:16:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1EF34C433F1;
        Wed, 11 Jan 2023 15:16:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673450202;
        bh=fFLqTcQNwLu0CsRaw3Xnu2gv0QW9Ki3xX4+eSs6i54s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=c3vmkxZv3lvuQb/VNRoDNM7FSHASMDfX6xpCLjXchEHwuPRNyRNwPjltmeMEzK3Ru
         067GSJofKaXCJ9G0tzWSnwPfv0vTz781jHuPpMe0tpN2YoZh8LVaTIOmT06BTPxxo3
         FpQGRZVtBGGU0cUl5gG06UM+uT+bGmuTIVQuF/tdzJJOXewT35A471w78XVyuTws1X
         e71IEUSvKojJS91aOK82RakTpM7cgaJbTPTf4ONj1Z7BeU/14/Na692zcZC+LOf3V3
         odYNf6z15SoKiPd0adutLaDHOAfgytOGjXVgK8u7xwl8UiedxZ0v0k1uC2fweDtLLj
         dOh/qE0q5YSYg==
Message-ID: <3423a83e-a937-d158-9123-5a85fdf9b07c@kernel.org>
Date:   Wed, 11 Jan 2023 17:16:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V3 2/2] phy: ti: j721e-wiz: Add support to enable LN23
 Type-C swap
Content-Language: en-US
To:     Sinthu Raja <sinthu.raja@mistralsolutions.com>,
        Vinod Koul <vkoul@kernel.org>,
        Ravi Gunasekaran <r-gunasekaran@ti.com>,
        Siddharth Vadapalli <s-vadapalli@ti.com>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        Sinthu Raja <sinthu.raja@ti.com>
References: <20230111111356.17392-1-sinthu.raja@ti.com>
 <20230111111356.17392-3-sinthu.raja@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230111111356.17392-3-sinthu.raja@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2023 13:13, Sinthu Raja wrote:
> From: Sinthu Raja <sinthu.raja@ti.com>
> 
> The WIZ acts as a wrapper for SerDes and has Lanes 0 and 2 reserved
> for USB for type-C lane swap if Lane 1 and Lane 3 are linked to the
> USB PHY that is integrated into the SerDes IP. The WIZ control register
> has to be configured to support this lane swap feature.
> 
> The support for swapping lanes 2 and 3 is missing and therefore
> add support to configure the control register to swap between
> lanes 2 and 3 if PHY type is USB.
> 
> Signed-off-by: Sinthu Raja <sinthu.raja@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>


--
cheers,
-roger
