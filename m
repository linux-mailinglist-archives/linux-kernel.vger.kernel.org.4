Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DFA66AD48
	for <lists+linux-kernel@lfdr.de>; Sat, 14 Jan 2023 19:32:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230367AbjANScM convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sat, 14 Jan 2023 13:32:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230204AbjANScK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Jan 2023 13:32:10 -0500
X-Greylist: delayed 474 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 14 Jan 2023 10:32:05 PST
Received: from bufferz9.csloxinfo.com (bufferz.csloxinfo.com [203.146.237.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9C907B763
        for <linux-kernel@vger.kernel.org>; Sat, 14 Jan 2023 10:32:05 -0800 (PST)
Received: from mailx4-13.cslox.com (unknown [10.20.140.73])
        by bufferz9.csloxinfo.com (Postfix) with ESMTP id ECB2423D5F47;
        Sun, 15 Jan 2023 01:24:09 +0700 (ICT)
IronPort-SDR: 63c2f349_cWO61nB6dgHKYMz3kjWuLhjEKApbCVScLPBFVr/rKyJyO/J
 pI5yGokqXF89jrCNd29rUZoCvszMqHM9lvxye3A==
X-IPAS-Result: =?us-ascii?q?A0D//wAl8sJj/9yS/htahx8YASyQd4JRGoUjjRCCHgF3C?=
 =?us-ascii?q?wiDCwtQgUCDdFYfgV4PAQEBAQEBAQEBHTAEAQGBUwGDKIUhAiVLAQYBAQEBA?=
 =?us-ascii?q?wIDAQEBAQEBAwIFAwIBAQYEgQoThXWGT0wzRDACORcTNIVtAgWqU26BNIEBh?=
 =?us-ascii?q?F2bDgGBVIlvgy+FahYGgg2ECIJIhwGCLppmgT18gScOgUiBDwQaNwMzER03C?=
 =?us-ascii?q?QMLbQpANQgOSisaGweBCiokBBUDBAQDAgYTAyACDSgxFAQpBwwNJyZrCQIDI?=
 =?us-ascii?q?WYDAwQoLQk/ByYkPAdWPAMCDx83BgMJAwIhToEgDRcFAwsVKkcECDYFBlESA?=
 =?us-ascii?q?ggPEg8JI0MOQjc2EwYwVgsOEwNQHn8yBIIWV50JgyWBZ5RyjRChYAcDg3CXW?=
 =?us-ascii?q?oh0GjKBHoJbjF+GLwiEI414hg+GG4shokuEUYIwUA6BWYEFgW0aTwEBgRkDG?=
 =?us-ascii?q?Q+FS5cmQDRUCYwjAQE?=
IronPort-Data: A9a23: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
 Zus
IronPort-HdrOrdr: A9a23:Fkw6raxMBc273dgega3DKrPwLL1zdoMgy1knxilNodU8SL37qy
 nIpoV56faUslcssR4b6La90cW7MBThHP1OgbX5Q43SJDUO0VHAROoJgOSN/9SHIVyGygc379
 YET0ERMqyVMbGkt6rH3DU=
X-IronPort-Anti-Spam-Filtered: true
Spam_Positive: LL
X-IronPort-AV: E=Sophos;i="5.97,216,1669050000"; 
   d="scan'208";a="452424700"
Received: from mail.seatec.co.th ([27.254.146.220])
  by mail-4.csloxinfo.com with ESMTP; 15 Jan 2023 01:24:10 +0700
Received: from localhost (localhost [127.0.0.1])
        by mail.seatec.co.th (Postfix) with ESMTP id 12278281F33;
        Sat, 14 Jan 2023 14:10:39 +0700 (+07)
Received: from mail.seatec.co.th ([127.0.0.1])
        by localhost (mail.seatec.co.th [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id NzawfGF-GcEO; Sat, 14 Jan 2023 14:10:38 +0700 (+07)
Received: from localhost (localhost [127.0.0.1])
        by mail.seatec.co.th (Postfix) with ESMTP id 45CA4281F28;
        Sat, 14 Jan 2023 14:10:38 +0700 (+07)
X-Virus-Scanned: amavisd-new at seatec.co.th
Received: from mail.seatec.co.th ([127.0.0.1])
        by localhost (mail.seatec.co.th [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id S0kH9qR00VGr; Sat, 14 Jan 2023 14:10:38 +0700 (+07)
Received: from [192.168.10.104] (unknown [37.19.214.7])
        by mail.seatec.co.th (Postfix) with ESMTPSA id 251B2281EE9;
        Sat, 14 Jan 2023 14:10:19 +0700 (+07)
Content-Type: text/plain; charset="iso-8859-1"
MIME-Version: 1.0
Content-Transfer-Encoding: 8BIT
Content-Description: Mail message body
Subject: Information
To:     Recipients <envi@seatec.co.th>
From:   "Mrs. Reem E. Al-Hashimi" <envi@seatec.co.th>
Date:   Sat, 14 Jan 2023 08:10:11 +0100
Reply-To: nationalbureau@kakao.com
Message-Id: <20230114071020.251B2281EE9@mail.seatec.co.th>
X-Spam-Status: No, score=3.2 required=5.0 tests=BAYES_50,KHOP_HELO_FCRDNS,
        RCVD_IN_MSPIKE_H2,RCVD_IN_VALIDITY_RPBL,SPF_HELO_NONE,SPF_SOFTFAIL,
        T_HK_NAME_MR_MRS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: ***
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Sir/Ma,

My name is Mrs. Reem E. Al-Hashimi, The Emirates Minister of State  United Arab Emirates.I have a great business proposal to discuss with you, if you are interested in Foreign Investment/Partnership please reply with your line of interest.


PLEASE REPLY ME : rrrhashimi2022@kakao.com

Reem
