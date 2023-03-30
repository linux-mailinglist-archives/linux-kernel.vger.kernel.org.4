Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1CF56CFBEE
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 08:51:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230312AbjC3Gvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 02:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229849AbjC3Gvb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 02:51:31 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97BB7469A
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 23:51:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1680159089; x=1711695089;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=isuW7lBgyM6zBizBIEv7+ZepVzPCYOK2CVN9uusKVP0=;
  b=CMhwlYuiU+HyCbE7Bn9YH2I7dx6E+r/MvjkeYBQ5E29LeSJ/JZlu9S4T
   jeNt/I6q+gKa26rrM6Y3jMR5OxANSV97TaVN3u0gFC5kOInwFZ9Aiw+aG
   V+Cy7NE+E35n1Os4CMERCQMdFuafZjWPEIKMafrct3OyOj4Bk9lhmnNi3
   G6TWFzPvhbusDValq+ENzVkzVG9JfF5WhAewTWb6xCQE985yUgVgFuVfp
   H9Saq4R4Nt4CDagh7PoJ2m51qwphk639nB/81cmAY2Ot8iUBZy3jGavlz
   8Z/vrF/dI/F9bUHFffrsHNbYtDn4QFMOnL1Wxkdce+foR+QjhOx5RquhU
   A==;
X-IronPort-AV: E=Sophos;i="5.98,303,1673938800"; 
   d="asc'?scan'208";a="218640819"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa1.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 29 Mar 2023 23:51:28 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Wed, 29 Mar 2023 23:51:29 -0700
Received: from wendy (10.10.115.15) by chn-vm-ex04.mchp-main.com
 (10.10.85.152) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21 via Frontend
 Transport; Wed, 29 Mar 2023 23:51:28 -0700
Date:   Thu, 30 Mar 2023 07:51:14 +0100
From:   Conor Dooley <conor.dooley@microchip.com>
To:     Sia Jee Heng <jeeheng.sia@starfivetech.com>
CC:     <paul.walmsley@sifive.com>, <palmer@dabbelt.com>,
        <aou@eecs.berkeley.edu>, <linux-riscv@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <leyfoon.tan@starfivetech.com>,
        <mason.huo@starfivetech.com>
Subject: Re: [PATCH v8 0/4] RISC-V Hibernation Support
Message-ID: <a73a194e-f7dd-4cf4-9fb7-62144672b71c@spud>
References: <20230330064321.1008373-1-jeeheng.sia@starfivetech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="mfeXrlZQg1KajaHO"
Content-Disposition: inline
In-Reply-To: <20230330064321.1008373-1-jeeheng.sia@starfivetech.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--mfeXrlZQg1KajaHO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Mar 30, 2023 at 02:43:17PM +0800, Sia Jee Heng wrote:

> Changes since v7:
> - Rebased to kernel v6.3-rc4

BTW, there is absolutely no need to do this every time you resubmit.
Usually patches will either be applied to for-next or to -rc1, so
rebasing on the newest -rc is not needed :)

--mfeXrlZQg1KajaHO
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYIAB0WIQRh246EGq/8RLhDjO14tDGHoIJi0gUCZCUxYgAKCRB4tDGHoIJi
0lIfAQDEWhvfFivg6kQkF18sXzUoe+Angr/aSl+M5qV1NxNIPwEAjz/t1WtBnJ4R
XP2W7zeGUogfxiIhmDT4rbxYEKas5QI=
=QcRt
-----END PGP SIGNATURE-----

--mfeXrlZQg1KajaHO--
