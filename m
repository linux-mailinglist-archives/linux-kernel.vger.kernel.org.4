Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3392F6EA3E3
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 08:34:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230045AbjDUGey (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 02:34:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229644AbjDUGev (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 02:34:51 -0400
Received: from 1wt.eu (ded1.1wt.eu [163.172.96.212])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 83702270D
        for <linux-kernel@vger.kernel.org>; Thu, 20 Apr 2023 23:34:50 -0700 (PDT)
Received: (from willy@localhost)
        by mail.home.local (8.17.1/8.17.1/Submit) id 33L6YlHa012564;
        Fri, 21 Apr 2023 08:34:47 +0200
Date:   Fri, 21 Apr 2023 08:34:47 +0200
From:   Willy Tarreau <w@1wt.eu>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     =?iso-8859-1?Q?Andr=E9?= Coelho <andrealbergaria@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: strings
Message-ID: <ZEIuh80SfDms30dc@1wt.eu>
References: <8de1912e-8009-3c85-ece5-7ca7f03be42a@gmail.com>
 <ZEIPKhKNz7LnhM/q@debian.me>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <ZEIPKhKNz7LnhM/q@debian.me>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[dropped innocents from the CC list]

On Fri, Apr 21, 2023 at 11:20:58AM +0700, Bagas Sanjaya wrote:
> On Thu, Apr 20, 2023 at 03:58:47AM +0100, André Coelho wrote:
> > greeting...if youre interessed in string algorihtm check
> > 
> > https://andrealbergaria.github.io/
> > 
> 
> Looks like above link is about hex arithmetic implemented using strings,
> right?

It looks more like a reinvention of the classical multi-byte string
processing (memcmp, memcpy, memmove etc).

> Also, on what use cases can your idea fit the kernel context? Or doesn't the
> kernel already have the implementation yet?

Sure it does, look at __crypto_memneq() for example, or more generally
at any memcmp() or memcpy() implementation from the last 30 years, for
example in glibc.

Regards,
Willy
