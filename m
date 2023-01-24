Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01F8167A42D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 21:45:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234246AbjAXUpa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 15:45:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234337AbjAXUp0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 15:45:26 -0500
X-Greylist: delayed 1811 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 24 Jan 2023 12:45:21 PST
Received: from bosmailout10.eigbox.net (bosmailout10.eigbox.net [66.96.184.10])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7E2A4FAC2
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 12:45:21 -0800 (PST)
Received: from [10.20.15.6] (helo=bosmailscan06.eigbox.net)
        by bosmailout10.eigbox.net with esmtp (Exim)
        id 1pKPhF-0002wy-2J
        for linux-kernel@vger.kernel.org; Tue, 24 Jan 2023 15:15:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=bestfzyhs.com; s=dkim; h=Sender:Content-Transfer-Encoding:Content-Type:
        Message-ID:Reply-To:Subject:To:From:Date:MIME-Version:Cc:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=X2ynI9Fsuf73Q/abz5DQqXyVbIcRJ5o0sL15Wzf8gr0=; b=GATVM0Lj5wWEsSwRE8AvmsOVH/
        uVmIbkZk0KpFCGT0jrt08jvIJRMUzS+7gwpNNFM+dwUZAJz2boppPM2BmiAxjD0mSPSU8CoauKRdx
        c0DH0q21FZMc2tVuOKgltY/E5vBapNweZ+NCttKx+eKYDOdTjwOnrTWdX9iOOmJ6h5DB7bhIaG1BR
        zxXccdV8j2JhDiGssB8fLiex9fRD3Zz2XtUZw2TpzKCpMABmvAgPqu63D2sxlqqVPc+4BDa9W1/zp
        MgSy5PmkPNjgHtsFsS6wGx/BpHnN6UUyNcyb8t5VZsMn2sDupxPq2+jtWhrQt7L8ZqLfURxg0sze8
        quafhTkg==;
Received: from [10.115.3.33] (helo=bosimpout13)
        by bosmailscan06.eigbox.net with esmtp (Exim)
        id 1pKPhE-0001PU-75; Tue, 24 Jan 2023 15:15:08 -0500
Received: from boswebmail02.eigbox.net ([10.20.16.2])
        by bosimpout13 with 
        id CkF12901702gDNJ01kF7ki; Tue, 24 Jan 2023 15:15:08 -0500
X-EN-SP-DIR: OUT
X-EN-SP-SQ: 1
Received: from [127.0.0.1] (helo=homestead)
        by boswebmail02.eigbox.net with esmtp (Exim)
        id 1pKPgh-0006I1-Fg; Tue, 24 Jan 2023 15:14:35 -0500
Received: from [197.239.108.34]
 by emailmg.homestead.com
 with HTTP (HTTP/1.1 POST); Tue, 24 Jan 2023 15:14:35 -0500
MIME-Version: 1.0
Date:   Tue, 24 Jan 2023 12:14:35 -0800
From:   Mrs Lorence Gonzalez <mrs.lorencez@bestfzyhs.com>
To:     undisclosed-recipients:;
Subject: Hello
Reply-To: mrslorencegonzalez@gmail.com
Mail-Reply-To: mrslorencegonzalez@gmail.com
Message-ID: <6f6c1c16bc3f9e9ccefc2006514c5519@bestfzyhs.com>
X-Sender: mrs.lorencez@bestfzyhs.com
User-Agent: Roundcube Webmail/1.3.14
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-EN-AuthUser: mrs.lorencez@bestfzyhs.com
Sender:  Mrs Lorence Gonzalez <mrs.lorencez@bestfzyhs.com>
X-Spam-Status: Yes, score=6.7 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,FREEMAIL_FORGED_REPLYTO,FROM_FMBLA_NEWDOM,
        HEADER_FROM_DIFFERENT_DOMAINS,ODD_FREEM_REPTO,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_HK_NAME_MR_MRS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: * -0.0 RCVD_IN_DNSWL_NONE RBL: Sender listed at
        *      https://www.dnswl.org/, no trust
        *      [66.96.184.10 listed in list.dnswl.org]
        *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5589]
        * -0.0 RCVD_IN_MSPIKE_H2 RBL: Average reputation (+2)
        *      [66.96.184.10 listed in wl.mailspike.net]
        * -0.0 SPF_PASS SPF: sender matches SPF record
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.2 HEADER_FROM_DIFFERENT_DOMAINS From and EnvelopeFrom 2nd level
        *      mail domains are different
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  2.4 ODD_FREEM_REPTO Has unusual reply-to header
        *  0.0 T_HK_NAME_MR_MRS No description available.
        *  1.0 FROM_FMBLA_NEWDOM From domain was registered in last 7 days
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  2.1 FREEMAIL_FORGED_REPLYTO Freemail in Reply-To, but not From
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



Hello,

Am a dying woman here in the hospital, i was diagnose as a Cancer
patient over  2 Years ago. I am A business woman how dealing with Gold
Exportation. I Am from Us California
I have a charitable and unfulfilled project that am about to handover
to you, if you are interested please reply

Hope to hear from you.
Regard

mrslorencegonzalez@gmail.com

Mrs.lorence Gonzalez





