Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D8FA6D1046
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 22:50:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjC3Uuv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 16:50:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50852 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229678AbjC3Uut (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 16:50:49 -0400
Received: from mail-0201.mail-europe.com (mail-0201.mail-europe.com [51.77.79.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7550249CF
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 13:50:47 -0700 (PDT)
Date:   Thu, 30 Mar 2023 20:50:36 +0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=proton.me;
        s=w5elennuwrb37gnh6zxddmvypq.protonmail; t=1680209443; x=1680468643;
        bh=W574/0kXNKnLUjX2uO+bsVEOsvWDq4+hEQzDObjXEgE=;
        h=Date:To:From:Cc:Subject:Message-ID:Feedback-ID:From:To:Cc:Date:
         Subject:Reply-To:Feedback-ID:Message-ID:BIMI-Selector;
        b=mkT6oRLXxScdcc1+L8c9eUUCeF8nVob4SrH0sJd11CGimEod7PezQGLb0meWW/cyv
         NHmcr6ThjWr6cOur2U/fSrUvd3woTmNst5/EP2ZMn20MIvREmoFmTCf/V6ZOZ6zlIP
         BlfIyMUYSxYF2q6XlVwKW5Jw4pr2VsLH/ZvByFyZNaFd1Pm8U8Ar0aCsqH/QX3+tez
         Dx15X60p+kQW+0ku6dUQw6v2XKYVBxXr6UFLG2Eu369OaFqS7iskxmr1EeEkXg2vie
         LXj5BIxRjw8YET4hR3ZLUVsTzfkRL1BFH255NRPbTNE2WSKii3bTcSMPfTVLgIYQiJ
         GkGNqbtB8DH1A==
To:     "Limonciello, Mario" <mario.limonciello@amd.com>
From:   gabipr2023@proton.me
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Kishon Vijay Abraham I <kvijayab@amd.com>,
        David R <david@unsolicited.net>,
        Borislav Petkov <bp@alien8.de>, eric.devolder@oracle.com
Subject: Re: Panic starting 6.2.x and later 6.1.x kernels
Message-ID: <788384b22962ff2fc716bd7cc82d08071bf440d1.camel@proton.me>
Feedback-ID: 70468172:user:proton
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-29 at 14:17 -0500, Limonciello, Mario wrote:
>=20
>=20
> You mean specifically this change:
> https://lore.kernel.org/all/20230327191026.3454-2-eric.devolder@oracle.co=
m/
>=20
> Yes; I suppose that still makes sense.
>=20
Just tried this patch on 6.3rc4 and it boots correctly for me with just
this.

(Offtopic but also my name is Gabriela, a typo from my part lol. And
this is another email since disroot is blocked my lkml)


