Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 34ACF6D2917
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 22:02:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233024AbjCaUCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 16:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233037AbjCaUCQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 16:02:16 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A08E23FF4;
        Fri, 31 Mar 2023 13:01:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Sender:In-Reply-To:
        Content-Transfer-Encoding:Content-Type:MIME-Version:References:Message-ID:
        Subject:Cc:To:From:Date:Reply-To:Content-ID:Content-Description;
        bh=O9v/o+LL35F39YCf85iRZwB52pys/g9pBnyqwNmlF9Y=; b=xj5j/DbnOE+bLqw399ZLnj5nOH
        nUvyiUYUWv3zAuiluYlq3l1r/m8PJz5pHclXKP3g0UaO5Wdba9rBEovo9lqrdhLwe2+j7cSjaleNA
        uU/uPff2IzKQwH8jYf+MEmTxOgZUu7Rxs/ODZoiNxBNNZc9i2Z0drTrIJ1Z64n8zc5J6/f/1UnGIf
        UD0q2u6zePcWgzHZ+VzkUnIXRqzKRK0xlsLjn0IhCyo8LvGFpasoZ5tSUZ6Lx5UkhquKb4a+jQLHq
        0D2Qp10SthXDc95beHKe2z9W2iicw4geJmwyKNk8sBbf43gyvPpecUCLJGMUIhSHQcxLIoompGkcD
        usbwLA0A==;
Received: from mcgrof by bombadil.infradead.org with local (Exim 4.96 #2 (Red Hat Linux))
        id 1piKwR-008hY3-0y;
        Fri, 31 Mar 2023 20:01:43 +0000
Date:   Fri, 31 Mar 2023 13:01:43 -0700
From:   Luis Chamberlain <mcgrof@kernel.org>
To:     Ahelenia =?utf-8?Q?Ziemia=C5=84ska?= 
        <nabijaczleweli@nabijaczleweli.xyz>
Cc:     "open list:MODULE SUPPORT" <linux-modules@vger.kernel.org>,
        "open list:MODULE SUPPORT" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] KEYS: Make use of platform keyring for module signature
 verification
Message-ID: <ZCc8J6wS1EpXrLQW@bombadil.infradead.org>
References: <qvgp2il2co4iyxkzxvcs4p2bpyilqsbfgcprtpfrsajwae2etc@3z2s2o52i3xg>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <qvgp2il2co4iyxkzxvcs4p2bpyilqsbfgcprtpfrsajwae2etc@3z2s2o52i3xg>
Sender: Luis Chamberlain <mcgrof@infradead.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_EF,HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 31, 2023 at 04:30:21PM +0200, Ahelenia Ziemia=C5=84ska wrote:
> This allows a cert in DB to be used to sign modules,
> in addition to certs in the MoK and built-in keyrings.
>=20
> This key policy matches what's used for kexec.
>=20
> Signed-off-by: Ahelenia Ziemia=C5=84ska <nabijaczleweli@nabijaczleweli.xy=
z>

Before I nose dive, the commit log should explain why this patch never
was sent upstream, if it was, why it was rejected. What makes it good now?

Who is using it? What are other distributions doing about it?

  Luis
