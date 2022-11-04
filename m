Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DBE1619A74
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 15:47:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230127AbiKDOrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 10:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229496AbiKDOrO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 10:47:14 -0400
Received: from redpilled.dev (redpilled.dev [195.201.122.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A4C1B21AF;
        Fri,  4 Nov 2022 07:47:13 -0700 (PDT)
Date:   Fri, 04 Nov 2022 16:47:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redpilled.dev;
        s=mail; t=1667573231;
        bh=MziWuBgQ66eSbh3PGJQDWRP49x0Q4k+wM89oAdBOOMk=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=g/rQi9JszwhwgYPFyR8DLVTg1kdOKge31I8r1LLIUPEl8vErhvvK9dWs1YGWO+XRX
         s9WMWBWwD2qWdzjg2S80nSbDyJpRe+Fsif8oup3yB4Rr+7DBHMXPh3LnLAp0nn8uMD
         NERlLprCYmB3nCfnbqh1jZbZ3Rz+/DeoHCacMv1Q=
From:   Mia Kanashi <chad@redpilled.dev>
To:     Jiri Kosina <jikos@kernel.org>
CC:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>,
        benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 1/2] HID: input: do not query XP-PEN Deco LW battery
In-Reply-To: <nycvar.YFH.7.76.2211041412500.29912@cbobk.fhfr.pm>
References: <20221029161240.15548-1-jose.exposito89@gmail.com> <20221029161240.15548-2-jose.exposito89@gmail.com> <1701DB3A-5538-4B58-8232-E6705B9C70DF@redpilled.dev> <nycvar.YFH.7.76.2211041412500.29912@cbobk.fhfr.pm>
Message-ID: <705A1972-A2D4-4659-BAD0-7053492478C9@redpilled.dev>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4 November 2022 15:13:34 EET, Jiri Kosina <jikos@kernel=2Eorg> wrote:
>Based on this, can I assume that I can turn
>
>	Reported-by: Mia Kanashi <chad@redpilled=2Edev>
>
>into
>
>	Reported-and-tested-by: Mia Kanashi <chad@redpilled=2Edev>
>
>for the final version?
>
>Thanks,

Yes, but maintainer docs don't recommend using combined tags=2E :)

  Please do not use combined tags, e=2Eg=2E Reported-and-tested-by,=20
  as they just complicate automated extraction of tags=2E

link: https://www=2Ekernel=2Eorg/doc/html/latest/process/maintainer-tip=2E=
html?highlight=3DReported-and-tested-by#ordering-of-commit-tags
