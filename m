Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF36A6C12C9
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 14:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231508AbjCTNKW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 09:10:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229684AbjCTNKT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 09:10:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3400F970
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 06:10:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 51C3B614B7
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 13:10:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0EE61C433D2;
        Mon, 20 Mar 2023 13:10:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679317816;
        bh=+ISdV6ZYvcWZ8PwpMZtUIgNfgk0uRP/Q4D+J9OXgG8s=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=pCpIY+wRVieNcNhhKYG5dQJSmivu8kDrwjaeQuVZXCiNuFBeWeB0ZbQJdv5dN7rGO
         fnNsGM1zrz2i31UgJaYgIf6IVpL2G9luCA5rj7/wgi3tCj5lqze5zJMqFxGIEbKFMz
         tz6U6sdnDs/1xL7eipu4X2lTuIc9Xfo7mcX4vpPVUyvwIXcDibZsu1TWN+hx5QZdT2
         epjshh6W4yqfnyIaVAUQ36ORizaKwWvlg7L5FGsY6w8afbaXQL1iFHd9qcQD4pbwRP
         cwyeg25M2cW9RkXf0FBk/cir8RSMjij0G95/GtyLrfpvxJDHKSP3E6P/QiLnFH3nx0
         xvY/Oc545gCqA==
Message-ID: <c2275a29-a241-8c36-0dc9-16fc8955243e@kernel.org>
Date:   Mon, 20 Mar 2023 15:10:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] phy: ti: j721e-wiz: Add SGMII support in WIZ driver for
 J721E
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
        kishon@kernel.org
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, srk@ti.com
References: <20230309092434.443550-1-s-vadapalli@ti.com>
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230309092434.443550-1-s-vadapalli@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 09/03/2023 11:24, Siddharth Vadapalli wrote:
> Enable full rate divider configuration support for J721E_WIZ_16G for SGMII.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
