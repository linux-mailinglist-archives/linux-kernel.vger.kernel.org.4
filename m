Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9EC3D600632
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Oct 2022 07:17:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229965AbiJQFRr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Oct 2022 01:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbiJQFRo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Oct 2022 01:17:44 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CA1852E57
        for <linux-kernel@vger.kernel.org>; Sun, 16 Oct 2022 22:17:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA892B80F01
        for <linux-kernel@vger.kernel.org>; Mon, 17 Oct 2022 05:17:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C930EC433C1;
        Mon, 17 Oct 2022 05:17:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665983861;
        bh=xdi1PON72UsOm7RryTztPFxGswH9+cIBKTnXL8g/xSc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Spblhtst0tubvcijyo7U98+c/qDehnqqbrhIMPPq2hgy0Dq7YS6T7O602MqOlNwlH
         j2uDuG7mlVJH8XjzySTDgSMUBgI5Xq5W6SRcNo3AWrV4UK7dTXn8OZgJSokPWjSVAb
         qAi/7mz7Mz4kqMO27VTIVtPaYIKm7GVU30xj8jVAuSp/UBifhrjRdPf9TEkKX0V/hY
         FnxQFPQpG+A1D2c6TGqjcZUT2b6QGcZYIoweXGKcklsgx0O4meMglI0q0OVrZFtWE+
         zWV07pH1o1BbHEBIS89vKMHyAIKbuft0QN/Hk/w9azYG17NdXnZBarZsW3RRJ0NhVT
         d/fmw2HMmeMrA==
Date:   Mon, 17 Oct 2022 10:47:37 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@ti.com>
Cc:     linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@kernel.org>
Subject: Re: [PATCH] MAINTAINERS: Update Kishon's email address in GENERIC
 PHY FRAMEWORK
Message-ID: <Y0zlcXW1M0BYNJWW@matsya>
References: <20221014062424.3327-1-kishon@ti.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221014062424.3327-1-kishon@ti.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-10-22, 11:54, Kishon Vijay Abraham I wrote:
> Update Kishon's email address in GENERIC PHY FRAMEWORK maintainer
> entry.

Applied, thanks

-- 
~Vinod
