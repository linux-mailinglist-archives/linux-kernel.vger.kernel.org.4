Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 181846B2BAE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 18:10:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230409AbjCIRJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 12:09:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41208 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjCIRJF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 12:09:05 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2772C497E2
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 09:06:02 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D2375B81FFC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 17:06:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16C99C433D2;
        Thu,  9 Mar 2023 17:05:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1678381559;
        bh=RSAcqfw4DMiJLx3ImYjFMzMWkPOStE1x/RPh9faErv8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=et4WE6hm2isC5kXMdE+ecn3CDmiqVOOnkljYx1MXTIqaakWdZ4hwV1MXy5gmLRHLB
         cNno5cB/DxyAraiUtPwPo02Km5mxNUFNVuQB2UsM94wnYuHHbke28mgOtyBgJE1Ya7
         +zotgLElptdLwreqs5LcYmcuVKoi5tl8O7VUSINo=
Date:   Thu, 9 Mar 2023 18:05:56 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     Arnd Bergmann <arnd@arndb.de>, Paul Menzel <pmenzel@molgen.mpg.de>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>, linux-kernel@vger.kernel.org,
        openbmc@lists.ozlabs.org,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        Thang Nguyen <thang@os.amperecomputing.com>
Subject: Re: [PATCH v2 2/2] misc: smpro-errmon: Add dimm training failure
 syndrome
Message-ID: <ZAoR9EnGBAwGaF0l@kroah.com>
References: <20230228092010.1863419-1-quan@os.amperecomputing.com>
 <20230228092010.1863419-3-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230228092010.1863419-3-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 28, 2023 at 04:20:10PM +0700, Quan Nguyen wrote:
> Adds event_dimm[0-15]_syndrome sysfs to report the failure syndrome
> to BMC when DIMM training failed.
> 
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> v2:
>   + Change "to initialized" to "to initialize"            [Paul]
>   + Corrected kernel version to 6.3                  [Greg,Paul]

Sorry, but this is going to have to be 6.4 now.

thanks,

greg k-h
