Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C7B699306
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:21:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229619AbjBPLVD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:21:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230419AbjBPLVA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:21:00 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE3263773A
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 03:20:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6A52861F95
        for <linux-kernel@vger.kernel.org>; Thu, 16 Feb 2023 11:20:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BC79C43442;
        Thu, 16 Feb 2023 11:20:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676546458;
        bh=6bI7jsNbZTwBBRqEFqYLHlNLFEBEHtYd8vD9dEevHTc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=VqCI/RZQRnsEyXOI84cvBBW23cEBJ5X29WEN+Kj18jSpwbOUdyDh0cmTzWTI2EzdD
         Qv3t15Jsas5eU7zkR0sXktK89MsSYhEGVPZASSYnBdk5aNHnYaNPYJ3V6TRGcWuGFy
         v5rJYonT8EcgdvfRoTCUuo95FeQCOjX+tAQ46ZTM=
Date:   Thu, 16 Feb 2023 12:20:49 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kris Chaplin <kris.chaplin@amd.com>
Cc:     Ruslan Bilovol <ruslan.bilovol@gmail.com>,
        Willy Tarreau <w@1wt.eu>, Theodore Ts'o <tytso@mit.edu>,
        Michal Simek <michal.simek@amd.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: Re: Reg the next LTS kernel (6.1?)
Message-ID: <Y+4RkU0x9VRYcUGv@kroah.com>
References: <c6c4787f-f0c6-7285-f782-d36bd86b1e01@amd.com>
 <96e41e6d-bec9-f8cf-22ed-1fa5d9022238@amd.com>
 <Y8FAFAwB9gBzQXQG@kroah.com>
 <314489f6-cb54-fb3b-6557-d69b1284fa4d@amd.com>
 <Y8GFYEnIy0Wbh/n6@kroah.com>
 <Y8HPw2t+TbdXa83C@mit.edu>
 <20230114071412.GB5088@1wt.eu>
 <Y8JnHyKNTHMjsHSb@kroah.com>
 <CAB=otbS2uwfm0+YHMXXY3TM94V82LtxgcBXGZq1Zxbvd36Wkug@mail.gmail.com>
 <2e2c9362-1f4e-a183-e619-c5dc3e56324a@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2e2c9362-1f4e-a183-e619-c5dc3e56324a@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 10:41:01AM +0000, Kris Chaplin wrote:
> On 05/02/2023 06:27, Ruslan Bilovol wrote:
> 
> > So, is there a final decision taken on what will be our next LTS?
> > Went through https://kernel.org/category/releases.html but it still shows
> > v5.15 as the latest LTS version.
> 
> No announcement has been made yet on this - my understanding is that a
> greater volume and community involvement in testing and feedback is required
> to indicate the quality of 6.1 (currently 6.1.12) prior to Greg making that
> decision on behalf of the community.

Have you looked at the above link recently?  :)
