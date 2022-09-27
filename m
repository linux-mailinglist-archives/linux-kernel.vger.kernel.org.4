Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073725EBD22
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 10:22:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231279AbiI0IWN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 04:22:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231130AbiI0IWH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 04:22:07 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41B03AA4DC;
        Tue, 27 Sep 2022 01:22:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EA68FB8198C;
        Tue, 27 Sep 2022 08:22:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E2E1C433C1;
        Tue, 27 Sep 2022 08:22:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664266922;
        bh=pxlcFe1lsswRR24DUMZ9doZA73cRVv7IeBcyhZAumnA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=BM4602TszfDF8QAGQTdA7Gvipnv3hBv3a3KCs0b0kc5/Or0Jt8SGY2vws66e9Uwhy
         9xL0CiFy5a7NeEAijhH6KpRvM1P8wBG2Gy4PYtw+5pMX7OM3LiJ2Yfc/PGVmoBVF+T
         YgyY8kb10rnFqNwjh6FN+KYfDVE6r0xm74u2xUls=
Date:   Tue, 27 Sep 2022 10:22:00 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-doc@vger.kernel.org, corbet@lwn.net,
        Shuah Khan <skhan@linuxfoundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] Documentation/CoC: Reflect current CoC interpretation
 and practices
Message-ID: <YzKyqNJk72TY//42@kroah.com>
References: <20220926211149.2278214-1-kristen@linux.intel.com>
 <dd89a30e-5403-8844-036c-9c9107cac888@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd89a30e-5403-8844-036c-9c9107cac888@gmail.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 27, 2022 at 03:19:29PM +0700, Bagas Sanjaya wrote:
> On 9/27/22 04:11, Kristen Carlson Accardi wrote:
> > The Code of Conduct interpretation does not reflect the current
> > practices of the CoC committee or the TAB. Update the documentation
> > to remove references to initial committees and boot strap periods
> > since it is past that time, and note that the this document
> > does serve as the documentation for the CoC committee processes.
> > 
> 
> When was the bootstrap period be concluded?

I do not understand the question, sorry.  What exactly are you asking
here?

confused,

greg k-h
