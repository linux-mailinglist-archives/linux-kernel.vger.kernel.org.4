Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C884B5FEB72
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 11:20:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229716AbiJNJUM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 05:20:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229513AbiJNJUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 05:20:08 -0400
Received: from smtp-out1.suse.de (smtp-out1.suse.de [IPv6:2001:67c:2178:6::1c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D50943B700
        for <linux-kernel@vger.kernel.org>; Fri, 14 Oct 2022 02:20:06 -0700 (PDT)
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by smtp-out1.suse.de (Postfix) with ESMTPS id 9273D21DF8;
        Fri, 14 Oct 2022 09:20:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1665739205;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n52SkV7Ax/wZ9k4CuOsll0s3NLfyMLNwu9OAT947O44=;
        b=CP9kBANq+4+Mhd40AMpt8RDO3fAh63HYMcSofsz+tM889I5shp6HfZrlMgj+WEdqMTZ608
        kWWt8X+CKbNGmSBXIxOcqc4F2BQ2hrmoFaAm+DGAU6W0Jjx35fICH5c6xbZ69vgSI4IU7H
        dna1qJnovE0fkwwlk9PjbAHny/0w6NQ=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1665739205;
        h=from:from:reply-to:reply-to:date:date:message-id:message-id:to:to:
         cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=n52SkV7Ax/wZ9k4CuOsll0s3NLfyMLNwu9OAT947O44=;
        b=m0ezkaHIiHEkpBfudad1EYP86KyCVWCTLpWbwliDD1mLjjGM3fzsCIJiVcdUqVKvho70w8
        Wzgmks5stlz6H4Ag==
Received: from imap2.suse-dmz.suse.de (imap2.suse-dmz.suse.de [192.168.254.74])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature ECDSA (P-521) server-digest SHA512)
        (No client certificate requested)
        by imap2.suse-dmz.suse.de (Postfix) with ESMTPS id 03B2C13451;
        Fri, 14 Oct 2022 09:20:04 +0000 (UTC)
Received: from dovecot-director2.suse.de ([192.168.254.65])
        by imap2.suse-dmz.suse.de with ESMTPSA
        id aCP3OMQpSWPSGwAAMHmgww
        (envelope-from <pvorel@suse.cz>); Fri, 14 Oct 2022 09:20:04 +0000
Date:   Fri, 14 Oct 2022 11:20:02 +0200
From:   Petr Vorel <pvorel@suse.cz>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     vapier@gentoo.org, chrubis@suse.cz, wanlong.gao@gmail.com,
        jstancek@redhat.com, stanislav.kholmanskikh@oracle.com,
        alexey.kodanev@oracle.com, ltp@lists.linux.it,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [LTP] [PATCH] MAINTAINERS: git://github -> https://github.com
 for linux-test-project
Message-ID: <Y0kpwmBvY6uxNXHC@pevik>
Reply-To: Petr Vorel <pvorel@suse.cz>
References: <20221013214638.30953-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221013214638.30953-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

> Github deprecated the git:// links about a year ago, so let's move to
> the https:// URLs instead.
Good point!

Reviewed-by: Petr Vorel <pvorel@suse.cz>

Kind regards,
Petr
