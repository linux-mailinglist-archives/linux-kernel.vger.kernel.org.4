Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 364866F2765
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Apr 2023 04:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230430AbjD3Csc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 29 Apr 2023 22:48:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229552AbjD3Csa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Apr 2023 22:48:30 -0400
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D4801BD5
        for <linux-kernel@vger.kernel.org>; Sat, 29 Apr 2023 19:48:28 -0700 (PDT)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 4204A20033;
        Sun, 30 Apr 2023 10:48:20 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1682822901;
        bh=zypWVf9MXS+lPQIzItTqVr7FILdJ9hERlQX46tPuHAQ=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References;
        b=NSLLVLm8VQGFuxD5PGQtL/WcVqx3tOl/CP/Jl7iQD0NlAb1TGdR/ax5AnNHXyFCd4
         6je199kUjTKo2+uP99776iidHnguIDdLfHKuT0cXs0wSmOc9wtMmuvXAmfbZwDEAez
         DHYuhJbXY2jZn0b3VsrucGOlZ9TGuwbIFb6gDm0hr/MMPgPJBXxEOAlNU723jEUNeF
         hfhisf854oJ4wVb9YLvj/Xi0N6zwMSD9RWryEdcQ7JrPejipP1tyfjg+CjbT+RD+2p
         Yb5YH3tL56d+TPtiCUP4pG+m3qBebrLel5KKljeay5cXWFry+mFU9c62idf3Mfscjh
         +leRbFah41gbA==
Message-ID: <71e6b0d439cf53d9b8824370a52a5bed9ce4fcf9.camel@codeconstruct.com.au>
Subject: Re: [PATCH] i3c: ast2600: set variable ast2600_i3c_ops
 storage-class-specifier to static
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Tom Rix <trix@redhat.com>, alexandre.belloni@bootlin.com
Cc:     linux-i3c@lists.infradead.org, linux-kernel@vger.kernel.org
Date:   Sun, 30 Apr 2023 10:48:19 +0800
In-Reply-To: <20230429134601.2688558-1-trix@redhat.com>
References: <20230429134601.2688558-1-trix@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tom,

> smatch reports
> drivers/i3c/master/ast2600-i3c-master.c:121:34: warning: symbol
> =C2=A0 'ast2600_i3c_ops' was not declared. Should it be static?
>=20
> This variable is only used in its defining file, so it should be
> static.

Super, thanks!

Reviewed-by: Jeremy Kerr <jk@codeconstruct.com.au>

Cheers,


Jeremy
