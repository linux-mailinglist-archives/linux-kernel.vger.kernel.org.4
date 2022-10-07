Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 530165F7D7E
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 20:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229491AbiJGSrF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 14:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51020 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229470AbiJGSrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 14:47:02 -0400
Received: from fanzine2.igalia.com (fanzine.igalia.com [178.60.130.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1D1C3BC51;
        Fri,  7 Oct 2022 11:46:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:Content-Type:In-Reply-To:From:
        References:Cc:To:Subject:MIME-Version:Date:Message-ID:Sender:Reply-To:
        Content-ID:Content-Description:Resent-Date:Resent-From:Resent-Sender:
        Resent-To:Resent-Cc:Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EodwG0g05ekNoO1K/V8lOMMkRvVb3NnqaC/Eah9QL44=; b=B1H3dE5A4yt1xZaXXlBBqThoU+
        5PeYPOJ5lsLDr7rYzzpY3ajtqGVBxVi5gn/r79psZn7+wm+PmtOeKpqlsydISVByRMcZ535+gTCgD
        C2b+DSbHhop28cHsP4OtPibKmvTMSNC/gYeXl2Sr4P+csSvtDuokL0kTrVuOkZDY50y7zlpYBJBzZ
        AFFtCIyo6W2ebdXw2IIXmhqoq4zFkf9hr1X8QWU8orju2P0VcndZ75OINQcf8TystqQaq+MiA6r3B
        2wKQ4KAqXnRtrZ10WpVIBethKchFaqz8BoYs0Pavwu19vNCsrCsx1D/JEff9xl+fCupoK/40tXkNH
        m2p8ck1A==;
Received: from 201-43-120-40.dsl.telesp.net.br ([201.43.120.40] helo=[192.168.1.60])
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
        id 1ogsMy-00DSuA-0H; Fri, 07 Oct 2022 20:46:48 +0200
Message-ID: <13ce63c5-dacd-ed4a-06f9-75541d812ff0@igalia.com>
Date:   Fri, 7 Oct 2022 15:46:34 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] pstore: migrate to crypto acomp interface (take 2)
Content-Language: en-US
To:     Kees Cook <keescook@chromium.org>, Ard Biesheuvel <ardb@kernel.org>
Cc:     Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>, linux-kernel@vger.kernel.org,
        linux-hardening@vger.kernel.org
References: <20221006234138.1835739-1-keescook@chromium.org>
From:   "Guilherme G. Piccoli" <gpiccoli@igalia.com>
In-Reply-To: <20221006234138.1835739-1-keescook@chromium.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for re-sending this one, I'll test it next week =)
Cheers,


Guilherme
