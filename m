Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7869741587
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Jun 2023 17:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230329AbjF1Poj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Jun 2023 11:44:39 -0400
Received: from smtp-out1.suse.de ([195.135.220.28]:37552 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230147AbjF1Poh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Jun 2023 11:44:37 -0400
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 37AD021860;
        Wed, 28 Jun 2023 15:44:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.cz; s=susede2_rsa;
        t=1687967076; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWt+NQ2trkbmCDkp3DTfEFMkpDtna8XOkZHkmpeD4Ew=;
        b=orQovuF0kkoJx4GMxTHEGaGRQrHr4iCHBJaw+Rhhr/cmpzUa5Va/vlVJhk0dVoz72SFXpp
        rxapqWjk8C+OICxSgZp0bhXr4+s1JWdI6jv3QGd38YOsqOnV5ehoEAkJP6NfJSJwckFGeD
        HLrqjpo8jDH7m539avIN/Vb1w0nceRk=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.cz;
        s=susede2_ed25519; t=1687967076;
        h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=dWt+NQ2trkbmCDkp3DTfEFMkpDtna8XOkZHkmpeD4Ew=;
        b=1D8DQbSh3cs820HzADMqu5dm759DOQPLzfpcJcAnFbSLCtiZFpL+VZiPx9tmU1hCr8PWiv
        IiZnKVtHswJSV1BA==
Received: from lion.mk-sys.cz (mkubecek.udp.ovpn2.nue.suse.de [10.163.44.94])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 23DB42C361;
        Wed, 28 Jun 2023 15:44:36 +0000 (UTC)
Received: by lion.mk-sys.cz (Postfix, from userid 1000)
        id 93356608BE; Wed, 28 Jun 2023 17:44:32 +0200 (CEST)
Date:   Wed, 28 Jun 2023 17:44:32 +0200
From:   Michal Kubecek <mkubecek@suse.cz>
To:     Josh Poimboeuf <jpoimboe@kernel.org>
Cc:     Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org
Subject: Re: build failure after commit eb0481bbc4ce ("objtool: Fix
 reloc_hash size")
Message-ID: <20230628154432.4drtq4pivlkkg6v2@lion.mk-sys.cz>
References: <20230628115825.ahqejf5y4hgxhyqj@lion.mk-sys.cz>
 <20230628151654.zqwy5zsc2cymqghr@treble>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230628151654.zqwy5zsc2cymqghr@treble>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 28, 2023 at 08:16:54AM -0700, Josh Poimboeuf wrote:
> Interesting.  Can you add the below patch and also do:
> 
>   make net/ipv4/netfilter/iptable_nat.o OBJTOOL_ARGS="--stats"
> 
> and report the output?

With these, I get

    ...
      CC [M]  net/ipv4/netfilter/iptable_nat.o
    nr_sections: 40
    section_bits: 10
    nr_symbols: 41
    symbol_bits: 10
    mmap reloc: Invalid argument
    make[1]: Leaving directory '/srv/ram/kobj'

Michal

