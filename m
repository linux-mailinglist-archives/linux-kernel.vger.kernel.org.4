Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 351186BA660
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 05:55:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230310AbjCOEzB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 00:55:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCOEzA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 00:55:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4224828EAD
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 21:54:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E82A7B81C6F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 04:54:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279AAC433EF;
        Wed, 15 Mar 2023 04:54:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678856096;
        bh=O6RvoiLqHVNWRlSjoPOvDZ5ZcrH3mZW23TYkGULvn3I=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U15aTW7BWM4GlSJ5BzvFARwMFMG05aoqqP/ez5goSdwMrrp45aOkyOsp52/xmXXTS
         AdJdJzKg2oNEiB0lQ6PFJvLrUezvjy86NUf1LkFDboQCQj4YyWpD1fDGxc/mfHueSd
         a44h7EzshjETQuloFfVCUD63NCHBYdoeLACvnSUs=
Date:   Wed, 15 Mar 2023 05:54:53 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Alison Schofield <alison.schofield@intel.com>,
        Kloudifold <cloudifold.3125@gmail.com>,
        teddy.wang@siliconmotion.com, sudipm.mukherjee@gmail.com,
        linux-staging@lists.linux.dev, outreachy@lists.linux.dev,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] staging: sm750: Rename function to avoid CamelCase
Message-ID: <ZBFPnZbvdI46Ah6r@kroah.com>
References: <ZA+K6OdPe21k8F2k@CloudiRingWorld>
 <ZA/+JlgWfdg2wH8B@debian.me>
 <ZBCS7DR9dZH1yds8@aschofie-mobl2>
 <5fd67671-8e21-ffa8-8571-d8b5533b4758@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5fd67671-8e21-ffa8-8571-d8b5533b4758@gmail.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 10:08:27AM +0700, Bagas Sanjaya wrote:
> On 3/14/23 22:29, Alison Schofield wrote:
> >> Fixes: <commit that introduces these camelcase function>
> >> ```
> > 
> > Why are you asking for a Fixes tag on this? 
> > Seems unusual for a staging driver cleanup.
> > 
> 
> I thought this style cleanup also warrants Fixes: since
> it fixes coding style problem on existing code (see
> Documentation/process/submitting-patches.rst).

No, sorry, Fixes: is for real bugs, not style issues.
