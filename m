Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE78F725285
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Jun 2023 05:45:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240833AbjFGDp3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 23:45:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240831AbjFGDpS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 23:45:18 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 622B61BC2;
        Tue,  6 Jun 2023 20:45:03 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0D8B63A20;
        Wed,  7 Jun 2023 03:45:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 40975C4339B;
        Wed,  7 Jun 2023 03:45:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686109502;
        bh=23b85ddF74DRpHqNGxTgfBMNcy0hEkGn39jASt7LXGY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=KozwMzbBcxqF3yspohCRX5N5zMV5Za8U22w+oHAcz4yDr/yx1eMfv3Zq40lwSaijF
         x0eJyRdVwKLJ5NPv9mpvUfstSDXmaXlFVfo34sWCVZGru8tfdtocvayA4TeNF9Idp9
         UyUJaAe2AgbYmC4GdN/M3yHcRS3KEZ79wX8Oe5mQV0F5bXNFUWoWC8zS5WELlJj4Dj
         obSKgYeqc9TnlFJn/AMk5GftaUWN2PwejIPzl3Z2Tyd2ZANoYWY7TGLx4enOa1SO9U
         GoyaGShdEoxet7hftBuqRs9b9NwWeZs0dDCSJDgrh48NEQnUJO8oyI1tmKgKo6XNim
         D7EnPd94tiBww==
Date:   Tue, 6 Jun 2023 20:45:00 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Justin Chen <justin.chen@broadcom.com>
Cc:     netdev@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        bcm-kernel-feedback-list@broadcom.com,
        florian.fainelli@broadcom.com, davem@davemloft.net,
        edumazet@google.com, pabeni@redhat.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        opendmb@gmail.com, andrew@lunn.ch, hkallweit1@gmail.com,
        linux@armlinux.org.uk, richardcochran@gmail.com,
        sumit.semwal@linaro.org, christian.koenig@amd.com,
        simon.horman@corigine.com
Subject: Re: [PATCH net-next v6 3/6] net: bcmasp: Add support for ASP2.0
 Ethernet controller
Message-ID: <20230606204500.04083bd8@kernel.org>
In-Reply-To: <024a6733-f552-c538-2b59-26058c750d66@broadcom.com>
References: <1685657551-38291-1-git-send-email-justin.chen@broadcom.com>
        <1685657551-38291-4-git-send-email-justin.chen@broadcom.com>
        <20230602235859.79042ff0@kernel.org>
        <956dc20f-386c-f4fe-b827-1a749ee8af02@broadcom.com>
        <20230606171605.3c20ae79@kernel.org>
        <8601be87-4bcb-8e6b-5124-1c63150c7c40@broadcom.com>
        <20230606185453.582d3831@kernel.org>
        <024a6733-f552-c538-2b59-26058c750d66@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 6 Jun 2023 19:33:13 -0700 Justin Chen wrote:
> >> Not netdevs per se, but packets can be redirected to an offload
> >> co-processor.  
> > 
> > How is the redirecting configured?
> 
> Through filters that can be programmed by the Host cpu or co-processor.

How are the filter programmed by the host (in terms of user API)?
