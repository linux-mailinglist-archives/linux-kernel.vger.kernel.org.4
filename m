Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E99747199AD
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:27:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233690AbjFAK1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233653AbjFAK0y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:26:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59096133;
        Thu,  1 Jun 2023 03:25:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E0F7D61BD6;
        Thu,  1 Jun 2023 10:25:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05203C433D2;
        Thu,  1 Jun 2023 10:25:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1685615156;
        bh=J5PTgg07FtlSE5yT6AkxfgZJcCj7NTpwejYwxKQwpPg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=KJaqoPbkiqGesUppSQ5Da3OBWTCOpNX+C+b1s9lvU1wZzuXXg3xSXkr1ZNL+HHZ8Q
         BUjbYTCItyZg6stkBsmUvW5p9bOIAOzXY7GmsJMSEeI4uebxLvOf/feMfSC9fdE90d
         Gz8CuE4GAeuS2+945rsnO9HSiepngW3L4mFlNBNs=
Date:   Thu, 1 Jun 2023 11:25:54 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     stable@vger.kernel.org, Pierre Gondois <pierre.gondois@arm.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Sudeep Holla <sudeep.holla@arm.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "open list:GENERIC ARCHITECTURE TOPOLOGY" 
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH stable 6.3 v2] arch_topology: Remove early cacheinfo
 error message if -ENOENT
Message-ID: <2023060134-dismount-obvious-cc5c@gregkh>
References: <20230530201955.848176-1-florian.fainelli@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230530201955.848176-1-florian.fainelli@broadcom.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023 at 01:19:55PM -0700, Florian Fainelli wrote:
> From: Pierre Gondois <pierre.gondois@arm.com>
> 
> commit 3522340199cc060b70f0094e3039bdb43c3f6ee1 upstream

Wait, this is already in 6.3.2, so why add it again?

totally confused,

greg k-h
