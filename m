Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE7967348B
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 10:36:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230156AbjASJgh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 04:36:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230121AbjASJg3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 04:36:29 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3A9E5DC06;
        Thu, 19 Jan 2023 01:36:27 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5E581611F8;
        Thu, 19 Jan 2023 09:36:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4365DC433EF;
        Thu, 19 Jan 2023 09:36:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1674120986;
        bh=rj8uvnYLkE+EnCB5eZEiSrC6akGxUsBb4C7W2iCn5YE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ui8GtCdoJDN2oHSD5wvW8X6LyF+6o8YVJQoV5pA3atXR+UUnFg781IS4fLC6jIhrh
         gQMwSkegN0oXrGtR13HPrWcfFfh7VBdpJxXAf9CToICXk1Q1qGuO+bpwLRRQT2tVh9
         MXCZEW19S1i2kGOj1KblPeTxjFow9S784i0ZNjoM=
Date:   Thu, 19 Jan 2023 10:36:23 +0100
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Adrien Thierry <athierry@redhat.com>,
        Dan Carpenter <error27@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Phil Elwell <phil@raspberrypi.com>,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Kieran Bingham <kieran.bingham@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: Re: [PATCH v4 0/6] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Message-ID: <Y8kPF56tqgSnfj6i@kroah.com>
References: <20230118191811.208552-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230118191811.208552-1-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 19, 2023 at 12:48:05AM +0530, Umang Jain wrote:
> The main patch (6/6) is laregly unchanged from v3.
> Specific details are elaborated in its commit message.
> 
> This series just introduces five extra patches for dropping include
> directives from Makefiles (suggested by Greg KH) and rebased.
> 
> Changes in v4: 
> - Introduce patches to drop include directives from Makefile
> 
> Changes in v3:
> - Rework entirely to replace platform devices/driver model
> 
> -v2:
> https://lore.kernel.org/all/20221222191500.515795-1-umang.jain@ideasonboard.com/
> 
> -v1:
> https://lore.kernel.org/all/20221220084404.19280-1-umang.jain@ideasonboard.com/
> 
> Umang Jain (6):
>   staging: vc04_services: Drop __VCCOREVER__ remnants
>   vc04_services: bcm2835-audio: Drop include Makefile directive
>   vc04_services: bcm2835-camera: Drop include Makefile directive
>   vc04_services: vchiq-mmal: Drop include Makefile directive
>   vc04_services: interface: Drop include Makefile directive
>   staging: vc04_services: vchiq: Register devices with a custom bus_type

Your patch subject lines are odd here, many drop the "staging: " prefix.
Please fix up.

thanks,

greg k-h
