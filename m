Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FDE970FB85
	for <lists+linux-kernel@lfdr.de>; Wed, 24 May 2023 18:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230273AbjEXQQi convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 24 May 2023 12:16:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233961AbjEXQQQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 May 2023 12:16:16 -0400
Received: from sinikuusama2.dnainternet.net (sinikuusama2.dnainternet.net [83.102.40.152])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D474DC1
        for <linux-kernel@vger.kernel.org>; Wed, 24 May 2023 09:16:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by sinikuusama2.dnainternet.net (Postfix) with ESMTP id 34C4E6275;
        Wed, 24 May 2023 19:16:08 +0300 (EEST)
X-Virus-Scanned: DNA Internet at dnainternet.net
X-Spam-Score: 0.92
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_FAIL,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
Received: from sinikuusama2.dnainternet.net ([83.102.40.152])
        by localhost (sinikuusama2.dnainternet.net [127.0.0.1]) (DNA Internet, port 10041)
        with ESMTP id DWWyND0Ki8HC; Wed, 24 May 2023 19:16:08 +0300 (EEST)
Received: from luumupuu2.dnainternet.net (luumupuu2.dnainternet.net [83.102.40.55])
        by sinikuusama2.dnainternet.net (Postfix) with ESMTP id 01392605C;
        Wed, 24 May 2023 19:16:07 +0300 (EEST)
Received: from basile.localnet (87-92-194-88.rev.dnainternet.fi [87.92.194.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by luumupuu2.dnainternet.net (Postfix) with ESMTPS id 228032C63;
        Wed, 24 May 2023 19:16:02 +0300 (EEST)
From:   =?ISO-8859-1?Q?R=E9mi?= Denis-Courmont <remi@remlab.net>
To:     palmer@dabbelt.com, linux-riscv@lists.infradead.org
Cc:     andy.chiu@sifive.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v20 20/26] riscv: Add prctl controls for userspace vector
 management
Date:   Wed, 24 May 2023 19:16:03 +0300
Message-ID: <3656227.v5FYL8H6MN@basile.remlab.net>
Organization: Remlab
In-Reply-To: <20230524092530.7773-1-andy.chiu@sifive.com>
References: <mhng-52f8af07-f3fc-4674-94ea-abbe2108907a@palmer-ri-x1c9a>
 <20230524092530.7773-1-andy.chiu@sifive.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset="UTF-8"
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le keskiviikkona 24. toukokuuta 2023, 12.25.30 EEST Andy Chiu a écrit :
> How about adding the following 2 patches to deal with the problem.
> However, I am concerned if this makes ELF_HWCAP too complicated. e.g.
> Future extensions may as well want to do something here after we create
> an entry here.

Fine with me but I feel that we are missing the bigger picture here, as to 
what the usage pattern/guideline for the prctl() on userspace side should be?

Maybe it was already discussed, and I just missed it, but I couldn't find it in 
the documentation.

-- 
Rémi Denis-Courmont
http://www.remlab.net/



