Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 527337031BF
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 17:40:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242162AbjEOPku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 11:40:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238157AbjEOPks (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 11:40:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7C30F4;
        Mon, 15 May 2023 08:40:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7CA3A6264E;
        Mon, 15 May 2023 15:40:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA016C433D2;
        Mon, 15 May 2023 15:40:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684165245;
        bh=rFnD4U1nT4DNo3mnKCFI1XD74BVKYN/wnhMUD12GbHE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aRQgZ8zZnZ2WecfVIogaEhqNvGU3EIpCpE0mIjWk7kdt1NJKmR4G5vfmxi/1Mibkz
         rgvXETIrGAOK4Hzf5ydH7K8PdwRHiTAL56fuUMdGbTOutm2TkEEpCX0Duf5FEgUPmO
         jn/5q8lkcSMnXaFTtDo2QJfsmIVlL3z6qxRzWYJOv209BeLlO6k08RfOsKYTR9k2F3
         uicdCpRpGPBxVRyJ4w58hfkVi1u+F4E6YNQzAetm2PqHh8Uwdljhld4x/r3VmklfLm
         WQ0uQnNbKK0Fj1rYG8I/rA4+SNqWomgT7JJJoi8t5/8DGRFSevIh50KpK1yvF9Zovh
         3iYE4RFV7f7bw==
Date:   Mon, 15 May 2023 16:40:40 +0100
From:   Lee Jones <lee@kernel.org>
To:     Henning Schild <henning.schild@siemens.com>
Cc:     Pavel Machek <pavel@ucw.cz>, Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-kernel@vger.kernel.org, linux-leds@vger.kernel.org,
        platform-driver-x86@vger.kernel.org
Subject: Re: [PATCH v2 0/3] leds: simatic-ipc-leds-gpio: split up
Message-ID: <20230515154040.GX10825@google.com>
References: <20230301170215.23382-1-henning.schild@siemens.com>
 <20230513120818.21b99596@md1za8fc.ad001.siemens.net>
 <20230515095042.GE8963@google.com>
 <20230515120138.66e48bd4@md1za8fc.ad001.siemens.net>
 <20230515121247.GB10825@google.com>
 <20230515170654.7aaae69c@md1za8fc.ad001.siemens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230515170654.7aaae69c@md1za8fc.ad001.siemens.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 May 2023, Henning Schild wrote:

> Am Mon, 15 May 2023 13:12:47 +0100
> schrieb Lee Jones <lee@kernel.org>:
> 
> > On Mon, 15 May 2023, Henning Schild wrote:
> > 
> > > Am Mon, 15 May 2023 10:50:42 +0100
> > > schrieb Lee Jones <lee@kernel.org>:
> > >   
> > > > On Sat, 13 May 2023, Henning Schild wrote:
> > > >   
> > > > > Ping.
> > > > > 
> > > > > As far as i remember this one should be ready to merge.
> > > > > 
> > > > > ACKed by Hans, and Andy had no objections given the maintainers
> > > > > would accept the patches.
> > > > > 
> > > > > So i think it is the maintainers turn now, Pavel and/or Lee i
> > > > > guess.    
> > > > 
> > > > Looks like there are lots of mail threads in reply to each of the
> > > > patches.  If these culminated in acceptance, please collect all
> > > > of the Acks you've received until this point and submit a
> > > > [RESEND].  If there are changes to be made still, please do the
> > > > same but submit as a new version.  
> > > 
> > > Ok i will send it again and include the ACK from Hans. There would
> > > be no code change. Please review the code already, if you find it
> > > acceptable we might receive a second ACK from Andy.  
> > 
> > Not sure what you mean by 'already'.
> > 
> > I shall not be reviewing this set until it is resent, thanks.
> 
> I just sent that v3 you requested. It has one Ack from Hans in p3. And
> some minor style things from Andy, which i decided to take in when
> having to rebase and test once more.
> 
> Looking forward to your feedback on that v3.

Thanks.  It's marked for review.

Just to set expectation, you are number 49 in the queue.

-- 
Lee Jones [李琼斯]
