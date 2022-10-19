Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E717060393A
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 07:28:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229802AbiJSF2l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 01:28:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229587AbiJSF2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 01:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1996FA2F;
        Tue, 18 Oct 2022 22:28:38 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 18DDA6176C;
        Wed, 19 Oct 2022 05:28:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 90922C43470;
        Wed, 19 Oct 2022 05:28:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1666157317;
        bh=zcvlAPCMUxoBZOtKn7CdHbj2emRTExlH2yMzgliRJoQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=RasJl0Hr14fJTyGEQK/ynOvBRb7f6CmvrzoPLZml/au6P4VbE2hXZAvZZrWOVC+D1
         at0DSJVa1+bOtXkFc7qqE7NueIxEeTZNsk5u650BpmrARKxkSzYAUq3z7xfJkzGOow
         vnIpTWWQl0mliUuN1e0l/a2AdcgBi9uj0cijUnTEeCaKSl2+64nDJ4uhzVZnFiDaTh
         eVuEdgvcwrQOzaNjdCAFbvIlTmq5W9lXfz3LFtoLTvxncF4MLnzGFL9V+h/LJ41zjM
         wouZLAvnhAIfUmFZkWN37ULnz674dan7Tup6MUTC0xhLEgkXCu5r7XRpUIUXCSCuas
         +GFcM5Ct8UTLQ==
Date:   Wed, 19 Oct 2022 10:58:32 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        linux-phy@lists.infradead.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] doc: phy: Document typical order of API calls
Message-ID: <Y0+LAK2UVLOyZS8H@matsya>
References: <20221018175841.1906611-1-sean.anderson@seco.com>
 <e002248f-7070-3f89-04f2-e7f694fad5cc@seco.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <e002248f-7070-3f89-04f2-e7f694fad5cc@seco.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18-10-22, 14:01, Sean Anderson wrote:
> Hi Vinod,
> 
> When sending this patch, I noticed that Kishon's email bounced. Is he

See 76845ba539c3 is phy/fixes

-- 
~Vinod
