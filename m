Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68CA168EE53
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 12:56:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231133AbjBHL4J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 06:56:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229457AbjBHL4H (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 06:56:07 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 052B546151;
        Wed,  8 Feb 2023 03:56:07 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id ADE6DB81D66;
        Wed,  8 Feb 2023 11:56:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8A4FC433D2;
        Wed,  8 Feb 2023 11:56:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1675857364;
        bh=gazmHH0ZzI7ztSf9tvICnb3LF83/e/Rwgtm+P+Mgtcw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eAcX9ePzKNJZ1k7CUjO+5VnoaYT7o+TJYoxG+A/o3nS9E5p9bzLybtWJMhSVYgrq9
         qAQ3lMQX0AvnZ11BpqCa+xrfH59dG7DYhbQlYKj9WBekj4032FA5LOk1W12dJGXkM2
         nPAgEBZsgwX+sCip+MsC6xZODZYFCONWSuayh9Ew=
Date:   Wed, 8 Feb 2023 12:56:01 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Tharunkumar.Pasumarthi@microchip.com
Cc:     Kumaravel.Thiagarajan@microchip.com, arnd@arndb.de,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        UNGLinuxDriver@microchip.com, lkp@intel.com
Subject: Re: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+ON0TC30SOUzP91@kroah.com>
References: <20230116192908.2980862-1-kumaravel.thiagarajan@microchip.com>
 <Y8pzIgeMyf2oNCn4@kroah.com>
 <PH7PR11MB59587A0639FE44245A68312B9BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y+DLVwfOjEKYJpyB@kroah.com>
 <PH7PR11MB59589EE1C7787496316C04339BDA9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <Y+E9iRWyxqOjO4UX@kroah.com>
 <PH7PR11MB5958A72A7165DF1EF28724709BDB9@PH7PR11MB5958.namprd11.prod.outlook.com>
 <PH7PR11MB5958A5B33798411DE2EBC90E9BDB9@PH7PR11MB5958.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PH7PR11MB5958A5B33798411DE2EBC90E9BDB9@PH7PR11MB5958.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 10:34:47AM +0000, Tharunkumar.Pasumarthi@microchip.com wrote:
> > From: Tharunkumar Pasumarthi - I67821
> > Sent: Tuesday, February 7, 2023 3:22 PM
> > To: Greg KH <gregkh@linuxfoundation.org>
> > Subject: RE: [PATCH v3 char-misc-next] misc: microchip: pci1xxxx: Add
> > OTP/EEPROM driver for the pci1xxxx switch
> > 
> > >
> > > I have no context here as to what the code actually looked like
> > > anymore, so I do not know what is going on anymore, sorry.
> > 
> > Greg, I addressed all the comments received for V2 version of the patch
> > (except for the one in discussion).
> > Shall I send V3 patch so that you will be able to get back previous context?
> 
> Sorry, I meant to ask if I could send V4 patch (not V3) addressing V3 comments.

You never need to ask if you can send a new patch series.  It is
implied, always do so if changes have been made.

thanks,

greg k-h
