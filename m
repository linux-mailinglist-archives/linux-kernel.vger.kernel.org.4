Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B46E5B5587
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 09:47:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229900AbiILHrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 03:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229969AbiILHrb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 03:47:31 -0400
X-Greylist: delayed 1194 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Mon, 12 Sep 2022 00:47:30 PDT
Received: from tartarus.angband.pl (tartarus.angband.pl [51.83.246.204])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FDED1A070;
        Mon, 12 Sep 2022 00:47:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=angband.pl;
        s=tartarus; h=In-Reply-To:Content-Transfer-Encoding:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=rDAY+PXvMHVXB1rpWjR688e1sfAlKdloAGloFsV+rhY=; b=WDokHuP7cC6GzTYCqmb/0MEKSH
        BAxObhiqkjPi/Q4AmdeaBK7rHEbo7Mvd7raX/CjdbxOU1b8CSdGN9ToRGjAG5DxLHEVvCFvqTZlkW
        cWNFzcZ0yuMjy5nb5QF+N4NEr2pHetWsjgudRnTLE/LBMigKXZSZ/QaSxeoe6OZXkcjQ=;
Received: from kilobyte by tartarus.angband.pl with local (Exim 4.94.2)
        (envelope-from <kilobyte@angband.pl>)
        id 1oXdqP-0009kf-TW; Mon, 12 Sep 2022 09:27:02 +0200
Date:   Mon, 12 Sep 2022 09:27:01 +0200
From:   Adam Borowski <kilobyte@angband.pl>
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        keyrings@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>,
        linux-kbuild@vger.kernel.org
Subject: Re: [PATCH] certs: make system keyring depend on built-in x509 parser
Message-ID: <Yx7fRV3YafRAN1/o@angband.pl>
References: <20220912065210.7932-1-masahiroy@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220912065210.7932-1-masahiroy@kernel.org>
X-Junkbait: aaron@angband.pl, zzyx@angband.pl
X-SA-Exim-Connect-IP: <locally generated>
X-SA-Exim-Mail-From: kilobyte@angband.pl
X-SA-Exim-Scanned: No (on tartarus.angband.pl); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Sep 12, 2022 at 03:52:10PM +0900, Masahiro Yamada wrote:
> Commit e90886291c7c ("certs: make system keyring depend on x509 parser")
> is not the right fix because x509_load_certificate_list() can be modular.

... oif.

> --- a/certs/Kconfig
> +++ b/certs/Kconfig
> @@ -43,7 +43,7 @@ config SYSTEM_TRUSTED_KEYRING
> -	depends on X509_CERTIFICATE_PARSER
> +	depends on X509_CERTIFICATE_PARSER = y

This works.


Meow!
-- 
⢀⣴⠾⠻⢶⣦⠀
⣾⠁⢠⠒⠀⣿⡁ A white dwarf seeks a red giant for a binary relationship.
⢿⡄⠘⠷⠚⠋⠀
⠈⠳⣄⠀⠀⠀⠀
