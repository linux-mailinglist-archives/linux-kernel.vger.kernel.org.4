Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CCD15E5BAF
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 08:52:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiIVGwr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 02:52:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35066 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbiIVGwn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 02:52:43 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2FA4B6D58;
        Wed, 21 Sep 2022 23:52:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 4C465CE200D;
        Thu, 22 Sep 2022 06:52:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 09F1CC433D7;
        Thu, 22 Sep 2022 06:52:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1663829558;
        bh=Xp/D0tOAOtdmChTVGjGQ0nVvQdqVzKkrNPPS83XVGfM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ofYywo4alcCDwd/CMlRdnC8uGHycQkeN6BU7wEiiCgD67MX0M1Y5wKMzfLXA3DoEQ
         Bwea3awT8jRbT7Ysm93UXkMmzkUNvzWVIbqrC09FdHi0z15CJxmUfb3GU2iYk1ta89
         uHfujwphCXdzpF3lmAxOYKR6Sztt3Mjuh5jRld/s=
Date:   Thu, 22 Sep 2022 08:53:08 +0200
From:   "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>
To:     "Sanil, Shruthi" <shruthi.sanil@intel.com>
Cc:     "balbi@kernel.org" <balbi@kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Krogerus, Heikki" <heikki.krogerus@intel.com>,
        "Thokala, Srikanth" <srikanth.thokala@intel.com>,
        "Sangannavar, Mallikarjunappa" 
        <mallikarjunappa.sangannavar@intel.com>
Subject: Re: [PATCH 0/2] Update the PCIe device ID's for USB device
 controllers on Alder Lake platforms
Message-ID: <YywGVJUiLvL0dXcX@kroah.com>
References: <20220913055316.23050-1-shruthi.sanil@intel.com>
 <IA1PR11MB621864E69E4782427A5C4816F14E9@IA1PR11MB6218.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <IA1PR11MB621864E69E4782427A5C4816F14E9@IA1PR11MB6218.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 22, 2022 at 05:58:15AM +0000, Sanil, Shruthi wrote:
> Gentle Reminder! 😊

Gentle reminder to never top-post :)
