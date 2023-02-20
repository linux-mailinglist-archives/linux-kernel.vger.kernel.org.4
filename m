Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE7B369D13F
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 17:20:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231785AbjBTQUk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 11:20:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35346 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231562AbjBTQUi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 11:20:38 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB1B64C2C
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 08:20:36 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8D0F7B80D56
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 16:20:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BA5D4C433EF;
        Mon, 20 Feb 2023 16:20:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676910034;
        bh=GugI1KTqWeJVvUyOogjWDktfwoNGBavCoLV6GdN8qsc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=mkJRVa8mY/VCQYWMTYkp32KrFyOEpyGMQ9PAktnv65UqNwY6FW3HgNMb8GSNN8PKC
         gIbi3BgsMHVLWhw0olblPpOXH+1I5CvAftFH7QaHeWTwp0KQ62e2upIax2qOaMPfh4
         jPPL+fWh+27uQE7IRuC35rpYSPNwPiBC6oM6cE79g7eJ3LscY/G1+foTJArNaE1pX6
         9z7huhzdsmjSJnDpwEUq1vjjrO4GleRNhBuLpo9toauOX2HPt5/5KAmDlyDHLD1yy0
         Huk7b0pJu1InzeDdPyFMTyYfMwFHYde4y8WWSUXEHBio3Qe/Q5xIriaMI69UngI9ey
         LtgamDtIIyKxA==
Message-ID: <c7bdaf8f-d377-9fdc-c11a-747c65775b3c@kernel.org>
Date:   Mon, 20 Feb 2023 18:20:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] phy: cadence: Sierra: Add PCIe + SGMII PHY multilink
 configuration
To:     Swapnil Jakhade <sjakhade@cadence.com>, vkoul@kernel.org,
        kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org
Cc:     mparab@cadence.com
References: <20230220141216.25326-1-sjakhade@cadence.com>
Content-Language: en-US
From:   Roger Quadros <rogerq@kernel.org>
In-Reply-To: <20230220141216.25326-1-sjakhade@cadence.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/02/2023 16:12, Swapnil Jakhade wrote:
> Add register sequences for PCIe + SGMII PHY multilink configuration.
> This has been validated on TI J7 platforms.
> 
> Signed-off-by: Swapnil Jakhade <sjakhade@cadence.com>

Reviewed-by: Roger Quadros <rogerq@kernel.org>
