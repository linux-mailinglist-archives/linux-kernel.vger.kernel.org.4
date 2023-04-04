Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 551E26D6636
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 16:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234757AbjDDO4e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 10:56:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233533AbjDDO4O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 10:56:14 -0400
Received: from todd.t-8ch.de (todd.t-8ch.de [159.69.126.157])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EA5E44A3;
        Tue,  4 Apr 2023 07:56:11 -0700 (PDT)
Date:   Tue, 4 Apr 2023 14:56:08 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=t-8ch.de; s=mail;
        t=1680620170; bh=YlApgOxHSRUtW1h2korvt3P+FHxY5UML+GHECLjEmkk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=hvUlxrG6ljYPKxp8n1yYQWceJ5Kii3GeZHTutHR5uiH533zttHWR9XgPMhDKD7lA2
         /uz8+kK/+eQ3ppqr4bGKya329IE0JGOfniwkAtwf48c4yj2DFi26rRxg0czKjaRFJK
         PjGsIRCeOZvVgZJxGujoijvhxJ2b6jYvaLPOv2wI=
From:   Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas@t-8ch.de>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     Jorge Lopez <jorgealtxwork@gmail.com>, hdegoede@redhat.com,
        Linux x86 Platform Drivers 
        <platform-driver-x86@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Documentation <linux-doc@vger.kernel.org>
Subject: Re: [PATCH v7] Introduction-of-HP-BIOSCFG-driver-documentation
Message-ID: <ee254b4e-579d-4b32-90a4-b28bc10046fe@t-8ch.de>
References: <20230403211548.6253-1-jorge.lopez2@hp.com>
 <ZCuMkdb6jeL4S8hz@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZCuMkdb6jeL4S8hz@debian.me>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

On 2023-04-04 09:33:53+0700, Bagas Sanjaya wrote:
> On Mon, Apr 03, 2023 at 04:15:48PM -0500, Jorge Lopez wrote:
> > HP BIOS Configuration driver purpose is to provide a driver supporting
> > the latest sysfs class firmware attributes framework allowing the user
> > to change BIOS settings and security solutions on HP Inc.’s commercial
> > notebooks.
> > 
> > Many features of HP Commercial notebooks can be managed using Windows
> > Management Instrumentation (WMI). WMI is an implementation of Web-Based
> > Enterprise Management (WBEM) that provides a standards-based interface
> > for changing and monitoring system settings. HP BIOSCFG driver provides
> > a native Linux solution and the exposed features facilitates the
> > migration to Linux environments.
> > 
> > The Linux security features to be provided in hp-bioscfg driver enables
> > managing the BIOS settings and security solutions via sysfs, a virtual
> > filesystem that can be used by user-mode applications. The new 
> > documentation cover features such Secure Platform Management and Sure 
> > Start. Each section provides security feature description and identifies 
> > sysfs directories and files exposed by the driver.
> > 
> > Many HP Commercial notebooks include a feature called Secure Platform
> > Management (SPM), which replaces older password-based BIOS settings
> > management with public key cryptography. PC secure product management
> > begins when a target system is provisioned with cryptographic keys
> > that are used to ensure the integrity of communications between system
> > management utilities and the BIOS.
> > 
> > HP Commercial notebooks have several BIOS settings that control its 
> > behaviour and capabilities, many of which are related to security. 
> > To prevent unauthorized changes to these settings, the system can be 
> > configured to use a cryptographic signature-based authorization string 
> > that the BIOS will use to verify authorization to modify the setting.
> 
> If this is single patch, I'd like to write the patch subject as
> "Documentation: sysfs: document HP-specific firmware attributes".
> 
> And also, adjust the patch description accordingly, since as it is
> written above, it looks like general documentation of HP-specific feature
> (which should be in actual diff).
> 
> > Version 7
> > 	Includes only sysfs-class-firmware-attributes documentation
> 
> Where is the rest of patches if this is a series? Had they been merged?

It was my proposal to focus on the documentation first in a single
patch.
So we can nail down the scope and details of the user-facing API without
Jorge and the reviewers spending time on polishing internals that will
change anyways.

The code exists and will be submitted with future revisions again.
You can find v6 with the code here:
https://lore.kernel.org/all/20230309201022.9502-1-jorge.lopez2@hp.com/

I should have also requested a note to that point with this revision.

Thomas
