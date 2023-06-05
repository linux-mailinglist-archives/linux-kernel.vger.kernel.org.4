Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A02D7230B5
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 22:07:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjFEUHe convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 5 Jun 2023 16:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231268AbjFEUHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 16:07:33 -0400
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AED619E;
        Mon,  5 Jun 2023 13:07:32 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 10B7363CC10C;
        Mon,  5 Jun 2023 22:07:31 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id X6roPuzR374K; Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id BF45E6081100;
        Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id xJjb7zySq9_X; Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9FE3863CC10C;
        Mon,  5 Jun 2023 22:07:30 +0200 (CEST)
Date:   Mon, 5 Jun 2023 22:07:30 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     Azeem Shaikh <azeemshaikh38@gmail.com>
Cc:     Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <kees@kernel.org>, kernel test robot <lkp@intel.com>,
        Maxim Krasnyansky <maxk@qti.qualcomm.com>,
        oe-kbuild-all <oe-kbuild-all@lists.linux.dev>,
        linux-hardening <linux-hardening@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        anton ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <458187791.3685910.1685995650602.JavaMail.zimbra@nod.at>
In-Reply-To: <CADmuW3WXDg-5SFXkMDE6BmvSwLNHmXpTzBonaOL8eErc4+d3qQ@mail.gmail.com>
References: <20230530164004.986750-1-azeemshaikh38@gmail.com> <202305311135.zGMT1gYR-lkp@intel.com> <09A0C6FA-669F-4B73-9620-43AEA17E5D0C@kernel.org> <103925562.158061.1685514200368.JavaMail.zimbra@nod.at> <CAMuHMdU70uRxnMNb8KCJe8M3BRPPxowRXtj+POcrh+KLkfQyAA@mail.gmail.com> <CADmuW3WXDg-5SFXkMDE6BmvSwLNHmXpTzBonaOL8eErc4+d3qQ@mail.gmail.com>
Subject: Re: [PATCH] uml: Replace all non-returning strlcpy with strscpy
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF97 (Linux)/8.8.12_GA_3809)
Thread-Topic: Replace all non-returning strlcpy with strscpy
Thread-Index: F0kvDMRUOo3WCvHaQMtuD24L4U1LkA==
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        T_SCC_BODY_TEXT_LINE,T_SPF_PERMERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

----- Ursprüngliche Mail -----
> Von: "Azeem Shaikh" <azeemshaikh38@gmail.com>
> Planning to send out v2 with the fixup from Richard applied. Let me
> know if that's ok.

Fine by me. :-)

Thanks,
//richard
