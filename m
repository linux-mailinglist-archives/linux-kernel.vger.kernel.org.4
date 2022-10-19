Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E81660423C
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 12:57:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234698AbiJSK5L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 06:57:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232696AbiJSK4V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 06:56:21 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21860165534
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 03:27:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id CC014B82266
        for <linux-kernel@vger.kernel.org>; Wed, 19 Oct 2022 10:26:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 383B5C433C1;
        Wed, 19 Oct 2022 10:26:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1666175166;
        bh=q3wB9AHPfSgAsJujP8BvTKO/CDtsqsSvPvYepL4KvFU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=tFloPUaEbs3jjuWbZCy6GywUaf6ebxA37OI5iV/zqKHsRoMYwrtSPmntvPPm1n0/O
         /7GBR8WKKXICD7vGH/YhwldrljCdyb1RPkhzELxlQYpQSP9XeW+SUdehU+NWKy89ey
         ed5FxBIlvFm8TPH94+9ymnGOQ7yIKmu46Wd0FAEQ=
Date:   Wed, 19 Oct 2022 12:26:03 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Alexander Atanasov <alexander.atanasov@virtuozzo.com>
Cc:     Nadav Amit <namit@vmware.com>,
        VMware PV-Drivers Reviewers <pv-drivers@vmware.com>,
        Arnd Bergmann <arnd@arndb.de>, kernel@openvz.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v5 6/8] drivers: vmware: balloon - report inflated
 memory
Message-ID: <Y0/Qu0eSYFqtuC/v@kroah.com>
References: <20221019095620.124909-1-alexander.atanasov@virtuozzo.com>
 <20221019095620.124909-7-alexander.atanasov@virtuozzo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221019095620.124909-7-alexander.atanasov@virtuozzo.com>
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 19, 2022 at 12:56:18PM +0300, Alexander Atanasov wrote:
> Update the inflated memory in the mm core on change.

That says what this does, but not why it is needed.

Please expand on this.

Also, is this actually fixing a bug?  Is it a new feature?  Something
else?

thanks,

greg k-h
