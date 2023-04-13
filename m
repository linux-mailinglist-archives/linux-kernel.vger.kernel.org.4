Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DE53F6E13F6
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 20:18:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbjDMSSf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 14:18:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDMSSd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 14:18:33 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 836BD4680
        for <linux-kernel@vger.kernel.org>; Thu, 13 Apr 2023 11:18:32 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 39CBA21902;
        Thu, 13 Apr 2023 18:18:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
        t=1681409911; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtbF+8VJeSvVndtxt+HzkIc3ESADEiMg6feU5WEP9tk=;
        b=PN4p5RFj/TKrXXWp0c+7fLGwkjwiEPnWdM1g+6jW816rmMzyn1edswqyCREIpbC7hG4RIS
        QycCBfm/CjUXFS21UAOcnt0haN40UWvfcgJPSotQWHT4VJaDXS5Tv++oD4aGK0zZWCxLhO
        NCiZd3NkMDhShZTXXcV7eiQ2ZoAEmhA=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
        s=susede2_ed25519; t=1681409911;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=YtbF+8VJeSvVndtxt+HzkIc3ESADEiMg6feU5WEP9tk=;
        b=EeFgwJIb74gGpnn5iImYfg3c4pxxXhgjgnt8mWEfjLx66mouuRCJ3USbI+4Lha97eJQzqJ
        aPiEUvvQW3vRiSDw==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 21C1413421;
        Thu, 13 Apr 2023 18:18:31 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id B8+GBndHOGQQLAAAMHmgww
        (envelope-from <iivanov@suse.de>); Thu, 13 Apr 2023 18:18:31 +0000
Date:   Thu, 13 Apr 2023 21:18:30 +0300
From:   "Ivan T. Ivanov" <iivanov@suse.de>
To:     Stefan Wahren <stefan.wahren@i2se.com>
Cc:     Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        Tim Gover <tim.gover@raspberrypi.com>,
        Phil Elwell <phil@raspberrypi.com>,
        linux-rpi-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: Add nvmem node for BCM2711 bootloader
 public key
Message-ID: <duuhz5pju4q7lnvzwndcnruqwqzbwy4jhrfn42vov2rfct4i7c@qh55cifhoud7>
References: <20230413085206.149730-1-iivanov@suse.de>
 <20230413085206.149730-3-iivanov@suse.de>
 <9b03551a-278d-16dc-08ed-1ef0f89dc79c@i2se.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <9b03551a-278d-16dc-08ed-1ef0f89dc79c@i2se.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-13 18:15, Stefan Wahren wrote:
> 
> Hi Ivan,
> 
> Am 13.04.23 um 10:52 schrieb Ivan T. Ivanov:
> > From: Tim Gover <tim.gover@raspberrypi.com>
> > 
> > Make a copy of the bootloader secure-boot public key available to the OS
> > via an nvmem node. The placement information is populated by the
> > Raspberry Pi firmware if a public key is present in the BCM2711
> > bootloader EEPROM.
> 
> It would be nice to have a helpful link like:
> https://www.raspberrypi.com/documentation/computers/configuration.html#nvmem-nodes

Yep, make sense.

> > +
> > +	/*
> > +	 * RPi4 will copy the binary public key blob (if present) from the bootloader
> > +	 * into memory for use by the OS.
> > +	 */
> > +	blpubkey: nvram@1 {
> > +		compatible = "raspberrypi,bootloader-public-key", "nvmem-rmem";
> 
> Yes this looks better, but this introduce a new dtbs_check issue. The new

Oops, yes, I forgot to make this check.

> compatible must be documented in
> Documentation/devicetree/bindings/nvmem/rmem.yaml in a separate patch and
> reviewed by the DT guys.

Or I can drop the new compatible string altogether? It looks like
only alias is strictly required?! Tim Gover is this correct?

Regards,
Ivan

