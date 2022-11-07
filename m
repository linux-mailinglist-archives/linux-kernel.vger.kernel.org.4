Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C6847626139
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 19:35:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233734AbiKKSfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 13:35:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233344AbiKKSfT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 13:35:19 -0500
Received: from mail.telsatco.com (mail.telsatco.com [190.147.169.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 816BF814D0
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 10:35:12 -0800 (PST)
Received: from mail.telsatco.com (localhost.localdomain [127.0.0.1])
        by mail.telsatco.com (Proxmox) with ESMTP id 482AB665FC5;
        Mon,  7 Nov 2022 18:57:51 -0500 (-05)
Received: from mail.telsatco.com (unknown [192.168.1.245])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.telsatco.com (Proxmox) with ESMTPS id DCC986884AF;
        Mon,  7 Nov 2022 16:36:17 -0500 (-05)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stockton.nl;
        s=default; t=1667856978;
        bh=Ld0SjEh4EiKVQucrSOGVsAdiZPG37fZ44tUanW9hnmU=;
        h=Subject:To:From:Date:Reply-To;
        b=UiT6irc1cUz40+ljtzSRvXDGxEug/s+qAfQMmArArK+jaHeQ+CIOgT/GOaMdXiQAk
         OUU691ps3alyVla243LBO8o57VUcPUQDyrZesq/WFkVH6XkVQ+uzG3hLZla+udMGRC
         naHsgywe/9TBJ6SieAkUjfCsA8nl2oPwWx6hYPqu4YWvQS7v4eby394RxyBOeDGFG4
         wFGukM26obG+aQFODK7/z9eeJW4IJ76qB7MrkkiF66vmUODZ4/QxaRj/0bbY0Neu9L
         yE/uplazx+x2A16yOfkCxxtAZfHB7DQ7pMP8TctMh8i+hP06kBARjTKJw30D5i78NG
         QrgQIKOft3sjw==
Received: from [45.135.128.68] (unknown [45.135.128.68])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.telsatco.com (Postfix) with ESMTPSA id B626B22BCF;
        Mon,  7 Nov 2022 16:29:58 -0500 (COT)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: URG
To:     Recipients <frank@stockton.nl>
From:   "Mr. Frank Stockton" <frank@stockton.nl>
Date:   Mon, 07 Nov 2022 13:27:49 -0800
Reply-To: frank61579657f@portfolio.trc-turk.com
Message-Id: <20221107235751.482AB665FC5@mail.telsatco.com>
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,HK_NAME_MR_MRS,RCVD_IN_PSBL,RCVD_IN_VALIDITY_RPBL,SPF_FAIL,
        SPF_HELO_NONE,TO_EQ_FM_DOM_SPF_FAIL,TO_EQ_FM_SPF_FAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5000]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [190.147.169.6 listed in psbl.surriel.com]
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [190.147.169.6 listed in bl.score.senderscore.com]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  0.0 SPF_FAIL SPF: sender does not match SPF record (fail)
        *      [SPF failed: Please see http://www.openspf.org/Why?s=mfrom;id=frank%40stockton.nl;ip=190.147.169.6;r=lindbergh.monkeyblade.net]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  1.0 HK_NAME_MR_MRS No description available.
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  0.0 TO_EQ_FM_DOM_SPF_FAIL To domain == From domain and external SPF
        *       failed
        *  0.0 TO_EQ_FM_SPF_FAIL To == From and external SPF failed
X-Spam-Level: ******
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Friend, My name is Frank Stockton an Investment portfolio Manager wit=
h a reputable investment management firm. I have a secure deal for you, ple=
ase contact me if you wish to know more Sincerely, Frank Stockton

