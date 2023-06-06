Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2A7724A70
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 19:40:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238601AbjFFRkg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 13:40:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238525AbjFFRke (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 13:40:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D60E210FB;
        Tue,  6 Jun 2023 10:40:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6AA7E6358E;
        Tue,  6 Jun 2023 17:40:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7B479C433D2;
        Tue,  6 Jun 2023 17:40:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1686073232;
        bh=WYxf/3Q3ln0EtcKEcOkqpMWLUxAkgN2J4JRyFAg4gyU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Z2OGSHabkH8afvGv/EumlxXeAVNv+x5MZ4PVmZaqjZDL/ijODNqxg5uBc2nEqjbr1
         i6uwthT90fO7vOPsB+7kyT+Q+adJGxu+1LWS+r/zIRhvF+tsoI45+60eZoPzVT8iYR
         parKj/ck55/+vPfMQUK8XmQzyQzKUH4uxoWfqwHk=
Date:   Tue, 6 Jun 2023 19:40:30 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Jeremi Piotrowski <jpiotrowski@linux.microsoft.com>
Cc:     linux-kernel@vger.kernel.org, dpark@linux.microsoft.com,
        t-lo@linux.microsoft.com, stable@vger.kernel.org
Subject: Re: soft lockup on Ampere Altra on v6.1.30
Message-ID: <2023060606-shininess-rosy-7533@gregkh>
References: <20230606144752.GA31904@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606144752.GA31904@linuxonhyperv3.guj3yctzbm1etfxqx2vob5hsef.xx.internal.cloudapp.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 06, 2023 at 07:47:52AM -0700, Jeremi Piotrowski wrote:
> We're currently trying to update the kernel in our distro (Flatcar) from
> v5.15.x to v6.1.x. When testing on Equinix Metal Ampere instances
> (c3.large.arm64) we now get a soft lockup about a minute after boot.
> 
> Has anyone else seen this? The splat looks like this, full dmesg is at [1]
> (trying without the attachement this time as LKML detects my mail as spam :/)

You might have better luck asking on the ARM lists, the stable@ list is
for patches to add or other fixes, not generic failures like this one.

Also, why not take a working 6.1.x kernel for this platform (which I
know they are out there) and comparing it to yours?

Good luck!

greg k-h
