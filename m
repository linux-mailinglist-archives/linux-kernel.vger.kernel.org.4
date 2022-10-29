Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44689612361
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 15:55:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229682AbiJ2Nzb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Oct 2022 09:55:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229497AbiJ2Nz2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Oct 2022 09:55:28 -0400
X-Greylist: delayed 48431 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 29 Oct 2022 06:55:27 PDT
Received: from redpilled.dev (redpilled.dev [195.201.122.22])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 771F532D95;
        Sat, 29 Oct 2022 06:55:27 -0700 (PDT)
Date:   Sat, 29 Oct 2022 16:55:21 +0300
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redpilled.dev;
        s=mail; t=1667051724;
        bh=kUdiw4ahjwJwkABVSWcAn3AL0mmdeXZ3h2UHy5jAxlM=;
        h=Date:From:To:CC:Subject:In-Reply-To:References;
        b=EUjxdw4FqDssq+J5Dd5ZMQ+slA3tgglJKCIb0pTR5+SXg+D3LmeQS7HhhmYcXkvYk
         rIGkytqO0BXqx/pdAqfwlUF6nrrkIti85Z0ie0Sd6fn9gcl+83uvOqoIspA4/mbFiv
         M2bbQWvfzs2VptPjWbQMrKxEZfhu2cxdjNo3Z1mE=
From:   Mia Kanashi <chad@redpilled.dev>
To:     =?ISO-8859-1?Q?Jos=E9_Exp=F3sito?= <jose.exposito89@gmail.com>
CC:     jikos@kernel.org, benjamin.tissoires@redhat.com, spbnick@gmail.com,
        pobrn@protonmail.com, linux-input@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Andreas Grosse <andig.mail@t-online.de>
Subject: Re: [PATCH v2] HID: uclogic: Add support for XP-PEN Deco LW
In-Reply-To: <21CA0A00-1B9F-4E97-B942-A3B7CAA2B52E@redpilled.dev>
References: <20221028082348.22386-1-jose.exposito89@gmail.com> <ED1CBF63-A70C-44FF-9F0B-80090EB347EA@redpilled.dev> <20221029075832.GA8790@elementary> <21CA0A00-1B9F-4E97-B942-A3B7CAA2B52E@redpilled.dev>
Message-ID: <C7FD0EC0-899A-4D29-8363-D2FAD8E89BBD@redpilled.dev>
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

>>[1] Actually it should be set to discharging until this gets merged:
>>    https://lore=2Ekernel=2Eorg/linux-input/20221028181849=2E23157-1-jos=
e=2Eexposito89@gmail=2Ecom/T/
>
>But i also currently applied this ^ patch, i will try testing without it =
and then report=2E

Tested without it, same issue=2E
So yeah it seems that hid-input driver can set supply status to dischargin=
g before setting a battery capacity?=20


