Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 570E6608E2A
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Oct 2022 17:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229732AbiJVPsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 22 Oct 2022 11:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229682AbiJVPsJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Oct 2022 11:48:09 -0400
Received: from sender4-pp-o95.zoho.com (sender4-pp-o95.zoho.com [136.143.188.95])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB08224F0F
        for <linux-kernel@vger.kernel.org>; Sat, 22 Oct 2022 08:48:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1666453682; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=F8UBZeNpHUqt7j1gtgh0UIOLLx1nBIXEdLayaiSHvv6T47Nn2ddLJPYcePnIRzz7Z9C4lr7Pg957vOVayEPNOaQHVzEE+ajnpFq67c40bKtwRhRnaruTGZQ8ak51a1oxINej2lc3O5Hh6p8v59g1Dh0Bg/L9iX7oCdSqPTfkXik=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1666453682; h=Content-Type:Content-Transfer-Encoding:Cc:Date:From:MIME-Version:Message-ID:Subject:To; 
        bh=AMpBj81iMsmcF9lQSUBpPTS/SD8xVcdpPW9DNQRXKW8=; 
        b=eSJN+DKg1cToc+RiPACzbpajtUL8TWnNGyVcmoR9jzuGGQGE63ws4ZUiM58xMZyWZJG4Zeyu7fFg7cV82BQ1AABkk/6NEqGIyGRcxzxnSyqMZ3dMcyYmFOWnzmQA49GIRkROa2wpd49chkdbHKrLtscixETHnkJhRoDiH7VJg+4=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=zohomail.com;
        spf=pass  smtp.mailfrom=t4rmin@zohomail.com;
        dmarc=pass header.from=<t4rmin@zohomail.com>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1666453682;
        s=zm2022; d=zohomail.com; i=t4rmin@zohomail.com;
        h=Message-ID:Subject:Subject:From:From:To:To:Cc:Cc:Date:Date:Content-Type:Content-Transfer-Encoding:MIME-Version:Message-Id:Reply-To;
        bh=AMpBj81iMsmcF9lQSUBpPTS/SD8xVcdpPW9DNQRXKW8=;
        b=afU54yqwsxC0iTuaU6Ke0pHoHvXiT5MGVslyw5ax22dsTbnFkwApdVrVS1unjWD7
        d+RaIzsuP7CXX3J22Tx1daybG0KgRYjpsJgkT6svz9dTa2A02iQfvSKmp82GMbGFRA6
        xdjDVWegAf21hItOVilC0SRIKcuuJRgb9JgDGO0w=
Received: from [192.168.0.106] (101.128.127.165 [101.128.127.165]) by mx.zohomail.com
        with SMTPS id 1666453681704955.0824423576704; Sat, 22 Oct 2022 08:48:01 -0700 (PDT)
Message-ID: <c072bc16145212943c60b2222ba752af102a5196.camel@zohomail.com>
Subject: [PATCH 0/3] staging: rtl8192e: rtl819x_HTProc: code cleanup patches
 on the rtl8192x_HTProc.c file.
From:   Aaron Lawrence <t4rmin@zohomail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Date:   Sat, 22 Oct 2022 22:47:44 +0700
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.44.4 
MIME-Version: 1.0
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From d2168b90726dda2f02279a3483b53b8d9b34cb30 Mon Sep 17 00:00:00 2001
Message-Id: <cover.1666450553.git.t4rmin@zohomail.com>
From: Aaron Lawrence <t4rmin@zohomail.com>
Date: Sat, 22 Oct 2022 21:55:53 +0700
Subject: [PATCH 0/3] staging: rtl8192e: rtl819x_HTProc: code cleanup patche=
s on the rtl8192x_HTProc.c file.

Multiple patches regarding the cleanup of code in the rtl819x_HTProc.c
file according to the checkpatch script aside from the CamelCase issues.=
=20

Aaron Lawrence (3):
  Staging: rtl8192e: rtl819x_HTProc: fixed missing blank space
  Staging: rtl8192e: rtl819x_HTProc: fixed alignment matching open
    parenthesis
  Staging: rtl8192e: rtl819x_HTProc: fixed unnecessary parentheses

 drivers/staging/rtl8192e/rtl819x_HTProc.c | 38 ++++++++++++-----------
 1 file changed, 20 insertions(+), 18 deletions(-)

--=20
2.38.1



