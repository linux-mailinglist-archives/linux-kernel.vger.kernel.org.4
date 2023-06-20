Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D2918736E84
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 16:18:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232753AbjFTOSh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 10:18:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231211AbjFTOSc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 10:18:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F13C91;
        Tue, 20 Jun 2023 07:18:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 13F9461297;
        Tue, 20 Jun 2023 14:18:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F01C9C433C0;
        Tue, 20 Jun 2023 14:18:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1687270710;
        bh=OeEz2tijAZvrCEACa8lKFXkp/VG+HjklbwwH/8dtI1c=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JyPNbTD2K+CLX+1/qZuwjr+kkkPE3G/xUO8w8u0ly0O7RasjLLoFPChsMT7Dbu4j3
         DlWSXpnjmln+w5uFkJofTlqJS0qPOf7jaLq+V/t16XG3oho69OZ1nGZ4igPcmtUGtu
         2KUjXbd+80I9q4+n2s8VeGV3muAtYMkm869RJdLQ=
Date:   Tue, 20 Jun 2023 16:18:27 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Umang Jain <umang.jain@ideasonboard.com>
Cc:     linux-staging@lists.linux.dev,
        linux-rpi-kernel@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-media@vger.kernel.org,
        linux-kernel@vger.kernel.org, stefan.wahren@i2se.com,
        f.fainelli@gmail.com, athierry@redhat.com, error27@gmail.com,
        dave.stevenson@raspberrypi.com, kieran.bingham@ideasonboard.com,
        laurent.pinchart@ideasonboard.com
Subject: Re: [PATCH v7 0/5] staging: vc04_services: vchiq: Register devices
 with a custom bus_type
Message-ID: <2023062010-sandblast-senate-a00c@gregkh>
References: <20230620134152.383569-1-umang.jain@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230620134152.383569-1-umang.jain@ideasonboard.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 20, 2023 at 07:11:47PM +0530, Umang Jain wrote:
> The patch series added a new bus type vchiq_bus_type and registers
> child devices in order to move them away from using platform
> device/driver.
> 
> Patch 1/5 and 2/5 adds a new bus_type and registers them to vchiq
> interface
> 
> Patch 3/5 and 4/5 moves the bcm2835-camera and bcm2835-audio
> to the new bus respectively
> 
> Patch 5/5 removes a platform registeration helper which is no
> longer required.

License issues asside, this looks very good, thanks for doing this!

greg k-h
