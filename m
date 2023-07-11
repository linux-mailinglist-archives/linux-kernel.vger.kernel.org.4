Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88A2974F856
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 21:22:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231490AbjGKTV5 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 11 Jul 2023 15:21:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjGKTVz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 15:21:55 -0400
X-Greylist: delayed 4613 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 11 Jul 2023 12:21:53 PDT
Received: from 5.mo581.mail-out.ovh.net (5.mo581.mail-out.ovh.net [178.32.120.239])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9674A11B
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 12:21:53 -0700 (PDT)
Received: from director9.ghost.mail-out.ovh.net (unknown [10.108.16.31])
        by mo581.mail-out.ovh.net (Postfix) with ESMTP id EC8AA278B1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 18:04:58 +0000 (UTC)
Received: from ghost-submission-6684bf9d7b-s87lf (unknown [10.110.115.217])
        by director9.ghost.mail-out.ovh.net (Postfix) with ESMTPS id 971BA1FE3E;
        Tue, 11 Jul 2023 18:04:58 +0000 (UTC)
Received: from courmont.net ([37.59.142.102])
        by ghost-submission-6684bf9d7b-s87lf with ESMTPSA
        id TjgcBcqZrWQtiQEAqDmyAA
        (envelope-from <remi@remlab.net>); Tue, 11 Jul 2023 18:04:58 +0000
Authentication-Results: garm.ovh; auth=pass (GARM-102R004a6e4188e-14a7-4010-a06c-008f3ac247c2,
                    BD5993DD31A8D185A8BDB9FDB50A3FED214DC06B) smtp.auth=postmaster@courmont.net
X-OVh-ClientIp: 87.92.194.88
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     linux-riscv@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 05/12] RISC-V: crypto: update perl include with helpers for
 vector (crypto) instructions
Date:   Tue, 11 Jul 2023 21:04:57 +0300
Message-ID: <10238181.0Rfz7avHUX@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230711153743.1970625-6-heiko@sntech.de>
References: <20230711153743.1970625-1-heiko@sntech.de>
 <20230711153743.1970625-6-heiko@sntech.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Ovh-Tracer-Id: 11081669834400668123
X-VR-SPAMSTATE: OK
X-VR-SPAMSCORE: 0
X-VR-SPAMCAUSE: gggruggvucftvghtrhhoucdtuddrgedviedrfedtgdduvdduucetufdoteggodetrfdotffvucfrrhhofhhilhgvmecuqfggjfdpvefjgfevmfevgfenuceurghilhhouhhtmecuhedttdenucenucfjughrpefhvfevufffkfhojghfggfgtgesthhqredttddtjeenucfhrhhomheptformhhiucffvghnihhsqdevohhurhhmohhnthcuoehrvghmihesrhgvmhhlrggsrdhnvghtqeenucggtffrrghtthgvrhhnpeeuhfegfeefvdefueetleefffduuedvjeefheduueekieeltdetueetueeugfevffenucffohhmrghinheprhgvmhhlrggsrdhnvghtnecukfhppeduvdejrddtrddtrddupdekjedrledvrdduleegrdekkedpfeejrdehledrudegvddruddtvdenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepihhnvghtpeduvdejrddtrddtrddupdhmrghilhhfrhhomhepoehrvghmihesrhgvmhhlrggsrdhnvghtqedpnhgspghrtghpthhtohepuddprhgtphhtthhopehlihhnuhigqdhkvghrnhgvlhesvhhgvghrrdhkvghrnhgvlhdrohhrghdpoffvtefjohhsthepmhhoheekuddpmhhouggvpehsmhhtphhouhht
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le tiistaina 11. heinäkuuta 2023, 18.37.36 EEST Heiko Stuebner a écrit :
> From: Heiko Stuebner <heiko.stuebner@vrull.eu>
> 
> The openSSL scripts use a number of helpers for handling vector
> instructions and instructions from the vector-crypto-extensions.

Uh but the kernel RVV code requires an assembler that supports the `.option 
arch` directive and the V extension anyway.

Is there a need to wrap vector load/store and ALU instructions from the Vector 
spec? This trick should only be necessary for the Zvk*-specific stuff, AFAICT.

(Also FWIW, this can be done directly with .macro inside a header file, without 
involving Perl.)

-- 
Rémi Denis-Courmont
http://www.remlab.net/



