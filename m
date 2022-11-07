Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D18AE622C9F
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 14:43:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230153AbiKINnx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 08:43:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229733AbiKINnu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 08:43:50 -0500
X-Greylist: delayed 163821 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 09 Nov 2022 05:43:45 PST
Received: from mail.telsatco.com (mail.telsatco.com [190.147.169.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD72D6404;
        Wed,  9 Nov 2022 05:43:44 -0800 (PST)
Received: from mail.telsatco.com (localhost.localdomain [127.0.0.1])
        by mail.telsatco.com (Proxmox) with ESMTP id 73D385CEACF;
        Mon,  7 Nov 2022 02:19:51 -0500 (-05)
Received: from mail.telsatco.com (unknown [192.168.1.245])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.telsatco.com (Proxmox) with ESMTPS id 4E7925D684E;
        Sun,  6 Nov 2022 22:52:30 -0500 (-05)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=stockton.nl;
        s=default; t=1667793150;
        bh=Ld0SjEh4EiKVQucrSOGVsAdiZPG37fZ44tUanW9hnmU=;
        h=Subject:To:From:Date:Reply-To;
        b=hIjBs9Ue8y8MXc7xuLfZ16iJuTwMj0+//hfkAlP2449j6rrBR7+EurrC4Vpszsbml
         nVft30wtmSEfPot/woUHjbxfg0wvbe6GBbJaynT7V7UeMm9e0U8IV9x1tWd7PPsoZe
         cfk1CCum4NbGVYHU7A+5BK1P0q3GnpHs3YfprM73BkIGrhGF87mv5HYeV3CmG+adq7
         dfgeBJKkmA6G4xa7MvcAVTKlZDCSIs+rM5y0rc0Ad/fg13KB/TdM/bfQPjedZDnSuJ
         O8Zp2H08FbZfaxYTUPDDflil4knmDM2LSW4ChGg8N87Vh+GoHoxaydeNttxmJuTAM8
         +MixYjWWsVbvQ==
Received: from [45.135.128.68] (unknown [45.135.128.68])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mail.telsatco.com (Postfix) with ESMTPSA id 1A91D23395;
        Sun,  6 Nov 2022 22:18:50 -0500 (COT)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Description: Mail message body
Subject: URG
To:     Recipients <frank@stockton.nl>
From:   "Mr. Frank Stockton" <frank@stockton.nl>
Date:   Sun, 06 Nov 2022 19:16:42 -0800
Reply-To: frank61579657f@portfolio.trc-turk.com
Message-Id: <20221107071951.73D385CEACF@mail.telsatco.com>
X-Spam-Status: Yes, score=6.0 required=5.0 tests=BAYES_50,DKIM_INVALID,
        DKIM_SIGNED,HK_NAME_MR_MRS,RCVD_IN_PSBL,RCVD_IN_VALIDITY_RPBL,SPF_FAIL,
        SPF_HELO_NONE,TO_EQ_FM_DOM_SPF_FAIL,TO_EQ_FM_SPF_FAIL autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Report: *  0.8 BAYES_50 BODY: Bayes spam probability is 40 to 60%
        *      [score: 0.5003]
        *  0.0 SPF_HELO_NONE SPF: HELO does not publish an SPF Record
        *  1.3 RCVD_IN_VALIDITY_RPBL RBL: Relay in Validity RPBL,
        *      https://senderscore.org/blocklistlookup/
        *      [190.147.169.6 listed in bl.score.senderscore.com]
        *  2.7 RCVD_IN_PSBL RBL: Received via a relay in PSBL
        *      [190.147.169.6 listed in psbl.surriel.com]
        *  0.0 SPF_FAIL SPF: sender does not match SPF record (fail)
        *      [SPF failed: Please see http://www.openspf.org/Why?s=mfrom;id=frank%40stockton.nl;ip=190.147.169.6;r=lindbergh.monkeyblade.net]
        *  0.1 DKIM_SIGNED Message has a DKIM or DK signature, not necessarily
        *       valid
        *  0.1 DKIM_INVALID DKIM or DK signature exists, but is not valid
        *  1.0 HK_NAME_MR_MRS No description available.
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

